class PaymentResponse {
  String sTATUS;
  String sTATUSMESSAGE;
  int sETTAMOUNT;
  String sERIAL;
  String aUDITNUMBER;
  String cUSNAME;
  int pARVALUE;
  String tOPUPPHONE;
  String pRODUCTCODE;
  int dISCOUNTAGENT;
  int aMOUNT;
  String aDDRESS;
  String bILLNO;
  String tOPUPCODE;
  String sUPPLIERCODE;

  PaymentResponse(
      {this.sTATUS,
      this.sTATUSMESSAGE,
      this.sETTAMOUNT,
      this.sERIAL,
      this.aUDITNUMBER,
      this.cUSNAME,
      this.pARVALUE,
      this.tOPUPPHONE,
      this.pRODUCTCODE,
      this.dISCOUNTAGENT,
      this.aMOUNT,
      this.aDDRESS,
      this.bILLNO,
      this.tOPUPCODE,
      this.sUPPLIERCODE});

  PaymentResponse.fromJson(Map<String, dynamic> data) {
    final json = data['Result'][0];
    sTATUS = json['STATUS'];
    sTATUSMESSAGE = json['STATUS_MESSAGE'];
    sETTAMOUNT = json['SETT_AMOUNT'];
    sERIAL = json['SERIAL'];
    aUDITNUMBER = json['AUDIT_NUMBER'];
    cUSNAME = json['CUS_NAME'];
    pARVALUE = json['PARVALUE'];
    tOPUPPHONE = json['TOPUP_PHONE'];
    pRODUCTCODE = json['PRODUCT_CODE'];
    dISCOUNTAGENT = json['DISCOUNT_AGENT'];
    aMOUNT = json['AMOUNT'];
    aDDRESS = json['ADDRESS'];
    bILLNO = json['BILL_NO'];
    tOPUPCODE = json['TOPUP_CODE'];
    sUPPLIERCODE = json['SUPPLIER_CODE'];
  }
}
