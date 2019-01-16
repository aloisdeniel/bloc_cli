import 'package:bloc_cli/src/serializers/types/int.dart';
import 'package:bloc_cli/src/serializers/types/string.dart';

import 'serializer.dart';

class Serializers {
  static final Serializers instance = Serializers()
    ..register(IntSerializer())
    ..register(StringSerializer());

  Map<Type, dynamic> serializers = {};

  void register<T>(Serializer<T> serializer) => serializers[T] = serializer;

  Serializer<T> get<T>() => serializers[T] as Serializer<T>;
}
