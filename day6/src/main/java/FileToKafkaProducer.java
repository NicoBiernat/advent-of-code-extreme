import java.io.File;
import java.io.FileNotFoundException;
import java.util.Properties;
import java.util.Scanner;

import org.apache.kafka.clients.producer.KafkaProducer;
import org.apache.kafka.clients.producer.ProducerConfig;
import org.apache.kafka.clients.producer.ProducerRecord;
import org.apache.kafka.common.serialization.LongSerializer;
import org.apache.kafka.common.serialization.StringSerializer;

/*
* Kafka Producer which reads the input file and sends the lines to the Kafka broker 
*/
public class FileToKafkaProducer extends Thread {
    
    private File file;
    private KafkaProducer<Long, String> producer;

    public FileToKafkaProducer(File file, String kafkaHost, String topic) {
        Properties props = new Properties();
        props.put(ProducerConfig.BOOTSTRAP_SERVERS_CONFIG, "kafka:9092");
        props.put(ProducerConfig.CLIENT_ID_CONFIG, "KafkaProducer");
        props.put(ProducerConfig.KEY_SERIALIZER_CLASS_CONFIG, LongSerializer.class.getName());
        props.put(ProducerConfig.VALUE_SERIALIZER_CLASS_CONFIG, StringSerializer.class.getName());
        producer = new KafkaProducer<>(props);
        this.file = file;
    }

    @Override
    public void run() {
            Scanner sc;
            try {
                sc = new Scanner(file);
            } catch (FileNotFoundException e) {
                e.printStackTrace();
                return;
            }
            long currentGroup = 0;
            while (sc.hasNextLine()) {
                String line = sc.nextLine();
                if (line.equals("")) {
                    currentGroup++;
                    continue;
                }
                line = line.replace("\n", "");
                ProducerRecord<Long, String> record = new ProducerRecord<>(
                    "input",
                    currentGroup,
                    line
                );
                producer.send(record);
            }
            ProducerRecord<Long, String> record = new ProducerRecord<>(
                "input",
                ++currentGroup,
                Character.toString((char) 0x04) // EOT / ^D
            );
            producer.send(record);
            sc.close();
            producer.flush();
            producer.close();
    }
}