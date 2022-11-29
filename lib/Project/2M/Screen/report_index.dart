import 'package:coresystem/Project/2M/Contains/skin/color_skin.dart';
import 'package:coresystem/Project/2M/Module/Report/View/report_category.dart';

import 'package:coresystem/Project/2M/Module/User/Views/report_money_date.dart';
import 'package:coresystem/Project/2M/Screen/transaction_index.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../Components/base_component.dart';
import '../../../Core/routes.dart';
import '../Contains/constants.dart';
import '../Contains/skin/typo_skin.dart';
import '../Module/Report/View/ReportByChart/View/report_by_chart.dart';

class SettingIndex extends StatefulWidget {
  const SettingIndex({Key key}) : super(key: key);

  @override
  State<SettingIndex> createState() => _SettingIndexState();
}

class _SettingIndexState extends State<SettingIndex> {
  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.dark,
      child: Scaffold(
        backgroundColor: FColorSkin.grey3_background,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(56),
          child: Container(
            decoration: BoxDecoration(boxShadow: [FElevation.elevation2]),
            child: appbarOnlyTitle(
                title: 'Report',
                systemUiOverlayStyle: SystemUiOverlayStyle.dark,
                action: [actionSearchAppbar()],
                noBack: true),
          ),
        ),
        body: Column(
          children: [
            FListTile(
              size: FListTileSize.size56,
              onTap: () {
                CoreRoutes.instance.navigatorPushRoutes(ViewMoneyWDate());
              },
              padding: EdgeInsets.only(left: 16),
              border: Border(
                  bottom: BorderSide(color: FColorSkin.grey3_background)),
              avatar: FIcon(
                icon: FFilled.calendar,
                size: 20,
                color: FColorSkin.subtitle,
              ),
              title: Text(
                'Report by date',
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
            ),
            FListTile(
              size: FListTileSize.size56,
              onTap: () {
                CoreRoutes.instance.navigatorPushRoutes(ReportByChart());
              },
              padding: EdgeInsets.only(left: 16),
              border: Border(
                  bottom: BorderSide(color: FColorSkin.grey3_background)),
              avatar: FIcon(
                icon: FFilled.pie_chart,
                size: 20,
                color: FColorSkin.subtitle,
              ),
              title: Text(
                'Report by year',
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
            ),
            FListTile(
              size: FListTileSize.size56,
              onTap: () {
                CoreRoutes.instance.navigatorPushRoutes(ReportWCategories());
              },
              padding: EdgeInsets.only(left: 16),
              border: Border(
                  bottom: BorderSide(color: FColorSkin.grey3_background)),
              avatar: FIcon(
                icon: FFilled.book,
                size: 20,
                color: FColorSkin.subtitle,
              ),
              title: Text(
                'Report by category',
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
            ),
          ],
        ),
      ),
    );
  }
}
