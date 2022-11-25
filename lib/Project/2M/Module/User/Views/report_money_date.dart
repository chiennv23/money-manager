import 'dart:math' as math;

import 'package:charts_flutter/flutter.dart' as charts;
import 'package:coresystem/Components/base_component.dart';
import 'package:coresystem/Project/2M/Contains/constants.dart';
import 'package:coresystem/Project/2M/Contains/skin/color_skin.dart';
import 'package:coresystem/Project/2M/LocalDatabase/model_lib.dart';
import 'package:coresystem/Project/2M/Module/Money/DA/money_controller.dart';
import 'package:coresystem/Project/2M/Module/Report/Widget/pie_chart.dart';
import 'package:coresystem/Utils/ConvertUtils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../../../Components/widgets/calender_date_picker.dart';
import '../../../Contains/skin/typo_skin.dart';
import '../../../Screen/transaction_index.dart';

class ViewMoneyWDate extends StatefulWidget {
  const ViewMoneyWDate({Key key}) : super(key: key);

  @override
  State<ViewMoneyWDate> createState() => _ViewMoneyState();
}

class _ViewMoneyState extends State<ViewMoneyWDate> {
  DateTime selectedDate = DateTime.now();

  MoneyController moneyController = Get.find();
  List<MoneyItem> moneyListADay = [];
  List<MoneyItem> moneyTypeListADay = [];
  double moneyValue = 0.0;

