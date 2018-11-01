import 'dart:async';
import 'theme.dart';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';


List<CameraDescription> cameras;

Future<Null> main() async { 
  cameras = await availableCameras();
  runApp (new CameraApp());
}

class CameraApp extends StatefulWidget{
  @override
  _CameraAppState createState() => new _CameraAppState();
}

class _CameraAppState extends State<CameraApp>{
  CameraController controller;
  @override
  void initState() {
    super.initState();
    controller = new CameraController(cameras[0], ResolutionPreset.medium);
    controller.initialize().then((_) {
      if (!mounted) {
        return;
      }
      setState(() {});
    });
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('CODE Scanner'),
        ),
        body: new Column(
          children: <Widget>[
            new Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                new Container(
                  child: new Stack(
                    children: <Widget>[
                      new Container(
                        margin: const EdgeInsets.all(10.0), 
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(const Radius.circular(8.0)),
                          boxShadow: [BoxShadow(
                            color: Colors.black,
                            blurRadius: 12.0,
                          )],
                          border: Border.all(
                            color: accentColor,
                            width: 5.0,
                          ),
                        ),
                        width: 260.0,
                        height: 260.0,
                        child: _cameraPreview(controller),
                      ),
                      new Positioned(
                        child: new Icon(Icons.star, color: Colors.red,),
                      ),
                    ]
                  )
                ),
              ],
            ),
            new Container(
              color: accentColor,
              child: new Padding(
                padding: EdgeInsets.only(top: 4.0, bottom: 50.0),
                child: new Column(
                  children: <Widget>[
                    new Padding(
                      padding: const EdgeInsets.only(top:4.0),
                      child: new Row(
                        children:<Widget>[
                          new Expanded(child: new Container()),
                          new RawMaterialButton(
                            shape: new CircleBorder(),
                            fillColor: Colors.white,
                            splashColor: lightAccentColor,
                            highlightColor: lightAccentColor.withOpacity(0.5),
                            elevation: 10.0,
                            highlightElevation: 5.0,
                            onPressed: (){},
                            child: new Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: new Icon(
                                Icons.find_in_page,
                                color: darkAccentColor,
                                size: 35.0,
                              )
                            ),
                          ),
                          new Expanded(child: new Container()),
                        ]
                      )
                    ),
                    new RichText(
                      text: new TextSpan(
                        text: '',
                        children: [
                          new TextSpan(
                            text: 'QR CODE\n',
                            style: new TextStyle(
                              color: Colors.white,
                              fontSize: 14.0,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 4.0,
                              height: 1.5,
                            )
                          ),
                          new TextSpan(
                            text: 'read text',
                            style: new TextStyle(
                              color: Colors.white.withOpacity(0.75),
                              fontSize: 12.0,
                              letterSpacing: 3.0,
                              height: 1.5,
                            )
                          ),
                        ]
                      ),
                    ),
                  ]
                )
              ),
            ),
          ]
        ),
      ),
    );    
  }

  Widget _cameraPreview(CameraController controller){
    if (!controller.value.isInitialized) {
      return new Container();
    }
    return new AspectRatio(
      aspectRatio: controller.value.aspectRatio,
      child: new CameraPreview(controller)
    );
  }
}