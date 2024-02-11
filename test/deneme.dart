import 'dart:async';
import 'dart:io';

import 'package:dartros/dartros.dart';

import 'package:sensor_msgs/msgs.dart' as sensor_msgs;

void main(List<String> args) async {
  NodeHandle nh = await initNode(
    'ros_node_1', args,
    rosMasterUri: "http://127.0.0.1:11311",
    // rosIP: InternetAddress("::1:11311",type:InternetAddressType.IPv6 )
    // rosIP: InternetAddress("docker.for.mac.localhost", type: InternetAddressType.IPv4),
  );

  final img_msg = sensor_msgs.Image(
    header: null,
    height: 600,
    width: 1024,
    encoding: 'rgba8',
    is_bigendian: 0,
    step: 1024 * 4,
    data: List.generate(600 * 1024 * 4, (_) => 255),
  );
  final pub = nh.advertise('/robot/head_display', sensor_msgs.Image.$prototype);

  Timer.periodic(Duration(seconds: 1), (timer) {
    pub.publish(img_msg, 1);
  });
  // await nh.getMasterUri();
  // await nh.setParam('/foo', 'value');
  // var value = await nh.getParam('/foo');
  // assert(value == 'value');
  // print(value);

  // print(await nh.setParam('/foo', 'new value'));
  // value = await nh.getParam('/foo');
  // assert(value == 'new value');
  // print(value);
}
