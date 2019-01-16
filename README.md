# bloc_cli

Create command line interfaces from your BLoCs.

## Quickstart

```dart
class ExampleBloc {
  Sink<int> get add => ...;
  Stream<int> get count => ...;
}

Future main() async {
  final cli = BlocCli("Example", ExampleBloc(), (bloc) => bloc.dispose())
    ..stream("count", (b) => b.count)
    ..sink("add", (b) => b.add);

  await cli.run();
}
```


```bash
Example ----------------------------------
Streams:
  * [count]: 0


Sinks: [add]
Type '-exit' to quit
----------------------------------------
Type a sink name to send it a value
----------------------------------------
```

And obviously, each time one of the streams is updated, the view will refresh.