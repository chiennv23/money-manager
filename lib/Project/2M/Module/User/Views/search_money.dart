import 'dart:async';

import 'package:coresystem/Components/base_component.dart';
import 'package:coresystem/Project/2M/Contains/skin/typo_skin.dart';
import 'package:coresystem/Project/2M/LocalDatabase/model_lib.dart';
import 'package:coresystem/Utils/ConvertUtils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../../../Components/styles/icon_data.dart';
import '../../../../../Core/routes.dart';
import '../../../Contains/constants.dart';
import '../../../Contains/skin/color_skin.dart';
import '../../Money/DA/money_controller.dart';
import '../../Money/Views/input_money.dart';

class SearchMoney extends StatefulWidget {
  const SearchMoney({Key key}) : super(key: key);

  @override
  State<SearchMoney> createState() => _SearchMoneyState();
}

class _SearchMoneyState extends State<SearchMoney> {
  final searchController = TextEditingController();
  MoneyController moneyController = Get.find();
  List<MoneyItem> list = [];
  List<MoneyItem> listSearch = [];

  List<int> listFilter = [];
  bool isIncome = true;
  bool isExpense = true;
  bool isAll = true;
  String valueSearch = '';

  @override
  void initState() {
    list = listSearch = moneyController.allMoneyList;
    listFilter = moneyController.allMoneyList
        .filterCheckDuplicateItem((e) => e.creMoneyDate.day)
        .map((e) => e.creMoneyDate.day)
        .toList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    list = listSearch;
    if (isExpense == false && isIncome == false) {
      isAll = true;
      isIncome = true;
      isExpense = true;
    } else if (isExpense && isIncome) {
      isAll = true;
    } else if (isExpense || isIncome) {
      isAll = false;
    }
    if (isAll && isExpense && isIncome) {
      // danh sách các ngày trong tháng
      listFilter = list
          .filterCheckDuplicateItem((e) => e.creMoneyDate.day)
          .map((e) => e.creMoneyDate.day)
          .toList();
      listFilter.sort((a, b) => a.compareTo(b));
    } else if (isIncome && isAll == false && isExpense == false) {
      list = list.where((element) => element.moneyType == '1').toList();
      // danh sách các ngày trong tháng
      listFilter = list
          .filterCheckDuplicateItem((e) => e.creMoneyDate.day)
          .map((e) => e.creMoneyDate.day)
          .toList();
      listFilter.sort((a, b) => a.compareTo(b));
    } else if (isExpense && isAll == false && isIncome == false) {
      list = list.where((element) => element.moneyType == '0').toList();
      // danh sách các ngày trong tháng
      listFilter = list
          .filterCheckDuplicateItem((e) => e.creMoneyDate.day)
          .map((e) => e.creMoneyDate.day)
          .toList();
      listFilter.sort((a, b) => a.compareTo(b));
    }
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: FColorSkin.grey1_background,
        appBar: appbarOnlyTitle(
            title: 'Search all money',
            iconBack: FOutlined.left,
            systemUiOverlayStyle: SystemUiOverlayStyle.dark),
        body: Column(
          children: [
            Container(
              padding: const EdgeInsets.only(left: 16, right: 16),
              child: Column(
                children: [
                  FTextFormField(
                    maxLine: 1,
                    controller: searchController,
                    autoFocus: true,
                    onChanged: (vl) {
                      if (vl.trim() == '') {
                        list = listSearch = moneyController.allMoneyList;
                      } else {
                        list = moneyController.allMoneyList;
                        listSearch = list
                            .where((element) =>
                                element.moneyCateType.cateName
                                    .toLowerCase()
                                    .contains(vl.trim().toLowerCase()) ||
                                element.moneyCateType.cateName
                                    .toLowerCase()
                                    .startsWith(vl.trim().toLowerCase()))
                            .toList();
                        print(listSearch.length);
                      }
                      valueSearch = vl;
                      setState(() {});
                    },
                    textInputAction: TextInputAction.done,
                    hintText: "Search money",
                    clearIcon: searchController.text.isEmpty
                        ? Container()
                        : FFilledButton.icon(
                            size: FButtonSize.size24,
                            backgroundColor: FColorSkin.transparent,
                            child: FIcon(
                              icon: FFilled.close_circle,
                              size: 16,
                              color: FColorSkin.subtitle,
                            ),
                            onPressed: () {
                              list = listSearch = moneyController.allMoneyList;
                              setState(searchController.clear);
                            }),
                    onSubmitted: (vl) {
                      if (vl.trim() == '') {
                        list = listSearch = moneyController.allMoneyList;
                      } else {
                        list = moneyController.allMoneyList;
                        listSearch = list
                            .where((element) =>
                                element.moneyCateType.cateName
                                    .toLowerCase()
                                    .contains(vl.trim().toLowerCase()) ||
                                element.moneyCateType.cateName
                                    .toLowerCase()
                                    .startsWith(vl.trim().toLowerCase()))
                            .toList();
                        print(listSearch.length);
                      }
                      valueSearch = vl;
                      setState(() {});
                    },
                    size: FInputSize.size48,
                    hintStyle: TextStyle(
                      color: FColorSkin.subtitle.withOpacity(.3),
                    ),
                  ),
                  Row(
                    children: [
                      Row(
                        children: [
                          FCheckbox(
                              value: isAll,
                              activeColor: FColorSkin.primaryColor,
                              onChanged: (vl) {
                                if (isAll == false) {
                                  setState(() {
                                    isAll = true;
                                    isIncome = true;
                                    isExpense = true;
                                  });
                                }
                              }),
                          Text(
                            'ALL',
                            style: FTypoSkin.subtitle2
                                .copyWith(color: FColorSkin.title),
                          )
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Row(
                          children: [
                            FCheckbox(
                                value: isIncome,
                                activeColor: FColorSkin.primaryColor,
                                onChanged: (vl) {
                                  setState(() {
                                    isIncome = vl;
                                    isAll = false;
                                  });
                                }),
                            Text(
                              'Income',
                              style: FTypoSkin.subtitle2
                                  .copyWith(color: FColorSkin.title),
                            )
                          ],
                        ),
                      ),
                      Row(
                        children: [
                          FCheckbox(
                              value: isExpense,
                              activeColor: FColorSkin.primaryColor,
                              onChanged: (vl) {
                                setState(() {
                                  isAll = false;
                                  isExpense = vl;
                                });
                              }),
                          Text(
                            'Expense',
                            style: FTypoSkin.subtitle2
                                .copyWith(color: FColorSkin.title),
                          )
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Expanded(
              child: searchController.text.isEmpty
                  ? Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          FIcon(
                            icon: FOutlined.search,
                            size: 100,
                            color: FColorSkin.subtitle,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(25.0),
                            child: Text(
                              'Type something to search',
                              style: FTypoSkin.title5
                                  .copyWith(color: FColorSkin.subtitle),
                            ),
                          ),
                        ],
                      ),
                    )
                  : Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Column(
                                  children: [
                                    Text(
                                      ' Income: ',
                                      style: FTypoSkin.subtitle2.copyWith(
                                        color: FColorSkin.primaryColor,
                                      ),
                                    ),
                                    Text(
                                      list.isEmpty
                                          ? '0'
                                          : '${WConvert.money(list.where((element) => element.moneyType == '1').toList().map((e) => e.moneyValue).fold(0, (previousValue, element) => previousValue + element), 0)}',
                                      style: FTypoSkin.subtitle2.copyWith(
                                          color: FColorSkin.primaryColor,
                                          fontWeight: FontWeight.w600),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ],
                                ),
                              ),
                              Expanded(
                                child: Column(
                                  children: [
                                    Text(
                                      ' Expense',
                                      style: FTypoSkin.subtitle2.copyWith(
                                        color: FColorSkin.warningPrimary,
                                      ),
                                    ),
                                    Text(
                                      list.isEmpty
                                          ? '0'
                                          : '${WConvert.money(list.where((element) => element.moneyType == '0').toList().map((e) => e.moneyValue.toInt()).fold(0, (previousValue, element) => previousValue + element), 0)}',
                                      style: FTypoSkin.subtitle2.copyWith(
                                          color: FColorSkin.warningPrimary,
                                          fontWeight: FontWeight.w600),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ],
                                ),
                              ),
                              Expanded(
                                child: Column(
                                  children: [
                                    Text(
                                      ' Balance',
                                      style: FTypoSkin.subtitle2.copyWith(
                                        color: FColorSkin.subtitle,
                                      ),
                                    ),
                                    Text(
                                      list.isEmpty
                                          ? '0'
                                          : '${WConvert.money(list.where((element) => element.moneyType == '1').toList().map((e) => e.moneyValue).fold(0, (previousValue, element) => previousValue + element) - list.where((element) => element.moneyType == '0').toList().map((e) => e.moneyValue).fold(0, (previousValue, element) => previousValue + element), 0)}',
                                      style: FTypoSkin.subtitle2.copyWith(
                                          color: FColorSkin.subtitle,
                                          fontWeight: FontWeight.w600),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: list.isEmpty
                              ? Center(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      SvgPicture.asset(StringIcon.empty),
                                      Padding(
                                        padding: const EdgeInsets.all(30.0),
                                        child: Text(
                                          'No money not found. Try again!',
                                          style: FTypoSkin.title5.copyWith(
                                              color: FColorSkin.subtitle),
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              : ListView.builder(
                                  itemCount: listFilter.length,
                                  itemBuilder: (context, index) {
                                    // lấy ra danh sách tiền theo từng ngày listFilter[index]
                                    final List<MoneyItem> moneyDayList =
                                        list.isEmpty
                                            ? []
                                            : list
                                                .where((e) =>
                                                    e.creMoneyDate.day ==
                                                    listFilter[index])
                                                .toList();
                                    // print(moneyDayList.length);
                                    // 0 chi tieu
                                    // 1 thu nhap
                                    // tính tổng tiền trong ngày
                                    var totalMoneyADay = 0.0;
                                    if (list.isNotEmpty) {
                                      if (isAll) {
                                        // tong thu - tong chi
                                        totalMoneyADay = moneyDayList
                                                .where((element) =>
                                                    element.moneyType == '1')
                                                .toList()
                                                .map((e) => e.moneyValue)
                                                .fold(
                                                    0,
                                                    (previousValue, element) =>
                                                        previousValue +
                                                        element) -
                                            moneyDayList
                                                .where((element) =>
                                                    element.moneyType == '0')
                                                .toList()
                                                .map((e) => e.moneyValue)
                                                .fold(
                                                    0,
                                                    (previousValue, element) =>
                                                        previousValue +
                                                        element);
                                      } else {
                                        totalMoneyADay = moneyDayList
                                            .map((e) => e.moneyValue)
                                            .fold(
                                                0,
                                                (previousValue, element) =>
                                                    previousValue + element);
                                      }
                                    }
                                    if (moneyDayList.isEmpty) {
                                      return Container();
                                    }

                                    return Container(
                                      color: FColorSkin.grey1_background,
                                      margin: EdgeInsets.only(bottom: 12),
                                      child: Column(
                                        children: [
                                          Container(
                                            padding: EdgeInsets.all(12),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Row(
                                                  children: [
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              left: 4.0),
                                                      child: Text(
                                                        '${moneyDayList.first.creMoneyDate.day < 10 ? '0${moneyDayList.first.creMoneyDate.day}' : moneyDayList.first.creMoneyDate.day}.${moneyDayList.first.creMoneyDate.month < 10 ? '0${moneyDayList.first.creMoneyDate.month}' : moneyDayList.first.creMoneyDate.month}.${moneyDayList.first.creMoneyDate.year}' ??
                                                            '',
                                                        style: FTypoSkin.title5
                                                            .copyWith(
                                                                color:
                                                                    FColorSkin
                                                                        .title),
                                                      ),
                                                    ),
                                                    Text(
                                                      '(${FDate.weekdayName[moneyDayList.first.creMoneyDate.weekday]})' ??
                                                          '',
                                                      style: FTypoSkin.bodyText2
                                                          .copyWith(
                                                              color: FColorSkin
                                                                  .subtitle),
                                                    ),
                                                  ],
                                                ),
                                                Text(
                                                  '${totalMoneyADay.wToMoney(0)}',
                                                  style: FTypoSkin.title5
                                                      .copyWith(
                                                          color:
                                                              FColorSkin.title),
                                                ),
                                              ],
                                            ),
                                          ),
                                          ...List.generate(moneyDayList.length,
                                              (indexDay) {
                                            final item = moneyDayList[indexDay];
                                            return FListTile(
                                              onTap: () async {
                                                final rs = await CoreRoutes
                                                    .instance
                                                    .navigatorPushDownToUp(
                                                        InputMoney(
                                                  idType:
                                                      int.parse(item.moneyType),
                                                  moneyItem: item,
                                                ));
                                                if (rs != null) {
                                                  if (valueSearch.trim() ==
                                                      '') {
                                                    list = listSearch =
                                                        moneyController
                                                            .allMoneyList;
                                                  } else {
                                                    list = moneyController
                                                        .allMoneyList;
                                                    listSearch = list
                                                        .where((element) =>
                                                            element
                                                                .moneyCateType
                                                                .cateName
                                                                .toLowerCase()
                                                                .contains(
                                                                    valueSearch
                                                                        .trim()
                                                                        .toLowerCase()) ||
                                                            element
                                                                .moneyCateType
                                                                .cateName
                                                                .toLowerCase()
                                                                .startsWith(
                                                                    valueSearch
                                                                        .trim()
                                                                        .toLowerCase()))
                                                        .toList();
                                                    print(listSearch.length);
                                                  }
                                                  setState(() {});
                                                }
                                              },
                                              avatar: FBoundingBox(
                                                size: FBoxSize.size24,
                                                backgroundColor:
                                                    FColorSkin.grey1_background,
                                                child: Image.asset(item
                                                    .moneyCateType.cateIcon),
                                              ),
                                              title: Text(
                                                '${item.moneyCateType.cateName}' ??
                                                    '',
                                                style: FTypoSkin.title6
                                                    .copyWith(
                                                        color: FColorSkin
                                                            .subtitle),
                                              ),
                                              action: Text(
                                                '${item.moneyType == '0' ? '-' : '+'}${item.moneyValue.wToMoney(0)}',
                                                style: FTypoSkin.bodyText2
                                                    .copyWith(
                                                        color: FColorSkin
                                                            .subtitle),
                                              ),
                                            );
                                          })
                                        ],
                                      ),
                                    );
                                  },
                                ),
                        ),
                      ],
                    ),
            )
          ],
        ),
      ),
    );
  }
}
