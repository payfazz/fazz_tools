import 'package:dio/dio.dart';
import 'package:fazz_tools/fazz_tools.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Dio _dio;
  FazzTools _fazzTools;

  _MyHomePageState() {
    _dio = Dio(BaseOptions(baseUrl: "http://jsonplaceholder.typicode.com"));
    _fazzTools = FazzTools(host: '192.168.1.3', isDebug: true);
    _dio.interceptors.add(_fazzTools.dioInspector);
  }

  @override
  void initState() {
    _dio.get("/posts", queryParameters: {"_limit": 10});
    super.initState();
  }

  void _printMe() {
    _fazzTools.log.timerStart();
    _fazzTools.log.printGroup('output from method _printMe');
    _fazzTools.log.printTable({'name': 'kondel'});
    _fazzTools.log.print('hello kondel');
    _fazzTools.log.printEndGroup();
    _fazzTools.log.timerEnd();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: RaisedButton(
          child: Text('Print me'),
          onPressed: _printMe,
        ),
      ),
    );
  }
}
