import 'package:bloc_cli/src/serializers/serializer.dart';

class StringSerializer extends Serializer<String> {
  @override
  String deserialize(String value) {
    return '"$value"';
  }

  @override
  String serialize(String value) {
    return value.substring(1, value.length - 2);
  }

  @override
  String validate(String value) {
    if(value == null || value.length < 2 || !value.startsWith("\"")|| !value.endsWith("\"")) {
      return "a string value must be surounded by \"...\"";
    }
    return null;
  }
}