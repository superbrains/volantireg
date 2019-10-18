import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'signature.dart';
import 'dart:async';
import 'package:naragireg/global.dart' as global;
import 'package:naragireg/models/visitors.dart';
import 'package:naragireg/utils/database_helper.dart';

class Signout extends StatefulWidget {
  
  @override
  _Signout createState() => _Signout();
}

//Activation
class _Signout extends State<Signout> {
  String phone;
  String mac;
  String phoneAct;
  String name;
  VisitorsObj visitors;


  DatabaseHelper helper = DatabaseHelper();

/*Future<bool> loader(){
  return showDialog(context: context,
      barrierDismissible: false,
      builder: (context)=> AlertDialog(
        title: ScalingText("Getting OTP. Please wait...", style: TextStyle(
          fontSize: 14
        ),),
      ));
}*/

  Future<bool> dialog(str) {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => AlertDialog(
              title: Text(
                str,
                style: TextStyle(fontSize: 14, color: Colors.red),
              ),
            ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: new AppBar(
          iconTheme: new IconThemeData(color: Colors.white),
          elevation: 15.0,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                'Signout',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ],
          ),
          backgroundColor: Colors.deepOrange,
        ),
        body: ListView(
          children: <Widget>[
            SizedBox(
              height: 20,
            ),

            Container(
              padding: EdgeInsets.only(top: 35.00, left: 20.0, right: 20.0),
              child: Column(
                children: <Widget>[
                  Text(
                  'Name:',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                  fontSize: 16, fontStyle: FontStyle.italic, color: Colors.deepOrange),
                  ),
                  SizedBox(
                  height: 5,
                  ),

                  Text(
                  global.name,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                  fontSize: 20, fontWeight: FontWeight.bold, fontStyle: FontStyle.italic, color: Colors.black),
                  ),
                  SizedBox(
                  height: 20,
                  ),

                  Text(
                  'Phone Number:',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                  fontSize: 16, fontStyle: FontStyle.italic, color: Colors.deepOrange),
                  ),
                  SizedBox(
                  height: 5,
                  ),

                  Text(
                  global.phoneNo,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                  fontSize: 20, fontWeight: FontWeight.bold, fontStyle: FontStyle.italic, color: Colors.black),
                  ),
                  SizedBox(
                  height: 20,
                  ),

                  Text(
                  'Purpose of Visit:',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                  fontSize: 16, fontStyle: FontStyle.italic, color: Colors.deepOrange),
                  ),
                  SizedBox(
                  height: 5,
                  ),

                  Text(
                  global.purpose,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                  fontSize: 20, fontWeight: FontWeight.bold, fontStyle: FontStyle.italic, color: Colors.black),
                  ),
                  SizedBox(
                  height: 20,
                  ),
                  Text(
                  'Tag No:',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                  fontSize: 16, fontStyle: FontStyle.italic, color: Colors.deepOrange),
                  ),
                  SizedBox(
                  height: 5,
                  ),

                  Text(
                  global.tagNo,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                  fontSize: 20, fontWeight: FontWeight.bold, fontStyle: FontStyle.italic, color: Colors.black),
                  ),
                 
                  SizedBox(height: 60.0),
                  Container(
                    height: 40.0,
                    child: Material(
                        borderRadius: BorderRadius.circular(20.0),
                        shadowColor: Colors.orange,
                        color: Colors.deepOrange,
                        elevation: 7.0,
                        child: GestureDetector(
                          onTap: () {
                            _save();
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                              return Signing();
                            }));
                          },
                          child: Center(
                            child: Text(
                              'CLICK TO SIGN OUT',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'MontSerrat'),
                            ),
                          ),
                        )),
                  ),
                   SizedBox(
                  height: 40,
                  ),
                   Text(
                  'PLEASE, DROP TAG!!!',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                  fontSize: 18,fontWeight: FontWeight.bold, fontStyle: FontStyle.italic, color: Colors.red),
                  ),
                  SizedBox(height: 20.0),
                ],
              ),
            )
          ],
        ));
  }

  void updateName() {
    visitors.name = global.name;
  }

  void updatePhone() {
    visitors.phonenumber = global.phoneNo;
  }

  void updateAddress() {
    visitors.address =global.address;
  }

  void updatePurpose() {
    visitors.purpose = global.purpose;
  }

  void updateTagno() {
    visitors.tagno = global.tagNo;
  }

  void _save() async {
    int result;

    
    visitors.id= global.id;
    visitors.timein ='';
    visitors.datein = '';
    visitors.timeout= new DateFormat("H:m:s").format(DateTime.now());
    visitors.dateout=DateFormat.yMMMd().format(DateTime.now());

    if (visitors.id != null) {
      //update
      result = await helper.updateVisitor(visitors);
    } else {
      //save
      result = await helper.insertVisitor(visitors);
    }

   /* if (result != 0) {
      _showAlertDialog('Status', 'Visitor Saved Successfully');
    } else {
      _showAlertDialog('Status', 'Problem Saving Data');
    }*/
  }

  void _showAlertDialog(String title, String message) {
    AlertDialog alertDialog = AlertDialog(
      title: Text(title),
      content: Text(message),
    );
    showDialog(context: context, builder: (_) => alertDialog);
  }
}
