import 'package:flutter/material.dart';
import 'package:naragireg/screens/login.dart';
import 'package:naragireg/screens/visitorsform.dart';
import 'dart:async';
import 'package:sqflite/sqflite.dart';
import 'package:naragireg/models/visitors.dart';
import 'package:naragireg/utils/database_helper.dart';
import 'screens/todayslist.dart';
import 'global.dart' as global;
import 'screens/visitorslist.dart';


void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Volant iReg',
      theme: ThemeData(
        primarySwatch: Colors.orange,
      ),
      home: MyHomePage(title: 'Volant iReg'),
    );
  }
}

////
class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  DatabaseHelper databaseHelper = DatabaseHelper();
  List<VisitorsObj> visitorsList;
  List<VisitorsObj> filteredvisitorsList;
  int count = 0;

  @override
  void initState() {
    super.initState();
    if(global.value=='1'){
       WidgetsBinding.instance
        .addPostFrameCallback((_) => _showsnackbar('Welcome to Narag Energy!'));
    }else if(global.value=='2'){
       WidgetsBinding.instance
        .addPostFrameCallback((_) => _showsnackbar('Thank You for visiting. Have a nice day!'));
    }
   
    setState(() {
    // updateListview();
    });
  }

  final GlobalKey<ScaffoldState> scaffoldstate = new GlobalKey<ScaffoldState>();

  void _showsnackbar(String value){
    global.value='0';
    scaffoldstate.currentState.showSnackBar(new SnackBar(
      
      content: new Text(value)
      
      ,));
  }

  @override
  Widget build(BuildContext context) {
    if (visitorsList == null) {
      visitorsList = List<VisitorsObj>();
      filteredvisitorsList =visitorsList;
      updateListview();
    }

    return Scaffold(
        appBar: new AppBar(
          iconTheme: new IconThemeData(color: Colors.orange),
          elevation: 15.0,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Image.asset(
                'assets/logo.PNG',
                width: 120.0,
                height: 50.0,
              ),
              Text(
                'Volant iReg',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              //
            ],
          ),
          actions: <Widget>[
            Icon(Icons.calendar_today),
          ],
          backgroundColor: Colors.deepOrange,
        ),
        body:
         
         Center(child: 
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[

           /* Positioned(top: 10,
            child: Text('Welcome to Narag Energy Solutions'),),*/
           
           
            Padding(
              
              padding:
              
                  EdgeInsets.only(bottom: 20, left: MediaQuery.of(context).size.width/8, right: MediaQuery.of(context).size.width/8, top: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[

                  Text('Welcome to Narag Energy Solutions',textAlign: TextAlign.center, style: TextStyle(
                    fontFamily: 'Ubuntu',
                    fontSize: MediaQuery.of(context).size.height/35,
                    fontWeight: FontWeight.bold
                  ),),

                  
                  SizedBox(height: MediaQuery.of(context).size.height/20,),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      _buildCard('New Visitor', 'assets/newVisitor.png', () {
                        global.id=null;
                        global.address='';
                        global.name='';
                        global.phoneNo='';


                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return Visitors(VisitorsObj('', '', '', '', '', '',''));
                        }));
                      }, context),
                      _buildCard(
                          'Returning Visitor', 'assets/returning.png', () {
                            updateListview();

                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return VisitorsList(visitorsList);
                        }));
                          }, context)
                    ],
                  ),

                  
                  SizedBox(height: MediaQuery.of(context).size.height/40,),
                   Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      _buildCard('Sign Out', 'assets/signout.png', () {
                        updateListview();

                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return TodayVisitors(visitorsList);
                        }));
                      }, context),
                      _buildCard(
                          'Administration', 'assets/administration.png', () {
                             Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return Login();
                        }));
                          }, context)
                    ],
                  ),
                   SizedBox(height: MediaQuery.of(context).size.height/40,),
                  ListView(
                    shrinkWrap: true,
                    children: <Widget>[
                    Row(children: <Widget>[
                      Icon(Icons.people),
                      SizedBox(width: 5,),
                      Text('Services', style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold
                      ),)
                    ],),
                     SizedBox(height: MediaQuery.of(context).size.height/80,),
                    Text('Asset Evaluation, Production & Facility Engineering, Investment and Divestment Consulting, IT Support and Data Management, Seismic Data Processing, Audit and Prequalification Services, Training and Manpower Development...', style: TextStyle(color: Colors.grey),),
                   SizedBox(height: MediaQuery.of(context).size.height/40,),
                   Row(children: <Widget>[
                      Icon(Icons.contacts),
                      SizedBox(width: 5,),
                      Text('Contacts', style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold
                      ),)
                    ],),
                      SizedBox(height: MediaQuery.of(context).size.height/80,),
                   Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                     children: <Widget>[
                       Text('EMAIL: sales@naragenergy.com'),
                       SizedBox(height: 10.0,),
                       Text('Phone Number: 	+2348173574149'),
                   ],)
                 
                  
                  ],)
              
                ],
              ),
            ),

          ],
        )));
        
    
  }

  void updateListview() {
    final Future<Database> dbFuture = databaseHelper.initializeDatabase();
    dbFuture.then((database) {
      Future<List<VisitorsObj>> visitorListFuture =
          databaseHelper.getVisitorsList();
      visitorListFuture.then((visitorsList) {
        setState(() {
          this.visitorsList = visitorsList;
         this.filteredvisitorsList = visitorsList;
         this.count = filteredvisitorsList.length;
        });
      });
    });
  }
}

_buildCard(String title, String imgPath, Function onTap , BuildContext context) {
  return InkWell(
    borderRadius: BorderRadius.circular(10.0),
    splashColor: Colors.deepOrange,
    onTap: onTap,
    child: Container(
      padding: EdgeInsets.all(7.0),
      margin: EdgeInsets.all(3.0),
      height: MediaQuery.of(context).size.height/7,
      width: MediaQuery.of(context).size.width/3.2,
      
       decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
                blurRadius: 3.0,
                spreadRadius: 2.0,
                color: Colors.deepOrange.withOpacity(0.2))
          ]),
     
      child: Column(
        children: <Widget>[
          Stack(
            children: <Widget>[
              Container(
                height: MediaQuery.of(context).size.height/11,
                width: MediaQuery.of(context).size.width/7,
                decoration: BoxDecoration(
                    image: DecorationImage(
                  image: AssetImage(imgPath),
                  fit: BoxFit.scaleDown,
                )),
              ),
            ],
          ),
          SizedBox(
            height: 5.0,
          ),
          Text(
            title,
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: MediaQuery.of(context).size.height/60,
                fontFamily: 'Ubuntu'),
            textAlign: TextAlign.center,
          )
        ],
      ),
    ),
  );
}