  @override
  void initState() {
    moneyListADay = moneyController.allMoneyList
        .where((element) => element.creMoneyDate.isSameDate(selectedDate))
        .toList();
    moneyTypeListADay = moneyListADay
        .filterCheckDuplicateItem(
          (p0) => p0.moneyCateType.cateName,
        )
        .toList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: FColorSkin.grey1_background,
      appBar: appbarOnlyTitle(
          title: 'Report by Date',
          iconBack: FOutlined.left,
          action: [actionSearchAppbar()],
          systemUiOverlayStyle: SystemUiOverlayStyle.dark),
      body: ListView(
        children: [
          Container(
            decoration: BoxDecoration(
                border: Border(
                    bottom: BorderSide(color: FColorSkin.subtitle, width: .2))),
            child: FCalendarDatePicker(
              lastDate: DateTime.utc(2030, 3, 14),
              initialDate: selectedDate,
              firstDate: DateTime.utc(2010, 10, 16),
              onDateChanged: (vl) {
                if (vl.isSameDate(selectedDate)) {
                  return;
                }
                setState(() {
                  selectedDate = vl;
                  moneyListADay = [];
                  moneyTypeListADay = [];
                  moneyListADay = moneyController.allMoneyList
                      .where((element) =>
                          element.creMoneyDate.isSameDate(selectedDate))
                      .toList();
                  moneyTypeListADay = moneyListADay
                      .filterCheckDuplicateItem(
                        (p0) => p0.moneyCateType.cateName,
                      )
                      .toList();
                });
              },
              moneyList: moneyController.allMoneyList,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Row(
                children: [
                  Container(
                    height: 10,
                    width: 10,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: FColorSkin.primaryColor,
                    ),
                  ),
                  Text(
                    ' Income',
                    style: FTypoSkin.subtitle2.copyWith(
                      color: FColorSkin.primaryColor,
                    ),
                  )
                ],
              ),
              Row(
                children: [
                  Container(
                    height: 10,
                    width: 10,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: FColorSkin.warningPrimary,
                    ),
                  ),
                  Text(
                    ' Expense',
                    style: FTypoSkin.subtitle2.copyWith(
                      color: FColorSkin.warningPrimary,
                    ),
                  )
                ],
              ),
            ],
          ),
          Builder(builder: (context) {
            List<MapMoneyData> lst = [];
            int i = 0;
            moneyTypeListADay.forEach((item) {
              if (item.moneyType == '0') {
                var listDayMoneyType = moneyListADay
                    .where((element) => element.moneyType == '0')
                    .toList();
                var listSameType = listDayMoneyType
                    .where((e) =>
                        e.moneyCateType.cateName == item.moneyCateType.cateName)
                    .toList();
                if (listSameType.first.moneyCateType.cateName ==
                    item.moneyCateType.cateName) {
                  moneyValue = listSameType
                      .map((e) => e.moneyValue)
                      .reduce((value, element) => value + element);
                } else {
                  moneyValue = item.moneyValue;
                }
              } else {
                var listDayMoneyType = moneyListADay
                    .where((element) => element.moneyType == '1')
                    .toList();
                var listSameType = listDayMoneyType
                    .where((e) =>
                        e.moneyCateType.cateName == item.moneyCateType.cateName)
                    .toList();
                if (listSameType.first.moneyCateType.cateName ==
                    item.moneyCateType.cateName) {
                  moneyValue = listSameType
                      .map((e) => e.moneyValue)
                      .reduce((value, element) => value + element);
                } else {
                  moneyValue = item.moneyValue;
                }
              }
              i += 1;
              // print(i);
              lst.add(MapMoneyData(
                  index: i,
                  icon: item.moneyCateType.cateIcon,
                  cate: item.moneyCateType.cateName,
                  value: moneyValue,
                  cateColor:
                      Color((math.Random().nextDouble() * 0xFFFFFF).toInt())
                          .withOpacity(1.0)));
            });
            // print(lst.length);
            List<charts.Series<MapMoneyData, int>> _MoneyChartData() {
              return [
                charts.Series<MapMoneyData, int>(
                  id: 'ReportMoney',
                  domainFn: (MapMoneyData sales, _) => sales.index,
                  measureFn: (MapMoneyData sales, _) => sales.value.toInt(),
                  colorFn: (MapMoneyData sales, _) =>
                      charts.ColorUtil.fromDartColor(sales.cateColor),
                  labelAccessorFn: (MapMoneyData row, _) =>
                      '${row.cate}: ${row.value.wToMoney(0)}',
                  outsideLabelStyleAccessorFn: (MapMoneyData row, _) =>
                      charts.TextStyleSpec(
                    fontSize: 8,
                    color: charts.ColorUtil.fromDartColor(row.cateColor),
                  ),
                  data: lst,
                )
              ];
            }

            if (lst.isEmpty) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset(StringIcon.empty),
                    Padding(
                      padding: const EdgeInsets.all(30.0),
                      child: Text(
                        'No money not found. Tap other days!',
                        style: FTypoSkin.title5
                            .copyWith(color: FColorSkin.subtitle),
                      ),
                    ),
                  ],
                ),
              );
            }
            return Container(
              padding: EdgeInsets.only(top: 20, bottom: 20),
              child: Column(
                children: [
                  Container(
                    height: 230,
                    child: lst.isEmpty
                        ? SimplePieChart.withSampleData()
                        : SimplePieChart(_MoneyChartData()),
                  ),
                  ...List.generate(moneyTypeListADay.length, (index) {
                    final item = moneyTypeListADay[index];

                    if (item.moneyType == '0') {
                      var listDayMoneyType = moneyListADay
                          .where((element) => element.moneyType == '0')
                          .toList();
                      var listSameType = listDayMoneyType
                          .where((e) =>
                              e.moneyCateType.cateName ==
                              item.moneyCateType.cateName)
                          .toList();
                      if (listSameType.first.moneyCateType.cateName ==
                          item.moneyCateType.cateName) {
                        moneyValue = listSameType
                            .map((e) => e.moneyValue)
                            .reduce((value, element) => value + element);
                      } else {
                        moneyValue = item.moneyValue;
                      }
                    } else {
                      var listDayMoneyType = moneyListADay
                          .where((element) => element.moneyType == '1')
                          .toList();
                      var listSameType = listDayMoneyType
                          .where((e) =>
                              e.moneyCateType.cateName ==
                              item.moneyCateType.cateName)
                          .toList();
                      if (listSameType.first.moneyCateType.cateName ==
                          item.moneyCateType.cateName) {
                        moneyValue = listSameType
                            .map((e) => e.moneyValue)
                            .reduce((value, element) => value + element);
                      } else {
                        moneyValue = item.moneyValue;
                      }
                    }

                    return FListTile(
                      size: FListTileSize.size32,
                      backgroundColor: FColorSkin.transparent,
                      padding: EdgeInsets.only(left: 24, right: 24),
                      avatar: FBoundingBox(
                        size: FBoxSize.size24,
                        backgroundColor: FColorSkin.grey1_background,
                        child: Image.asset(item.moneyCateType.cateIcon),
                      ),
                      title: Text(
                        item.moneyCateType.cateName ?? '',
                        style: FTypoSkin.title5
                            .copyWith(color: lst[index].cateColor),
                      ),
                      action: Text(
                        '${item.moneyType == '0' ? '-' : '+'}${moneyValue.wToMoney(0)}',
                        style: FTypoSkin.title5.copyWith(
                          color: item.moneyType == '0'
                              ? FColorSkin.warningPrimary
                              : FColorSkin.primaryColor,
                        ),
                      ),
                    );
                  })
                ],
              ),
            );
          })
        ],
      ),
    );
  }
}

class MapMoneyData {
  MapMoneyData({this.index, this.icon, this.cate, this.value, this.cateColor});

  final int index;
  final String icon, cate;
  final double value;
  final Color cateColor;
}
