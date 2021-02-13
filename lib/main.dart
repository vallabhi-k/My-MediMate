import 'dart:async';
import 'package:flutter/material.dart';
import 'package:medi_mate/Database.dart';
import 'package:medi_mate/dashboard.dart';
import 'signup.dart';
import 'select_language.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'MedicineReminder.dart';
import 'Prescription_manual.dart';

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
final FirebaseAuth _auth = FirebaseAuth.instance;
class _SplashPageState extends State<SplashPage> {
  Database d = new Database();
  var flutterLocalNotificationsPlugin = new FlutterLocalNotificationsPlugin();
  String userPhone;
  initializeNotifications() async {
    var initializationSettingsAndroid =
    AndroidInitializationSettings('@mipmap/ic_launcher');
    var initializationSettingsIOS = IOSInitializationSettings();
    var initializationSettings = InitializationSettings(
        android: initializationSettingsAndroid, iOS: initializationSettingsIOS);
    await flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onSelectNotification: onSelectNotification);
  }

  Future onSelectNotification(String payload) async {
    print('Notification clicked');
    print(payload);
    if(payload!=null) {
      Navigator.push(context,
          MaterialPageRoute(builder: (context) =>
              MedicineReminder(userPhone: userPhone)));
    }
    //return Future.value(0);
  }

  @override
  void initState() {
    super.initState();
    Timer(
        Duration(seconds: 3),
        () {
          getUser().then((user) async {
            if(user != null){
              userPhone =user.phoneNumber.toString();
              String username = await  d.getUser(user.phoneNumber.toString());
              //print(user.phoneNumber.toString());
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => Dashboard(userPhone:user.phoneNumber.toString(),userName: username.toString(),)));
            }
            else
              {
                Navigator.pushReplacement(context,MaterialPageRoute(builder: (context) => SelectLanguagePage()));
                //Navigator.pushReplacement(context,MaterialPageRoute(builder: (context) =>Prescription_Manual(userName: "Sameeksha",userPhone: "+919833515264",)));
                //Navigator.pushReplacement(context,MaterialPageRoute(builder: (context) =>MedicineReminder(userPhone: "+919833515264",)));
              }
          });
        });
    initializeNotifications();
  }

  Future<FirebaseUser> getUser() async {
    return await _auth.currentUser();
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
                  left: 60.0, top: 70.0, right: 5.0),
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
              left: 20.0, top: 80.0, right: 20.0, bottom: 50.0),
        child:Row(
          children: [
            Image.asset(
              'assets/splash_screen_img.png',
              width: 350.0,
              height: 300.0,
              fit: BoxFit.fill,
            ),
          ],
        ),),
        Padding(
          padding: const EdgeInsets.only(
              left: 1.0, top: 50.0, right: 8.0, bottom: 50.0),
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
