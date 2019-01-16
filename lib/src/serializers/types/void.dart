import 'package:bloc_cli/src/serializers/serializer.dart';

class VoidSerializer extends Serializer<void> {
  @override
  void deserialize(String value) {}

  @override
  String serialize(void value) {
    return "";
  }

  @override
  String validate(String value) => null;

}