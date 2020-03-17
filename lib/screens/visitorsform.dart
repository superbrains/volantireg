import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'signature.dart';
import 'dart:async';
import 'package:naragireg/global.dart' as global;
import 'package:naragireg/models/visitors.dart';
import 'package:naragireg/utils/database_helper.dart';
import 'package:naragireg/services/visitorsServ.dart' as Service;
import 'package:naragireg/services/serv.dart' as Serv;

class Visitors extends StatefulWidget {
  final VisitorsObj visitors;
  Visitors(this.visitors);

  @override
  _Visitors createState() => _Visitors(this.visitors);
}

//Activation
class _Visitors extends State<Visitors> {

   final _formKey = GlobalKey<FormState>();

  String phone;
  String mac;
  String phoneAct;
  String name;
  VisitorsObj visitors;

  _Visitors(this.visitors);

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
     phoneController.text =global.phoneNo;
      nameController.text = global.name;
     addressController.text = global.address;
 
    return Scaffold(
        appBar: new AppBar(
          iconTheme: new IconThemeData(color: Colors.white),
          elevation: 15.0,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                'Visitors Entry Form',
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
            Text(
              'Kindly fill up all fields below',
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 16, fontStyle: FontStyle.italic, color: Colors.red),
            ),
            SizedBox(
              height: 10,
            ),
            Form(
              key: _formKey,
              child: 
                Container(
                  padding: EdgeInsets.only(top: 35.00, left: 20.0, right: 20.0),
                  child: Column(
                    children: <Widget>[
                      Material(
                        elevation: 3.0,
                        borderRadius: BorderRadius.circular(10.0),
                        child: TextFormField(
                            validator: (value) {
                            if (value.isEmpty) {
                            return 'Please enter a name!';
                            }
                            return null;
                            },
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
                              hintText: 'NAME'),
                          onChanged: (value) {
                            updateName();
                          },
                        ),
                      ),
                      SizedBox(height: 20.0),
                      Material(
                        elevation: 3.0,
                        borderRadius: BorderRadius.circular(10.0),
                        child: TextFormField(
                                                      validator: (value) {
                            if (value.isEmpty || !isNumeric(value) ) {
                            return 'Please enter valid phone number!';
                            }
                            return null;
                            },

                          controller: phoneController,
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              prefixIcon: Icon(
                                Icons.phone,
                                color: Colors.deepOrange,
                                size: 30.0,
                              ),
                              contentPadding: EdgeInsets.only(
                                  left: 15.0, right: 15.0, top: 15.0),
                              hintText: 'PHONE NUMBER'),
                          onChanged: (value) {
                            updatePhone();
                          },
                        ),
                      ),
                      SizedBox(height: 20.0),
                      Material(
                        elevation: 3.0,
                        borderRadius: BorderRadius.circular(10.0),
                        child: TextFormField(
                                                      validator: (value) {
                            if (value.isEmpty) {
                            return 'Please enter an address!';
                            }
                            return null;
                            },

                          controller: addressController,
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              prefixIcon: Icon(
                                Icons.location_city,
                                color: Colors.deepOrange,
                                size: 30.0,
                              ),
                              contentPadding: EdgeInsets.only(
                                  left: 15.0, right: 15.0, top: 15.0),
                              hintText: 'COMPANY and ADDRESS'),
                          onChanged: (value) {
                            updateAddress();
                          },
                        ),
                      ),
                      SizedBox(height: 20.0),
                      Material(
                        elevation: 3.0,
                        borderRadius: BorderRadius.circular(10.0),
                        child: TextFormField(
                                                      validator: (value) {
                            if (value.isEmpty) {
                            return 'Please enter purpose of visit!';
                            }
                            return null;
                            },

                          controller: purposeController,
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              prefixIcon: Icon(
                                Icons.note,
                                color: Colors.deepOrange,
                                size: 30.0,
                              ),
                              contentPadding: EdgeInsets.only(
                                  left: 15.0, right: 15.0, top: 15.0),
                              hintText: 'PURPOSE OF VISIT'),
                          onChanged: (value) {
                            updatePurpose();
                          },
                        ),
                      ),
                      SizedBox(height: 20.0),
                      Material(
                        elevation: 3.0,
                        borderRadius: BorderRadius.circular(10.0),
                        child: TextFormField(
                                                      validator: (value) {
                            if (value.isEmpty || !isNumeric(value)) {
                            return 'Please enter a valid tag number!';
                            }
                            return null;
                            },

                          controller: tagController,
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              prefixIcon: Icon(
                                Icons.tag_faces,
                                color: Colors.deepOrange,
                                size: 30.0,
                              ),
                              contentPadding: EdgeInsets.only(
                                  left: 15.0, right: 15.0, top: 15.0),
                              hintText: 'TAG NO'),
                          onChanged: (value) {
                            updateTagno();
                          },
                        ),
                      ),
                      SizedBox(height: 40.0),
                       GestureDetector(
                   onTap: (){

                      if (_formKey.currentState.validate()) {
                           // _save();
                           global.value="sign in";
                            global.purpose =purposeController.text;
                             global.tagNo =tagController.text;
                             
                                 Navigator.push(context, MaterialPageRoute(builder: (context){
                                   return Signing();
                                  }));



                   // Scaffold
                 // .of(context)
                 // .showSnackBar(SnackBar(content: Text('Processing Data')));
                    }
                               
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
                        Text('CLICK TO APPEND SIGNATURE', style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),),
                      ],)),) ,),
                      SizedBox(height: 20.0),
                       GestureDetector(
                   onTap: (){
                                
                                 Navigator.pop(context, MaterialPageRoute(builder: (context){
                                 
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
                    ],
                  ),
                ),
              
            )
          ],
        ));
  }

  void updateName() {
    visitors.name = nameController.text;
    global.name = nameController.text;
  }

  void updatePhone() {
    visitors.phonenumber = phoneController.text;
    global.phoneNo = phoneController.text;
  }

  void updateAddress() {
    visitors.address = addressController.text;
     global.address = addressController.text;
  }

