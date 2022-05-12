class AccountItem {
  String aCCNO;
  String pHONE;
  String aCCNOVISIBLE;
  String eMAIL;
  String dISPLAYNAME;

  String bALANCEVISIBLE;
  String sTATUS;
  String aDDRESS;
  DateTime bIRTHDATE;
  String uSERNAME;
  String gENDER;
  String bRANCHNAME;
  String get getGender {
    switch (gENDER) {
      case 'M':
        {
          return 'Nam';
        }
        break;

      case 'F':
        {
          return 'Nữ';
        }
        break;

      default:
        {
          return 'Khác';
        }
        break;
    }
  }

  AccountItem(
      {this.aCCNO,
      this.pHONE,
      this.aCCNOVISIBLE,
      this.eMAIL,
      this.dISPLAYNAME,
      this.bALANCEVISIBLE,
      this.sTATUS,
      this.aDDRESS,
      this.bIRTHDATE,
      this.uSERNAME,
      this.gENDER,
      this.bRANCHNAME});

  AccountItem.fromJson(Map<String, dynamic> data) {
    var json = data['Result'][0];
    aCCNO = json['ACC_NO'];
    pHONE = json['PHONE'];
    aCCNOVISIBLE = json['ACC_NO.VISIBLE'];
    eMAIL = json['EMAIL'];
    dISPLAYNAME = json['DISPLAY_NAME'];
    bALANCEVISIBLE = json['BALANCE.VISIBLE'];
    sTATUS = json['STATUS'];
    aDDRESS = json['ADDRESS'];
    if (json['BIRTH_DATE'] != 0) {
      DateTime date =
          DateTime.fromMillisecondsSinceEpoch(json['BIRTH_DATE'] * 1000);

      bIRTHDATE = date;
    }

    uSERNAME = json['USERNAME'];
    gENDER = json['GENDER'];
    bRANCHNAME = json['BRANCH_NAME'];
  }
}
