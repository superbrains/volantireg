
import 'package:flutter/material.dart';
import 'package:naragireg/main.dart';

class Signing extends StatefulWidget {
  @override
  _Signing createState() => new _Signing();
}

class _Signing extends State<Signing> {
  List<Offset> _points = <Offset>[];

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
      
      body: Column(children: <Widget>[
       
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
                  Container(
                    height: 60.0,
                    child: Material(
                        borderRadius: BorderRadius.circular(20.0),
                        shadowColor: Colors.orange,
                        color: Colors.deepOrange,
                        elevation: 7.0,
                        child: GestureDetector(
                          onTap: (){
                             _showAlertDialog('Status', 'Visitor Saved Successfully');
                           Navigator.pushReplacement(context, MaterialPageRoute(builder: (context){
                            return MyHomePage();
                            }));
                          },
                          child: Center(
                            child: Text(
                              'CLICK TO SAVE',
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
      ],),
      
      
      floatingActionButton: new FloatingActionButton(
        child: new Icon(Icons.clear),
        onPressed: () => _points.clear(),
      ),
    );
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
