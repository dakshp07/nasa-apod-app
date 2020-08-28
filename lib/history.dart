import 'package:flutter/material.dart';
import 'package:space_app/historyapod.dart';

class DatePickerDemo extends StatefulWidget {
  @override
  _DatePickerDemoState createState() => _DatePickerDemoState();
}

class _DatePickerDemoState extends State<DatePickerDemo> {
  DateTime selectedDate = DateTime.now();

  _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2025),
    );
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
      });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: new Text("Select Date",style: TextStyle(fontSize: 20,color: Colors.white,fontWeight: FontWeight.bold),),
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text(
              "${selectedDate.toLocal()}".split(' ')[0],
              style: TextStyle(fontSize: 55, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 20.0,
            ),
            RaisedButton(
              onPressed: () => _selectDate(context),
              child: Text(
                'Select date',
                style:
                TextStyle(color: Colors.black, fontWeight: FontWeight.bold,fontSize: 20),
              ),
              color: Colors.greenAccent,
            ),
            new Padding(padding: const EdgeInsets.only(top: 20)),
            RaisedButton(
              onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (BuildContext context)=>HistoryPage(date: "${selectedDate.toLocal()}".split(' ')[0],)));
              },
              child: Text(
                'Continue',
                style:
                TextStyle(color: Colors.black, fontWeight: FontWeight.bold,fontSize: 25),
              ),
              color: Colors.greenAccent,
            ),
          ],
        ),
      ),
    );
  }
}