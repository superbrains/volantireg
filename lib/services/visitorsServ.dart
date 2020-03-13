import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'package:naragireg/classes/VisitorsClass.dart';

class Services{

  static const String url =   'https://naragenergy.com/ireg/api/visitors';
  static Future<String> saveVisitor(String name,String phoneNumber,String address,String purpose,String tagNo,DateTime dateAndTimeIn,DateTime dateAndTimeOut) async{

    try{
      final response = await http.post(url,  headers: {'content-type' : 'application/json'}, body: jsonEncode({'name': '$name', 'phoneNumber': '$phoneNumber', 'address': '$address', 'purpose': '$purpose', 'tagNo': '$tagNo', 'dateAndTimeIn': '$dateAndTimeIn', 'dateAndTimeOut': '$dateAndTimeOut' ,'status':'IN'}));
    
      if(response.statusCode==201){
        String data = response.body;
        return data;
      }else {

        return null;
      //  throw Exception(response.statusCode);
      }
    }
    catch(e){
     // throw Exception(e.toString());
    }
  }

  static List<VisitorsClass> parse(String responseBody){
    Map data;
    data = json.decode(responseBody);

    final parsed = data[null].cast<Map<String,dynamic>>();

    return parsed.map<VisitorsClass>((json)=> VisitorsClass.fromJson(json)).toList();
  }
}