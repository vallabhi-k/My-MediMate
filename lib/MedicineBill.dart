//import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'navbar.dart';
import 'MedicineBill_image.dart';
import 'MedicineBill_manual.dart';
class MedicineBillPage extends StatefulWidget {
  String userName;
  String userPhone;
  MedicineBillPage({Key key, @required this.userName,this.userPhone}) : super(key: key);

  @override
  _MedicineBillState createState() => _MedicineBillState(userName: userName,userPhone: userPhone);
}

class _MedicineBillState extends State<MedicineBillPage> {
  String userName;
  String userPhone;
  _MedicineBillState({Key key, @required this.userName,this.userPhone});
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
      body: SingleChildScrollView (child : MedicineBillForm(userName: userName,userPhone: userPhone,),),
    );
  }
}


class MedicineBillForm extends StatefulWidget {
  String userName;
  String userPhone;
  MedicineBillForm({Key key, @required this.userName,this.userPhone}) : super(key: key);
  @override
  _MedicineBillFormState createState() => _MedicineBillFormState(userName: userName,userPhone: userPhone);
}

class _MedicineBillFormState extends State<MedicineBillForm> {
  String userName;
  String userPhone;
  _MedicineBillFormState({Key key, @required this.userName,this.userPhone});
  @override
  Widget build(BuildContext context) {
    return Column(
      children:<Widget> [
        Padding(
          padding: const EdgeInsets.only(left: 20.0, right: 20.0, top: 20.0),
          child:RaisedButton(
            color : const Color(0xFFFFC7C7),
            child:Center(
                child:Text("Input Medicine Bill From Image")
            ),
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MedicineBill_image(userName: userName,),
                  ));
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 20.0, right: 20.0, top: 20.0),
          child:RaisedButton(
            color : const Color(0xFFFFC7C7),
            child:Center(
              child: Text("Input Medicine Bill Manually"),
            ),
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MedicineBill_Manual(userName: userName,userPhone: userPhone,),
                  ));
            },
          ),
        ),
      ],
    );
  }
}