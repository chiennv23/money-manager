import 'package:coresystem/Project/2M/Contains/skin/color_skin.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../Components/base_component.dart';
import '../../../Core/routes.dart';
import '../Contains/constants.dart';
import '../Contains/skin/typo_skin.dart';
import 'transaction_index.dart';

class SettingIndex extends StatefulWidget {
  const SettingIndex({Key key}) : super(key: key);

  @override
  State<SettingIndex> createState() => _SettingIndexState();
}

class _SettingIndexState extends State<SettingIndex> {
  final _mainMenu = [
    {
      'title': 'Test',
      'icon': FFilled.bank,
      'route': CoreRouteNames.ACCOUNT_INFO,
    },
  ];


  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.dark,
      child: Scaffold(
        backgroundColor: FColorSkin.grey3_background,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(65),
          child: Stack(
            children: [
              Container(
                height: 65,
                color: FColorSkin.grey1_background,
              ),
              SafeArea(
                child: FListTile(
                  size: FListTileSize.size72,
                  padding: EdgeInsets.only(left: 16, right: 8, bottom: 16),
                  backgroundColor: FColorSkin.grey1_background,
                  title: Text(
                    'Cấu hình',
                    style: FTypoSkin.title2.copyWith(
                      color: FColorSkin.title,
                    ),
                  ),
                  action: actionAppbar(context),
                ),
              ),
            ],
          ),
        ),
        body: ListView.builder(
            padding: EdgeInsets.only(top: 16.0),
            itemCount: _mainMenu.length,
            itemBuilder: (context, i) {
              final item = _mainMenu[i];
              return FListTile(
                size: FListTileSize.size56,
                onTap: () {
                  CoreRoutes.instance.navigateToRouteString(item['route']);
                },
                padding: EdgeInsets.only(left: 16),
                border: Border(
                    bottom: BorderSide(color: FColorSkin.grey3_background)),
                avatar: FIcon(
                  icon: item['icon'],
                  size: 20,
                  color: FColorSkin.subtitle,
                ),
                title: Text(
                  item['title'],
                  style: FTypoSkin.title4.copyWith(color: FColorSkin.title),
                ),
                action: Container(
                  padding: EdgeInsets.only(right: 16),
                  child: FIcon(
                    icon: FOutlined.right,
                    color: FColorSkin.title,
                    size: 16,
                  ),
                ),
              );
            }),
      ),
    );
  }
}
