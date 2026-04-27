class VisitorsDataModel {
  int? vID;
  String? vName;
  String? vFrom;
  String? vAddress;
  String? vMobile;
  String? vCreatedOn;
  String? toCompanyName;
  String? toCompanyAddress;
  String? toWhom;
  String? toPurpose;
  String? vImage;
  String? vCheckIn;
  String? vCheckOut;
  String? vGateOut;
  String? gateOutName;

  VisitorsDataModel(
      {this.vID,
        this.vName,
        this.vFrom,
        this.vAddress,
        this.vMobile,
        this.vCreatedOn,
        this.toCompanyName,
        this.toCompanyAddress,
        this.toWhom,
        this.toPurpose,
        this.vImage,
        this.vCheckIn,
        this.vCheckOut,
        this.vGateOut,
        this.gateOutName});

  VisitorsDataModel.fromJson(Map<String, dynamic> json) {
    vID = int.tryParse(json['V ID']?.toString() ?? '');
    vName = json['V name'] ?? '';
    vFrom = json['V From'] ?? '';
    vAddress = json['V Address'] ?? '';
    vMobile = json['V Mobile'] ?? '';
    vCreatedOn = json['V Created On'] ?? '';
    toCompanyName = json['To Company Name'] ?? '';
    toCompanyAddress = json['To Company Address'] ?? '';
    toWhom = json['To Whom'] ?? '';
    toPurpose = json['To Purpose'] ?? '';
    vImage = json['V Image'] ?? '';
    vCheckIn = json['V Check in'] ?? '';
    vCheckOut = json['V Check out'] ?? '';
    vGateOut = json['V Gate out'] ?? '';
    gateOutName = json['Gate Out Name'] ?? '';
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['V ID'] = this.vID;
    data['V name'] = this.vName;
    data['V From'] = this.vFrom;
    data['V Address'] = this.vAddress;
    data['V Mobile'] = this.vMobile;
    data['V Created On'] = this.vCreatedOn;
    data['To Company Name'] = this.toCompanyName;
    data['To Company Address'] = this.toCompanyAddress;
    data['To Whom'] = this.toWhom;
    data['To Purpose'] = this.toPurpose;
    data['V Image'] = this.vImage;
    data['V Check in'] = this.vCheckIn;
    data['V Check out'] = this.vCheckOut;
    data['V Gate out'] = this.vGateOut;
    data['Gate Out Name'] = this.gateOutName;
    return data;
  }
}