import 'package:charts_flutter/flutter.dart' as charts;
import 'package:coresystem/Components/base_component.dart';
import 'package:coresystem/Project/2M/Module/Report/View/report_category.dart';
import 'package:coresystem/Project/2M/Module/Report/Widget/stack_bar_chart.dart';
import 'package:coresystem/Utils/ConvertUtils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../../../../../../Components/styles/icon_data.dart';
import '../../../../../Contains/constants.dart';
import '../../../../../Contains/skin/color_skin.dart';
import '../../../../../Contains/skin/typo_skin.dart';
import '../../../../../LocalDatabase/Models/money_item.dart';
import '../../../../../Screen/transaction_index.dart';
import '../../../../Money/DA/money_controller.dart';
import '../../../../User/Views/report_money_date.dart';

class ReportByChart extends StatefulWidget {
  const ReportByChart({Key key}) : super(key: key);

  @override
  State<ReportByChart> createState() => _ReportByChartState();
}

class _ReportByChartState extends State<ReportByChart> {
  MoneyController moneyController = Get.find();
  int selectedYear = DateTime.now().year;
  int indexType = 1;

  List<MoneyItem> moneyListAYear = [];

  @override
  void initState() {
    moneyListAYear = moneyController.allMoneyList
        .where((element) =>
            element.creMoneyDate.year == selectedYear &&
            element.moneyType == indexType.toString())
        .toList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: FColorSkin.grey1_background,
      appBar: appbarWithBottom(
        title: 'Report by Year',
        iconBack: FOutlined.left,
        actions: [actionSearchAppbar()],
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

                      setState(() {});
                    },
                  ),
                ),
                Expanded(
                  child: FFilledButton(
                    size: FButtonSize.size40
                        .copyWith(borderRadius: Radius.circular(16.0)),
                    backgroundColor: indexType == 2
                        ? FColorSkin.title
                        : FColorSkin.transparent,
                    child: Center(
                      child: Text(
                        'Balance',
                        style: FTypoSkin.buttonText2.copyWith(
                            color: indexType == 2
                                ? FColorSkin.grey1_background
                                : FColorSkin.subtitle),
                      ),
                    ),
                    onPressed: () {
                      indexType = 2;
                      moneyListAYear = moneyController.allMoneyList
                          .where((element) =>
                              element.creMoneyDate.year == selectedYear)
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
      body: Container(
        padding: EdgeInsets.only(left: 16, right: 16),
        child: Builder(builder: (context) {
          List<MapMoneyData> lst = [];
          for (var i = 1; i <= 12; i++) {
            var totalMoneyAMonth = 0.0;
            if (indexType == 2) {
              // so du cac thang
              // 0 chi tieu
              // 1 thu nhap
              double inc = moneyListAYear
                  .where((element) =>
                      element.creMoneyDate.month == i &&
                      element.moneyType == '1')
                  .map((e) => e.moneyValue ?? 0.0)
                  .fold(0, (a, b) => a + b);
              double exp = moneyListAYear
                  .where((element) =>
                      element.creMoneyDate.month == i &&
                      element.moneyType == '0')
                  .map((e) => e.moneyValue ?? 0.0)
                  .fold(0, (a, b) => a + b);
              totalMoneyAMonth = inc - exp;
            } else {
              totalMoneyAMonth = moneyListAYear
                  .where((element) => element.creMoneyDate.month == i)
                  .map((e) => e.moneyValue ?? 0.0)
                  .fold(0, (a, b) => a + b);
            }

            lst.add(MapMoneyData(
              index: i,
              value: totalMoneyAMonth,
            ));
          }

          List<charts.Series<MapMoneyData, String>> _MoneyChartData() {
            return [
              charts.Series<MapMoneyData, String>(
                id: 'ReportChartYear',
                domainFn: (MapMoneyData sales, _) => sales.index.toString(),
                measureFn: (MapMoneyData sales, _) => sales.value.toInt(),
                colorFn: (MapMoneyData sales, _) =>
                    charts.ColorUtil.fromDartColor(FColorSkin.primaryColor),
                data: lst,
              )
            ];
          }

          return Column(
            children: [
              Row(
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
                              style: FTypoSkin.title4.copyWith(
                                  color: FColorSkin.primaryColor,
                                  fontWeight: FontWeight.bold),
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
              ),
              Container(
                height: Get.height / 3.5,
                child: moneyListAYear.isNotEmpty
                    ? SimpleBarChart(_MoneyChartData())
                    : SimpleBarChart.withSampleData(),
              ),
              Container(
                decoration: BoxDecoration(
                    border: Border(
                        bottom:
                            BorderSide(color: FColorSkin.grey9_background))),
                child: FListTile(
                  size: FListTileSize.size32,
                  title: Text(
                    'Total:',
                    style: FTypoSkin.title4.copyWith(
                        color: FColorSkin.primaryColor,
                        fontWeight: FontWeight.w600),
                  ),
                  action: Text(
                    WConvert.money(
                        lst.map((e) => e.value).fold(0, (a, b) => a + b), 0),
                    style: FTypoSkin.title4.copyWith(
                        color: FColorSkin.primaryColor,
                        fontWeight: FontWeight.w600),
                  ),
                ),
              ),
              if (moneyListAYear.isNotEmpty)
                Expanded(
                    child: ListView.separated(
                        separatorBuilder: (__, _) {
                          return Divider(
                            color: FColorSkin.grey4_background,
                            height: 1.5,
                            thickness: 0.5,
                          );
                        },
                        itemCount: lst.length,
                        itemBuilder: (context, index) {
                          final item = lst[index];
                          return FListTile(
                            size: FListTileSize.size32,
                            title: Text(
                              WConvert.month(item.index),
                              style: FTypoSkin.title5.copyWith(
                                  color: FColorSkin.title,
                                  fontWeight: FontWeight.normal),
                            ),
                            action: Text(
                              item.value.wToMoney(0),
                              style: FTypoSkin.title5.copyWith(
                                  color: FColorSkin.title,
                                  fontWeight: FontWeight.normal),
                            ),
                          );
                        })),
            ],
          );
        }),
      ),
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
