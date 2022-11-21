import 'dart:math' as math;

import 'package:charts_flutter/flutter.dart' as charts;
import 'package:coresystem/Project/2M/Contains/constants.dart';
import 'package:coresystem/Project/2M/Contains/skin/color_skin.dart';
import 'package:coresystem/Project/2M/LocalDatabase/Models/money_item.dart';
import 'package:coresystem/Project/2M/Module/Money/DA/money_controller.dart';
import 'package:coresystem/Utils/ConvertUtils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../../../Components/base_component.dart';
import '../../../../../Core/routes.dart';
import '../../../Contains/skin/typo_skin.dart';
import '../../User/Views/report_money_date.dart';
import '../Widget/pie_chart.dart';

class ReportWCategories extends StatefulWidget {
  const ReportWCategories({Key key}) : super(key: key);

  @override
  State<ReportWCategories> createState() => _ReportWCategoriesState();
}

class _ReportWCategoriesState extends State<ReportWCategories> {
  int indexType = 1;
  double moneyValue = 0.0;
  int selectedYear = DateTime.now().year;

  MoneyController moneyController = Get.find();

  List<MoneyItem> moneyListAYear = [];
  List<MoneyItem> moneyTypeListAYear = [];

  @override
  void initState() {
    moneyListAYear = moneyController.allMoneyList
        .where((element) =>
            element.creMoneyDate.year == selectedYear &&
            element.moneyType == indexType.toString())
        .toList();
    moneyTypeListAYear = moneyListAYear
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
      appBar: appbarWithBottom(
        title: 'Report with Category',
        iconBack: FOutlined.left,
        systemUiOverlayStyle: SystemUiOverlayStyle.dark,
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(40),
          child: Container(
            height: 48,
            margin: EdgeInsets.only(left: 24, right: 24, bottom: 16, top: 0.0),
            padding: EdgeInsets.symmetric(horizontal: 4),
            decoration: BoxDecoration(
                color: FColorSkin.grey3_background,
                borderRadius: BorderRadius.circular(16.0)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: FFilledButton(
                    size: FButtonSize.size40
                        .copyWith(borderRadius: Radius.circular(16.0)),
                    backgroundColor: indexType == 1
                        ? FColorSkin.title
                        : FColorSkin.transparent,
                    child: Center(
                      child: Text(
                        'Income',
                        style: FTypoSkin.buttonText2.copyWith(
                            color: indexType == 1
                                ? FColorSkin.grey1_background
                                : FColorSkin.subtitle),
                      ),
                    ),
                    onPressed: () {
                      indexType = 1;
                      moneyListAYear = moneyController.allMoneyList
                          .where((element) =>
                              element.creMoneyDate.year == selectedYear &&
                              element.moneyType == indexType.toString())
                          .toList();
                      moneyTypeListAYear = moneyListAYear
                          .filterCheckDuplicateItem(
                            (p0) => p0.moneyCateType.cateName,
                          )
                          .toList();
                      setState(() {});
                    },
                  ),
                ),
                Expanded(
                  child: FFilledButton(
                    size: FButtonSize.size40
                        .copyWith(borderRadius: Radius.circular(16.0)),
                    backgroundColor: indexType == 0
                        ? FColorSkin.title
                        : FColorSkin.transparent,
                    child: Center(
                      child: Text(
                        'Expense',
                        style: FTypoSkin.buttonText2.copyWith(
                            color: indexType == 0
                                ? FColorSkin.grey1_background
                                : FColorSkin.subtitle),
                      ),
                    ),
                    onPressed: () {
                      indexType = 0;
                      moneyListAYear = moneyController.allMoneyList
                          .where((element) =>
                              element.creMoneyDate.year == selectedYear &&
                              element.moneyType == indexType.toString())
                          .toList();
                      moneyTypeListAYear = moneyListAYear
                          .filterCheckDuplicateItem(
                            (p0) => p0.moneyCateType.cateName,
                          )
                          .toList();
                      setState(() {});
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      body: Builder(builder: (context) {
        List<MapMoneyData> lst = [];
        int i = 0;
        moneyTypeListAYear.forEach((item) {
          var listDayMoneyType = moneyListAYear
              .where((element) => element.moneyType == indexType.toString())
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
          i += 1;
          // print(i);
          lst.add(MapMoneyData(
              index: i,
              icon: item.moneyCateType.cateIcon,
              cate: item.moneyCateType.cateName,
              value: moneyValue,
              cateColor: Color((math.Random().nextDouble() * 0xFFFFFF).toInt())
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
          return Column(
            children: [
              Container(
                  height: 50,
                  alignment: Alignment.center,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 24.0),
                        child: FFilledButton(
                            backgroundColor: FColorSkin.transparent,
                            size: FButtonSize.size32
                                .copyWith(padding: EdgeInsets.zero),
                            onPressed: changeYear,
                            child: Row(
                              children: [
                                Text(
                                  '$selectedYear',
                                  style: FTypoSkin.title2
                                      .copyWith(color: FColorSkin.primaryColor),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 4.0),
                                  child: FIcon(
                                    icon: FOutlined.down,
                                    size: 16,
                                    color: FColorSkin.primaryColor,
                                  ),
                                )
                              ],
                            )),
                      ),
                    ],
                  )),
              Expanded(child: SvgPicture.asset(StringIcon.empty)),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(30.0),
                  child: Text(
                    'No money not found. Tap other days!',
                    style:
                        FTypoSkin.title5.copyWith(color: FColorSkin.subtitle),
                  ),
                ),
              ),
            ],
          );
        }
        return Column(
          children: [
            Container(
                height: 50,
                alignment: Alignment.center,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 24.0),
                      child: FFilledButton(
                          backgroundColor: FColorSkin.transparent,
                          size: FButtonSize.size32
                              .copyWith(padding: EdgeInsets.zero),
                          onPressed: changeYear,
                          child: Row(
                            children: [
                              Text(
                                '$selectedYear',
                                style: FTypoSkin.title2
                                    .copyWith(color: FColorSkin.primaryColor),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 4.0),
                                child: FIcon(
                                  icon: FOutlined.down,
                                  size: 16,
                                  color: FColorSkin.primaryColor,
                                ),
                              )
                            ],
                          )),
                    ),
                  ],
                )),
            Container(
                height: 200,
                child: lst.isEmpty
                    ? SimplePieChart.withSampleData()
                    : SimplePieChart(_MoneyChartData())),
            Expanded(
                child: Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                      border: Border(
                          bottom:
                              BorderSide(color: FColorSkin.grey4_background))),
                  child: FListTile(
                    size: FListTileSize.size32,
                    backgroundColor: FColorSkin.transparent,
                    padding: EdgeInsets.only(left: 24, right: 24),
                    title: Text(
                      'Total: ',
                      style: FTypoSkin.title4.copyWith(
                          color: FColorSkin.title, fontWeight: FontWeight.w600),
                    ),
                    action: Text(
                      '${WConvert.money(lst.map((e) => e.value).fold(0, (previousValue, element) => previousValue + element), 0)}' ??
                          '',
                      style: FTypoSkin.title4.copyWith(
                          color: indexType.toString() == '0'
                              ? FColorSkin.warningPrimary
                              : FColorSkin.primaryColor,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                      itemCount: lst.length,
                      itemBuilder: (context, index) {
                        final item = lst[index];
                        return FListTile(
                          size: FListTileSize.size32,
                          backgroundColor: FColorSkin.transparent,
                          padding: EdgeInsets.only(left: 24, right: 24),
                          avatar: FBoundingBox(
                            size: FBoxSize.size24,
                            backgroundColor: FColorSkin.grey1_background,
                            child: Image.asset(item.icon),
                          ),
                          title: Text(
                            item.cate ?? '',
                            style: FTypoSkin.title5
                                .copyWith(color: lst[index].cateColor),
                          ),
                          action: Text(
                            '${indexType.toString() == '0' ? '-' : '+'}${item.value.wToMoney(0)}',
                            style: FTypoSkin.title5.copyWith(
                              color: lst[index].cateColor,
                            ),
                          ),
                        );
                      }),
                ),
              ],
            ))
          ],
        );
      }),
    );
  }

  Future changeYear() {
    return showModalBottomSheet(
      elevation: 0,
      enableDrag: true,
      isDismissible: true,
      isScrollControlled: true,
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(12),
          topRight: Radius.circular(12),
        ),
      ),
      builder: (context) => Container(
        height: MediaQuery.of(context).size.height / 3,
        child: StatefulBuilder(
          builder: (context, setStatefulBuilder) {
            return Scaffold(
              backgroundColor: FColors.transparent,
              appBar: PreferredSize(
                preferredSize: Size.fromHeight(68.0 + 16),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(12),
                      topRight: Radius.circular(12),
                    ),
                    color: FColorSkin.grey1_background,
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        width: 32,
                        height: 4,
                        margin: EdgeInsets.only(top: 8),
                        decoration: BoxDecoration(
                            color: FColorSkin.subtitle,
                            borderRadius: BorderRadius.circular(8.0)),
                      ),
                      AppBar(
                        backgroundColor: FColors.grey1,
                        centerTitle: true,
                        elevation: 0.2,
                        leading: Container(
                          child: FFilledButton.icon(
                            size: FButtonSize.size48,
                            backgroundColor: FColors.transparent,
                            child: FIcon(icon: FOutlined.close),
                            onPressed: () {
                              Navigator.pop(context);
                            },
                          ),
                        ),
                        title: Text(
                          'Year',
                          style: FTextStyle.semibold16_24
                              .copyWith(color: FColors.grey10),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              body: Container(
                  color: FColorSkin.grey1_background,
                  child: Builder(builder: (context) {
                    return BTSFilterYear(
                      '$selectedYear',
                      onChangeYear: (vl) {
                        selectedYear = int.parse(vl);
                        moneyListAYear = moneyController.allMoneyList
                            .where((element) =>
                                element.creMoneyDate.year == selectedYear &&
                                element.moneyType == indexType.toString())
                            .toList();
                        moneyTypeListAYear = moneyListAYear
                            .filterCheckDuplicateItem(
                              (p0) => p0.moneyCateType.cateName,
                            )
                            .toList();
                        setState(() {});
                      },
                    );
                  })),
            );
          },
        ),
      ),
    );
  }
}

