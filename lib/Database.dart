//import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
//import 'package:flutter/material.dart';
//import 'package:medi_mate/signup.dart';

class Database {

  final databaseReference = FirebaseDatabase.instance.reference();

  Future <void> saveUser(String UserName , String PhoneNumber) {
    var id = databaseReference.child(PhoneNumber).child("Profile").set({
      'Name': UserName,
    });
  }

  Future <void> savePrescription(String PhoneNumber,String DiseaseName,String MedicineName,bool Breakfast,bool Lunch, bool Dinner, String Date,int Days) {
    //print("in Database");
    //print(PhoneNumber);
    //print(Date);
    //print(DiseaseName);
    //print(MedicineName);
    int c =0;
    if(Breakfast)
      c++;
    if(Lunch)
      c++;
    if(Dinner)
      c++;
    int total = c*Days;
    try {
      var id = databaseReference.child(PhoneNumber).child("Prescription").child(
          Date).child(DiseaseName).child(MedicineName).set({
        'Breakfast': Breakfast,
        'Lunch': Lunch,
        'Dinner': Dinner,
        'Total' : total,
        'Days': Days
      });
    }
    catch(e){
      print(e);
    }
  }
  Future <void> saveMedicine(String PhoneNumber,String MedicineName,int Quantity) async{
    //print("in Database");
    //print(PhoneNumber);
    //print(MedicineName);
    int Temp = await getQuantity(PhoneNumber, MedicineName);
    Quantity+=Temp;
    try {
      var id = databaseReference.child(PhoneNumber).child("Medicine").child(MedicineName).set({
        'Quantity': Quantity,
      }).catchError((onError) {
        print(onError);
      });
    }
    catch(e){
      print(e);
    }
  }
  
  Future <void> saveProfile(String PhoneNumber, String UserName, String Birthdate, String BreakfastTime, String LunchTime, String DinnerTime, List<String> PeerName, List<String> PeerNumber)
  {
    try{
      var id = databaseReference.child(PhoneNumber).child("Profile").set({
        'Name': UserName,
        'Birthdate': Birthdate,
        'BreakfastTime': BreakfastTime,
        'LunchTime': LunchTime,
        'DinnerTime': DinnerTime,
      });
      for(int i = PeerName.length-1;i>=0;i--)
      {
          var id2 = databaseReference.child(PhoneNumber).child("Profile").child("Peer").child(i.toString()).set({
            'PeerName': PeerName[i],
            'PeerNumber': "+91"+PeerNumber[i]
          });
      }
    }
    catch(e){
      print(e);
    }
  }

  Future <int> getQuantity(String PhoneNumber,String MedicineName) async{
    int Quantity;
    try {
      await databaseReference.child(PhoneNumber).child("Medicine").child(
          MedicineName).once().then((DataSnapshot data) {
        //print(data.value['UserName']);
        Quantity = data.value['Quantity'];
      });
    }
    catch(e) {
      Quantity = 0;
    }
    return Quantity;
  }

  Future <String> getUser(String PhoneNumber) async{
    String userName;

    await databaseReference.child(PhoneNumber).child("Profile").once().then((DataSnapshot data) {
      //print(data);
      userName = data.value['Name'];
    });
    return userName;
  }
  Future <DataSnapshot> getProfile(String PhoneNumber) async{
    DataSnapshot dataList;
    await databaseReference.child(PhoneNumber).child("Profile").once().then((DataSnapshot data) {
      //print(data);
      dataList = data;
    });
    return dataList;
  }
  Future <List<String>> getMedicine(String PhoneNumber,String Time) async{
    List<String> MedicineName = [];
    List<String> DateValue = [];
    try {
      await databaseReference.child(PhoneNumber).child("Prescription").once().then((DataSnapshot data) {
        //print(data.value);
        data.value.forEach((key,value){DateValue.insert(0,key);});
      });
      for(int i =0;i<DateValue.length;i++)
      {
        List<String> temp = [];
        await databaseReference.child(PhoneNumber).child("Prescription").child(DateValue[i]).once().then((DataSnapshot data) {
          data.value.forEach((key,value){temp.insert(0,key);});
        });
        for(int j = 0;j<temp.length;j++)
          {
            await databaseReference.child(PhoneNumber).child("Prescription").child(DateValue[i]).child(temp[j]).once().then((DataSnapshot data) {
              data.value.forEach((key,value){
                if(value[Time])
                  {
                    MedicineName.insert(0, DateValue[i]);
                    MedicineName.insert(1, temp[j]);
                    MedicineName.insert(2, key);
                  }
              });
            });
          }
      }
    }
    catch(e) {
      print(e);
    }
    print(MedicineName);
    return MedicineName;
  }

  void updateMedicine(String PhoneNumber,String Date,String DiseaseName,String MedicineName) async{
    int total;
    DataSnapshot temp;
    try {
      await databaseReference.child(PhoneNumber).child("Prescription").child(Date).child(DiseaseName).child(MedicineName).once().then((DataSnapshot data) {
        //print(data.value);
        total = (data.value['Total']);
        temp=data;
      });
      total--;
      if(total == 0)
        {
          var id = databaseReference.child(PhoneNumber).child("Archive")
              .child(Date).child(DiseaseName).child(MedicineName).set({
            'Breakfast': temp.value['Breakfast'],
            'Lunch': temp.value['Lunch'],
            'Dinner': temp.value['Dinner'],
            'Total' : 0,
            'Days': temp.value['Days']
          });
          databaseReference.child(PhoneNumber).child("Prescription").child(Date).child(DiseaseName).child(MedicineName).remove();
        }
      else {
        var id = databaseReference.child(PhoneNumber).child("Prescription")
            .child(Date).child(DiseaseName).child(MedicineName)
            .set({
          'Breakfast': temp.value['Breakfast'],
          'Lunch': temp.value['Lunch'],
          'Dinner': temp.value['Dinner'],
          'Total' : total,
          'Days': temp.value['Days']
        });
      }
    }
    catch(e){
      print(e);
    }
  }

  Future <Map> getMedicineLogs(String PhoneNumber) async{
    var finaltemp = new Map();
    try
    {
    await databaseReference.child(PhoneNumber).child("Prescription").once().then((DataSnapshot data) {
      data.value.forEach((key,value) async{
        await databaseReference.child(PhoneNumber).child("Prescription").child(key).once().then((DataSnapshot data1) {
          data1.value.forEach((key1,value1){
            finaltemp[key].append(data1.value[key1]);
          });
        });
      });
    });
    await databaseReference.child(PhoneNumber).child("Archive").once().then((DataSnapshot data) {
      data.value.forEach((key,value) async{
        await databaseReference.child(PhoneNumber).child("Archive").child(key).once().then((DataSnapshot data1) {
          data1.value.forEach((key1,value1){
            finaltemp[key].append(data1.value[key1]);
          });
        });
      });
    });
    }
    catch(e)
    {
      print(e);
    }
    print(finaltemp);
    return finaltemp;
  }
}