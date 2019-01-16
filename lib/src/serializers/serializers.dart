import 'types/int.dart';
import 'types/null.dart';
import 'types/string.dart';
import 'types/void.dart';
import 'types/bool.dart';
import 'types/list.dart';

import 'serializer.dart';

class Serializers {
  static final Serializers instance = Serializers()
    ..register(NullSerializer())
    ..register(VoidSerializer())
    ..register(IntSerializer())
    ..register(BoolSerializer())
    ..register(StringSerializer());

  Map<Type, dynamic> serializers = {};

  void register<T>(Serializer<T> serializer) => serializers[T] = serializer;

  Serializer<T> get<T>() {   

    return serializers[T] as Serializer<T>;
  }
}
