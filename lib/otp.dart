import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dashboard.dart';

class OtpPage extends StatefulWidget {
  @override
  OtpPageState createState() => OtpPageState();
}

class OtpPageState extends State<OtpPage> {
  TextEditingController controller1 = new TextEditingController();
  TextEditingController controller2 = new TextEditingController();
  TextEditingController controller3 = new TextEditingController();
  TextEditingController controller4 = new TextEditingController();
  TextEditingController controller5 = new TextEditingController();
  TextEditingController controller6 = new TextEditingController();

  TextEditingController currController = new TextEditingController();

  @override
  void dispose() {
    super.dispose();
    controller1.dispose();
    controller2.dispose();
    controller3.dispose();
    controller4.dispose();
    //controller5.dispose();
    //controller6.dispose();
  }

  @override
  void initState() {
    super.initState();
    currController = controller1;
  }

  @override
  Widget build(BuildContext context) {
    String mobileNumber = ModalRoute.of(context).settings.arguments;
    List<Widget> widgetList = [
      Padding(
        padding: EdgeInsets.only(left: 0.0, right: 2.0),
        child: new Container(
          color: Colors.transparent,
        ),
      ),
      Padding(
        padding: const EdgeInsets.only(right: 2.0, left: 2.0),
        child: new Container(
            alignment: Alignment.center,
            decoration: new BoxDecoration(
                color: Color.fromRGBO(0, 0, 0, 0.1),
                border: new Border.all(
                    width: 3.0, color: Color.fromRGBO(0, 0, 0, 0.1)),
                borderRadius: new BorderRadius.circular(6.0)),
            child: new TextField(
              inputFormatters: [
                LengthLimitingTextInputFormatter(1),
              ],
              enabled: false,
              controller: controller1,
              autofocus: false,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 24.0, color: Colors.black),
            )),
      ),
      Padding(
        padding: const EdgeInsets.only(right: 2.0, left: 2.0),
        child: new Container(
          alignment: Alignment.center,
          decoration: new BoxDecoration(
              color: Color.fromRGBO(0, 0, 0, 0.1),
              border: new Border.all(
                  width: 3.0, color: Color.fromRGBO(0, 0, 0, 0.1)),
              borderRadius: new BorderRadius.circular(6.0)),
          child: new TextField(
            inputFormatters: [
              LengthLimitingTextInputFormatter(1),
            ],
            controller: controller2,
            autofocus: false,
            enabled: false,
            keyboardType: TextInputType.number,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 24.0, color: Colors.black),
          ),
        ),
      ),
      Padding(
        padding: const EdgeInsets.only(right: 2.0, left: 2.0),
        child: new Container(
          alignment: Alignment.center,
          decoration: new BoxDecoration(
              color: Color.fromRGBO(0, 0, 0, 0.1),
              border: new Border.all(
                  width: 3.0, color: Color.fromRGBO(0, 0, 0, 0.1)),
              borderRadius: new BorderRadius.circular(6.0)),
          child: new TextField(
            inputFormatters: [
              LengthLimitingTextInputFormatter(1),
            ],
            keyboardType: TextInputType.number,
            controller: controller3,
            textAlign: TextAlign.center,
            autofocus: false,
            enabled: false,
            style: TextStyle(fontSize: 24.0, color: Colors.black),
          ),
        ),
      ),
      Padding(
        padding: const EdgeInsets.only(right: 2.0, left: 2.0),
        child: new Container(
          alignment: Alignment.center,
          decoration: new BoxDecoration(
              color: Color.fromRGBO(0, 0, 0, 0.1),
              border: new Border.all(
                  width: 3.0, color: Color.fromRGBO(0, 0, 0, 0.1)),
              borderRadius: new BorderRadius.circular(6.0)),
          child: new TextField(
            inputFormatters: [
              LengthLimitingTextInputFormatter(1),
            ],
            textAlign: TextAlign.center,
            controller: controller4,
            autofocus: false,
            enabled: false,
            style: TextStyle(fontSize: 24.0, color: Colors.black),
          ),
        ),
      ),
      Padding(
        padding: EdgeInsets.only(left: 2.0, right: 0.0),
        child: new Container(
          color: Colors.transparent,
        ),
      ),
    ];

    return new Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(100.0),
          child: AppBar(
            title: Image.asset("assets/logo_text.png",width:200,height:100),
            centerTitle: true,
          )),
      backgroundColor: Color(0xFFeaeaea),
      body: Container(
        child: Column(
          children: <Widget>[
            Flexible(
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(top: 10.0),
                    child: Image(
                      image: AssetImage('assets/SMS.png'),
                      height: 120.0,
                      width: 120.0,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 2.0, bottom: 10.0),
                    child: Text(
                      "Verification!",
                      style: TextStyle(
                          fontSize: 18.0, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 16.0, top: 5.0, right: 16.0),
                    child: Text(
                      "Please type the verification code sent to",
                      style: TextStyle(
                          fontSize: 15.0, fontWeight: FontWeight.normal),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 30.0, top: 2.0, right: 30.0),
                    child: Text(
                      ("+91 "+mobileNumber),
                      style: TextStyle(
                          fontSize: 15.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.brown[300],
                          ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
              flex: 90,
            ),
            Flexible(
              child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    GridView.count(
                        crossAxisCount: 6,
                        mainAxisSpacing: 10.0,
                        shrinkWrap: true,
                        primary: false,
                        scrollDirection: Axis.vertical,
                        children: List<Container>.generate(
                            6,
                            (int index) =>
                                Container(child: widgetList[index]))),
                  ]),
              flex: 30,
            ),
            Flexible(
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  new Container(
                    child: Padding(
                      padding: const EdgeInsets.only(
                          left: 8.0, top: 8.0, right: 8.0, bottom: 0.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          MaterialButton(
                            onPressed: () {
                              inputTextToField("1");
                            },
                            child: Text("1",
                                style: TextStyle(
                                    fontSize: 25.0,
                                    fontWeight: FontWeight.w400),
                                textAlign: TextAlign.center),
                          ),
                          MaterialButton(
                            onPressed: () {
                              inputTextToField("2");
                            },
                            child: Text("2",
                                style: TextStyle(
                                    fontSize: 25.0,
                                    fontWeight: FontWeight.w400),
                                textAlign: TextAlign.center),
                          ),
                          MaterialButton(
                            onPressed: () {
                              inputTextToField("3");
                            },
                            child: Text("3",
                                style: TextStyle(
                                    fontSize: 25.0,
                                    fontWeight: FontWeight.w400),
                                textAlign: TextAlign.center),
                          ),
                        ],
                      ),
                    ),
                  ),
                  new Container(
                    child: Padding(
                      padding: const EdgeInsets.only(
                          left: 8.0, top: 4.0, right: 8.0, bottom: 0.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          MaterialButton(
                            onPressed: () {
                              inputTextToField("4");
                            },
                            child: Text("4",
                                style: TextStyle(
                                    fontSize: 25.0,
                                    fontWeight: FontWeight.w400),
                                textAlign: TextAlign.center),
                          ),
                          MaterialButton(
                            onPressed: () {
                              inputTextToField("5");
                            },
                            child: Text("5",
                                style: TextStyle(
                                    fontSize: 25.0,
                                    fontWeight: FontWeight.w400),
                                textAlign: TextAlign.center),
                          ),
                          MaterialButton(
                            onPressed: () {
                              inputTextToField("6");
                            },
                            child: Text("6",
                                style: TextStyle(
                                    fontSize: 25.0,
                                    fontWeight: FontWeight.w400),
                                textAlign: TextAlign.center),
                          ),
                        ],
                      ),
                    ),
                  ),
                  new Container(
                    child: Padding(
                      padding: const EdgeInsets.only(
                          left: 8.0, top: 4.0, right: 8.0, bottom: 0.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          MaterialButton(
                            onPressed: () {
                              inputTextToField("7");
                            },
                            child: Text("7",
                                style: TextStyle(
                                    fontSize: 25.0,
                                    fontWeight: FontWeight.w400),
                                textAlign: TextAlign.center),
                          ),
                          MaterialButton(
                            onPressed: () {
                              inputTextToField("8");
                            },
                            child: Text("8",
                                style: TextStyle(
                                    fontSize: 25.0,
                                    fontWeight: FontWeight.w400),
                                textAlign: TextAlign.center),
                          ),
                          MaterialButton(
                            onPressed: () {
                              inputTextToField("9");
                            },
                            child: Text("9",
                                style: TextStyle(
                                    fontSize: 25.0,
                                    fontWeight: FontWeight.w400),
                                textAlign: TextAlign.center),
                          ),
                        ],
                      ),
                    ),
                  ),
                  new Container(
                    child: Padding(
                      padding: const EdgeInsets.only(
                          left: 8.0, top: 4.0, right: 8.0, bottom: 0.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          MaterialButton(
                              onPressed: () {
                                deleteText();
                              },
                              child: Image.asset('assets/delete.png',
                                  width: 25.0, height: 25.0)),
                          MaterialButton(
                            onPressed: () {
                              inputTextToField("0");
                            },
                            child: Text("0",
                                style: TextStyle(
                                    fontSize: 25.0,
                                    fontWeight: FontWeight.w400),
                                textAlign: TextAlign.center),
                          ),
                          MaterialButton(
                              onPressed: () {
                                //matchOtp();
                                Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>
                                    Dashboard()), (Route<dynamic> route) => false);

                              },
                              child: Image.asset('assets/success.png',
                                  width: 25.0, height: 25.0)),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              flex: 90,
            ),
          ],
        ),
      ),
    );
  }

  void inputTextToField(String str) {
    //Edit first textField
    if (currController == controller1) {
      controller1.text = str;
      currController = controller2;
    }

    //Edit second textField
    else if (currController == controller2) {
      controller2.text = str;
      currController = controller3;
    }

    //Edit third textField
    else if (currController == controller3) {
      controller3.text = str;
      currController = controller4;
    }

    //Edit fourth textField
    else if (currController == controller4) {
      controller4.text = str;
      currController = controller5;
    }
  }

  void deleteText() {
    if (currController.text.length == 0) {
    } else {
      currController.text = "";
      currController = controller5;
      return;
    }

    if (currController == controller1) {
      controller1.text = "";
    } else if (currController == controller2) {
      controller1.text = "";
      currController = controller1;
    } else if (currController == controller3) {
      controller2.text = "";
      currController = controller2;
    } else if (currController == controller4) {
      controller3.text = "";
      currController = controller3;
    }
  }

  void matchOtp() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Successfully"),
            content: Text("Otp matched successfully."),
            actions: <Widget>[
              IconButton(
                  icon: Icon(Icons.check),
                  onPressed: () {
                    Navigator.of(context).pop();
                  })
            ],
          );
        });
  }
}
