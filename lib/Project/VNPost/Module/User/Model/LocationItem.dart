class LocationItem {
  String code;
  String name;
  String parentCode;
  String unitType;

  LocationItem({this.code, this.name, this.parentCode, this.unitType});

  LocationItem.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    name = json['name'];
    parentCode = json['parentCode'];
    unitType = json['unitType'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['name'] = this.name;
    data['parentCode'] = this.parentCode;
    data['unitType'] = this.unitType;
    return data;
  }

  static List<LocationItem> fromJsonToList(List<dynamic> data) {
    return data.map((c) => LocationItem.fromJson(c)).toList();
  }
}
