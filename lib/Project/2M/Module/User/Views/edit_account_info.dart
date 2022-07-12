import 'package:coresystem/Components/base_component.dart';
import 'package:coresystem/Project/2M/Contains/constants.dart';
import 'package:coresystem/Project/2M/Contains/skin/color_skin.dart';
import 'package:coresystem/Project/2M/Contains/skin/typo_skin.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class EditAccountInfo extends StatefulWidget {
  const EditAccountInfo({Key key}) : super(key: key);

  @override
  State<EditAccountInfo> createState() => _EditAccountInfoState();
}

class _EditAccountInfoState extends State<EditAccountInfo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: FColorSkin.grey1_background,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(48),
        child: Container(
          decoration: BoxDecoration(boxShadow: [FElevation.elevation2]),
          child: appbarOnlyTitle(
            systemUiOverlayStyle: SystemUiOverlayStyle.dark,
            title: 'Sửa thông tin cá nhân',
            iconBack: FOutlined.left,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [],
        ),
      ),
    );
  }
}
