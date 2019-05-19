import 'package:fazz_tools/tools/network_inspector/dio_inspector.dart';
import 'package:meta/meta.dart';

abstract class FazzNetworkInspectorInterface {
  FazzDioInspector get dioInspect;
}

class FazzNetworkInspector implements FazzNetworkInspectorInterface {
  FazzDioInspector dio;

  FazzNetworkInspector({@required this.dio});

  FazzDioInspector get dioInspect => dio;
}
