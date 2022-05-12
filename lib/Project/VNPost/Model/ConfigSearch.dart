class ConfigSearch {
  String groupName;
  String varName;
  String varValue;
  String varDesc;

  ConfigSearch({this.groupName, this.varName, this.varValue, this.varDesc});

  ConfigSearch.fromJson(Map<String, dynamic> data) {
    final json = data['Result'];
    groupName = json['GroupName'];
    varName = json['VarName'];
    varValue = json['VarValue'];
    varDesc = json['VarDesc'];
  }
}
