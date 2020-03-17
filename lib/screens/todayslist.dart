import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:naragireg/global.dart' as global;
import 'dart:async';
import 'signoutform.dart';

import 'package:naragireg/models/visitors.dart';
import 'package:naragireg/utils/database_helper.dart';

class TodayVisitors extends StatefulWidget {
  final List<VisitorsObj> visitorsList;
  TodayVisitors(this.visitorsList);
  
  @override
  _TodayVisitors createState() => _TodayVisitors(this.visitorsList);
}

//Activation
class _TodayVisitors extends State<TodayVisitors> {
  String phone;
  String mac;
  String phoneAct;
  String name;
 

 List<VisitorsObj> visitorsList;
 List<VisitorsObj> newList;
  List<VisitorsObj> filteredvisitorsList;
  _TodayVisitors(this.visitorsList);

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
      newList = visitorsList
                          .where((u) =>
                              ((u.datein.toLowerCase().contains(DateFormat.yMMMd().format(DateTime.now()).toLowerCase())||
                               (u.timein.toLowerCase().contains(DateFormat.yMMMd().format(DateTime.now()).toLowerCase())) &&
                           (u.dateout.contains('')))))
                          .toList();
      filteredvisitorsList = newList;
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
                "Today's Visitor's List",
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
            SizedBox(height:20),
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
                  SizedBox(height:20),
            Column(
              children: <Widget>[
                TextField(
                  decoration: InputDecoration(
                      contentPadding: EdgeInsets.all(10.0),
                      hintText: 'Search Visitors (Phone Number or Name)'),
                  onChanged: (string) {
                    setState(() {
                      filteredvisitorsList = newList
                          .where((u) =>
                              (u.name.toLowerCase().contains(string.toLowerCase())|| 
                              (u.tagno.toLowerCase().contains(string.toLowerCase()) ||
                              (u.phonenumber.toLowerCase().contains(string.toLowerCase()))
                          )))
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
              'Search in the box above and click on your name to sign out',
              style: TextStyle(
                  color: Colors.red, fontSize: 12, fontStyle: FontStyle.italic),
            ),
            Expanded(
              child: ListView.builder(
                  padding: EdgeInsets.all(10.0),
                  itemCount: filteredvisitorsList.length,
                  itemBuilder: (BuildContext context, int index) {

                   if(filteredvisitorsList[index].dateout ==null ){

                      return InkWell(
                      splashColor: Colors.redAccent,
                      borderRadius: BorderRadius.circular(10.0),
                      onTap: () {
                        setState(() {
                          global.name=  this.filteredvisitorsList[index].name;
                          global.id=  this.filteredvisitorsList[index].id;
                          global.phoneNo=  this.filteredvisitorsList[index].phonenumber;
                          global.tagNo=  this.filteredvisitorsList[index].tagno;
                          global.address=  this.filteredvisitorsList[index].address;
                          global.purpose=  this.filteredvisitorsList[index].purpose;
                          global.date=  this.filteredvisitorsList[index].datein;
                          global.timein =  this.filteredvisitorsList[index].timein;
                          Navigator.push(context, MaterialPageRoute(builder: (context){
                          return  Signout();
                        }));
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
                                    fontSize: 16.0,
                                    fontFamily: 'Monseratti',
                                    fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Row(
                               
                                children: <Widget>[
                                  Text(
                                     'TIME IN:',
                                    style: TextStyle(
                                        fontSize: 12.0,
                                        fontFamily: 'Monseratti',
                                        color: Colors.grey,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(width: 10,),
                                  Text(
                                    this.filteredvisitorsList[index].datein +' '+ this.filteredvisitorsList[index].timein,
                                    style: TextStyle(
                                        fontSize: 12.0,
                                        fontFamily: 'Monseratti',
                                        color: Colors.grey),
                                  ),
                                  SizedBox(width:20),
                                                                   SizedBox(width: 20,),
                                   Text(
                                     'TAG NO:',
                                    style: TextStyle(
                                        fontSize: 12.0,
                                        fontFamily: 'Monseratti',
                                        color: Colors.grey,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(width: 10,),
                                  Text(
                                    this.filteredvisitorsList[index].tagno,
                                    style: TextStyle(
                                        fontSize: 12.0,
                                        fontFamily: 'Monseratti',
                                        color: Colors.grey),
                                  ),
                                                            SizedBox(width: 20,),
                                   Text(
                                     'Please tap to sign out',
                                    style: TextStyle(
                                        fontSize: 12.0,
                                        fontFamily: 'Monseratti',
                                        color: Colors.red,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                      
                    }else{
                      return InkWell(
                      splashColor: Colors.redAccent,
                      borderRadius: BorderRadius.circular(10.0),
                      onTap: () {
                      
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
                                    fontSize: 16.0,
                                    fontFamily: 'Monseratti',
                                    fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Row(
                               
                                children: <Widget>[
                                  Text(
                                     'TIME IN:',
                                    style: TextStyle(
                                        fontSize: 12.0,
                                        fontFamily: 'Monseratti',
                                        color: Colors.grey,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(width: 10,),
                                  Text(
                                    this.filteredvisitorsList[index].datein +' '+ this.filteredvisitorsList[index].timein,
                                    style: TextStyle(
                                        fontSize: 12.0,
                                        fontFamily: 'Monseratti',
                                        color: Colors.grey),
                                  ),
                                   SizedBox(width: 20,),
                                   Text(
                                     'TIME OUT:',
                                    style: TextStyle(
                                        fontSize: 12.0,
                                        fontFamily: 'Monseratti',
                                        color: Colors.grey,
                                        fontWeight: FontWeight.bold),
                                  ),
                                    SizedBox(width: 10,),
                                  Text(
                                    this.filteredvisitorsList[index].dateout +' '+ this.filteredvisitorsList[index].timeout,
                                    style: TextStyle(
                                        fontSize: 12.0,
                                        fontFamily: 'Monseratti',
                                        color: Colors.grey),
                                  ),
                                    SizedBox(width: 20,),
                                   Text(
                                     'TAG NO:',
                                    style: TextStyle(
                                        fontSize: 12.0,
                                        fontFamily: 'Monseratti',
                                        color: Colors.grey,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(width: 10,),
                                  Text(
                                    this.filteredvisitorsList[index].tagno,
                                    style: TextStyle(
                                        fontSize: 12.0,
                                        fontFamily: 'Monseratti',
                                        color: Colors.grey),
                                  ),
                                  Icon(Icons.forward),
                                  Text('Signed Out', style:TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.grey),)
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                    }
                    
                  }),
            )
          ],
        ));
       
  }

 
}
