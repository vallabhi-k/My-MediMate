import 'dart:async';
import 'dart:io';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'navbar.dart';
import 'Database.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'dashboard.dart';
import 'package:android_alarm_manager/android_alarm_manager.dart';

class Prescription_Manual extends StatefulWidget {
  String userName;
  String userPhone;
  Prescription_Manual({Key key, @required this.userName,this.userPhone}) : super(key: key);

  @override
  _PrescriptionManual createState() => _PrescriptionManual(userName: userName,userPhone: userPhone);
}

class _PrescriptionManual extends State<Prescription_Manual> {
  String userName;
  String userPhone;
  _PrescriptionManual({Key key, @required this.userName,this.userPhone});
  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(100.0),
          child: AppBar(
            title: Image.asset("assets/logo_text.png",width:200,height:100),
            centerTitle: true,
          )),
      drawer: NavDrawer(userName: userName,),
      body: SingleChildScrollView (child : PrescriptionManualForm(userPhone: userPhone,),),
    );
  }
}

class PrescriptionManualForm extends StatefulWidget {
  String userPhone;
  PrescriptionManualForm({Key key, @required this.userPhone}) : super(key: key);
  @override
  _PrescriptionManualFormState createState() => _PrescriptionManualFormState(userPhone: userPhone);
}

class _PrescriptionManualFormState extends State<PrescriptionManualForm> {
  String userPhone;
  _PrescriptionManualFormState({Key key, @required this.userPhone});
  final _formKey = GlobalKey<FormState>();
  Database d = new Database();
  TextEditingController _nameController;
  TextEditingController _DiseasesController;
  TextEditingController _CourseController;
  TextEditingController _numberController;
  static List<String> MedicineList = [null];
  static List<bool> BreakfastList = [null];
  static List<bool> LunchList = [null];
  static List<bool> DinnerList = [null];
  String DiseasesName="";
  String CourseDays="";

