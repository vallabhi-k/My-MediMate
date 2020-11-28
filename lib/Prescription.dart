import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'navbar.dart';

class PrescriptionPage extends StatefulWidget {
  PrescriptionPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _PrescriptionState createState() => _PrescriptionState();
}

class _PrescriptionState extends State<PrescriptionPage> {
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
      drawer: NavDrawer(),
      body: SingleChildScrollView (child : PrescriptionForm(),),
    );
  }
}

class PrescriptionForm extends StatefulWidget {
  @override
  _PrescriptionFormState createState() => _PrescriptionFormState();
}

class _PrescriptionFormState extends State<PrescriptionForm> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController _nameController;
  TextEditingController _numberController;
  File _image;
  static List<String> friendsList = [null];

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
    _numberController = TextEditingController();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _numberController.dispose();
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
                    child: Center(child: Text("Upload Prescription")),
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
          ListTile(
            leading: Icon(Icons.medical_services_outlined,color:Colors.brown[300]),
            title: TextFormField(
              decoration: InputDecoration(
                hintText: "Disease Name",
              ),
              validator: (value) {
                if (value.isEmpty) {
                  return 'Please enter text';
                }
                return null;
              },
            ),
          ),
          RaisedButton(
            color : const Color(0xFFFFC7C7),
            child: Text("Read Prescription"),
            onPressed: () {
              showDialog(
                context: context,
                //builder: (BuildContext context) => _buildAboutDialog(context),
              );
            },
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: RaisedButton(
              color : const Color(0xFFFFC7C7),
              
              child: Row(children: [
                Flexible(
                  flex: 1,
                  child: Icon(Icons.add_circle_outlined,color : Colors.brown[300]),
                ),
                Flexible(
                  flex: 8,
                  child: Center(child: Text("Manual Entry")),
                ),
              ]),
              onPressed: () async {
                friendsList.insert(0, null);
                setState(() {});
              },
            ),
          ),
          SizedBox(
            height: 20,
          ),
          ..._getFriends(),
          SizedBox(
            height: 40,
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

  List<Widget> _getFriends() {
    List<Widget> friendsTextFields = [];
    List<Widget> friendsNumberFields = [];
    List<Widget> combinedFields = [];
    for (int i = 0; i < friendsList.length; i++) {
      friendsTextFields.add(Padding(
        padding: const EdgeInsets.symmetric(vertical: 1.0),
        child: Row(
          children: [
            Expanded(child: FriendTextFields(i)),
            SizedBox(
              width: 16,
            ),
            // we need add button at last friends row
            _addRemoveButton(false, i),
          ],
        ),
      ));
      friendsNumberFields.add(Padding(
        padding: const EdgeInsets.symmetric(vertical: 1.0),
        child: Row(
          children: [
            Expanded(child: FriendNumberFields(i)),
            SizedBox(
              width: 16,
            ),
          ],
        ),
      ));
      combinedFields.add(friendsTextFields[i]);
      combinedFields.add(friendsNumberFields[i]);
    }
    return combinedFields;
  }

  /// add / remove button
  Widget _addRemoveButton(bool add, int index) {
    return InkWell(
      onTap: () {
        if (add) {
          // add new text-fields at the top of all friends textfields
          friendsList.insert(0, null);
        } else
          friendsList.removeAt(index);
        setState(() {});
      },
      child: Container(
        width: 50,
        height: 50,
        child: Icon(
          (add) ? Icons.add : Icons.remove_circle,
          color: Colors.red,
          size: 40,
        ),
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

class FriendTextFields extends StatefulWidget {
  final int index;
  FriendTextFields(this.index);
  @override
  _FriendTextFieldsState createState() => _FriendTextFieldsState();
}

class _FriendTextFieldsState extends State<FriendTextFields> {
  TextEditingController _nameController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _nameController.text =
          _PrescriptionFormState.friendsList[widget.index] ?? '';
    });

    return Container(
        child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: TextFormField(
        controller: _nameController,
        onChanged: (v) => _PrescriptionFormState.friendsList[widget.index] = v,
        decoration: InputDecoration(
          hintText: 'Enter medicine name',
        ),
        validator: (v) {
          if (v.trim().isEmpty) return 'Please enter something';
          return null;
        },
      ),
    ));
  }
}

class FriendNumberFields extends StatefulWidget {
  final int index;
  FriendNumberFields(this.index);
  @override
  _FriendNumbersFieldsState createState() => _FriendNumbersFieldsState();
}

class _FriendNumbersFieldsState extends State<FriendNumberFields> {
  TextEditingController _nameController;
  bool checkedValueBreakfast = false;
  bool checkedValueLunch = false;
  bool checkedValueDinner = false;
  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _nameController.text =
          _PrescriptionFormState.friendsList[widget.index] ?? '';
    });

    return Container(
      //onChanged: (v) => _PrescriptionFormState.friendsList[widget.index] = v,
      child: Column(
        children: <Widget>[
          CheckboxListTile(
            title: Text("Breakfast"),
            value: checkedValueBreakfast,
            onChanged: (newValue) {
              setState(
                () {
                  checkedValueBreakfast = newValue;
                },
              );
            },
            controlAffinity: ListTileControlAffinity.leading,
          ),
          CheckboxListTile(
            title: Text("Lunch"),
            value: checkedValueLunch,
            onChanged: (newValue) {
              setState(
                () {
                  checkedValueLunch = newValue;
                },
              );
            },
            controlAffinity: ListTileControlAffinity.leading,
          ),
          CheckboxListTile(
            title: Text("Dinner"),
            value: checkedValueDinner,
            onChanged: (newValue) {
              setState(
                () {
                  checkedValueDinner = newValue;
                },
              );
            },
            controlAffinity: ListTileControlAffinity.leading,
          ),
        ],
      ),
    );
  }
}
