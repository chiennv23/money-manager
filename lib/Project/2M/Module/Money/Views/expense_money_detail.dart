import 'package:coresystem/Components/base_component.dart';
import 'package:coresystem/Core/routes.dart';
import 'package:coresystem/Project/2M/Contains/skin/color_skin.dart';
import 'package:coresystem/Project/2M/Contains/skin/skin_route.dart';
import 'package:coresystem/Project/2M/LocalDatabase/model_lib.dart';
import 'package:coresystem/Project/2M/Module/Money/DA/money_controller.dart';
import 'package:coresystem/Utils/ConvertUtils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class ExpenseMoneyDetail extends StatefulWidget {
  final String walletName;

  const ExpenseMoneyDetail({Key key, this.walletName}) : super(key: key);

  @override
  State<ExpenseMoneyDetail> createState() => _ExpenseMoneyDetailState();
}

class _ExpenseMoneyDetailState extends State<ExpenseMoneyDetail> {
  MoneyController moneyController = Get.find();

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light,
      child: Obx(() {
        // danh sách theo loại tiền chi hoặc thu
        final lst = moneyController.AllExpenseMoneyByDateList;

        // danh sách các ngày trong tháng
        final listFilter = lst
            .filterCheckDuplicateItem((e) => e.creMoneyDate.day)
            .map((e) => e.creMoneyDate.day)
            .toList();
        listFilter.sort((a, b) => a.compareTo(b));

        return Scaffold(
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(170.0),
            child: Container(
              padding: EdgeInsets.only(top: 50),
              color: Colors.indigo[900],
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  FFilledButton(
                      backgroundColor: FColorSkin.transparent,
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          FIcon(
                            icon: FOutlined.left,
                            color: FColorSkin.grey1_background,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 4.0),
                            child: Row(
                              children: [
                                Text(
                                  'Expense ',
                                  style: FTypoSkin.title5.copyWith(
                                      color: FColorSkin.grey1_background,
                                      fontWeight: FontWeight.normal),
                                ),
                                if (widget.walletName != '')
                                  Text(
                                    '${widget.walletName} '.toUpperCase(),
                                    style: FTypoSkin.title3.copyWith(
                                        color: FColorSkin.grey1_background),
                                  ),
                                Text(
                                  'detail',
                                  style: FTypoSkin.title5.copyWith(
                                      color: FColorSkin.grey1_background,
                                      fontWeight: FontWeight.normal),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      onPressed: () => CoreRoutes.instance.pop()),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 24.0, top: 16),
                        child: Row(
                          children: [
                            Text(
                              'Expense ',
                              style: FTypoSkin.title1.copyWith(
                                  color: FColorSkin.subtitle,
                                  fontWeight: FontWeight.normal),
                            ),
                            Obx(() {
                              return Text(
                                '${moneyController.expenseAllMoneyWalletByDates.wToMoney(0).replaceAll('.', ',')} VND',
                                style: FTypoSkin.title1.copyWith(
                                  color: FColorSkin.grey1_background,
                                ),
                              );
                            }),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 24.0, bottom: 24),
                        child: Text(
                          'T${moneyController.selectedWalletDetailValue.value.month}/${moneyController.selectedWalletDetailValue.value.year}',
                          style: FTypoSkin.title1.copyWith(
                              color: FColorSkin.subtitle,
                              fontWeight: FontWeight.normal),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
          backgroundColor: FColorSkin.grey3_background,
          body: ListView.builder(
            itemCount: listFilter.length,
            itemBuilder: (context, index) {
              // lấy ra danh sách tiền theo từng ngày listFilter[index]
              final moneyDayList = lst
                  .where((e) => e.creMoneyDate.day == listFilter[index])
                  .toList();
              print(moneyDayList);
              // tính tổng tiền trong ngày
              final totalMoneyADay = moneyDayList
                  .map((e) => e.moneyValue)
                  .reduce((value, element) => value + element)
                  .wToMoney(0);
              return Container(
                color: FColorSkin.grey1_background,
                margin: EdgeInsets.only(bottom: 12),
                child: Column(
                  children: [
                    Container(
                      padding: EdgeInsets.all(12),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              FBoundingBox(
                                size: FBoxSize.size24,
                                child: Text(
                                  moneyDayList[0].creMoneyDate.weekday < 7
                                      ? 'T${moneyDayList[0].creMoneyDate.weekday + 1}'
                                      : '${FDate.onlyDayWeek(moneyDayList[0].creMoneyDate)}' ??
                                          '',
                                  style: FTypoSkin.bodyText2
                                      .copyWith(color: FColorSkin.subtitle),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 12.0),
                                child: Text(
                                  '${moneyDayList[0].creMoneyDate.day < 10 ? '0${moneyDayList[0].creMoneyDate.day}' : moneyDayList[0].creMoneyDate.day}.${moneyDayList[0].creMoneyDate.month < 10 ? '0${moneyDayList[0].creMoneyDate.month}' : moneyDayList[0].creMoneyDate.month}' ??
                                      '',
                                  style: FTypoSkin.title5
                                      .copyWith(color: FColorSkin.title),
                                ),
                              ),
                            ],
                          ),
                          Text(
                            '-$totalMoneyADay',
                            style: FTypoSkin.title5
                                .copyWith(color: FColorSkin.warningPrimary),
                          ),
                        ],
                      ),
                    ),
                    ...List.generate(moneyDayList.length, (indexDay) {
                      final item = moneyDayList[indexDay];
                      return Container(
                        padding: EdgeInsets.all(12.0),
                        color: FColorSkin.grey1_background,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                FBoundingBox(
                                  size: FBoxSize.size24,
                                  backgroundColor: FColorSkin.grey1_background,
                                  child:
                                      Image.asset(item.moneyCateType.cateIcon),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 12.0),
                                  child: Text(
                                    '${item.moneyCateType.cateName}' ?? '',
                                    style: FTypoSkin.title6
                                        .copyWith(color: FColorSkin.subtitle),
                                  ),
                                ),
                              ],
                            ),
                            Text(
                              '-${item.moneyValue.wToMoney(0)}',
                              style: FTypoSkin.bodyText2
                                  .copyWith(color: FColorSkin.subtitle),
                            ),
                          ],
                        ),
                      );
                    })
                  ],
                ),
              );
            },
          ),
        );
      }),
    );
  }
}

class CardMoney extends StatefulWidget {
  final List<MoneyItem> moneyItemList;

  const CardMoney({Key key, this.moneyItemList}) : super(key: key);

  @override
  State<CardMoney> createState() => _CardMoneyState();
}

class _CardMoneyState extends State<CardMoney> {
  @override
  Widget build(BuildContext context) {
    var listMoneyItemDate = widget.moneyItemList.expand((element) => null);
    return Container(
      child: Column(
        children: [
          for (var elemetn in widget.moneyItemList)
            Row(
              children: [
                // Text(widget.moneyItem.creMoneyDate.day.toString()),
              ],
            ),
          // dU TU
          // if(widget.moneyItem.moneyCateType.cateName)
        ],
      ),
    );
  }
}
