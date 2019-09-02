import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'signature.dart';
import 'dart:async';

import 'package:naragireg/models/visitors.dart';
import 'package:naragireg/utils/database_helper.dart';

class Login extends StatefulWidget {

  @override
  _Login createState() => _Login();
}

//Activation
class _Login extends State<Login> {
  String phone;
  String mac;
  String phoneAct;
  String name;
  VisitorsObj visitors;

  DatabaseHelper helper = DatabaseHelper();

  TextEditingController phoneController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController purposeController = TextEditingController();
  TextEditingController tagController = TextEditingController();

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
                'Login',
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
           
            SizedBox(
              height: 20,
            ),
            Container(
              padding: EdgeInsets.only(top: 35.00, left: 20.0, right: 20.0),
              child: Column(
                children: <Widget>[
                  Material(
                    elevation: 3.0,
                    borderRadius: BorderRadius.circular(10.0),
                    child: TextField(
                      controller: nameController,
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          prefixIcon: Icon(
                            Icons.person,
                            color: Colors.deepOrange,
                            size: 30.0,
                          ),
                          contentPadding: EdgeInsets.only(
                              left: 15.0, right: 15.0, top: 15.0),
                          hintText: 'Username or Email'),
                      onChanged: (value) {
                        updateName();
                      },
                    ),
                  ),
                  SizedBox(height: 20.0),
                  Material(
                    elevation: 3.0,
                    borderRadius: BorderRadius.circular(10.0),
                    child: TextField(
                      controller: phoneController,
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          prefixIcon: Icon(
                            Icons.lock,
                            color: Colors.deepOrange,
                            size: 30.0,
                          ),
                          contentPadding: EdgeInsets.only(
                              left: 15.0, right: 15.0, top: 15.0),
                          hintText: 'Password'),
                      onChanged: (value) {
                        updatePhone();
                      },
                    ),
                  ),
                 
                  
                  SizedBox(height: 40.0),
                  Container(
                    height: 40.0,
                    child: Material(
                        borderRadius: BorderRadius.circular(20.0),
                        shadowColor: Colors.orange,
                        color: Colors.deepOrange,
                        elevation: 7.0,
                        child: GestureDetector(
                          onTap: () {
                           
                          },
                          child: Center(
                            child: Text(
                              'Login',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'MontSerrat'),
                            ),
                          ),
                        )),
                  ),
                  SizedBox(height: 20.0),
                ],
              ),
            )
          ],
        ));
  }

  void updateName() {
    visitors.name = nameController.text;
  }

  void updatePhone() {
    visitors.phonenumber = phoneController.text;
  }

  void updateAddress() {
    visitors.address = addressController.text;
  }

  void updatePurpose() {
    visitors.purpose = purposeController.text;
  }

  void updateTagno() {
    visitors.tagno = tagController.text;
  }

  void _save() async {
    int result;

    visitors.timein = DateFormat.yMMMd().format(DateTime.now());
    visitors.datein = DateFormat.yMMMd().format(DateTime.now());
    visitors.timeout='';
    visitors.dateout='';

    if (visitors.id != null) {
      //update
      result = await helper.updateVisitor(visitors);
    } else {
      //save
      result = await helper.insertVisitor(visitors);
    }

    if (result != 0) {
      _showAlertDialog('Status', 'Visitor Saved Successfully');
    } else {
      _showAlertDialog('Status', 'Problem Saving Data');
    }
  }

  void _showAlertDialog(String title, String message) {
    AlertDialog alertDialog = AlertDialog(
      title: Text(title),
      content: Text(message),
    );
    showDialog(context: context, builder: (_) => alertDialog);
  }
}
