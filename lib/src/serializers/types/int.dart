import 'package:bloc_cli/src/serializers/serializer.dart';

class IntSerializer extends Serializer<int> {
  @override
  int deserialize(String value) {
    return int.parse(value);
  }

  @override
  String serialize(int value) {
    return value?.toString();
  }

  @override
  String validate(String value) {
    if(int.tryParse(value) == null) {
      return "invalid number ('$value')";
    }
    return null;
  }

}