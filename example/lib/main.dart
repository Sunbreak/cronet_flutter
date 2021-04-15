import 'package:flutter/material.dart';

import 'package:cronet_flutter/cronet_flutter.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  child: Text('startEngine'),
                  onPressed: () {
                    var startEngine = CronetFlutter().startEngine();
                    print('startEngine $startEngine');
                  },
                ),
                ElevatedButton(
                  child: Text('shutdownEngine'),
                  onPressed: () {
                    var shutdownEngine = CronetFlutter().shutdownEngine();
                    print('shutdownEngine $shutdownEngine');
                  },
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  child: Text('startRequest'),
                  onPressed: () {
                    var startRequest = CronetFlutter().startRequest('https://postman-echo.com/get?foo1=bar1&foo2=bar2');
                    print('startRequest $startRequest');
                  },
                ),
                ElevatedButton(
                  child: Text('stopRequest'),
                  onPressed: () {
                    CronetFlutter().stopRequest();
                    print('stopRequest');
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
