
import 'package:flutter/material.dart';
import 'signature.dart';



class Visitors extends StatefulWidget{
  @override
  _Visitors createState()=> _Visitors();

}

//Activation
class _Visitors extends State<Visitors> {
String phone;
String mac;
String phoneAct;
String name;

TextEditingController phoneController =  TextEditingController();
TextEditingController nameController =  TextEditingController();

/*Future<bool> loader(){
  return showDialog(context: context,
      barrierDismissible: false,
      builder: (context)=> AlertDialog(
        title: ScalingText("Getting OTP. Please wait...", style: TextStyle(
          fontSize: 14
        ),),
      ));
}*/


Future<bool> dialog(str){
  return showDialog(context: context,
      barrierDismissible: false,
      builder: (context)=> AlertDialog(
        title: Text(str, style: TextStyle(
            fontSize: 14,
          color: Colors.red

        ),),
      ));
}


 

  @override
  Widget build(BuildContext context) {

    return Scaffold(
       
         appBar: new AppBar(iconTheme: new IconThemeData(color: Colors.white),
        elevation: 15.0,

        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[ 
            
          
            Text('Visitors Entry Form',style: TextStyle(
              color: Colors.white,

            ),),
           
          ],
        ), 
       
      backgroundColor: Colors.deepOrange,

        ),
        body: ListView(
         
          children: <Widget>[
            SizedBox(height: 20,),
           Text('Kindly fill up all fields below', textAlign: TextAlign.center,  style: 
           TextStyle(
             fontSize: 16,
             fontStyle: FontStyle.italic,
             color: Colors.red
             ),),
           SizedBox(height: 10,),
            Container(
              padding: EdgeInsets.only(top: 35.00, left: 20.0, right: 20.0),
              child: Column(
                children: <Widget>[
                  Material(
                    elevation: 3.0,
                    borderRadius: BorderRadius.circular(10.0),
                    child: TextField(
                      
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        prefixIcon: Icon(Icons.person, color: Colors.deepOrange, size: 30.0,),
                        contentPadding: EdgeInsets.only(left: 15.0, right: 15.0, top:15.0),
                        hintText: 'NAME'
                      ),
                    ),
                  ),
                  SizedBox(height: 20.0),
                   Material(
                    elevation: 3.0,
                    borderRadius: BorderRadius.circular(10.0),
                    child: TextField(
                      
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        prefixIcon: Icon(Icons.phone, color: Colors.deepOrange, size: 30.0,),
                        contentPadding: EdgeInsets.only(left: 15.0, right: 15.0, top:15.0),
                        hintText: 'PHONE NUMBER'
                      ),
                    ),
                  ),
                   SizedBox(height: 20.0),
                   Material(
                    elevation: 3.0,
                    borderRadius: BorderRadius.circular(10.0),
                    child: TextField(
                      
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        prefixIcon: Icon(Icons.location_city, color: Colors.deepOrange, size: 30.0,),
                        contentPadding: EdgeInsets.only(left: 15.0, right: 15.0, top:15.0),
                        hintText: 'ADDRESS'
                      ),
                    ),
                  ),
                    SizedBox(height: 20.0),
                   Material(
                    elevation: 3.0,
                    borderRadius: BorderRadius.circular(10.0),
                    child: TextField(
                      
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        prefixIcon: Icon(Icons.note, color: Colors.deepOrange, size: 30.0,),
                        contentPadding: EdgeInsets.only(left: 15.0, right: 15.0, top:15.0),
                        hintText: 'PURPOSE OF VISIT'
                      ),
                    ),
                  ),

                  SizedBox(height: 20.0),
                   Material(
                    elevation: 3.0,
                    borderRadius: BorderRadius.circular(10.0),
                    child: TextField(
                      
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        prefixIcon: Icon(Icons.tag_faces, color: Colors.deepOrange, size: 30.0,),
                        contentPadding: EdgeInsets.only(left: 15.0, right: 15.0, top:15.0),
                        hintText: 'TAG NO'
                      ),
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
                          onTap: (){
                            phone= phoneController.text;
                            mac= phoneController.text;
                            name = nameController.text;
                          //  getOtp();
                           Navigator.push(context, MaterialPageRoute(builder: (context){
                            return Signing();
                            }));
                          },
                          child: Center(
                            child: Text(
                              'CLICK TO SIGN',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'MontSerrat'
                              ),
                            ),
                          ),
                        )
                    ),

                  ),
                  SizedBox(height: 20.0),
                
                ],
              ),

            )
          ],
        )
    );
  }
}
