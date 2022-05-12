import 'package:coresystem/Utils/ConvertUtils.dart';

class BaseResponse {
  String message;
  int code;
  int totalCount;
  int pageSize;
  int count;
  int page;
  List<String> errors = [];
  String error;
  bool result;

  BaseResponse.fromJson(Map<String, dynamic> json) {
    code = json['Status'] == 'Ok' ? 200 : 500;
  }
}


class BasicResponse<T> {
  String message;
  int code;
  String errorCode;
  String errorData;

  T data;

  int totalRow;

  BasicResponse();

  BasicResponse.fromJson(Map<String, dynamic> data) {
    code =  data['Status'] == 'Ok' ? 200 : 500;
  }
}


class DataPage {
  DataSourceLoadOptions dataSourceLoadOptions;

  DataPage({this.dataSourceLoadOptions});

  DataPage.fromJson(Map<String, dynamic> json) {
    dataSourceLoadOptions = json['DataSourceLoadOptions'] != null
        ? new DataSourceLoadOptions.fromJson(json['DataSourceLoadOptions'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.dataSourceLoadOptions != null) {
      data['DataSourceLoadOptions'] = this.dataSourceLoadOptions.toJson();
    }
    return data;
  }
}

class DataSourceLoadOptions {
  bool requireTotalCount;
  int page;
  int pageSize;

  DataSourceLoadOptions({this.requireTotalCount, this.page, this.pageSize});

  DataSourceLoadOptions.fromJson(Map<String, dynamic> json) {
    requireTotalCount = json['RequireTotalCount'];
    page = json['Page'];
    pageSize = json['PageSize'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['RequireTotalCount'] = this.requireTotalCount;
    data['Page'] = this.page;
    data['PageSize'] = this.pageSize;
    return data;
  }
}
