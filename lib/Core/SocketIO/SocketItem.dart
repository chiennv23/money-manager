import 'package:coresystem/Constant/Enum.dart';

class IOItem {
  int status;
  dynamic data;
  int key;
  int event;

  IOItem({
    this.status,
    this.data,
    this.key,
    this.event
  });

  factory IOItem.fromJson(Map<String, dynamic> json) {
    return IOItem(
      status: json['Status'],
      data: json['Data'],
    );
  }

  Map<String, dynamic> toJson() => {
        'Status': status,
        'Data': data,
      };
}
