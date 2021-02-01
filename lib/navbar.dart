import 'package:flutter/material.dart';
import 'medical_logs.dart';
import 'prescription_logs.dart';
import 'Prescription.dart';
import 'MedicineBill.dart';
import 'Profile.dart';
import 'dashboard.dart';

class NavDrawer extends StatelessWidget {
  String userName;
  NavDrawer({Key key, @required this.userName}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          //Image.asset('assets/cover.png'),
          DrawerHeader(
            child: Text(
              ''+userName,
              style: TextStyle(color: Colors.white, fontSize: 25),
            ),
           
            decoration: BoxDecoration(
                color: Colors.brown,
                image: DecorationImage(
                    fit: BoxFit.fitHeight,
                    image: AssetImage('assets/womanavatar.png'))),
          ),
           
          ListTile(
            leading: Icon(Icons.input),
            title: Text('Input Prescription Image'),
            onTap: () => {
              Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => PrescriptionPage(userName: userName,),
                                    )),
            },
          ),
          ListTile(
            
            leading: Icon(Icons.verified_user),
            title: Text('Profile'),
            onTap: () => {
              Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => ProfilePage(userName: userName,),
                                    )),
            },
          ),
          ListTile(
            leading: Icon(Icons.book),
            title: Text('Prescription Logs'),
            onTap: () => {Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => Prescription_Logs(userName: userName,),
                                    )),},
          ),
          ListTile(
            leading: Icon(Icons.book),
            title: Text('Medical Logs'),
            onTap: () => {Navigator.of(context).pop()},
          ),
          ListTile(
            leading: Icon(Icons.border_color),
            title: Text('Input Medicine Bill Image'),
            onTap: () => {Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => MedicineBillPage(userName: userName,),
                                    )),},
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