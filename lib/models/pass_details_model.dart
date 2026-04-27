class PassDetailsModel {
  String? patRegno;
  String? attName;
  String? attAddr;
  String? attCity;
  String? attPincode;
  String? attMobile;
  String? attRequesttime;
  String? wardName;
  String? bedNo;
  int? ipid;
  int? wardid;
  int? bedid;
  String? appdt;
  String? visitor_Type;
  String? patientName;

  PassDetailsModel({
    this.patRegno,
    this.attName,
    this.attAddr,
    this.attCity,
    this.attPincode,
    this.attMobile,
    this.attRequesttime,
    this.wardName,
    this.bedNo,
    this.ipid,
    this.wardid,
    this.bedid,
    this.appdt,
    this.visitor_Type,
    this.patientName,
  });

  // Factory constructor for JSON deserialization
  factory PassDetailsModel.fromJson(Map<String, dynamic> json) {
    return PassDetailsModel(
      patRegno: json['Pat_regno'] as String?,
      attName: json['att_name'] as String?,
      attAddr: json['att_addr'] as String?,
      attCity: json['att_city'] as String?,
      attPincode: json['att_pincode'] as String?,
      attMobile: json['att_mobile'] as String?,
      attRequesttime: json['Att_Requesttime'] as String?,
      wardName: json['Ward_name'] as String?,
      bedNo: json['Bed_no'] as String?,
      ipid: json['Ipid'] as int?,
      wardid: json['Wardid'] as int?,
      bedid: json['Bedid'] as int?,
      appdt: json['Appdt'] as String?,
      visitor_Type: json['Visitor_Type'] as String?,
      patientName: json['PatientName'] as String?,
    );
  }

  // Method for JSON serialization
  Map<String, dynamic> toJson() {
    return {
      'Pat_regno': patRegno,
      'att_name': attName,
      'att_addr': attAddr,
      'att_city': attCity,
      'att_pincode': attPincode,
      'att_mobile': attMobile,
      'Att_Requesttime': attRequesttime,
      'Ward_name': wardName,
      'Bed_no': bedNo,
      'Ipid': ipid,
      'Wardid': wardid,
      'Bedid': bedid,
      'Appdt':appdt,
      'Visitor_Type':visitor_Type,
      'PatientName':patientName,
    };
  }
}