  //var flutterLocalNotificationsPlugin = new FlutterLocalNotificationsPlugin();

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
    _numberController = TextEditingController();
    _CourseController = TextEditingController();
    _DiseasesController = TextEditingController();
    //initializeNotifications();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _numberController.dispose();
    _CourseController.dispose();
    _DiseasesController.dispose();
    super.dispose();
  }

  /*initializeNotifications() async {
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
    return Future.value(0);
  }*/

  @override
  Widget build(BuildContext context) {
    _DiseasesController.text = DiseasesName;
    _CourseController.text = CourseDays;
    return Form(
      key: _formKey,
      child: Column(
        children: <Widget>[
          ListTile(
            leading: Icon(Icons.medical_services_outlined,color:Colors.brown[300]),
            title: TextFormField(
              controller: _DiseasesController,
              decoration: InputDecoration(
                hintText: "Disease Name",
              ),
              onChanged: (v)=>DiseasesName = v,
              validator: (value) {
                if (value.isEmpty) {
                  return 'Please enter Disease Name';
                }

                return null;
              },
            ),
          ),
          ListTile(
            leading: Icon(Icons.calendar_today_rounded,color:Colors.brown[300]),
            title: TextFormField(
              controller: _CourseController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                hintText: "Number of days for the course",
              ),
              onChanged: (v)=>CourseDays = v,
              validator: (value) {
                if (value.isEmpty) {
                  return 'Please enter Disease Name';
                }

                return null;
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: RaisedButton(
              color : const Color(0xFFFFC7C7),

              child: Row(children: [
                Flexible(
                  flex: 1,
                  child: Icon(Icons.add_circle_outlined,color : Colors.brown[300]),
                ),
                Flexible(
                  flex: 8,
                  child: Center(child: Text("Add Medicine")),
                ),
              ]),
              onPressed: () async {
                MedicineList.insert(0, null);
                BreakfastList.insert(0, false);
                LunchList.insert(0, false);
                DinnerList.insert(0, false);
                setState(() {});
              },
            ),
          ),
          SizedBox(
            height: 20,
          ),
          ..._getFriends(),
          SizedBox(
            height: 40,
          ),
          ElevatedButton(
            onPressed: () async {
              if (_formKey.currentState.validate()) {
                Scaffold.of(context).showSnackBar(SnackBar(
                  content: Text('Saving Data'),
                ));
                /*var BreakfastTime;
                var LunchTime;
                var DinnerTime;
                await d.getProfile(userPhone).then((DataSnapshot data) async{
                  BreakfastTime = (data.value["BreakfastTime"]);
                  LunchTime = (data.value["LunchTime"]);
                  DinnerTime = (data.value["DinnerTime"]);
                });
                  int btemphr = int.parse(BreakfastTime.split(":")[0]);
                  var btemp = BreakfastTime.split(":")[1];
                  int btempmin = int.parse(btemp.split(" ")[0]);
                  String btempnoon = (btemp.split(" ")[1]).toString();
                  if (btempnoon == "PM" && btemphr<12)
                    btemphr+=12;
                  int ltemphr = int.parse(LunchTime.split(":")[0]);
                  var ltemp = LunchTime.split(":")[1];
                  int ltempmin = int.parse(ltemp.split(" ")[0]);
                  String ltempnoon = ltemp.split(" ")[1].toString();
                  if (ltempnoon == "PM" && ltemphr<12)
                    ltemphr+=12;
                  int dtemphr = int.parse(DinnerTime.split(":")[0]);
                  var dtemp = DinnerTime.split(":")[1];
                  int dtempmin = int.parse(dtemp.split(" ")[0]);
                  String dtempnoon = (dtemp.split(" ")[1]).toString();
                  if (dtempnoon == "PM" && dtemphr<12)
                    dtemphr+=12;
                  int temph;
                  int tempm;
                  bool breakfastcheck = false;
                  bool lunchcheck = false;
                  bool dinnercheck = false;
                  if(btemphr-(DateTime.now().hour)>0 && btempmin-(DateTime.now().minute)>0)
                    {
                      temph = btemphr-(DateTime.now().hour);
                      tempm = btempmin-(DateTime.now().minute);
                      breakfastcheck = true;
                    }
                  else if(ltemphr-(DateTime.now().hour)>0 && ltempmin-(DateTime.now().minute)>0)
                    {
                      temph = ltemphr-(DateTime.now().hour);
                      tempm = ltempmin-(DateTime.now().minute);
                      lunchcheck = true;
                    }
                  else if(dtemphr-(DateTime.now().hour)>0 && dtempmin-(DateTime.now().minute)>0)
                    {
                      temph = dtemphr-(DateTime.now().hour);
                      tempm = dtempmin-(DateTime.now().minute);
                      dinnercheck = true;
                    }
                  else
                    {
                      temph = 23-(DateTime.now().hour)+btemphr;
                      tempm = 60-(DateTime.now().minute)+btempmin;
                      breakfastcheck = true;
                    }
                  if(breakfastcheck)
                    {
                      bool check = true;
                      for(int i =0;i<BreakfastList.length;i++)
                      {
                        if (BreakfastList[i]==true) {
                          check = false;
                          break;
                        }
                      }
                      if(check)
                      {
                        for (int i = 0; i < LunchList.length; i++)
                        {
                          if (LunchList[i]==true)
                          {
                            temph += (ltemphr - btemphr);
                            tempm += (ltempmin - btempmin);
                            check = false;
                            break;
                          }
                        }
                      }
                      if(check)
                        {
                          for (int i = 0; i < DinnerList.length; i++)
                          {
                            if (DinnerList[i]==true)
                            {
                              temph += (dtemphr - btemphr);
                              tempm += (dtempmin - btempmin);
                              check = false;
                              break;
                            }
                          }
                        }
                }
                  else if(lunchcheck)
                    {
                      bool check = true;
                      for(int i =0;i<LunchList.length;i++)
                      {
                        if (LunchList[i]==true) {
                          check = false;
                          break;
                        }
                      }
                      if(check)
                        {
                          for (int i = 0; i < DinnerList.length; i++)
                          {
                            if (DinnerList[i]==true)
                            {
                              temph += (dtemphr - ltemphr);
                              tempm += (dtempmin - ltempmin);
                              check = false;
                              break;
                            }
                          }
                        }
                      if(check)
                        {
                          for(int i =0;i<BreakfastList.length;i++)
                          {
                            if (BreakfastList[i]==true) {
                              temph = 23-(DateTime.now().hour)+btemphr;
                              tempm = 60-(DateTime.now().minute)+btempmin;
                              check = false;
                              break;
                            }
                          }
                        }
                    }
                  else if(dinnercheck)
                    {
                      bool check = true;
                      for (int i = 0; i < DinnerList.length; i++)
                      {
                        if (DinnerList[i]==true)
                        {
                          check = false;
                          break;
                        }
                      }
                      if(check)
                        {
                          for(int i =0;i<BreakfastList.length;i++)
                          {
                            if (BreakfastList[i]==true) {
                              temph = 23-(DateTime.now().hour)+btemphr;
                              tempm = 60-(DateTime.now().minute)+btempmin;
                              check = false;
                              break;
                            }
                          }
                        }
                      if(check)
                        {
                          for(int i =0;i<LunchList.length;i++)
                          {
                            if (LunchList[i]==true) {
                              temph = 23-(DateTime.now().hour)+ltemphr;
                              tempm = 60-(DateTime.now().minute)+ltempmin;
                              check = false;
                              break;
                            }
                          }
                        }
                    }
                  //var scheduledNotificationDateTime = new DateTime.now().add(new Duration(hours: temph,minutes: tempm));
                  var scheduledNotificationDateTime = new DateTime.now().add(new Duration(seconds: 2));
                  print(scheduledNotificationDateTime);
                  var androidPlatformChannelSpecifics = new AndroidNotificationDetails('your other channel id','your other channel name', 'your other channel description');
                  var iOSPlatformChannelSpecifics = new IOSNotificationDetails();
                  var platformChannelSpecifics = new NotificationDetails(android: androidPlatformChannelSpecifics, iOS: iOSPlatformChannelSpecifics);
                  await flutterLocalNotificationsPlugin.schedule(
                      0,
                      'scheduled title',
                      'scheduled body',
                      scheduledNotificationDateTime,
                      platformChannelSpecifics);*/

                DateTime selectedDate = DateTime.now();
                String Date = "${selectedDate.toLocal()}".split(' ')[0];
                  for (int i = MedicineList.length-1;i>=0; i--) {
                    if(BreakfastList[i]==null) BreakfastList[i]=false;
                    if(DinnerList[i]==null) DinnerList[i]=false;
                    if(LunchList[i]==null) LunchList[i]=false;
                    d.savePrescription(userPhone, DiseasesName, MedicineList[i], BreakfastList[i], LunchList[i], DinnerList[i],Date,int.parse(CourseDays));
                    MedicineList.removeAt(i);
                    BreakfastList.removeAt(i);
                    LunchList.removeAt(i);
                    DinnerList.removeAt(i);
                  }
                  DiseasesName="";
                  CourseDays="";
                //print(_nameController);
                //print(_numberController);
                MedicineList.insert(0, null);
                BreakfastList.insert(0, false);
                LunchList.insert(0, false);
                DinnerList.insert(0, false);
                setState(() {});
              }
            },
            child: Text('Save'),
          )
        ],
      ),
    );
  }

  List<Widget> _getFriends() {
    List<Widget> friendsTextFields = [];
    List<Widget> friendsNumberFields = [];
    List<Widget> combinedFields = [];
    for (int i = 0; i < MedicineList.length; i++) {
      friendsTextFields.add(Padding(
        padding: const EdgeInsets.symmetric(vertical: 1.0),
        child: Row(
          children: [
            Expanded(child: FriendTextFields(i)),
            SizedBox(
              width: 16,
            ),
            // we need add button at last friends row
            _addRemoveButton(false, i),
          ],
        ),
      ));
      friendsNumberFields.add(Padding(
        padding: const EdgeInsets.symmetric(vertical: 1.0),
        child: Row(
          children: [
            Expanded(child: FriendNumberFields(i)),
            SizedBox(
              width: 16,
            ),
          ],
        ),
      ));
      combinedFields.add(friendsTextFields[i]);
      combinedFields.add(friendsNumberFields[i]);
    }
    return combinedFields;
  }

  /// add / remove button
  Widget _addRemoveButton(bool add, int index) {
    return InkWell(
      onTap: () {
        if (add) {
          // add new text-fields at the top of all friends textfields
          MedicineList.insert(0, null);
          BreakfastList.insert(0, false);
          LunchList.insert(0, false);
          DinnerList.insert(0, false);
        } else {
          MedicineList.removeAt(index);
          BreakfastList.removeAt(index);
          LunchList.removeAt(index);
          DinnerList.removeAt(index);
        }
        setState(() {});
      },
      child: Container(
        width: 50,
        height: 50,
        child: Icon(
          (add) ? Icons.add : Icons.remove_circle,
          color: Colors.red,
          size: 40,
        ),
      ),
    );
  }
}

