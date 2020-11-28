import 'package:flutter/material.dart';
import 'medical_logs.dart';
import 'prescription_logs.dart';
import 'Prescription.dart';
import 'MedicineBill.dart';
import 'Profile.dart';

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
                    image: AssetImage('assets/womanavatar.png'))),
          ),
           
          ListTile(
            leading: Icon(Icons.input),
            title: Text('Upload Prescription'),
            onTap: () => {
              Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => PrescriptionPage(title:'MyMediMate'),
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
                                      builder: (context) => ProfilePage(title:'My MediMate'),
                                    )),
            },
          ),
          ListTile(
            leading: Icon(Icons.book),
            title: Text('Prescription Logs'),
            onTap: () => {Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => Prescription_Logs(),
                                    )),},
          ),
          ListTile(
            leading: Icon(Icons.book),
            title: Text('Medical Logs'),
            onTap: () => {Navigator.of(context).pop()},
          ),
          ListTile(
            leading: Icon(Icons.border_color),
            title: Text('Upload bill'),
            onTap: () => {Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => MedicineBillPage(title:'My MediMate'),
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