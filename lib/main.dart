import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  final title;
  MyHomePage({Key key, this.title}) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    return MyHomePageState();
  }
}

class MyHomePageState extends State<MyHomePage> {
  Color primaryColor = Color(0xff18203d);
  Color secondaryColor = Color(0xff232c51);
  Color loginGreen = Color(0xff25bcbb);

  Map data;

  addData() {
    Map<String, dynamic> demoData = {
      'name': 'the demo hoacomay data',
      'moto': 'hello every body'
    };
    CollectionReference collectionReference =
        FirebaseFirestore.instance.collection('data');
    collectionReference.add(demoData);
  }

  fetchData() {
    CollectionReference collectionReference =
        FirebaseFirestore.instance.collection('data');
    collectionReference.snapshots().listen((snapshot) {
      List documents;

      setState(() {
        data = snapshot.docs[0].data();
      });
    });
  }

  updateData() async {
    CollectionReference collectionReference =
        FirebaseFirestore.instance.collection('data');
    QuerySnapshot querySnapshot = await collectionReference.get();
    querySnapshot.docs[0].reference.update({'name': 'hoacomay'});
  }

  deleteData() async {
    CollectionReference collectionReference =
        FirebaseFirestore.instance.collection('data');
    QuerySnapshot querySnapshot = await collectionReference.get();
    querySnapshot.docs[0].reference.delete();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
      ),
      backgroundColor: Colors.green[100],
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                children: [
                  Expanded(
                    child: MaterialButton(
                      height: 50,
                      color: Colors.green,
                      onPressed: () {
                        fetchData();
                      },
                      child: Text(
                        'Fetch Data',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 30.0,
              ),
              Row(
                children: [
                  Expanded(
                    child: MaterialButton(
                      height: 50,
                      color: Colors.green,
                      onPressed: () {
                        addData();
                      },
                      child: Text(
                        'Add Data',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 30,
              ),
              Row(
                children: [
                  Expanded(
                    child: MaterialButton(
                      height: 50,
                      color: Colors.green,
                      onPressed: () {
                        updateData();
                      },
                      child: Text(
                        'Update Data',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 30.0,
              ),
              Row(
                children: [
                  Expanded(
                    child: MaterialButton(
                      height: 50,
                      color: Colors.green,
                      onPressed: () {
                        deleteData();
                      },
                      child: Text(
                        'Delete Data',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 30,
              ),
              Text(
                //nếu để mỗi data thì nó sẽ lấy nguyên toàn bộ map vào
                //nêu thay bằng data['key'] sẽ lấy value của data['key]
                data['moto'].toString(),
                textAlign: TextAlign.center,
                style: GoogleFonts.openSans(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold),
              )
            ],
          ),
        ),
      ),
    );
  }
}
