import 'package:bloc_cli/src/serializers/serializer.dart';

class NullSerializer extends Serializer<Null> {
  @override
  Null deserialize(String value) => null;

  @override
  String serialize(Null value) {
    return "null";
  }

  @override
  String validate(String value) => null;

}