bool isNumeric(String s) {
  if(s == null) {
    return false;
  }

 try{
  double.parse(s);
  return true;
 }catch(s){
   return false;
 }

 
}

  void updatePurpose() {
    visitors.purpose = purposeController.text;
    global.purpose =purposeController.text;
  }

  void updateTagno() {
    visitors.tagno = tagController.text;
    global.tagNo =tagController.text;
  }

  void _save() async {
    int result;

    //print(new DateFormat("H:m:s").format(now)); // => 14:40:25
     VisitorsObj vis= VisitorsObj(nameController.text, phoneController.text , addressController.text,purposeController.text,tagController.text, DateFormat.yMMMd().format(DateTime.now()),new DateFormat("H:m:s").format(DateTime.now()));

     /* vis.name = nameController.text;
       vis.phonenumber = phoneController.text;
      vis.address = addressController.text;
      vis.purpose = purposeController.text;
    vis.tagno = tagController.text;
    vis.id = global.id;
    vis.timein = new DateFormat("H:m:s").format(DateTime.now());
    vis.datein = DateFormat.yMMMd().format(DateTime.now());
    vis.timeout='';
    vis.dateout='';*/

 //save
      global.value ='1';
      result = await helper.insertVisitor(vis);
      String response;

      response = await Service.Services.saveVisitor(vis.name, vis.phonenumber, vis.address, vis.purpose, vis.tagno, DateTime.now(), DateTime.now());
      
  //  if (visitors.id != null) {
      //update
   //     global.value ='2';
   //   result = await helper.updateVisitor(visitors);
   // } else {
      //save
   //   global.value ='1';
    //  result = await helper.insertVisitor(visitors);
    //  String response;

     // response = await Service.Services.saveVisitor(visitors.name, visitors.phonenumber, visitors.address, visitors.purpose, visitors.tagno, DateTime.now(), DateTime.now());
      
    //}

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
