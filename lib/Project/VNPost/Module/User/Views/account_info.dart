import 'package:coresystem/Components/base_component.dart';
import 'package:coresystem/Core/routes.dart';
import 'package:coresystem/Project/VNPost/Contains/constants.dart';
import 'package:coresystem/Project/VNPost/Contains/skin/color_skin.dart';
import 'package:coresystem/Project/VNPost/Contains/skin/typo_skin.dart';
import 'package:coresystem/Project/VNPost/Module/User/Views/edit_account_info.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AccountInfo extends StatefulWidget {
  const AccountInfo({Key key}) : super(key: key);

  @override
  State<AccountInfo> createState() => _AccountInfoState();
}

class _AccountInfoState extends State<AccountInfo> {
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
              title: 'Thông tin tài khoản',
              iconBack: FOutlined.left,
              action: [
                FFilledButton(
                    backgroundColor: FColorSkin.transparent,
                    onPressed: () {
                      CoreRoutes.instance
                          .navigatorPushRoutes(EditAccountInfo());
                    },
                    child: Text(
                      'Chỉnh sửa',
                      style: FTypoSkin.buttonText2
                          .copyWith(color: FColorSkin.infoPrimary),
                    ))
              ]),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.only(top: 16.0, right: 16),
        child: Column(
          children: [
            FListTile(
                title: Text(
              'Thông tin cá nhân',
              style: FTypoSkin.title3.copyWith(color: FColorSkin.title),
            )),
            cardInfo('Họ tên', 'Nguyễn Văn Anh'),
            cardInfo('Số điện thoại', '0385018488'.replaceRange(3, 6, '***')),
            cardInfo('Email', 'Nguyenvananh@gmail.com'),
            cardInfo(
                'Địa chỉ', '11 Hoang Hoa Tham, Trung Liệt, Đống Đa, Hà Nội'),
            cardInfo('Ngày sinh', '14/04/2000'),
            cardInfo('CMT/CCCD', '001057756474'),
            cardInfo('Mã số thuế', '0010577', isBorder: false),
          ],
        ),
      ),
    );
  }

  Widget cardInfo(String title, String value, {bool isBorder = true}) {
    return FListTile(
      size: FListTileSize.size56,
      padding: EdgeInsets.fromLTRB(16, 0, 0, 0),
      border: isBorder
          ? Border(
              bottom: BorderSide(
              color: FColorSkin.grey3_background,
            ))
          : null,
      title: Text(
        title,
        style: FTypoSkin.title6.copyWith(
          color: FColorSkin.secondaryText,
        ),
      ),
      action: Container(
        width: MediaQuery.of(context).size.width / 2,
        child: Text(
          value,
          maxLines: 2,
          textAlign: TextAlign.end,
          overflow: TextOverflow.ellipsis,
          style: FTypoSkin.title6.copyWith(
            color: FColorSkin.title,
          ),
        ),
      ),
    );
  }
}