class FriendTextFields extends StatefulWidget {
  final int index;
  FriendTextFields(this.index);
  @override
  _FriendTextFieldsState createState() => _FriendTextFieldsState();
}

class _FriendTextFieldsState extends State<FriendTextFields> {
  TextEditingController _nameController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _nameController.text =
          _PrescriptionManualFormState.MedicineList[widget.index] ?? '';
    });

    return Container(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: TextFormField(
            controller: _nameController,
            onChanged: (v) => _PrescriptionManualFormState.MedicineList[widget.index] = v,
            decoration: InputDecoration(
              hintText: 'Enter medicine name',
            ),
            validator: (v) {
              if (v.trim().isEmpty) return 'Please enter Medicine Name';
              //print(_nameController.text);
              return null;
            },
          ),
        ));
  }
}

class FriendNumberFields extends StatefulWidget {
  final int index;
  FriendNumberFields(this.index);
  @override
  _FriendNumbersFieldsState createState() => _FriendNumbersFieldsState();
}

class _FriendNumbersFieldsState extends State<FriendNumberFields> {
  TextEditingController _numberController;
  bool checkedValueBreakfast = false;
  bool checkedValueLunch = false;
  bool checkedValueDinner = false;
  @override
  void initState() {
    super.initState();
    _numberController = TextEditingController();
  }

