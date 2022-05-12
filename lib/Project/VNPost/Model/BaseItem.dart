class BaseItem {
  String fieldID;
  String fieldType;
  String value;

  BaseItem({this.fieldID, this.fieldType, this.value});

  BaseItem.fromJson(Map<String, dynamic> json) {
    fieldID = json['FieldID'];
    fieldType = json['FieldType'];
    value = json['Value'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['FieldID'] = this.fieldID;
    data['FieldType'] = this.fieldType;
    data['Value'] = this.value;
    return data;
  }
}


