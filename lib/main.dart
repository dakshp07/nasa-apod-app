import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'history.dart';

void main()=>runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: new ThemeData(
        brightness: Brightness.dark,
      ),
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  Map nasaData;
  fetchData() async {
    http.Response response = await http.get("https://api.nasa.gov/planetary/apod/?api_key={YOUR_API_KEY}&hd=true");
    setState(() {
      nasaData=jsonDecode(response.body);
    });
  }

  @override
  void initState() {
    fetchData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: new Text("NASA APOD",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.white),),
      ),
      drawer: new Drawer(
        child: new Column(
          children: [
            new UserAccountsDrawerHeader(
                accountName: new Text("NASA APOD",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.white),),
                accountEmail: new Text("nasaaopdhelp@gmail.com",style: TextStyle(fontSize: 20,color: Colors.grey[600],fontWeight: FontWeight.bold),),
                currentAccountPicture: new CircleAvatar(
                  backgroundColor: Colors.green[600],
                  child: new Text("NA",style: TextStyle(fontSize: 25,color: Colors.white,fontWeight: FontWeight.bold),),
                ),
            ),
            new ListTile(
              title: new Text("Today's",style: TextStyle(fontSize: 20,color: Colors.white,fontWeight: FontWeight.bold),),
              trailing: new Icon(Icons.today),
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (BuildContext context)=>HomePage()));
              },
            ),
            new Padding(padding: const EdgeInsets.only(bottom: 10)),
            new ListTile(
              title: new Text("History",style: TextStyle(fontSize: 20,color: Colors.white,fontWeight: FontWeight.bold),),
              trailing: new Icon(Icons.history),
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (BuildContext context)=>DatePickerDemo()));
              },
            ),
            new Padding(padding: const EdgeInsets.only(bottom: 10)),
            new ListTile(
              title: new Text("Settings",style: TextStyle(fontSize: 20,color: Colors.white,fontWeight: FontWeight.bold),),
              trailing: new Icon(Icons.settings),
            ),
            new Padding(padding: const EdgeInsets.only(bottom: 10)),
            new ListTile(
              title: new Text("Account",style: TextStyle(fontSize: 20,color: Colors.white,fontWeight: FontWeight.bold),),
              trailing: new Icon(Icons.account_circle),
            ),
            new Padding(padding: const EdgeInsets.only(bottom: 280)),
            new Divider(
              thickness: 1,
              height: 5,
              color: Colors.grey[600],
            ),
            new ListTile(
              title: new Text("Close",style: TextStyle(fontSize: 20,color: Colors.white,fontWeight: FontWeight.bold),),
              trailing: new Icon(Icons.close),
              onTap: (){
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
      body: nasaData==null? new Center(
        child: new CircularProgressIndicator(),
      ) : new SingleChildScrollView(
        child: new Card(
          color: Color(0x0080),
          shape: new RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
          child: new Column(
            children: [
              new ClipRRect(
                child: new Image.network(nasaData["hdurl"]),
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
              new Padding(padding: const EdgeInsets.only(top: 10)),
              new Text(nasaData["title"],style: TextStyle(fontSize: 25,color: Colors.white,fontWeight: FontWeight.bold),),
              new Padding(padding: const EdgeInsets.only(top: 10)),
              new Text(nasaData["date"]+" \u00a9 "+nasaData["copyright"],style: TextStyle(fontSize: 20,color: Colors.grey[600],fontWeight: FontWeight.bold),),
              new Padding(padding: const EdgeInsets.only(top: 10)),
              new Text(nasaData["explanation"],style: TextStyle(fontSize: 20,color: Colors.white,fontWeight: FontWeight.bold),),
              new Padding(padding: const EdgeInsets.only(bottom: 10)),
            ],
          ),
        ),
      ),
    );
  }
}

