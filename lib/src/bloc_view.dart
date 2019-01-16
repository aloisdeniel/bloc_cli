import 'package:meta/meta.dart';

class BlocView {
  final String title;
  final Map<String, String> streams;
  final List<String> sinks;
  final String status;

  BlocView(
      {@required this.title,
      @required this.streams,
      @required this.sinks,
      @required this.status});

  BlocView copyWith({
    String title,
    Map<String, String> streams,
    List<String> sinks,
    String status,
  }) {
    return BlocView(
        title: title ?? this.title,
        streams: streams ?? this.streams,
        sinks: sinks ?? this.sinks,
        status: status ?? this.status);
  }

  @override
  String toString() {
    final buffer = StringBuffer();

    buffer.writeln("\n\n\n\n$title ----------------------------------");
    buffer.writeln("Streams:");
    this.streams.forEach((k, v) => buffer.writeln("  * [$k]: $v"));
    buffer.writeln("\n");
    buffer.writeln("Sinks: " + this.sinks.map((k) => "[$k]").join(", "));
    buffer.writeln("Type '-exit' to quit");
    buffer.writeln("----------------------------------------");
    buffer.writeln("${status}");
    buffer.writeln("----------------------------------------");

    return buffer.toString();
  }
}
