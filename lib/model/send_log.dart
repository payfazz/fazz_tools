import 'dart:convert';
import 'package:fazz_tools/model/print_options.dart';
import 'package:fazz_tools/model/stringify.dart';
import 'package:fazz_tools/value/log_display.dart';
import 'package:fazz_tools/value/log_type.dart';
import 'package:meta/meta.dart';
import 'package:uuid/uuid.dart';

class SendLog implements Stringify {
  dynamic text;
  String type;
  String showAs;
  PrintOptions options;
  String _id;

  SendLog({
    @required this.text,
    String type = '',
    String showAs = '',
    PrintOptions options,
  })  : this._id = Uuid().v4(),
        this.type = type == '' ? LogType.text : type,
        this.showAs = showAs == '' ? LogDisplay.plainText : showAs,
        this.options = options == null ? PrintOptions() : options;

  @override
  Map<String, dynamic> toJson() => {
        "_id": _id,
        "text": text,
        "type": type,
        "showAs": showAs,
        "options": options.toJson(),
      };

  @override
  String stringify() => jsonEncode(toJson());
}