class BTSFilterYear extends StatefulWidget {
  final String year;
  final int maxYear;
  final int minYear;
  final Function(String) onChangeYear;

  const BTSFilterYear(
    this.year, {
    key,
    this.onChangeYear,
    this.maxYear = 2300,
    this.minYear = 1900,
  }) : super(key: key);

  @override
  BTSFilterYearState createState() => BTSFilterYearState();
}

class BTSFilterYearState extends State<BTSFilterYear> {
  int _selectedYear = DateTime.now().year;
  List<int> yearList = [];
  FixedExtentScrollController _yearController;

  @override
  void initState() {
    super.initState();
    _selectedYear = int.parse(widget.year);
    for (var i = widget.minYear; i <= widget.maxYear; i++) {
      yearList.add(i);
    }
    _yearController = FixedExtentScrollController(
        initialItem: yearList.indexOf(int.parse(widget.year)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: FColorSkin.onColorBackground,
      body: Column(
        children: [
          FDivider(
            height: 0,
          ),
          Expanded(
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 10),
              child: CupertinoPicker(
                itemExtent: 36,
                onSelectedItemChanged: (int index) {
                  setState(() {
                    _selectedYear = yearList[index];
                  });
                },
                useMagnifier: true,
                magnification: 1.2,
                squeeze: 1.10,
                selectionOverlay: CupertinoPickerDefaultSelectionOverlay(
                    background: Color.fromARGB(30, 161, 161, 170)),
                scrollController: _yearController,
                children: yearList
                    .map(
                      (item) => Center(
                        child: Text(
                          item.toString(),
                          style: FTypoSkin.title4
                              .copyWith(color: FColorSkin.title),
                        ),
                      ),
                    )
                    .toList(),
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: SafeArea(
        bottom: true,
        child: Padding(
          padding: EdgeInsets.fromLTRB(16.0, 6.0, 16.0, 0.0),
          child: FFilledButton(
            size: FButtonSize.size40,
            backgroundColor: FColorSkin.primaryColor,
            onPressed: () {
              _onApply(_selectedYear);
            },
            child: Container(
              alignment: Alignment.center,
              child: Text(
                'Change',
                style: FTypoSkin.buttonText2
                    .copyWith(color: FColorSkin.onColorBackground),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _onApply(int selectYear) {
    // SaleReport Detail
    print(_selectedYear.toString());
    widget.onChangeYear(_selectedYear.toString());
    CoreRoutes.instance.pop(result: _selectedYear.toString());
  }
}
