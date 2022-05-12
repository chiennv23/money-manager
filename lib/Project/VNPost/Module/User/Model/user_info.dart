class UserInfo {
  String iss;
  int exp;
  int nbf;
  int iat;
  String aid;
  String uid;
  String ufn;
  String org;
  String did;
  int lcp;
  int expirationDate;
  bool isEmployee;
  String owner;
  String phoneNumber;
  String token;
  String username, avatar;
  String password;

  UserInfo(
      {this.iss,
      this.exp,
      this.nbf,
      this.iat,
      this.aid,
      this.uid,
      this.ufn,
      this.org,
      this.did,
      this.lcp,
      this.expirationDate,
      this.isEmployee,
      this.owner,
      this.phoneNumber,
      this.token,
      this.username,
      this.avatar,
      this.password});

  UserInfo.fromJson(Map<String, dynamic> json) {
    iss = json['iss'];
    exp = json['exp'];
    nbf = json['nbf'];
    iat = json['iat'];
    aid = json['aid'];
    uid = json['uid'];
    ufn = json['ufn'];
    org = json['org'];
    did = json['did'];
    lcp = json['lcp'];
    expirationDate = json['expirationDate'];
    isEmployee = json['isEmployee'];
    owner = json['owner'];
    phoneNumber = json['phoneNumber'];
    token = json['token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['iss'] = this.iss;
    data['exp'] = this.exp;
    data['nbf'] = this.nbf;
    data['iat'] = this.iat;
    data['aid'] = this.aid;
    data['uid'] = this.uid;
    data['ufn'] = this.ufn;
    data['org'] = this.org;
    data['did'] = this.did;
    data['lcp'] = this.lcp;
    data['expirationDate'] = this.expirationDate;
    data['isEmployee'] = this.isEmployee;
    data['owner'] = this.owner;
    data['phoneNumber'] = this.phoneNumber;
    data['token'] = this.token;
    return data;
  }
}
