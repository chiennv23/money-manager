class verifySuccessItem {
  String code;
  String fullname;
  Null dateOfBirth;
  Null idCard;
  String email;
  Null orgCode;
  String phoneNumber;
  int status;
  int idCardType;
  Null positionId;
  Null positionName;
  Null titleId;
  Null titleName;
  Null gender;
  String address;
  Null taxCode;
  String provinceCode;
  String districtCode;
  String communeCode;
  int rowNum;
  Null isLocked;
  String otpPhone;
  String otpEmail;
  Null objMcasOrganizationDto;
  Null importingErrorMessages;
  bool verifyEmail;
  bool verifyPhone;

  verifySuccessItem(
      {this.code,
      this.fullname,
      this.dateOfBirth,
      this.idCard,
      this.email,
      this.orgCode,
      this.phoneNumber,
      this.status,
      this.idCardType,
      this.positionId,
      this.positionName,
      this.titleId,
      this.titleName,
      this.gender,
      this.address,
      this.taxCode,
      this.provinceCode,
      this.districtCode,
      this.communeCode,
      this.rowNum,
      this.isLocked,
      this.otpPhone,
      this.otpEmail,
      this.objMcasOrganizationDto,
      this.importingErrorMessages,
      this.verifyEmail,
      this.verifyPhone});

  verifySuccessItem.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    fullname = json['fullname'];
    dateOfBirth = json['dateOfBirth'];
    idCard = json['idCard'];
    email = json['email'];
    orgCode = json['orgCode'];
    phoneNumber = json['phoneNumber'];
    status = json['status'];
    idCardType = json['idCardType'];
    positionId = json['positionId'];
    positionName = json['positionName'];
    titleId = json['titleId'];
    titleName = json['titleName'];
    gender = json['gender'];
    address = json['address'];
    taxCode = json['taxCode'];
    provinceCode = json['provinceCode'];
    districtCode = json['districtCode'];
    communeCode = json['communeCode'];
    rowNum = json['rowNum'];
    isLocked = json['isLocked'];
    otpPhone = json['otpPhone'];
    otpEmail = json['otpEmail'];
    objMcasOrganizationDto = json['objMcasOrganizationDto'];
    importingErrorMessages = json['importingErrorMessages'];
    verifyEmail = json['verifyEmail'];
    verifyPhone = json['verifyPhone'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['fullname'] = this.fullname;
    data['dateOfBirth'] = this.dateOfBirth;
    data['idCard'] = this.idCard;
    data['email'] = this.email;
    data['orgCode'] = this.orgCode;
    data['phoneNumber'] = this.phoneNumber;
    data['status'] = this.status;
    data['idCardType'] = this.idCardType;
    data['positionId'] = this.positionId;
    data['positionName'] = this.positionName;
    data['titleId'] = this.titleId;
    data['titleName'] = this.titleName;
    data['gender'] = this.gender;
    data['address'] = this.address;
    data['taxCode'] = this.taxCode;
    data['provinceCode'] = this.provinceCode;
    data['districtCode'] = this.districtCode;
    data['communeCode'] = this.communeCode;
    data['rowNum'] = this.rowNum;
    data['isLocked'] = this.isLocked;
    data['otpPhone'] = this.otpPhone;
    data['otpEmail'] = this.otpEmail;
    data['objMcasOrganizationDto'] = this.objMcasOrganizationDto;
    data['importingErrorMessages'] = this.importingErrorMessages;
    data['verifyEmail'] = this.verifyEmail;
    data['verifyPhone'] = this.verifyPhone;
    return data;
  }
}
