class TopUpConfirmResponse {
  int discountAgent;
  int amount;
  String serviceCode;
  int step;
  String transtype;
  int parvalue;
  String topupPhone;
  String productCode;
  String supplierCode;
  String parvaluedesc;
  int parvalue1;

  TopUpConfirmResponse(
      {this.discountAgent,
      this.amount,
      this.serviceCode,
      this.step,
      this.transtype,
      this.parvalue,
      this.topupPhone,
      this.productCode,
      this.supplierCode,
      this.parvaluedesc,
      this.parvalue1});

  TopUpConfirmResponse.fromJson(Map<String, dynamic> data) {
    final json = data['Result'][0];

    discountAgent = json['DISCOUNT_AGENT'];
    amount = json['AMOUNT'];
    serviceCode = json['SERVICE_CODE'];
    step = json['STEP'];
    transtype = json['TRANS_TYPE'];
    parvalue = json['PARVALUE'];
    topupPhone = json['TOPUP_PHONE'];
    productCode = json['PRODUCT_CODE'];
    supplierCode = json['SUPPLIER_CODE'];
    parvaluedesc = json['PARVALUE_DESC'];
    parvalue1 = json['PARVALUE_1'];
  }

 
}