import 'dart:convert';

class VisitorsClass {
    int id;
    String name;
    String phoneNumber;
    String address;
    String purpose;
    String tagNo;
    String dateAndTimeIn;
    String dateAndTimeOut;
    String status;

    VisitorsClass({
        this.id,
        this.name,
        this.phoneNumber,
        this.address,
        this.purpose,
        this.tagNo,
        this.dateAndTimeIn,
        this.dateAndTimeOut,
        this.status,
    });

    factory VisitorsClass.fromJson(String str) => VisitorsClass.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory VisitorsClass.fromMap(Map<String, dynamic> json) => VisitorsClass(
        id: json["id"],
        name: json["name"],
        phoneNumber: json["phoneNumber"],
        address: json["address"],
        purpose: json["purpose"],
        tagNo: json["tagNo"],
        dateAndTimeIn: json["dateAndTimeIN"],
        dateAndTimeOut: json["dateAndTimeOut"],
        status: json["status"],
    );

    Map<String, dynamic> toMap() => {
        "id": id,
        "name": name,
        "phoneNumber": phoneNumber,
        "address": address,
        "purpose": purpose,
        "tagNo": tagNo,
        "dateAndTimeIN": dateAndTimeIn,
        "dateAndTimeOut": dateAndTimeOut,
        "status": status,
    };
}
