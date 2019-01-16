import 'dart:async';
import 'package:meta/meta.dart';
import 'package:rxdart/rxdart.dart';

class ExampleBloc {

  Sink<int> get add => this._add.sink;

  Stream<int> get count => this._count.stream;

  final PublishSubject<int> _add = PublishSubject<int>(sync: true);

  final BehaviorSubject<int> _count = BehaviorSubject<int>(sync: true, seedValue: 0);

  List<StreamSubscription> subscriptions;

  List<Subject> subjects;

  ExampleBloc() {
    subscriptions = [
      this._add.listen(_onAdd),
    ];
    subjects = [
      this._add,
      this._count,
    ];
  }

  void _onAdd(int value) {
    this._count.add(this._count.value + value);
  }

  @mustCallSuper
  void dispose() {
    this.subjects.forEach((s) => s.close());
    this.subscriptions.forEach((s) => s.cancel());
  }
}