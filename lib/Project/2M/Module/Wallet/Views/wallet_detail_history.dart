import 'package:coresystem/Components/base_component.dart';
import 'package:coresystem/Core/routes.dart';
import 'package:coresystem/Project/2M/Contains/skin/color_skin.dart';
import 'package:coresystem/Project/2M/Contains/skin/skin_route.dart';
import 'package:coresystem/Project/2M/LocalDatabase/Models/wallet_item.dart';
import 'package:coresystem/Project/2M/LocalDatabase/model_lib.dart';
import 'package:coresystem/Project/2M/Module/Money/DA/money_controller.dart';
import 'package:coresystem/Utils/ConvertUtils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class WalletDetailHistory extends StatefulWidget {
  final WalletItem walletItem;

  const WalletDetailHistory({Key key, this.walletItem}) : super(key: key);

  @override
  State<WalletDetailHistory> createState() => _WalletDetailHistoryState();
}

class _WalletDetailHistoryState extends State<WalletDetailHistory> {
  MoneyController moneyController = Get.find();
  int indexType = 1;

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light,
      child: Obx(() {
        // danh sách theo loại tiền chi hoặc thu
        final lst = moneyController.moneyListPageView
            .where((element) => element.moneyType == indexType.toString())
            .toList();

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
                            child: Text(
                              widget.walletItem.title ?? '',
                              style: FTypoSkin.title3
                                  .copyWith(color: FColorSkin.grey1_background),
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
                              indexType == 1 ? 'Income ' : 'Expense ',
                              style: FTypoSkin.title1.copyWith(
                                  color: FColorSkin.subtitle,
                                  fontWeight: FontWeight.normal),
                            ),
                            Obx(() {
                              return Text(
                                indexType == 1
                                    ? '${moneyController.incomeAllMoneyWalletDetail.wToMoney(0).replaceAll('.', ',')} VND'
                                    : '${moneyController.expenseAllMoneyWalletDetail.wToMoney(0).replaceAll('.', ',')} VND',
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
                            '${moneyDayList[0].moneyType == '0' ? '-' : '+'}$totalMoneyADay',
                            style: FTypoSkin.title5.copyWith(
                                color: moneyDayList[0].moneyType == '0'
                                    ? FColorSkin.warningPrimary
                                    : FColorSkin.primaryColor),
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
                                  child: Text(
                                    '${item.moneyCateType.cateIcon}' ?? '',
                                    style: FTypoSkin.bodyText2
                                        .copyWith(color: FColorSkin.subtitle),
                                  ),
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
                              '${item.moneyType == '0' ? '-' : '+'}${item.moneyValue.wToMoney(0)}',
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
          bottomNavigationBar: BottomAppBar(
            color: FColorSkin.grey1_background,
            elevation: 0.0,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Obx(() {
                  return Container(
                    margin: EdgeInsets.all(24),
                    height: 48.0,
                    decoration: BoxDecoration(
                        color: FColorSkin.grey3_background,
                        borderRadius: BorderRadius.circular(16.0)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: FFilledButton.icon(
                              backgroundColor: FColorSkin.transparent,
                              child: FIcon(
                                icon: FOutlined.left,
                                size: 24,
                                color: FColorSkin.subtitle,
                              ),
                              onPressed: () {
                                moneyController
                                    .changeDateTimeWalletDetail('minus');
                              },
                            ),
                          ),
                        ),
                        Text(
                          '${FDate.My(moneyController.selectedWalletDetailValue.value)}',
                          style: FTypoSkin.title5
                              .copyWith(color: FColorSkin.title),
                        ),
                        Expanded(
                          child: Align(
                            alignment: Alignment.centerRight,
                            child: FFilledButton.icon(
                              backgroundColor: FColorSkin.transparent,
                              child: FIcon(
                                icon: FOutlined.right,
                                size: 24,
                                color: FColorSkin.subtitle,
                              ),
                              onPressed: () {
                                moneyController
                                    .changeDateTimeWalletDetail('plus');
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                }),
                Container(
                  margin: EdgeInsets.only(left: 24, right: 24, bottom: 16),
                  height: 48.0,
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
                              'Thu nhập',
                              style: FTypoSkin.buttonText2.copyWith(
                                  color: indexType == 1
                                      ? FColorSkin.grey1_background
                                      : FColorSkin.subtitle),
                            ),
                          ),
                          onPressed: () {
                            indexType = 1;
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
                              'Chi tiêu',
                              style: FTypoSkin.buttonText2.copyWith(
                                  color: indexType == 0
                                      ? FColorSkin.grey1_background
                                      : FColorSkin.subtitle),
                            ),
                          ),
                          onPressed: () {
                            indexType = 0;
                            setState(() {});
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
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
