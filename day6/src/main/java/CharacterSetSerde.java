import java.io.ByteArrayInputStream;
import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.io.ObjectInput;
import java.io.ObjectInputStream;
import java.io.ObjectOutputStream;
import java.util.HashSet;

import org.apache.kafka.common.serialization.Deserializer;
import org.apache.kafka.common.serialization.Serde;
import org.apache.kafka.common.serialization.Serializer;

/*
 * Custom Serde for Set<Character>
 */
public class CharacterSetSerde implements Serde<HashSet<Character>> {
    private static CharacterSetSerde INSTANCE = new CharacterSetSerde();
    
    public static CharacterSetSerde serde() {
        return INSTANCE;
    }

    private CharacterSetSerde() {}

    @Override
    public Serializer<HashSet<Character>> serializer() {
        return new CharacterSetSerializer();
    }

    @Override
    public Deserializer<HashSet<Character>> deserializer() {
        return new CharacterSetDeserializer();
    }

    private class CharacterSetSerializer implements Serializer<HashSet<Character>> {
        @Override
        public byte[] serialize(String topic, HashSet<Character> data) {
            ByteArrayOutputStream bos = new ByteArrayOutputStream();
            ObjectOutputStream oos;
            try {
                oos = new ObjectOutputStream(bos);
                oos.writeObject(data);
                oos.flush();
                return bos.toByteArray();
            } catch (IOException e) {
                e.printStackTrace();
                return null;
            } finally {
                try {
                    bos.close();
                } catch (IOException e) {
                }
            }
        }
    }

    private class CharacterSetDeserializer implements Deserializer<HashSet<Character>> {
        @Override
        @SuppressWarnings("unchecked")
        public HashSet<Character> deserialize(String topic, byte[] data) {
            ByteArrayInputStream bis = new ByteArrayInputStream(data);
            ObjectInput in;
            try {
                in = new ObjectInputStream(bis);
                HashSet<Character> set = null;
                try {
                    set = (HashSet<Character>) in.readObject();
                } catch (ClassNotFoundException e) {
                    e.printStackTrace();
                }
                return set;
            } catch (IOException e) {
                e.printStackTrace();
                return null;
            } finally {
                try {
                    bis.close();
                } catch (IOException e) {
                }
            }
        }
    }
}
