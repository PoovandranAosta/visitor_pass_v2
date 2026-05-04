class GateModel {
  String? gatename;
  int? gateid;

  GateModel({this.gatename, this.gateid});

  GateModel.fromJson(Map<String, dynamic> json) {
    gatename = json['Gatename'];
    gateid = json['gateid'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Gatename'] = this.gatename;
    data['gateid'] = this.gateid;
    return data;
  }
}