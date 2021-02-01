import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'Login.dart';
import 'otp.dart';
import 'prescription_logs.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dashboard.dart';
import 'Database.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  //TextEditingController emailEditingContrller = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  String mobileNumber;
  String username;
  final _phoneController = TextEditingController();
  final _userController = TextEditingController();
  final _codeController = TextEditingController();
  FirebaseUser user;
  Database d = new Database();
  Future<bool> loginUser(String phone, BuildContext context) async{
    FirebaseAuth _auth = FirebaseAuth.instance;
    _auth.verifyPhoneNumber(
        phoneNumber: phone,
        timeout: Duration(seconds: 60),
        verificationCompleted: (AuthCredential credential) async{
          Navigator.of(context).pop();

          AuthResult result = await _auth.signInWithCredential(credential);

          FirebaseUser user = result.user;
          print("user");
          print(user);
          if(user != null){
            Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>
                Dashboard(userPhone: mobileNumber,userName: username,)), (Route<dynamic> route) => false);
          }else{
            print("Error");
          }

          //This callback would gets called when verification is done auto maticlly
        },
        verificationFailed: (AuthException exception){
          print(exception);
          print('Phone number verification failed. Code: ${exception.code}. Message: ${exception.message}');
        },
        codeSent: (String verificationId, [int forceResendingToken]){
          showDialog(
              context: context,
              barrierDismissible: false,
              builder: (context) {
                return AlertDialog(
                  title: Text("Enter Otp"),
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      TextField(
                        controller: _codeController,
                      ),
                    ],
                  ),
                  actions: <Widget>[
                    FlatButton(
                      child: Text("Confirm"),
                      textColor: Colors.white,
                      color: Colors.blue,
                      onPressed: () async{
                        final code = _codeController.text.trim();
                        AuthCredential credential = PhoneAuthProvider.getCredential(verificationId: verificationId, smsCode: code);

                        AuthResult result = await _auth.signInWithCredential(credential);

                        FirebaseUser user = result.user;

                        if(user != null){
                          d.saveUser(username, mobileNumber);
                          Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>
                              Dashboard(userPhone: mobileNumber,userName: username,)), (Route<dynamic> route) => false);
                        }else{
                          print("Error");
                        }
                      },
                    )
                  ],
                );
              }
          );
        },
        codeAutoRetrievalTimeout: null
    );
  }

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
                    controller: _userController,
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
                      username = value;
                      return null;
                    },
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    controller: _phoneController,
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
                      mobileNumber = "+91"+value;
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
                            loginUser(mobileNumber, context);
                      }
                      },
                      textColor: Colors.white,
                      color: const Color(0xFFFAC7C7),
                      
                      height: 50,
                      child: Text("Login"),
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
