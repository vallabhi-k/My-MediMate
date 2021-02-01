import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'navbar.dart';
class MedicineBill_image extends StatefulWidget {
  String userName;
  MedicineBill_image({Key key, @required this.userName}) : super(key: key);

  @override
  _MedicineBillImageState createState() => _MedicineBillImageState(userName: userName);
}

class _MedicineBillImageState extends State<MedicineBill_image> {
  String userName;
  _MedicineBillImageState({Key key, @required this.userName});
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
      body: SingleChildScrollView (child : MedicineBillImageForm(),),
    );
  }
}


class MedicineBillImageForm extends StatefulWidget {
  @override
  _MedicineBillImageFormState createState() => _MedicineBillImageFormState();
}

class _MedicineBillImageFormState extends State<MedicineBillImageForm> {
  final _formKey = GlobalKey<FormState>();

  File _image;
  static List<String> friendsList = [null];

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(
              left: 16.0,
              right: 16.0,
              top: 16.0,
            ),
            child: RaisedButton(
                color : const Color(0xFFFFC7C7),
                child: Row(children: [
                  Flexible(
                    flex: 1,
                    child:  Icon(Icons.upload_rounded,color:Colors.brown[300]),
                  ),
                  Flexible(
                    flex: 8,
                    child: Center(child: Text("Upload Medicine Bill")),
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
                    padding: const EdgeInsets.symmetric(horizontal: 45.0),
                    child: Stack(children: <Widget>[
                      ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Image.file(
                          _image,
                          width: 300,
                          height: 300,
                          fit: BoxFit.fitHeight,
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
          Container(
            height: 35.0,
          ),
          RaisedButton(
            color : const Color(0xFFFFC7C7),
            child: Text("Read Medicine Bill"),
            onPressed: () {
              showDialog(
                context: context,
                //builder: (BuildContext context) => _buildAboutDialog(context),
              );
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