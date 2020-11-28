import 'package:flutter/material.dart';
import 'Login.dart';
import 'otp.dart';
import 'prescription_logs.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  TextEditingController emailEditingContrller = TextEditingController();

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
            child: Center(
              child: Column(
                children: <Widget>[
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Sign Up",style: TextStyle(fontSize: 32.0, fontWeight: FontWeight.bold,color:Colors.black),
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
                   
                  TextField(
                    autofocus: false,
                    obscureText: false,
                    keyboardType: TextInputType.text,
                    controller: emailEditingContrller,
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
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextField(
                    autofocus: false,
                    obscureText: true,
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
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => OtpPage(),
                            ));
                      },
                      textColor: Colors.white,
                      color: const Color(0xFFFAC7C7),
                      
                      height: 50,
                      child: Text("Create an account"),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  FlatButton(
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => Login()));
                    },
                    textColor: Colors.brown[300],
                    child: Text('Already have account. Log In'),
                  ),
                  FlatButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Prescription_Logs()));
                    },
                    textColor: Colors.black,
                    
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
