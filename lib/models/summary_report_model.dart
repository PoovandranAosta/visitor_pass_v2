class SummaryReportModel {
  String? companyName;
  int? visitorCount;
  int? checkOutCount;
  int? exitCount;

  SummaryReportModel(
      {this.companyName,
        this.visitorCount,
        this.checkOutCount,
        this.exitCount});

  SummaryReportModel.fromJson(Map<String, dynamic> json) {
    companyName = json['Company Name'];
    visitorCount = json['Visitor count'];
    checkOutCount = json['Check out count'];
    exitCount = json['Exit count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Company Name'] = this.companyName;
    data['Visitor count'] = this.visitorCount;
    data['Check out count'] = this.checkOutCount;
    data['Exit count'] = this.exitCount;
    return data;
  }
}