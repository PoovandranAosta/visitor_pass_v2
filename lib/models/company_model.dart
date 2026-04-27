class CompanyModel {
  int? iCID;
  String? ccompanyname;

  CompanyModel({this.iCID, this.ccompanyname});

  CompanyModel.fromJson(Map<String, dynamic> json) {
    iCID = json['ICID'];
    ccompanyname = json['ccompanyname'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ICID'] = this.iCID;
    data['ccompanyname'] = this.ccompanyname;
    return data;
  }
}