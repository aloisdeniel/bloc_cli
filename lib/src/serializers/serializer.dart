abstract class Serializer<T> {
  String serialize(T value);
  T deserialize(String value);
  String validate(String value);
}