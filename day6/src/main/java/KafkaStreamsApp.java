import java.io.File;
import java.io.FileNotFoundException;
import java.util.Arrays;
import java.util.HashMap;
import java.util.HashSet;
import java.util.Properties;
import java.util.Set;
import java.util.concurrent.CompletableFuture;
import java.util.concurrent.TimeUnit;
import java.util.function.BiFunction;

import org.apache.kafka.common.serialization.Serdes;
import org.apache.kafka.streams.KafkaStreams;
import org.apache.kafka.streams.KeyValue;
import org.apache.kafka.streams.StreamsBuilder;
import org.apache.kafka.streams.StreamsConfig;
import org.apache.kafka.streams.Topology;
import org.apache.kafka.streams.kstream.Consumed;
import org.apache.kafka.streams.kstream.Grouped;
import org.apache.kafka.streams.kstream.KStream;
import org.apache.kafka.streams.kstream.KTable;
import org.apache.kafka.streams.kstream.Materialized;
import org.apache.kafka.streams.kstream.Produced;

/*
 * Kafka Streams application which does the main work
 */
public class KafkaStreamsApp {

    private static final String kafkaHost = "kafka:9092";
    private final CompletableFuture<Void> stopEvent = new CompletableFuture<>();

    private static HashMap<String, Integer> solution = new HashMap<>();

    public static void main(final String[] args) throws FileNotFoundException, InterruptedException {
        KafkaStreamsApp app = new KafkaStreamsApp();
        FileToKafkaProducer producer = new FileToKafkaProducer(new File("input.txt"), kafkaHost, "input");
        producer.start();
        app.run().join();
        Thread.sleep(3000);
        System.out.println("################");
        System.out.println("Solution 1: " + solution.get("Solution 1"));
        System.out.println("Solution 2: " + solution.get("Solution 2"));
        System.out.println("################");
    }

    private CompletableFuture<Void> run() {
        final KafkaStreams kafkaStreams = createKafkaStreamsApplication(createTopology());
        Runtime.getRuntime().addShutdownHook(new Thread(kafkaStreams::close));
        kafkaStreams.start();
        stopEvent.thenRun(kafkaStreams::close);
        return stopEvent;
    }

    private KafkaStreams createKafkaStreamsApplication(final Topology topology) {
        final Properties properties = new Properties();
        properties.put(StreamsConfig.APPLICATION_ID_CONFIG, "kafkastreams-app");
        properties.put(StreamsConfig.BOOTSTRAP_SERVERS_CONFIG, kafkaHost);
        properties.put(StreamsConfig.NUM_STREAM_THREADS_CONFIG, 1);
        properties.put(StreamsConfig.COMMIT_INTERVAL_MS_CONFIG, 100);
        properties.put(StreamsConfig.CACHE_MAX_BYTES_BUFFERING_CONFIG, 0);
        return new KafkaStreams(topology, properties);
    }

    private Topology createTopology() {
        final StreamsBuilder builder = new StreamsBuilder();
        
        KStream<Long, String> input = buildInputStream(builder);

        KTable<Long, Integer> groupUnion = groupSet(input, (s1, s2) -> {
            HashSet<Character> res = new HashSet<>(s1);
            res.addAll(s2);
            return res;
        });

        KTable<Long, Integer> groupIntersection = groupSet(input, (s1, s2) -> {
            HashSet<Character> res = new HashSet<>(s1);
            res.retainAll(s2);
            return res;
        });
        
        KStream<String, Integer> groupSum1 = sumGroups(groupUnion, "Solution 1");
        KStream<String, Integer> groupSum2 = sumGroups(groupIntersection, "Solution 2");

        groupSum1.to("output1", Produced.with(Serdes.String(), Serdes.Integer()));
        groupSum2.to("output2", Produced.with(Serdes.String(), Serdes.Integer()));

        return builder.build();
    }

    private KStream<Long, String> buildInputStream(StreamsBuilder builder) {
        return builder
            .stream("input", Consumed.with(Serdes.Long(), Serdes.String()))
            .peek((Long key, String value) -> {
                if (value.length() == 1 && value.charAt(0) == (char) 0x04) {
                    System.out.println("Received EOT - Stopping application in 5s");
                    CompletableFuture.delayedExecutor(5, TimeUnit.SECONDS).execute(() -> {
                        stopEvent.complete(null);
                    });
                }
            })
            .filter((k, v) -> !(v.length() == 1 && v.charAt(0) == (char) 0x04));
    }

    private KTable<Long, Integer> groupSet(KStream<Long, String> input,
        BiFunction<HashSet<Character>, HashSet<Character>, HashSet<Character>> setOperation) {
        return input
            .mapValues((String v) -> new HashSet<>(
                Arrays.asList(
                    v.chars()
                    .mapToObj(c -> (char) c )
                    .toArray(Character[]::new)
                )
            ))
            .groupByKey(Grouped.with(Serdes.Long(), CharacterSetSerde.serde()))
            .reduce(
                (HashSet<Character> agg, HashSet<Character> value) -> setOperation.apply(agg, value),
                Materialized.with(Serdes.Long(), CharacterSetSerde.serde())
            )
            .mapValues((Set<Character> v) -> v.size());
    }
    
    private KStream<String, Integer> sumGroups(KTable<Long, Integer> groups, String key) {
        return groups
            .groupBy((Long k, Integer v) -> new KeyValue<String, Integer>(key, v),
                Grouped.with(Serdes.String(), Serdes.Integer()))
            .aggregate(
                () -> 0,
                (String k, Integer v, Integer a) -> a + v,
                (String k, Integer v, Integer a) -> a - v,
                Materialized.with(Serdes.String(), Serdes.Integer())
            )
            .toStream()
            .peek((String k, Integer v) -> {
                solution.put(k, v);
            });
    }
}