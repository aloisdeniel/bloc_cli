import 'package:bloc_cli/src/serializers/serializer.dart';

class ListSerializer<T> extends Serializer<List<T>> {

  ListSerializer(this.childSerializer);

  final Serializer<T> childSerializer;

  @override
  List<T> deserialize(String value) {
    return value.split(",").map((v) => childSerializer.deserialize(v.trim())).toList();
  }

  @override
  String serialize(List<T> value) {
    return value?.map((v) => childSerializer.serialize(v))?.join(",");
  }

  @override
  String validate(String value) {
    // TODO
    return null;
  }
}