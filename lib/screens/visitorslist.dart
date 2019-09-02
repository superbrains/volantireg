import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'signature.dart';
import 'dart:async';

import 'package:naragireg/models/visitors.dart';
import 'package:naragireg/utils/database_helper.dart';

class VisitorsList extends StatefulWidget {
  final List<VisitorsObj> visitorsList;
  VisitorsList(this.visitorsList);
  
  @override
  _VisitorsList createState() => _VisitorsList(this.visitorsList);
}

//Activation
class _VisitorsList extends State<VisitorsList> {
  String phone;
  String mac;
  String phoneAct;
  String name;
 

 List<VisitorsObj> visitorsList;
 List<VisitorsObj> newList;
  List<VisitorsObj> filteredvisitorsList;
  _VisitorsList(this.visitorsList);

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
  void initState() {
    
    super.initState();
    setState(() {
      
      filteredvisitorsList = visitorsList;
    });
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
                "List of Past Visitors",
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ],
          ),
          backgroundColor: Colors.deepOrange,
        ),
         body: Column(
          children: <Widget>[
           
            Column(
              children: <Widget>[
                TextField(
                  decoration: InputDecoration(
                      contentPadding: EdgeInsets.all(10.0),
                      hintText: 'Search Visitors (Phone Number or Name)'),
                  onChanged: (string) {
                    setState(() {
                      filteredvisitorsList = visitorsList
                          .where((u) =>
                              (u.name.toLowerCase().contains(string.toLowerCase())|| 
                             
                              (u.phonenumber.toLowerCase().contains(string.toLowerCase()))
                          ))
                          .toList();
                    });
                  },
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              'Search in the box above and click on your name to sign in',
              style: TextStyle(
                  color: Colors.red, fontSize: 12, fontStyle: FontStyle.italic, fontWeight: FontWeight.bold),
            ),
            Expanded(
              child: ListView.builder(
                  padding: EdgeInsets.all(10.0),
                  itemCount: filteredvisitorsList.length,
                  itemBuilder: (BuildContext context, int index) {
                    return InkWell(
                      splashColor: Colors.redAccent,
                      borderRadius: BorderRadius.circular(10.0),
                      onTap: () {
                        setState(() {
                          /*Navigator.push(context, MaterialPageRoute(builder: (context){
                          return  Sections('States', filteredstates[index].toString());
                        }));*/
                        });
                      },
                      child: Card(
                        child: Padding(
                          padding: EdgeInsets.all(10.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                this.filteredvisitorsList[index].name,
                                style: TextStyle(
                                    fontSize: 15.0,
                                    fontFamily: 'Monseratti',
                                    fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Text(
                                    this.filteredvisitorsList[index].phonenumber,
                                    style: TextStyle(
                                        fontSize: 12.0,
                                        fontFamily: 'Monseratti',
                                        color: Colors.grey),
                                  ),
                                  
                                  Icon(Icons.arrow_forward_ios)
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  }),
            )
          ],
        ));
  }

 
}
