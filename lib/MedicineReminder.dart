import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'Database.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';


class MedicineReminder extends StatefulWidget {
  String userPhone;
  MedicineReminder({Key key, @required this.userPhone}) : super(key: key);
  @override
  _MedicineReminderState createState() => _MedicineReminderState(userPhone: userPhone);
}

class _MedicineReminderState extends State<MedicineReminder> {
  String userPhone;
  _MedicineReminderState({Key key, @required this.userPhone});
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(100.0),
          child: AppBar(
            title: Image.asset("assets/logo_text.png",width:200,height:100),
            centerTitle: true,
          )),
      body: SingleChildScrollView (child : Reminder(userPhone: userPhone,),),
    );
  }
}

class Reminder extends StatefulWidget {
  String userPhone;
  Reminder({Key key, @required this.userPhone}) : super(key: key);
  @override
  _ReminderState createState() => _ReminderState(userPhone: userPhone);
}

class _ReminderState extends State<Reminder> {
  String userPhone;
  _ReminderState({Key key, @required this.userPhone});
  Database d = new Database();
  bool breakfastcheck = false;
  bool lunchcheck = false;
  bool dinnercheck = false;
  bool loaded = false;
  static List<String> MedicineName=[];
  var flutterLocalNotificationsPlugin = new FlutterLocalNotificationsPlugin();

  void check() async{
    var BreakfastTime;
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
    if((DateTime.now().hour-btemphr).abs()<=(DateTime.now().hour-ltemphr).abs())
    {
      MedicineName = await d.getMedicine(userPhone,"Breakfast");
      loaded = true;
      setState(() {});
      //print("breakfast");
    }
    else if((DateTime.now().hour-ltemphr).abs()<=(DateTime.now().hour-dtemphr).abs())
      {
        MedicineName = await d.getMedicine(userPhone,"Lunch");
        loaded = true;
        setState(() {});
        //print("Lunch");
      }
    else
      {
        MedicineName = await d.getMedicine(userPhone,"Dinner");
        loaded = true;
        setState(() {});
        //print("Dinner");
      }
  }

  @override
  void initState() {
    check();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    if(loaded) {
      return Container(
          child: Column(
              children: <Widget>[
                ..._addReminder(),
              ]
          )
      );
    }
    else
      {
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

  List<Widget> _addReminder()
  {
    List<Widget> Medicine = [];
    for(int i=2;i<MedicineName.length;i+=3)
      {
        Medicine.add(Padding(
          padding: const EdgeInsets.symmetric(vertical: 1.0,horizontal: 10),
          child: Row(
            children: [
              Expanded(child: MedicineFields(i)),
              SizedBox(
                width: 16,
              ),
              // we need add button at last friends row
              _doneButton(i),
            ],
          ),
        ));
      }
    return Medicine;
  }
  Widget _doneButton(int index) {
    return InkWell(
      onTap: () {
        d.updateMedicine(userPhone,MedicineName[index-2], MedicineName[index-1], MedicineName[index]);
        MedicineName.removeAt(index);
        MedicineName.removeAt(index-1);
        MedicineName.removeAt(index-2);
        setState(() {});
      },
      child: Container(
        width: 50,
        height: 50,
        child: Icon(
          Icons.check,
          color: Colors.green,
          size: 40,
        ),
      ),
    );
  }

  /*void shedule() async{
    var BreakfastTime;
    var LunchTime;
    var DinnerTime;
    List<String> Temp = [];
    int temph;
    int tempm;

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
    if((DateTime.now().hour-btemphr).abs()<=(DateTime.now().hour-ltemphr).abs())
    {
      MedicineName = await d.getMedicine(userPhone,"Breakfast");
      setState(() {});
      Temp = await d.getMedicine(userPhone,"Lunch");
      if(Temp.length!=0)
      {
        temph = ltemphr-(DateTime.now().hour);
        tempm = ltempmin-(DateTime.now().minute);
      }
      else {
        Temp = await d.getMedicine(userPhone, "Dinner");
        if(Temp.length!=0)
        {
          temph = dtemphr-(DateTime.now().hour);
          tempm = dtempmin-(DateTime.now().minute);
        }
        else
        {
          Temp = await d.getMedicine(userPhone,"Breakfast");
          if(Temp.length!=0)
          {
            temph = 23-(DateTime.now().hour)+btemphr;
            tempm = 60-(DateTime.now().minute)+btempmin;
          }
        }
      }
      //print("breakfast");
    }
    else if((DateTime.now().hour-ltemphr).abs()<=(DateTime.now().hour-dtemphr).abs())
    {
      MedicineName = await d.getMedicine(userPhone,"Lunch");
      setState(() {});
      Temp = await d.getMedicine(userPhone,"Dinner");
      if(Temp.length!=0)
      {
        temph = dtemphr-(DateTime.now().hour);
        tempm = dtempmin-(DateTime.now().minute);
      }
      else {
        Temp = await d.getMedicine(userPhone, "Breakfast");
        if(Temp.length!=0)
        {
          temph = 23-(DateTime.now().hour)+btemphr;
          tempm = 60-(DateTime.now().minute)+btempmin;
        }
        else
        {
          Temp = await d.getMedicine(userPhone,"Lunch");
          if(Temp.length!=0)
          {
            temph = 23-(DateTime.now().hour)+ltemphr;
            tempm = 60-(DateTime.now().minute)+ltempmin;
          }
        }
      }
      //print("Lunch");
    }
    else
    {
      MedicineName = await d.getMedicine(userPhone,"Dinner");
      setState(() {});
      Temp = await d.getMedicine(userPhone,"Breakfast");
      if(Temp.length!=0)
      {
        temph = 23-(DateTime.now().hour)+btemphr;
        tempm = 60-(DateTime.now().minute)+btempmin;
      }
      else {
        Temp = await d.getMedicine(userPhone, "Lunch");
        if(Temp.length!=0)
        {
          temph = 23-(DateTime.now().hour)+ltemphr;
          tempm = 60-(DateTime.now().minute)+ltempmin;
        }
        else
        {
          Temp = await d.getMedicine(userPhone,"Dinner");
          if(Temp.length!=0)
          {
            temph = 23-(DateTime.now().hour)+dtemphr;
            tempm = 60-(DateTime.now().minute)+dtempmin;
          }
        }
      }
      //print("Dinner");
    }
    var scheduledNotificationDateTime = new DateTime.now().add(new Duration(hours: temph,minutes: tempm));
    //var scheduledNotificationDateTime = new DateTime.now().add(new Duration(seconds: 2));
    print(scheduledNotificationDateTime);
    var androidPlatformChannelSpecifics = new AndroidNotificationDetails('your other channel id','your other channel name', 'your other channel description');
    var iOSPlatformChannelSpecifics = new IOSNotificationDetails();
    var platformChannelSpecifics = new NotificationDetails(android: androidPlatformChannelSpecifics, iOS: iOSPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin.schedule(
        0,
        'scheduled title',
        'scheduled body',
        scheduledNotificationDateTime,
        platformChannelSpecifics);
  }*/

}

class MedicineFields extends StatefulWidget {
  final int index;
  MedicineFields(this.index);
  @override
  _MedicineFieldsState createState() => _MedicineFieldsState();
}

class _MedicineFieldsState extends State<MedicineFields> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text(_ReminderState.MedicineName[widget.index],style: TextStyle(fontWeight: FontWeight.bold,fontSize: 30)),
    );
  }
}

