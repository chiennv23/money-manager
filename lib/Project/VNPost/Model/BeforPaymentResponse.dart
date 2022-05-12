class BeforPaymentResponse {
  String auditNumber;
  String webContentRefresh;
  String url;
  String returnUrl;
  String cancelUrl;
  String result;

  BeforPaymentResponse(
      {this.auditNumber,
      this.webContentRefresh,
      this.url,
      this.cancelUrl,
      this.returnUrl});

  BeforPaymentResponse.fromJson(Map<String, dynamic> data) {
    final json = data['Result'][0];

    auditNumber = json['AUDIT_NUMBER'];
    webContentRefresh = json['WEB_CONTENT.REFRESH'];
    url = json['URL'];
    cancelUrl = json['CANCEL_URL'];
    returnUrl = json['RETURN_URL'];
    auditNumber = json['AUDIT_NUMBER'];
    result = json['RESULT'];
  }
}
