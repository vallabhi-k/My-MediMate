import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'navbar.dart';
import 'package:flutter_tts/flutter_tts.dart';

enum TtsState { playing, stopped }

class Prescription_Image extends StatefulWidget {
  String userName;
  Prescription_Image({Key key, @required this.userName}) : super(key: key);

  @override
  _ImageState createState() => _ImageState(userName: userName);
}

class _ImageState extends State<Prescription_Image> {
  String userName;
  _ImageState({Key key, @required this.userName});
  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(100.0),
          child: AppBar(
            title: Image.asset("assets/logo_text.png",width:200,height:100),
            centerTitle: true,
          )),
      drawer: NavDrawer(userName: userName,),
      body: SingleChildScrollView (child : PrescriptionImageForm(),),
    );
  }
}

class PrescriptionImageForm extends StatefulWidget {
  @override
  _PrescriptionImageFormState createState() => _PrescriptionImageFormState();
}

class _PrescriptionImageFormState extends State<PrescriptionImageForm> {
  final _formKey = GlobalKey<FormState>();
  File _image;
  FlutterTts flutterTts;
  dynamic languages;
  String language;
  double volume = 0.5;
  double pitch = 1.0;
  double rate = 1.0;

  String _newVoiceText;

  TtsState ttsState = TtsState.stopped;

  get isPlaying => ttsState == TtsState.playing;

  get isStopped => ttsState == TtsState.stopped;



  initTts() {
    flutterTts = FlutterTts();

    _getLanguages();

    flutterTts.setStartHandler(() {
      setState(() {
        print("playing");
        ttsState = TtsState.playing;
      });
    });

    flutterTts.setCompletionHandler(() {
      setState(() {
        print("Complete");
        ttsState = TtsState.stopped;
      });
    });

    flutterTts.setErrorHandler((msg) {
      setState(() {
        print("error: $msg");
        ttsState = TtsState.stopped;
      });
    });
  }

  Future _getLanguages() async {
    languages = await flutterTts.getLanguages;
    print("pritty print ${languages}");
    if (languages != null) setState(() => languages);
  }

  Future _speak() async {
    await flutterTts.setVolume(volume);
    await flutterTts.setSpeechRate(rate);
    await flutterTts.setPitch(pitch);

    if (_newVoiceText != null) {
      if (_newVoiceText.isNotEmpty) {
        var result = await flutterTts.speak(_newVoiceText);
        if (result == 1) setState(() => ttsState = TtsState.playing);
      }
    }
  }

  Future _stop() async {
    var result = await flutterTts.stop();
    if (result == 1) setState(() => ttsState = TtsState.stopped);
  }

  @override
  void initState() {
    super.initState();
    initTts();
    flutterTts.setLanguage("hi-IN");
  }

  @override
  void dispose() {
    flutterTts.stop();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(left: 16.0, right: 16.0, top: 16.0),
            child: RaisedButton(
                color : const Color(0xFFFFC7C7),

                child: Row(children: [
                  Flexible(
                    flex: 1,
                    child:  Icon(Icons.upload_rounded,color : Colors.brown[300]),
                  ),
                  Flexible(
                    flex: 8,
                    child: Center(child: Text("Input Prescription Image")),
                  ),
                ]),
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) =>
                        _buildAboutDialog(context),
                  );
                }),
          ),
          Container(
            child: _image != null
                ? Container(
                child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 75.0),
                    child: Stack(children: <Widget>[
                      ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Image.file(
                          _image,
                          width: 300,
                          height: 300,
                          fit: BoxFit.fill,
                        ),
                      ),
                      Align(
                        alignment: Alignment.topRight,
                        child: Container(
                          width: 40,
                          height: 40,
                          child: FlatButton(
                            padding: const EdgeInsets.only(
                                right: 10.0, top: 5.0),
                            color: Colors.black.withOpacity(0.0),
                            child: Icon(
                              Icons.cancel_outlined,
                              color: Colors.red,
                              size: 30,
                            ),
                            onPressed: () {
                              _image = null;
                              setState(() {});
                            },
                          ),
                        ),
                      ),
                    ])))
                : Container(),
          ),
          ListTile(
            leading: Icon(Icons.medical_services_outlined,color:Colors.brown[300]),
            title: TextFormField(
              decoration: InputDecoration(
                hintText: "Disease Name",
              ),
              validator: (value) {
                if (value.isEmpty) {
                  return 'Please enter Disease Name';
                }
                return null;
              },
            ),
          ),
          RaisedButton(
            color : const Color(0xFFFFC7C7),
            child: Text("Read Prescription from Image"),
            onPressed: () {
              if (_image!= null)
              {
                _newVoiceText="ABC Medicine (No Generics) 250mg capsules, take 1 capsule twice a day, 1 after breakfast, 1 after dinner";
                _speak();
              }
            },
          ),
          ElevatedButton(
            onPressed: () {
              if (_formKey.currentState.validate()) {
                Scaffold.of(context).showSnackBar(SnackBar(
                  content: Text('Saving Data'),
                ));
              }
            },
            child: Text('Save'),
          )
        ],
      ),
    );
  }

  Widget _buildAboutDialog(BuildContext context) {
    return AlertDialog(
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          ListTile(
              leading: const Icon(Icons.photo),
              title: Text("Choose from Gallery"),
              onTap: () {
                _imgFromGallery();
                Navigator.of(context).pop();
              }),
          ListTile(
              leading: const Icon(Icons.photo_camera),
              title: Text("Take a Photo"),
              onTap: () {
                _imgFromCamera();
                Navigator.of(context).pop();
              }),
        ],
      ),
    );
  }

  _imgFromCamera() async {
    File image = await ImagePicker.pickImage(
        source: ImageSource.camera, imageQuality: 50);

    setState(() {
      _image = image;
    });
  }

  _imgFromGallery() async {
    File image = await ImagePicker.pickImage(
        source: ImageSource.gallery, imageQuality: 50);

    setState(() {
      _image = image;
    });
  }
}