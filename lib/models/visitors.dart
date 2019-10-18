class VisitorsObj {
  int _id;
  String _name;
  String _phoneNumber;
  String _address;
  String _purpose;
  String _tagno;
  String _timein;
  String _datein;
  String _timeout;
  String _dateout;
  

  VisitorsObj(this._name, this._phoneNumber, this._address, this._purpose,
      this._tagno,this._datein, this._timein,  [this._dateout,
      this._timeout]);
  VisitorsObj.withId(this._id, this._name, this._phoneNumber, this._address,
      this._purpose, this._tagno, this._datein, this._timein, [this._dateout,
      this._timeout]);

  int get id => _id;
  String get name => _name;
  String get phonenumber => _phoneNumber;
  String get address => _address;
  String get purpose => _purpose;
  String get tagno => _tagno;
   String get datein => _datein;
  String get timein => _timein;
   String get dateout => _dateout;
  String get timeout => _timeout;

  set id(int newid) {
    this._id = newid;
  }
  
  set name(String newName) {
    this._name = newName;
  }

  set phonenumber(String newPhone) {
    this._phoneNumber = newPhone;
  }

  set address(String newAddress) {
    this._address = newAddress;
  }

  set purpose(String newPurpose) {
    this._purpose = newPurpose;
  }

  set tagno(String newtagno) {
    this._tagno = newtagno;
  }

 set dateout(String newdateout) {
    this._dateout = newdateout;
  }

   set datein(String newdatein) {
    this._datein = newdatein;
  }

  set timein(String newtimein) {
    this._timein = newtimein;
  }

  set timeout(String newtimeout) {
    this._timeout = newtimeout;
  }

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();

    if (id != null) {
      map["id"] = _id;
    }
    map["name"] = _name;
    map["phonenumber"] = _phoneNumber;
    map["address"] = _address;
    map["purpose"] = _purpose;
    map["tagno"] = _tagno;
     map["datein"] = _datein;
    map["timein"] = _timein;
     map["dateout"] = _dateout;
    map["timeout"] = _timeout;
    return map;
  }

  VisitorsObj.fromMapObject(Map<String, dynamic> map) {
    this._id = map["id"];
    this._name = map["name"];
    this._phoneNumber = map["phonenumber"];
    this._address = map["address"];
    this._purpose = map["purpose"];
    this._tagno = map["tagno"];
    this._datein = map["datein"];
    this._timein = map["timein"];
    this._timeout = map["timeout"];
    this._dateout = map["dateout"];
  }
}
