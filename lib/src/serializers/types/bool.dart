import 'package:bloc_cli/src/serializers/serializer.dart';

class BoolSerializer extends Serializer<bool> {
  @override
  bool deserialize(String value) {
    return value == "true";
  }

  @override
  String serialize(bool value) {
    return value?.toString();
  }

  @override
  String validate(String value) {
    return null;
  }
}