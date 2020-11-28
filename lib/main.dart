import 'dart:async';
import 'package:flutter/material.dart';
import 'signup.dart';
import 'select_language.dart';

Map<int, Color> color = {
  50: Color.fromRGBO(136, 14, 79, .1),
  100: Color.fromRGBO(136, 14, 79, .2),
  200: Color.fromRGBO(136, 14, 79, .3),
  300: Color.fromRGBO(136, 14, 79, .4),
  400: Color.fromRGBO(136, 14, 79, .5),
  500: Color.fromRGBO(136, 14, 79, .6),
  600: Color.fromRGBO(136, 14, 79, .7),
  700: Color.fromRGBO(136, 14, 79, .8),
  800: Color.fromRGBO(136, 14, 79, .9),
  900: Color.fromRGBO(136, 14, 79, 1),
};
void main() => runApp(MyApp());
// ignore: non_constant_identifier_names
MaterialColor final_color = MaterialColor(0xFFE2E2, color);

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My MediMate',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primaryColor: const Color(0xFFFFE2E2),
        //primaryColor: Colors.yellow,
        accentColor: const Color(0xFFFAC7C7),
        //primarySwatch: Colors.pink,
      ),
      //home: MyHomePage(title: 'Flutter Demo Home Page'),
      home: SplashPage(),
    );
  }
}

class SplashPage extends StatefulWidget {
  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    Timer(
        Duration(seconds: 3),
        () => Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => SelectLanguagePage())));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFFFFE2E2),
      child: Column(children: [
        Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(
                  left: 35.0, top: 70.0, right: 5.0, bottom: 20.0),
              child: Image.asset('assets/logo_text.png'),
            ),
            /*Text("My MediMate",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 32.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.pink,
                )),
                */
          ],
        ),
        Padding(
          padding: const EdgeInsets.only(
              left: 8.0, top: 20.0, right: 8.0, bottom: 50.0),
        ),
        Row(
          children: [
            Image.asset(
              'assets/splash_screen_img.png',
              width: 350.0,
              height: 300.0,
              fit: BoxFit.fill,
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.only(
              left: 1.0, top: 80.0, right: 8.0, bottom: 50.0),
        ),
        Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(
                  left: 20.0, top: 10.0, right: 8.0, bottom: 50.0),
            ),
            Image.asset(
              'assets/hand_with_pill.png',
              color: const Color(0xFFFFE2E2),
              colorBlendMode: BlendMode.softLight,
            ),
          ],
        ),
      ]),
    );
  }
}
//class SignUpPage extends
/*
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavDrawer(),
      appBar: AppBar(
        title: Text('My mediMate'),
      ),
      body: Center(
        child: Text(''),
      ),
    );
  }
}

class NavDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          //Image.asset('assets/cover.png'),
          DrawerHeader(
            child: Text(
              'Sameeksha',
              style: TextStyle(color: Colors.white, fontSize: 25),
            ),
            decoration: BoxDecoration(
                color: Colors.brown,
                image: DecorationImage(
                    fit: BoxFit.fitHeight,
                    image: AssetImage('assets/cover.png'))),
          ),
          ListTile(
            leading: Icon(Icons.input),
            title: Text('Upload Prescription'),
            onTap: () => {},
          ),
          ListTile(
            leading: Icon(Icons.verified_user),
            title: Text('Profile'),
            onTap: () => {Navigator.of(context).pop()},
          ),
          ListTile(
            leading: Icon(Icons.book),
            title: Text('Prescription Logs'),
            onTap: () => {Navigator.of(context).pop()},
          ),
          ListTile(
            leading: Icon(Icons.book),
            title: Text('Medical Logs'),
            onTap: () => {Navigator.of(context).pop()},
          ),
          ListTile(
            leading: Icon(Icons.border_color),
            title: Text('Upload bill'),
            onTap: () => {Navigator.of(context).pop()},
          ),
          ListTile(
            leading: Icon(Icons.chat),
            title: Text('Chat'),
            onTap: () => {Navigator.of(context).pop()},
          ),
        ],
      ),
    );
  }
}
*/
