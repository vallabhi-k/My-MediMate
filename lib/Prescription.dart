import 'dart:io';
import 'package:flutter/material.dart';
import 'package:medi_mate/Prescription_image.dart';
import 'package:medi_mate/Prescription_manual.dart';
import 'navbar.dart';
import 'dashboard.dart';

class PrescriptionPage extends StatefulWidget {
  String userName;
  String userPhone;
  PrescriptionPage({Key key, @required this.userName,this.userPhone}) : super(key: key);
  @override
  _PrescriptionState createState() => _PrescriptionState(userName: userName,userPhone: userPhone);
}

class _PrescriptionState extends State<PrescriptionPage> {
  String userName;
  String userPhone;
  _PrescriptionState({Key key, @required this.userName,this.userPhone});
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
      body: SingleChildScrollView (child : PrescriptionForm(userName: userName,userPhone: userPhone,),),
    );
  }
}

class PrescriptionForm extends StatefulWidget {
  String userName;
  String userPhone;
  PrescriptionForm({Key key, @required this.userName,this.userPhone});
  @override
  _PrescriptionFormState createState() => _PrescriptionFormState(userName: userName,userPhone: userPhone);
}

class _PrescriptionFormState extends State<PrescriptionForm> {
  String userName;
  String userPhone;
  _PrescriptionFormState({Key key, @required this.userName,this.userPhone});
  @override
  Widget build(BuildContext context) {
    return Column(
      children:<Widget> [
      Padding(
        padding: const EdgeInsets.only(left: 20.0, right: 20.0, top: 20.0),
        child:RaisedButton(
          color : const Color(0xFFFFC7C7),
              child:Center(
                  child:Text("Input Prescription From Image")
              ),
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => Prescription_Image(userName: userName,),
                ));
          },
        ),
       ),
      Padding(
      padding: const EdgeInsets.only(left: 20.0, right: 20.0, top: 20.0),
      child:RaisedButton(
          color : const Color(0xFFFFC7C7),
            child:Center(
              child: Text("Input Prescription Manually"),
            ),
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => Prescription_Manual(userName: userName,userPhone: userPhone,),
                ));
          },
        ),
      ),
      ],
    );
  }
}