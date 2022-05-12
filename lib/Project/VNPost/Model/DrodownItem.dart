import 'dart:typed_data';
import 'dart:convert';

class DropdownItem {
  String text;
  String value;
  String image;
  String discountMethod;
  String description;
  String serviceCode;
  double discountAmount;
  Uint8List imageBase64;
  Base64Codec base64 = Base64Codec();
  bool selected = false;

  DropdownItem(
      {this.text,
      this.value,
      this.image,
      this.description,
      this.discountAmount,
      this.discountMethod,
      this.serviceCode});

  DropdownItem.fromJson(Map<String, dynamic> json) {
    text = json['TEXT'];
    value = json['VALUE'];
    image = json['IMAGE'];
    discountMethod = json['DISCOUNT_METHOD'];
    description = json['DESCRIPTION'];
    serviceCode = json['SERVICE_CODE'];
    if (json['DISCOUNT_AMOUNT'] != null) {
      discountAmount = double.parse(json['DISCOUNT_AMOUNT'].toString());
    }
    if (image != null) {
      try {
        image = image.replaceAll('\n', '');
        imageBase64 = Base64Decoder()
            .convert(base64.normalize(image.split('base64,')[1]));
      } catch (e) {
        image = null;
      }
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['TEXT'] = this.text;
    data['VALUE'] = this.value;

    return data;
  }

  static List<DropdownItem> fromJsonToList(Map<String, dynamic> data) {
    var json = data['Result'];
    var list = json as List;

    return list.map((c) => DropdownItem.fromJson(c)).toList();
  }
}
