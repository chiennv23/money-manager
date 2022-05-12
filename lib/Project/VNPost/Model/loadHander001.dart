class LoadHander001 {
  String auditNumber;

  LoadHander001({this.auditNumber});

  LoadHander001.fromJson(Map<String, dynamic> data) {
    final json = data['Result'][0];
    auditNumber = json['AUDIT_NUMBER'];
  }
}