  @override
  void dispose() {
    _numberController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      checkedValueBreakfast =
          _PrescriptionManualFormState.BreakfastList[widget.index] ?? false;
      checkedValueLunch =
          _PrescriptionManualFormState.LunchList[widget.index] ?? false;
      checkedValueDinner =
          _PrescriptionManualFormState.DinnerList[widget.index] ?? false;
      setState(() {});
    });

    return Container(
      //onChanged: (v) => _PrescriptionFormState.friendsList[widget.index] = v,
      child: Column(
        children: <Widget>[
          CheckboxListTile(
            title: Text("Breakfast"),
            value: checkedValueBreakfast,
            onChanged: (newValue) {
              setState(
                    () {
                  checkedValueBreakfast = newValue;
                  _PrescriptionManualFormState.BreakfastList[widget.index] = newValue;
                },
              );
            },
            controlAffinity: ListTileControlAffinity.leading,
          ),
          CheckboxListTile(
            title: Text("Lunch"),
            value: checkedValueLunch,
            onChanged: (newValue) {
              setState(
                    () {
                  checkedValueLunch = newValue;
                  _PrescriptionManualFormState.LunchList[widget.index] = newValue;
                },
              );
            },
            controlAffinity: ListTileControlAffinity.leading,
          ),
          CheckboxListTile(
            title: Text("Dinner"),
            value: checkedValueDinner,
            onChanged: (newValue) {
              setState(
                    () {
                  checkedValueDinner = newValue;
                  _PrescriptionManualFormState.DinnerList[widget.index] = newValue;
                },
              );
            },
            controlAffinity: ListTileControlAffinity.leading,
          ),
        ],
      ),
    );
  }
}
