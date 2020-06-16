import 'dart:io';

import 'package:flutter/material.dart';

import 'CappsSignatureWidget.dart';

class CappsSignatureButton extends StatefulWidget {

  String filePath;
  CappsSignatureButton({Key key, @required this.filePath}) : super(key: key);

  @override
  _CappsSignatureButtonState createState() => _CappsSignatureButtonState();
}

class _CappsSignatureButtonState extends State<CappsSignatureButton> {

  @override
  Widget build(BuildContext context) {
    return FlatButton(
      onPressed: () async {
        String returnFilePath = await Navigator.push(context,
            MaterialPageRoute(builder: (context) => CappsSignatureWidget()));
        if (returnFilePath != null) {
          setState(() {
            widget.filePath = returnFilePath;
          });
        }
      },
      child: widget.filePath != null ? Image.file(File(widget.filePath)) : Text('Tap to add signature'),
    );
  }
}
