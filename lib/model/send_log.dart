import 'package:fazz_tools/model/print_options.dart';
import 'package:fazz_tools/value/log_display.dart';
import 'package:fazz_tools/value/log_type.dart';
import 'package:meta/meta.dart';

class SendLog {
  dynamic text;
  LogType type;
  LogDisplay showAs;
  PrintOptions options;

  SendLog({
    @required this.text,
    this.type = LogType.text,
    this.showAs = LogDisplay.plainText,
    this.options,
  });
}
