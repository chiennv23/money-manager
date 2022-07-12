class UserResponse {
  String type;
  String message;
  String accessToken;
  String tokenType;
  int checkExpirePassword;
  String username;
  Null orgUserList;

  UserResponse(
      {this.type,
      this.message,
      this.accessToken,
      this.tokenType,
      this.checkExpirePassword,
      this.username,
      this.orgUserList});

  UserResponse.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    message = json['message'];
    accessToken = json['accessToken'];
    tokenType = json['tokenType'];
    checkExpirePassword = json['checkExpirePassword'];
    username = json['username'];
    orgUserList = json['orgUserList'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['type'] = this.type;
    data['message'] = this.message;
    data['accessToken'] = this.accessToken;
    data['tokenType'] = this.tokenType;
    data['checkExpirePassword'] = this.checkExpirePassword;
    data['username'] = this.username;
    data['orgUserList'] = this.orgUserList;
    return data;
  }
}
