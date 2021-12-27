import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:tflite/tflite.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final picker = ImagePicker();
  late File _image;
  bool _loading = false;
  List _output = [''];

  pickImage() async {
    var image = await picker.getImage(source: ImageSource.camera);

    if (image == null) return null;
    setState(() {
      _image = File(image.path);
    });
    classifyImage(_image);
  }

  pickGallaryImage() async {
    var image = await picker.getImage(source: ImageSource.gallery);

    if (image == null) return null;
    setState(() {
      _image = File(image.path);
    });
    classifyImage(_image);
  }

  @override
  void initState() {
    super.initState();
    _loading = true;
    loadModel().then((value) {});
  }

  @override
  void dispose() {
    Tflite.close();
    super.dispose();
  } /////status

//
  classifyImage(File image) async {
    var output = await Tflite.runModelOnImage(
      path: image.path,
      numResults: 2,
      threshold: 0.5,
      imageMean: 127.5,
      imageStd: 127.5,
    );
//git a
    setState(() {
      _loading = false;
      if (output != null) {
        _output = (output).toList();
      }
    });
  }

  loadModel() async {
    await Tflite.loadModel(
        model: 'assets/model_unquant.tflite', labels: 'assets/labels.txt');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xFF101010),
        body: Container(
          padding: EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(
                height: 100,
              ),
              Text(
                'Teachablemachne CNN',
                style: TextStyle(color: Color(0xFFEEDA28)),
              ),
              SizedBox(height: 6),
              Text(
                'Detect Dogs and Cats',
                style: TextStyle(
                    color: Color(0xFFE99600),
                    fontWeight: FontWeight.w500,
                    fontSize: 28),
              ),
              SizedBox(
                height: 50.0,
              ),
              Container(
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    children: <Widget>[
                      GestureDetector(
                        onTap: pickImage,
                        child: Container(
                          width: MediaQuery.of(context).size.width - 260,
                          alignment: Alignment.center,
                          padding: EdgeInsets.symmetric(
                              horizontal: 24, vertical: 17),
                          decoration: BoxDecoration(
                            color: Color(0xFFE99600),
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Text(
                            'Take a photo',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      GestureDetector(
                        onTap: pickGallaryImage,
                        child: Container(
                          width: MediaQuery.of(context).size.width - 260,
                          alignment: Alignment.center,
                          padding: EdgeInsets.symmetric(
                              horizontal: 24, vertical: 17),
                          decoration: BoxDecoration(
                            color: Color(0xFFE99600),
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Text(
                            'Camera Roll  ',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      )
                    ],
                  )),
              Center(
                child: _loading
                    ? Container(
                        width: 300,
                        child: Column(
                          children: <Widget>[
                            Image.asset('assets/cat.png'),
                            SizedBox(
                              height: 50.0,
                            )
                          ],
                        ),
                      )
                    : Container(
                        child: Column(
                        children: <Widget>[
                          Container(height: 250, child: Image.file(_image)),
                          SizedBox(
                            height: 20,
                          ),
                          _output != null
                              ? Container(
                                  padding: EdgeInsets.symmetric(vertical: 10),
                                  child: Text('${_output[0]['label']}',
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 20)),
                                )
                              : Container(),
                        ],
                      )),
              ),
            ],
          ),
        ));
  }
}
