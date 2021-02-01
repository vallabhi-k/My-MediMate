import 'package:flutter/material.dart';
import 'navbar.dart';
import 'Database.dart';

class Prescription_Logs extends StatefulWidget {
  String userName;
  Prescription_Logs({Key key, @required this.userName}) : super(key: key);
  @override
  _Prescription_LogsState createState() => _Prescription_LogsState(userName: userName);
}

class _Prescription_LogsState extends State<Prescription_Logs> {
  String userName;
  _Prescription_LogsState({Key key, @required this.userName});
  Database d = new Database();

  @override
  Widget build(BuildContext context) {
    var data = d.getMedicineLogs("+919833515264");
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(100.0),
          child: AppBar(
            title: Image.asset("assets/logo_text.png",width:200,height:100),
            centerTitle: true,
          )),
          drawer:NavDrawer(userName: userName,),
      body: Column(children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(8.0),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Table(
            // textDirection: TextDirection.rtl,
            // defaultVerticalAlignment: TableCellVerticalAlignment.bottom,
            //border: TableBorder.all(width: 2.0, color: Colors.yellow),
            children: [
              TableRow(children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(top: 5.0),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 5.0),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 5.0),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 5.0),
                ),
              ]),
              TableRow(
                  decoration: BoxDecoration(
                      border: Border(
                          right: BorderSide(width: 2.0, color: Colors.white)),
                      color: const Color(0xFFFAC7C7)),
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(top: 2.0),
                      child: Image(
                        image: AssetImage('assets/Gallery.png'),
                        height: 90.0,
                        width: 90.0,
                      ),
                    ),
                    Padding(
                        padding: const EdgeInsets.only(top: 5.0),
                        child: Center(
                            child: Text(
                          "26-11-20",
                          textScaleFactor: 1.2,
                          textAlign: TextAlign.center,
                        ))),
                    Padding(
                        padding: const EdgeInsets.only(top: 5.0),
                        child: Center(
                            child: Text(
                          "Jaundice",
                          textScaleFactor: 1.2,
                          textAlign: TextAlign.center,
                        ))),
                    Padding(
                      padding: const EdgeInsets.only(top: 2.0),
                      child: Image(
                        image: AssetImage('assets/Megaphone.png'),
                        height: 60.0,
                        width: 50.0,
                      ),
                    ),
                  ]),
              TableRow(children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(top: 5.0),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 5.0),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 5.0),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 5.0),
                ),
              ]),
              TableRow(
                  decoration: BoxDecoration(
                      border: Border(
                        right: BorderSide(width: 2.0, color: Colors.white),
                      ),
                      color:const Color(0xFFFFC7C7)),
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(top: 2.0),
                      child: Image(
                        image: AssetImage('assets/Gallery.png'),
                        height: 90.0,
                        width: 90.0,
                      ),
                    ),
                    Padding(
                        padding: const EdgeInsets.only(top: 5.0),
                        child: Center(
                            child: Text(
                          "26-11-20",
                          textScaleFactor: 1.2,
                          textAlign: TextAlign.center,
                        ))),
                    Padding(
                        padding: const EdgeInsets.only(top: 5.0),
                        child: Center(
                            child: Text(
                          "Jaundice",
                          textScaleFactor: 1.2,
                          textAlign: TextAlign.center,
                        ))),
                    Padding(
                      padding: const EdgeInsets.only(top: 2.0),
                      child: Image(
                        image: AssetImage('assets/Megaphone.png'),
                        height: 60.0,
                        width: 50.0,
                      ),
                    ),
                  ]),
            ],
          ),
        ),
      ]),
    );
  }
}
