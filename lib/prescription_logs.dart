import 'package:flutter/material.dart';

class Prescription_Logs extends StatefulWidget {
  @override
  _Prescription_LogsState createState() => _Prescription_LogsState();
}

class _Prescription_LogsState extends State<Prescription_Logs> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Prescription Log"),
        backgroundColor: Colors.pink,
        centerTitle: true,
      ),
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
                      color: Colors.pink),
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
                      color: Colors.pink),
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
