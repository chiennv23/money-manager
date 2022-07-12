class SpitAddressItem {
  int id;
  double score;
  String code;
  String name;
  String distCode;
  String distName;
  String provCode;
  String provName;
  String postalCode;
  String fullText;
  String ftext;
  int point;
  bool empty;

  SpitAddressItem(
      {this.id,
      this.score,
      this.code,
      this.name,
      this.distCode,
      this.distName,
      this.provCode,
      this.provName,
      this.postalCode,
      this.fullText,
      this.ftext,
      this.point,
      this.empty});

  SpitAddressItem.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    score = json['score'];
    code = json['code'];
    name = json['name'];
    distCode = json['dist_code'];
    distName = json['dist_name'];
    provCode = json['prov_code'];
    provName = json['prov_name'];
    postalCode = json['postal_code'];
    fullText = json['full_text'];
    ftext = json['ftext'];
    point = json['point'];
    empty = json['empty'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['score'] = this.score;
    data['code'] = this.code;
    data['name'] = this.name;
    data['dist_code'] = this.distCode;
    data['dist_name'] = this.distName;
    data['prov_code'] = this.provCode;
    data['prov_name'] = this.provName;
    data['postal_code'] = this.postalCode;
    data['full_text'] = this.fullText;
    data['ftext'] = this.ftext;
    data['point'] = this.point;
    data['empty'] = this.empty;
    return data;
  }

  static List<SpitAddressItem> fromJsonToList(List<dynamic> data) {
    return data.map((c) => SpitAddressItem.fromJson(c)).toList();
  }
}
