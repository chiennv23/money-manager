class LoadHanderCreate {
  String auditNumber;

  LoadHanderCreate({this.auditNumber});

  LoadHanderCreate.fromJson(Map<String, dynamic> data) {
    final json = data['Result'][0];
    auditNumber = json['AUDIT_NUMBE'];
  }
}
