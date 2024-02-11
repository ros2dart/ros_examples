import 'dart:io';

import 'package:dartros/dartros.dart' as ros;
import 'package:sensor_msgs/msgs.dart' as sensor_msgs;
import 'package:flutter/material.dart';

Future<void> main(List<String> args) async {
  ros.NodeHandle? node;
  try {
    node = await ros.initNode(
      'deneme',
      args,
      rosMasterUri: "http://localhost:11311",
    );

    await node.getMasterUri();
    runApp(MyApp(node: node));
  } catch (e) {
    print(e);
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key, required this.node});
  final ros.NodeHandle node;

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: MyHomePage(title: 'Flutter Demo ROS Page', node: node),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title, required this.node});

  final String title;

  final ros.NodeHandle node;
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      // final img_msg = sensor_msgs.Image(
      //   header: null,
      //   height: 600,
      //   width: 1024,
      //   encoding: 'rgba8',
      //   is_bigendian: 0,
      //   step: 1024 * 4,
      //   data: List.generate(600 * 1024 * 4, (_) => 255),
      // );
      // final pub = widget.node
      //     .advertise('/robot/head_display', sensor_msgs.Image.$prototype);
      // pub.publish(img_msg, 1);
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
