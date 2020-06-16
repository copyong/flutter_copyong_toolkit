import 'dart:async';
import 'dart:io';
import 'dart:ui' as ui;

import 'package:copyongtoolkit/utils/DatetimeUtil.dart';
import 'package:copyongtoolkit/utils/PermissionUtil.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

const directoryName = 'Signature';

class CappsSignatureWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return CappsSignatureWidgetState();
  }
}

class CappsSignatureWidgetState extends State<CappsSignatureWidget> {
  var image;

  List<Path> _paths = <Path>[];
  Path _path = new Path();
  bool _repaint = false;
  int back = 0;

  double signatureWidth = 400;
  double signatureHeight = 300;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Scaffold(
        body: Container(
          child: Column(
            children: <Widget>[
              GestureDetector(
                onPanDown: (DragDownDetails details) {
                  setState(() {
                    _path = new Path();
                    _paths.add(_path);
                    RenderBox object = context.findRenderObject();
                    Offset _localPosition =
                        object.globalToLocal(details.globalPosition);
                    _paths.last.moveTo(_localPosition.dx, _localPosition.dy);
                    _repaint = true;
                  });
                },
                onPanUpdate: (DragUpdateDetails details) {
                  setState(() {
                    RenderBox object = context.findRenderObject();
                    Offset _localPosition =
                        object.globalToLocal(details.globalPosition);
                    _paths.last.lineTo(_localPosition.dx, _localPosition.dy);
                  });
                },
                onPanEnd: (DragEndDetails details) {
                  setState(() {});
                },
                child: ClipRect(
                  child: CustomPaint(
                    painter: PathPainter(paths: _paths, repaint: _repaint),
                    size: Size(signatureWidth, signatureHeight),
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                FlatButton(
                  textColor: Colors.blue,
                  child: Text('Clear'),
                  onPressed: () {
                    clearPaths();
                  },
                ),
                FlatButton(
                  textColor: Colors.blue,
                  child: Text('Save'),
                  onPressed: () async {
                    String filePath = await setRenderedImage(context);
                    Navigator.pop(context, filePath);
                  },
                ),
              ],),
            ],
          ),
        ),
      ),
    );
  }

  Future<String> setRenderedImage(BuildContext context) async {
    ui.Image renderedImage = await rendered;

    setState(() {
      image = renderedImage;
    });

    var pngBytes = await image.toByteData(format: ui.ImageByteFormat.png);
    if (!(await _checkPermission())) await _requestPermission();
    Directory directory = await getExternalStorageDirectory();
    String path = directory.path;
    print(path);
    await Directory('$path/$directoryName').create(recursive: true);
    String filename =
        DatetimeUtil.fileDatetimeFmt.format(DateTime.now()) + '.png';
    String filePath = '$path/$directoryName/${filename}';
    File(filePath).writeAsBytesSync(pngBytes.buffer.asInt8List());
    print(filePath);
    return filePath;
  }

  Future<ui.Image> get rendered {
    ui.PictureRecorder recorder = ui.PictureRecorder();
    Canvas canvas = Canvas(recorder);
    PathPainter painter = PathPainter(paths: _paths);
    var size = Size(signatureWidth, signatureHeight);
    painter.paint(canvas, size);
    return recorder
        .endRecording()
        .toImage(size.width.floor(), size.height.floor());
  }

  void clearPaths() {
    setState(() {
      _path = new Path();
      _paths = [new Path()];
      _repaint = true;
    });
  }

  _requestPermission() async {
    bool result = await PermissionUtil.requestPermission(Permission.storage);
    return result;
  }

  _checkPermission() async {
    bool result = await PermissionUtil.checkPermission(Permission.storage);
    return result;
  }
}

class PathPainter extends CustomPainter {
  List<Path> paths;
  bool repaint;

  PathPainter({this.paths, this.repaint});

  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint()
      ..color = Colors.black
      ..style = PaintingStyle.stroke
      ..strokeJoin = StrokeJoin.bevel
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 4.2;

    paths.forEach((path) {
      canvas.drawPath(path, paint);
    });
    repaint = false;
  }

  @override
  bool shouldRepaint(PathPainter oldDelegate) => repaint;
}
