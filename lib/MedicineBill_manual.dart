import 'dart:io';
import 'package:flutter/material.dart';
import 'navbar.dart';
import 'Database.dart';
class MedicineBill_Manual extends StatefulWidget {
  String userName;
  String userPhone;
  MedicineBill_Manual({Key key, @required this.userName,this.userPhone}) : super(key: key);

  @override
  _MedicineBillManualState createState() => _MedicineBillManualState(userName: userName,userPhone: userPhone);
}

class _MedicineBillManualState extends State<MedicineBill_Manual> {
  String userName;
  String userPhone;
  _MedicineBillManualState({Key key, @required this.userName,this.userPhone});
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
      body: SingleChildScrollView (child : MedicineBillManualForm(userPhone: userPhone,),),
    );
  }
}


class MedicineBillManualForm extends StatefulWidget {
  String userPhone;
  MedicineBillManualForm({Key key, @required this.userPhone});
  @override
  _MedicineBillManualFormState createState() => _MedicineBillManualFormState(userPhone: userPhone);
}

class _MedicineBillManualFormState extends State<MedicineBillManualForm> {
  String userPhone;
  _MedicineBillManualFormState({Key key, @required this.userPhone});
  final _formKey = GlobalKey<FormState>();
  Database d = new Database();
  TextEditingController _nameController;
  TextEditingController _numberController;
  static List<String> MedicineList = [null];
  static List<String> QuantityList = [null];

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
    _numberController = TextEditingController();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _numberController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(left: 16.0, right: 16.0, top: 20.0),
            child: RaisedButton(
              color : const Color(0xFFFFC7C7),
              child: Row(children: [
                Flexible(
                  flex: 1,
                  child:  Icon(Icons.add_circle_outlined,color:Colors.brown[300]),
                ),
                Flexible(
                  flex: 8,
                  child: Center(child: Text("Add Medicine")),
                ),
              ]),
              onPressed: () async {
                MedicineList.insert(0, null);
                QuantityList.insert(0, null);
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
            onPressed: () {
              if (_formKey.currentState.validate()) {
                for(int i =MedicineList.length-1;i>=0;i--)
                  {
                    //print(int.parse(QuantityList[i]));
                    d.saveMedicine(userPhone, MedicineList[i], int.parse(QuantityList[i]));
                    MedicineList.removeAt(i);
                    QuantityList.removeAt(i);
                  }
                Scaffold.of(context).showSnackBar(SnackBar(
                  content: Text('Saving Data'),
                ));
                MedicineList.insert(0, null);
                QuantityList.insert(0, null);
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
          QuantityList.insert(0, null);
        } else {
          MedicineList.removeAt(index);
          QuantityList.removeAt(index);
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
          _MedicineBillManualFormState.MedicineList[widget.index] ?? '';
    });

    return Container(
        child: Padding(
          padding: const EdgeInsets.only(left: 16.0, right: 16.0, top: 10.0),
          child: TextFormField(
            controller: _nameController,
            onChanged: (v) => _MedicineBillManualFormState.MedicineList[widget.index] = v,
            decoration: InputDecoration(
              hintText: 'Enter medicine name',
            ),
            validator: (v) {
              if (v.trim().isEmpty) return 'Please enter something';
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
      _numberController.text =
          _MedicineBillManualFormState.QuantityList[widget.index] ?? '';
    });

    return Container(
        child: Padding(
            padding: const EdgeInsets.only(left: 16.0, right: 66.0),
            child: TextFormField(
              controller: _numberController,
              onChanged: (v) =>
              _MedicineBillManualFormState.QuantityList[widget.index] = v,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(hintText: 'Enter Quantity'),
              validator: (v) {
                if (v.trim().isEmpty) return 'Please enter something';
                return null;
              },
            )));
  }
}
