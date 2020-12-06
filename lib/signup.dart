import 'package:flutter/material.dart';
import 'Login.dart';
import 'otp.dart';
import 'prescription_logs.dart';
import 'package:flutter_otp/flutter_otp.dart';
import 'package:sms/sms.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  TextEditingController emailEditingContrller = TextEditingController();
  FlutterOtp otp = FlutterOtp();
  final _formKey = GlobalKey<FormState>();
  String mobileNumber;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //resizeToAvoidBottomInset: false,
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(100.0),
          child: AppBar(
            title: Image.asset("assets/logo_text.png",width:200,height:100),
            centerTitle: true,
          )),
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            color: Colors.white,
            padding: EdgeInsets.all(24),
            child: Form(
              key: _formKey,
            child: Center(
              child: Column(
                children: <Widget>[
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Log In",style: TextStyle(fontSize: 32.0, fontWeight: FontWeight.bold,color:Colors.black),
                  ),
                  Center(
                    child: SizedBox(
                      width: 0,
                      height: 0,
                     
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                   
                  TextFormField(
                    autofocus: false,
                    obscureText: false,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                        labelText: "Name",
                        hintText: "Name",
                        labelStyle: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                        ),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(4)),
                            borderSide: BorderSide(
                                width: 1,
                                color: Colors.green,
                                style: BorderStyle.solid))),
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Please enter Name';
                      }
                      return null;
                    },
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    autofocus: false,
                    obscureText: false,
                    keyboardType: TextInputType.number,
                    //controller: emailEditingContrller,
                    decoration: InputDecoration(
                        labelText: "Mobile Number",
                        hintText: "Mobile Number",
                        labelStyle: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                        ),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(4)),
                            borderSide: BorderSide(
                                width: 1,
                                color: Colors.green,
                                style: BorderStyle.solid))),
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Please enter Mobile Number';
                      }
                      mobileNumber = value;
                      return null;
                    },
                  ),

                  SizedBox(
                    height: 40,
                  ),
                  ButtonTheme(
                    //elevation: 4,
                    //color: Colors.green,
                    minWidth: double.infinity,
                    child: MaterialButton(
                      onPressed: () {
                      if (_formKey.currentState.validate()) {
                        otp.sendOtp("9833515265", "OTP is", 1000, 9999, '+91');
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => OtpPage(),
                              settings: RouteSettings(arguments: mobileNumber,)
                            ));
                      }
                      },
                      textColor: Colors.white,
                      color: const Color(0xFFFAC7C7),
                      
                      height: 50,
                      child: Text("Create an account"),
                    ),
                  ),

                ],
              ),
            ),
            ),
          ),
        ),
      ),
    );
  }
}
