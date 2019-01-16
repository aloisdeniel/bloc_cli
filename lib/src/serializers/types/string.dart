import 'package:bloc_cli/src/serializers/serializer.dart';

class StringSerializer extends Serializer<String> {
  @override
  String deserialize(String value) {
    return value;
  }

  @override
  String serialize(String value) {
    return value;
  }

  @override
  String validate(String value) => null;

}