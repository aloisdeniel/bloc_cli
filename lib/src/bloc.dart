import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:bloc_cli/src/bloc_view.dart';
import 'package:bloc_cli/src/serializers/serializers.dart';

typedef void Dispatcher(String value);

typedef void Disposer<T>(T instance);

typedef void Initializer();

class BlocCli<TBloc> {
  final TBloc bloc;

  final Disposer<TBloc> _blocDisposer;

  final String name;
  final String description;
  final Serializers serializers;
  bool get isRunning => this._completer != null && !this._completer.isCompleted;

  bool get isDisposed => this._isDisposed;

  bool _isDisposed = false;

  String status = null;

  List<StreamSubscription> _subscriptions = [];

  List<Initializer> _initializers = [];

  BlocView _view;

  Map<String, Dispatcher> _dispatchers = {};

  static const String defaultStatus = "Type a sink name to send it a value";

  BlocCli(this.name, this.bloc, this._blocDisposer,
      {this.description, Serializers serializers})
      : this.serializers = serializers ?? Serializers.instance,
        this._view = BlocView(title: name, streams: {}, sinks: [], status: defaultStatus);

  void sink<T>(String name, Sink<T> getSink(TBloc bloc)) {
    final sink = getSink(bloc);
    this._view = this._view.copyWith(sinks: []..addAll(this._view.sinks)..add(name));
    _initializers.add(() {
      final serializer = this.serializers.get<T>();

      this._dispatchers[name.toLowerCase()] = (input) {
        final validation = serializer.validate(input);
        if (validation == null) {
          final value = serializer.deserialize(input);
          this.updateView(this
              ._view
              .copyWith(status: "Sent value '$input' to Sink '$name'"));
          sink.add(value);
        } else {
          this.updateView(
              this._view.copyWith(status: "ERROR: invalid input: $validation"));
        }
      };
    });
  }

  void stream<T>(String name, Stream<T> getStream(TBloc bloc)) {
    this.updateView(this._view.copyWith(
        streams: {}
          ..addAll(this._view.streams)
          ..[name] = "?"));

    final stream = getStream(bloc);

    _initializers.add(() {
      final serializer = this.serializers.get<T>();
      this._subscriptions.add(stream.listen((v) {
            this.updateView(this._view.copyWith(
                streams: {}
                  ..addAll(this._view.streams)
                  ..[name] = serializer.serialize(v)));
          }, onError: (e) {
            this.updateView(this._view.copyWith(
                  status: "ERROR(stream:$name) $e",
                ));
          }, onDone: () {
            this.updateView(this._view.copyWith(
                  status: "WARNING(stream:$name): done",
                ));
          }));
    });
  }

  void updateView(BlocView view) {
    this._view = view;
    this.render();
  }

  void render() {
    if (this.isRunning) {
      print(this._view.toString());
    }
  }

  Dispatcher _dispatcher;

  Completer _completer;

  void requestValue(String line) {
    if(this._dispatcher == null) {
      final sinkName = line?.trim()?.toLowerCase();
      if (sinkName == "-exit") {
        this.dispose();
      } else if (this._dispatchers.containsKey(sinkName)) {
        _dispatcher = this._dispatchers[sinkName];
        this.updateView(
            this._view.copyWith(status: "Which value do you want to send ?"));
      } else {
        this.updateView(
            this._view.copyWith(status: "ERROR: Sink '$sinkName' not found"));
      }
    }
    else {
      final value = line?.trim()?.toLowerCase();
      final dispatcher = _dispatcher;
      this._dispatcher = null;
      dispatcher(value);
      
    }
  }

  Future run() {
    if (this.isDisposed) {
      throw Exception("The bloc is disposed");
    }

    if (this.isRunning) {
      throw Exception("The bloc is already running");
    }

    this._initializers.forEach((init) => init());

    this._completer = Completer();
    this.render();

    stdin.transform(utf8.decoder).transform(const LineSplitter()).listen((line) {
      this.requestValue(line);
    });

    return this._completer.future;
  }

  void dispose() {
    this._subscriptions.forEach((s) => s.cancel());
    this._blocDisposer(this.bloc);
        _completer.complete();
    this._isDisposed = true;
  }
}
