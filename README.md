# My-MediMate
A medical Assistant System for the elderly.
class PrescriptionPage extends StatefulWidget {
  PrescriptionPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _PrescriptionState createState() => _PrescriptionState();
}

class _PrescriptionState extends State<PrescriptionPage> {
  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
        centerTitle: true,
      ),
      drawer: NavDrawer(),
      body: SingleChildScrollView (child : PrescriptionForm(),),
    );
  }
}
