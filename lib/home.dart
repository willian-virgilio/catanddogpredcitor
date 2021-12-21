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
              Center(
                child: Container(
                  width: 300,
                  child: Column(
                    children: <Widget>[
                      Image.asset('assets/cat.png'),
                      SizedBox(
                        height: 50.0,
                      )
                    ],
                  ),
                ),
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
                  ))
            ],
          ),
        ));
  }
}
