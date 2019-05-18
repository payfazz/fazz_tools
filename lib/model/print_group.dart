import 'package:fazz_tools/model/send_log.dart';

class PrintGroup {
  String labelName;
  List<SendLog> _texts;

  PrintGroup({this.labelName}) : _texts = [];

  List<SendLog> get texts => _texts;

  addText(SendLog text) {
    _texts.add(text);
  }
}
