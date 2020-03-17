
import 'package:flutter/material.dart';
import 'package:naragireg/main.dart';
import 'package:naragireg/utils/database_helper.dart';
import 'package:naragireg/services/visitorsServ.dart' as Service;
import 'package:naragireg/global.dart' as global;
import 'package:naragireg/models/visitors.dart';
import 'package:intl/intl.dart';

class Signing extends StatefulWidget {
  @override
  _Signing createState() => new _Signing();
}

class _Signing extends State<Signing> {
  List<Offset> _points = <Offset>[];
 DatabaseHelper helper = DatabaseHelper();
/*if (result != 0) {
      _showAlertDialog('Status', 'Visitor Saved Successfully');
    } else {
      _showAlertDialog('Status', 'Problem Saving Data');
    }
  }*/

  void _showAlertDialog(String title, String message) {
    AlertDialog alertDialog = AlertDialog(
      title: Text(title),
      content: Text(message),
    );
    showDialog(context: context, builder: (_) => alertDialog);
  }
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      
      body: 
      
      Container(
        child: Column(children: <Widget>[
         
 new Container(
          child: new GestureDetector(
            onPanUpdate: (DragUpdateDetails details) {
              setState(() {
                RenderBox object = context.findRenderObject();
                Offset _localPosition =
                    object.globalToLocal(details.globalPosition);
                _points = new List.from(_points)..add(_localPosition);
              });
            },
            onPanEnd: (DragEndDetails details) => _points.add(null),
            child: new CustomPaint(
              painter: new Signature(points: _points),
              size: Size.fromHeight(500.0),
            ),
          ),
        ),
        Text('Sign on the space provided above', style: TextStyle(
          fontStyle: FontStyle.italic,
          fontWeight: FontWeight.bold,
          fontSize: 16,
          color: Colors.red
        ),),
         SizedBox(height: 10.0),
                    GestureDetector(
               onTap: (){
                            _save();
                             Navigator.pushReplacement(context, MaterialPageRoute(builder: (context){
                               return MyHomePage();
                              }));
                            },
              child: Container(
                height: 60,
                width:6000,
                child: Material(
                  borderRadius: BorderRadius.circular(20.0),
                          shadowColor: Colors.orange,
                          color: Colors.deepOrange,
                          elevation: 7.0,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                    Text('CLICK TO SAVE', style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),),
                  ],)),) ,),
                     SizedBox(height: 20.0),
                     GestureDetector(
               onTap: (){
                            
                             Navigator.pushReplacement(context, MaterialPageRoute(builder: (context){
                               return MyHomePage();
                              }));
                            },
              child: Container(
                height: 60,
                width:6000,
                child: Material(
                  borderRadius: BorderRadius.circular(20.0),
                          shadowColor: Colors.orange,
                          color: Colors.deepOrange,
                          elevation: 7.0,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                    Text('<<BACK', style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),),
                  ],)),) ,),
        ],),
      ),
      
      
      floatingActionButton: new FloatingActionButton(
        child: new Icon(Icons.clear),
        onPressed: () => _points.clear(),
      ),
    );
  }

   void _save() async {
    int result;

   if(global.value=='sign in'){
      global.value='';
      VisitorsObj vis= VisitorsObj(global.name, global.phoneNo, global.address,global.purpose,global.tagNo, DateFormat.yMMMd().format(DateTime.now()),new DateFormat("H:m:s").format(DateTime.now()));

      global.value ='1';
      result = await helper.insertVisitor(vis);
      String response;

      response = await Service.Services.saveVisitor(vis.name, vis.phonenumber, vis.address, vis.purpose, vis.tagno, DateTime.now(), DateTime.now());
     
   }else if(global.value=='sign out'){
      global.value='';
      VisitorsObj vis= VisitorsObj(global.name, global.phoneNo , global.address,global.purpose,global.tagNo,global.date, global.timein, DateFormat.yMMMd().format(DateTime.now()),new DateFormat("H:m:s").format(DateTime.now()));

      vis.id= global.id;
   

      if (vis.id != null) {
      //update
      global.value='2';
      result = await helper.updateVisitor(vis);
    } else {
      //save
       global.value='1';
      result = await helper.insertVisitor(vis);
    }
   }
    
 
  }

}

class Signature extends CustomPainter {
  List<Offset> points;

  Signature({this.points});

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = new Paint()
      ..color = Colors.black
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 5.0;

    for (int i = 0; i < points.length - 1; i++) {
      if (points[i] != null && points[i + 1] != null) {
        canvas.drawLine(points[i], points[i + 1], paint);
      }
    }
  }

  @override
  bool shouldRepaint(Signature oldDelegate) => oldDelegate.points != points;
}
