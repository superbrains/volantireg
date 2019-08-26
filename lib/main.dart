import 'package:flutter/material.dart';
import 'package:naragireg/screens/visitorsform.dart';

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
//
class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  final List<String> states = ["Whyte Akpomiemie", "Udeh Aurelia Ifeoma",
    "Thompson Ebake",
    "Temitope Oluwatosin Awe",
    "Tamunotonye Solomon Ogolo",
    "Sanni Mubarak Babatunji",
    "Samira Iveren Denke",
    "Roland Ademola",
    "Otefisan Paul Abiodun",
    "Oluseun S. Oyelakin",
    "Obi Azubike",
    "Igah Dagogo",
    "Henry Agochukwu",
    "Faith Emmanuel Umoh",
    "Everest Njoku",
    "Eloji Chinazom",
    "Edmund Adesuyi",
    "Cyril Nwonye",
  ];
  List<String> filteredstates = List();

  @override
  void initState() {
    super.initState();
    setState(() {

      filteredstates = states;

    });

  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        appBar: new AppBar(iconTheme: new IconThemeData(color: Colors.orange),
          elevation: 15.0,

          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[

              Image.asset('assets/logo.PNG', width: 120.0, height: 50.0,),
              Text('Volant iReg',style: TextStyle(
                color: Colors.white,

              ),),
              //
            ],
          ),
          actions: <Widget>[
            Icon(Icons.calendar_today),

          ],
          backgroundColor: Colors.deepOrange,

        ),
        body:
        Column(

          children: <Widget>[

            Padding(padding: EdgeInsets.only(bottom: 20, left: 50, right: 50, top: 20),
              child: Column(

                mainAxisAlignment: MainAxisAlignment.center,

                children: <Widget>[
                  Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,

                    children: <Widget>[
                      _buildCard('New Visitor', 'assets/newVisitor.png', (){
                        Navigator.push(context, MaterialPageRoute(builder: (context){
                          return Visitors();
                        }));
                      }),
                      _buildCard('Returning Visitor', 'assets/returning.png', (){})
                    ],)
                ],

              ),
            ),

            Column(
              children: <Widget>[
                TextField(
                  decoration: InputDecoration(
                      contentPadding: EdgeInsets.all(10.0),
                      hintText: 'Search Visitors (Phone Number or Name)'
                  ),
                  onChanged: (string){
                    setState(() {
                      filteredstates = states.where((u)=>
                      (u.toLowerCase().contains(string.toLowerCase()))).toList();
                    });

                  },
                ),

              ],
            ),
            SizedBox(height: 10,),
            Text('Search in the box above and click on your name to sign out', style: TextStyle(
                color: Colors.red,
                fontSize: 12,
                fontStyle: FontStyle.italic
            ),),
            Expanded(
              child: ListView.builder(
                  padding: EdgeInsets.all(10.0),
                  itemCount:  filteredstates.length,
                  itemBuilder: (BuildContext context, int index){
                    return InkWell(
                      splashColor: Colors.redAccent,
                      borderRadius: BorderRadius.circular(10.0),
                      onTap: (){
                        setState(() {
                          /*Navigator.push(context, MaterialPageRoute(builder: (context){
                          return  Sections('States', filteredstates[index].toString());
                        }));*/

                        });
                      },

                      child:  Card(
                        child: Padding(
                          padding: EdgeInsets.all(10.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(filteredstates[index].toString(), style: TextStyle(
                                  fontSize: 15.0,
                                  fontFamily: 'Monseratti',
                                  fontWeight: FontWeight.bold

                              ),),

                              SizedBox(height: 30,),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: <Widget>[

                                  Text('26-08-2019 09:45AM', style: TextStyle(
                                      fontSize: 12.0,
                                      fontFamily: 'Monseratti',
                                      color: Colors.grey

                                  ),),
                                  Text('TAG NO: 013', style: TextStyle(
                                      fontSize: 12.0,
                                      fontFamily: 'Monseratti',
                                      color: Colors.grey

                                  ),),
                                  Icon(Icons.forward)
                                ],),


                            ],
                          ),
                        ),
                      )
                      ,
                    );

                  }),
            )
          ],
        )

    );
  }
}

_buildCard(String title, String imgPath, Function onTap){
  return
    InkWell(

      borderRadius: BorderRadius.circular(10.0),

      splashColor: Colors.deepOrange,

      onTap: onTap,
      child:  Container(

        padding: EdgeInsets.all(7.0),
        margin: EdgeInsets.all(3.0),
        height: 100.0,
        width: 100.0,
        decoration: BoxDecoration(

            borderRadius: BorderRadius.circular(10.0),
            color: Colors.white,
            boxShadow:[
              BoxShadow(

                  blurRadius: 3.0,
                  spreadRadius: 2.0,

                  color: Colors.deepOrange.withOpacity(0.2)
              )
            ]
        ),



        child: Column(
          children: <Widget>[
            Stack(
              children: <Widget>[


                Container(
                  height: 30.0,
                  width: 50.0,
                  decoration: BoxDecoration(
                      image: DecorationImage(

                        image: AssetImage(imgPath),
                        fit: BoxFit.scaleDown,

                      )
                  ),

                ),


              ],
            ),
            SizedBox(height: 20.0,),
            Text(title, style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 10.0,
                fontFamily: 'Monseratti'

            ), textAlign: TextAlign.center,)
          ],
        ),

      ),
    );


}
