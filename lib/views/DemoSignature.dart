import 'package:copyongtoolkit/widgets/CappsSignature/CappsSignatureButton.dart';
import 'package:flutter/material.dart';

class DemoSignature extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return DemoSignatureState();
  }
}

class DemoSignatureState extends State<DemoSignature> {
  String filePath =
      '/storage/emulated/0/Android/data/com.copyong.copyongtoolkit/files/Signature/20200609_141348055.png';

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CappsSignatureButton(filePath: filePath),
    );
  }
}
