import 'dart:convert';

import 'package:fazz_tools/model/stringify.dart';

class PrintOptions implements Stringify {
  String color;
  String prefix;
  String suffix;
  bool showTimestamp;

  PrintOptions({
    this.color,
    this.prefix,
    this.suffix,
    this.showTimestamp = true,
  });

  @override
  Map<String, dynamic> toJson() => {
        "color": color,
        "prefix": prefix,
        "suffix": suffix,
        "showTimestamp": showTimestamp
      };

  @override
  String stringify() => jsonEncode(toJson());
}
