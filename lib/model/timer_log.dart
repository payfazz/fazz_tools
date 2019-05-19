import 'dart:convert';

import 'package:fazz_tools/model/stringify.dart';
import 'package:meta/meta.dart';

class TimerLog implements Stringify {
  int startTime;
  int endTime;
  int range;

  TimerLog({
    @required this.startTime,
    @required this.endTime,
    @required this.range,
  });

  @override
  String stringify() => jsonEncode(toJson());

  @override
  Map<String, dynamic> toJson() => {
        "startTime": startTime,
        "endTime": endTime,
        "range": range,
      };
}
