import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
//import 'history.dart';


class HistoryPage extends StatefulWidget {

  String date;
  HistoryPage({this.date});

  @override
  _HistoryPageState createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {

  Map nasaData;
  fetchData() async {
    http.Response response = await http.get("https://api.nasa.gov/planetary/apod/?api_key={YOUR_API_KEY}&date="+widget.date+"&hd=true");
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
