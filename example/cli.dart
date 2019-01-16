import 'dart:convert';
import 'dart:io';
import 'package:bloc_cli/src/bloc.dart';
import 'bloc.dart';

Future main() async {
 final cli = BlocCli("Example", ExampleBloc(), (bloc) => bloc.dispose())
    ..stream("count", (b) => b.count)
    ..sink("add", (b) => b.add);

  await cli.run();
}
