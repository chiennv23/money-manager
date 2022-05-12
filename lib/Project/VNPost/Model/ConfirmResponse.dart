class ConfirmResponse {
  String cUSSUPNAME;
  int dISCOUNTAGENT;
  String cUSSUPADDRESS;
  int pAYMENTAMOUNT;
  int sTEP;
  String sUPPLIERCODE;
  int tOTALAMOUNT;
  String pRODUCTCODE;
  String cUSSUPCODE;
  int aCTUALAMOUNT;
  String transType;

  ConfirmResponse(
      {this.cUSSUPNAME,
      this.dISCOUNTAGENT,
      this.cUSSUPADDRESS,
      this.pAYMENTAMOUNT,
      this.sTEP,
      this.sUPPLIERCODE,
      this.tOTALAMOUNT,
      this.pRODUCTCODE,
      this.cUSSUPCODE,
      this.aCTUALAMOUNT,
      this.transType});

  ConfirmResponse.fromJson(Map<String, dynamic> data) {
    final json = data['Result'][0];
    cUSSUPNAME = json['CUS_SUP_NAME'];
    dISCOUNTAGENT = json['DISCOUNT_AGENT'];
    cUSSUPADDRESS = json['CUS_SUP_ADDRESS'];
    pAYMENTAMOUNT = json['PAYMENT_AMOUNT'];
    sTEP = json['STEP'];
    sUPPLIERCODE = json['SUPPLIER_CODE'];
    tOTALAMOUNT = json['TOTAL_AMOUNT'];
    pRODUCTCODE = json['PRODUCT_CODE'];
    cUSSUPCODE = json['CUS_SUP_CODE'];
    aCTUALAMOUNT = json['ACTUAL_AMOUNT'];
    transType = json['TRANS_TYPE'];
  }
}
