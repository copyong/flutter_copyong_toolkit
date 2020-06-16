import 'package:copyongtoolkit/views/DemoSharedPreference.dart';
import 'package:copyongtoolkit/views/DemoSignature.dart';
import 'package:copyongtoolkit/views/DeviceInfo.dart';
import 'package:copyongtoolkit/views/GeoLocation.dart';
import 'package:copyongtoolkit/views/Homepage.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      initialRoute: '/',
      routes: {
        // When navigating to the "/" route, build the FirstScreen widget.
        '/': (context) => Homepage(),
        '/geoLocation': (context) => GeoLocation(),
        '/sharedPreference': (context) => DemoSharedPreference(),
        '/demoSignature': (context) => DemoSignature(),
        '/deviceInfo': (context) => DeviceInfo(),
      },
    );
  }
}