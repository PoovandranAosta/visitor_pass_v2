class CheckInOutModel {
  final String? patRegno;
  final String? visiorNo;
  final String? attName;
  final String? attAddr;
  final String? attCity;
  final String? attPincode;
  final String? attMobile;
  final String? attRequesttime;
  final String? wardName;
  final String? bedNo;
  final String? appointmentdt;
  final String? visitor_Type;
  final String? checkin;
  final String? checkout;
  final String? patientName;

  CheckInOutModel({
    this.patRegno,
    this.visiorNo,
    this.attName,
    this.attAddr,
    this.attCity,
    this.attPincode,
    this.attMobile,
    this.attRequesttime,
    this.wardName,
    this.bedNo,
    this.appointmentdt,
    this.visitor_Type,
    this.checkin,
    this.checkout,
    this.patientName,
  });

  factory CheckInOutModel.fromJson(Map<String, dynamic> json) {
    return CheckInOutModel(
      patRegno: json['Pat_regno']?.toString() ?? "",
      visiorNo: json['VisiorNo']?.toString() ?? "",
      attName: json['att_name']?.toString()?? "",
      attAddr: json['att_addr']?.toString()?? "",
      attCity: json['att_city']?.toString()?? "",
      attPincode: json['att_pincode']?.toString()?? "",
      attMobile: json['att_mobile']?.toString()?? "",
      attRequesttime: json['Att_Requesttime']?.toString()?? "",
      wardName: json['Ward_name']?.toString()?? "",
      bedNo: json['Bed_no']?.toString()?? "",
      appointmentdt: json['Appointmentdt']?.toString()?? "",
      visitor_Type: json['Visitor_Type']?.toString()??"",
      checkin: json['Checkin']?.toString()?? "",
      checkout: json['Checkout']?.toString()?? "",
      patientName: json['PatientName']?.toString()??"",
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'Pat_regno': patRegno,
      'VisiorNo':visiorNo,
      'att_name': attName,
      'att_addr': attAddr,
      'att_city': attCity,
      'att_pincode': attPincode,
      'att_mobile': attMobile,
      'Att_Requesttime': attRequesttime,
      'Ward_name': wardName,
      'Bed_no': bedNo,
      'Appointmentdt': appointmentdt,
      'Visitor_Type':visitor_Type,
      'Checkin': checkin,
      'Checkout': checkout,
      'PatientName':patientName
    };
  }
}