import 'package:copyongtoolkit/widgets/MainDrawer.dart';
import 'package:flutter/material.dart';

class Homepage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MainDrawer(),
      appBar: AppBar(title: Text('Copyong Toolkits'),),
      body: Container(),
    );
  }
}
