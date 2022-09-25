import 'dart:io';

import 'package:coresystem/Components/base_component.dart';
import 'package:coresystem/Core/routes.dart';
import 'package:coresystem/Project/2M/Contains/constants.dart';
import 'package:coresystem/Project/2M/Module/Money/DA/money_controller.dart';
import 'package:coresystem/Project/2M/Module/Money/Views/expense_money_detail.dart';
import 'package:coresystem/Project/2M/Module/Wallet/DA/wallet_controller.dart';
import 'package:coresystem/Utils/ConvertUtils.dart';
import 'package:coresystem/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import '../../../Config/AppConfig.dart';
import '../../../Core/enum_core.dart';
import '../../../Core/userService.dart';
import '../Contains/skin/color_skin.dart';
import '../Contains/skin/typo_skin.dart';
import '../Module/Money/Views/input_money.dart';

class TransactionIndex extends StatefulWidget {
  const TransactionIndex({Key key}) : super(key: key);

  @override
  State<TransactionIndex> createState() => _TransactionIndexState();
}

class _TransactionIndexState extends State<TransactionIndex>
    with SingleTickerProviderStateMixin {
  WalletController walletController = Get.find();
  MoneyController moneyController = Get.find();

  TabController tabController;
  ScrollController scrollController = ScrollController();

  DateTime now = DateTime.now();
  DateTime more7day = DateTime.now().add(Duration(days: 6));
  File _imagesFile;

  @override
  void initState() {
    super.initState();
    tabController = TabController(
      length: walletController.walletList.length,
      vsync: this,
    );
    moneyController.walletIdInTab.value = '';
    // scrollController.addListener(handleScroll);
    if (UserService.getAvtUsername != null) {
      _imagesFile = File(UserService.getAvtUsername);
    }
  }

  //
  // void handleScroll() {
  //   final offset = scrollController.offset;
  //   final minOffset = scrollController.position.minScrollExtent;
  //   final maxOffset = scrollController.position.maxScrollExtent;
  //   final isOutOfRange = scrollController.position.outOfRange;
  //
  //   final hasReachedTheEnd = offset >= maxOffset && !isOutOfRange;
  //   final hasReachedTheStart = offset <= minOffset && !isOutOfRange;
  //   final isScrolling = maxOffset > offset && minOffset < offset;
  //   setState(() {
  //     _isScroll = !hasReachedTheStart;
  //   });
  // }

  bool _isScroll = false;

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // 288 = height app bar + height navigation + padding;
    final pxBody = (Get.height - 288) / 2;
    final lg = S.of(context);
    // print(DateTime.now().hour);
    // print(moneyController.incomeAllMoneyWallet);
    // print(moneyController.expenseAllMoneyWallet);
    // print(moneyController.surplusMoneyWallet);
    return Scaffold(
      backgroundColor: FColorSkin.grey1_background,
      appBar: AppBar(
        systemOverlayStyle: SystemUiOverlayStyle.dark,
        toolbarHeight: 170.0,
        centerTitle: false,
        backgroundColor: FColorSkin.grey1_background,
        title: Container(
          padding: EdgeInsets.only(left: 8, top: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: FColorSkin.grey3_background),
                  shape: BoxShape.circle,
                ),
                child: FBoundingBox(
                    shape: FBoxShape.circle,
                    backgroundColor: FColorSkin.disable,
                    size: FBoxSize.size48,
                    child: _imagesFile != null
                        ? Image.file(
                            _imagesFile,
                            width: 64,
                            height: 64,
                            fit: BoxFit.cover,
                          )
                        : FIcon(
                            icon: FFilled.user,
                            color: FColorSkin.grey9_background,
                            size: 20,
                          )),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Text(
                  DateTime.now().hour >= 1 && DateTime.now().hour <= 12
                      ? 'Good morning'
                      : DateTime.now().hour > 12 && DateTime.now().hour < 18
                          ? 'Good Afternoon'
                          : DateTime.now().hour >= 18 &&
                                  DateTime.now().hour <= 24
                              ? 'Good Evening'
                              : 'Hello, Boss',
                  style: FTypoSkin.title1.copyWith(
                      color: FColorSkin.title, fontWeight: FontWeight.w400),
                ),
              ),
              Text(
                'Nguyen Van Chien',
                style: FTypoSkin.title1.copyWith(color: FColorSkin.title),
              ),
              FListTile(
                  padding: EdgeInsets.zero,
                  backgroundColor: FColorSkin.grey1_background,
                  title: Obx(() {
                    return Text(
                      '${moneyController.startDateValue} - ${moneyController.endDateValue}',
                      style: FTypoSkin.title2.copyWith(color: FColorSkin.title),
                    );
                  })),
            ],
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0, top: 40),
            child: FFilledButton.icon(
                size: FButtonSize.size32,
                backgroundColor: FColorSkin.grey3_background,
                child: FIcon(
                  icon: FFilled.setting,
                  size: 20,
                  color: FColorSkin.secondaryText,
                ),
                onPressed: () {}),
          )
        ],
        elevation: 0.0,
      ),
      body: SingleChildScrollView(
        child: Column(children: [
          // customize chart
          Container(
            height: pxBody + 40,
            color: FColorSkin.grey1_background,
            child: Obx(() {
              return Stack(
                alignment: AlignmentDirectional.bottomCenter,
                children: [
                  Row(
                    children: [
                      SizedBox(
                        width: 16,
                      ),
                      // income
                      Flexible(
                        child: ColumnChart(
                          title:
                              'Income T${moneyController.selectedValue.value.month}',
                          money: moneyController.incomeAllMoneyWallet,
                          value:
                              moneyController.getHeightChartHome('1', pxBody),
                          color: FColorSkin.primaryColor,
                        ),
                      ),
                      // expense
                      Flexible(
                        child: ColumnChart(
                          title:
                              'Expense T${moneyController.selectedValue.value.month}',
                          money: moneyController.expenseAllMoneyWallet,
                          value:
                              moneyController.getHeightChartHome('0', pxBody),
                          color: FColorSkin.warningPrimary,
                        ),
                      ),
                      // so du
                      Flexible(
                        child: ColumnChart(
                          title: 'All Surplus',
                          money: moneyController.surplusMoneyWallet,
                          value:
                              moneyController.getHeightChartHome('2', pxBody),
                          color: Colors.blueGrey,
                        ),
                      ),
                    ],
                  ),
                  // overlay white
                  AnimatedOpacity(
                    duration: Duration(milliseconds: 450),
                    opacity: (moneyController.incomeAllMoneyWallet != 0.0 &&
                            moneyController.expenseAllMoneyWallet != 0.0 &&
                            moneyController.surplusMoneyWallet > 0.0)
                        ? 1
                        : 0,
                    child: Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            FColorSkin.grey1_background.withOpacity(0.0),
                            FColorSkin.grey1_background,
                          ],
                          begin: const FractionalOffset(1.0, 0.9),
                          end: const FractionalOffset(1.0, .99),
                          stops: const [
                            .01,
                            1.0,
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              );
            }),
          ),
          Container(
              height: pxBody + 40,
              decoration: BoxDecoration(
                color: FColorSkin.grey1_background,
              ),
              child: Obx(() {
                return DefaultTabController(
                  length: walletController.walletList.length + 1,
                  child: Column(
                    children: <Widget>[
                      Container(
                        height: 45,
                        width: Get.width,
                        padding: EdgeInsets.only(top: 5),
                        decoration: BoxDecoration(
                          color: FColorSkin.title,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(8.0),
                            topRight: Radius.circular(8.0),
                          ),
                        ),
                        child: TabBar(
                            onTap: (index) {
                              if (index == 0) {
                                moneyController.changeWalletIndex('');
                              } else {
                                moneyController.changeWalletIndex(
                                    walletController.walletList[index - 1].iD);
                              }
                            },
                            isScrollable:
                                walletController.walletList.length >= 4
                                    ? true
                                    : false,
                            indicatorSize: TabBarIndicatorSize.label,
                            indicatorColor: FColorSkin.grey1_background,
                            labelColor: FColorSkin.grey1_background,
                            tabs: [
                              Tab(
                                text: 'All wallets',
                              ),
                              ...List<Tab>.generate(
                                  walletController.walletList.length, (index) {
                                return Tab(
                                  text:
                                      walletController.walletList[index].title,
                                );
                              })
                            ]),
                      ),
                      Expanded(
                          child: Container(
                              color: FColorSkin.title,
                              child: TabBarView(
                                  children: List.generate(
                                      walletController.walletList.length + 1,
                                      (index) => Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              // Chi tiêu nổi bật
                                              Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 24,
                                                        vertical: 10),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Text(
                                                      'High Expenses',
                                                      style: FTypoSkin.title3
                                                          .copyWith(
                                                              color: FColorSkin
                                                                  .grey1_background),
                                                    ),
                                                    FFilledButton.icon(
                                                        size:
                                                            FButtonSize.size24,
                                                        backgroundColor:
                                                            FColorSkin
                                                                .primaryColor,
                                                        child: FIcon(
                                                          icon: FOutlined.right,
                                                          size: 16,
                                                          color: FColorSkin
                                                              .grey1_background,
                                                        ),
                                                        onPressed: () {
                                                          CoreRoutes.instance
                                                              .navigatorPushRoutes(
                                                                  ExpenseMoneyDetail());
                                                        })
                                                  ],
                                                ),
                                              ),
                                              Obx(() {
                                                return Column(
                                                  children: List.generate(
                                                    moneyController
                                                            .top3ExpenseMoneyList
                                                            .length ??
                                                        0,
                                                    (index) => FListTile(
                                                      size:
                                                          FListTileSize.size32,
                                                      backgroundColor:
                                                          FColorSkin
                                                              .transparent,
                                                      padding: EdgeInsets.only(
                                                          left: 24, right: 24),
                                                      onTap: () {
                                                        CoreRoutes.instance
                                                            .navigatorPushDownToUp(
                                                                InputMoney(
                                                          idType: int.parse(
                                                              moneyController
                                                                  .top3ExpenseMoneyList[
                                                                      index]
                                                                  .moneyType),
                                                          moneyItem: moneyController
                                                                  .top3ExpenseMoneyList[
                                                              index],
                                                        ));
                                                      },
                                                      avatar: FBoundingBox(
                                                          size:
                                                              FBoxSize.size24),
                                                      title: Text(
                                                        moneyController
                                                                .top3ExpenseMoneyList[
                                                                    index]
                                                                .moneyCateType
                                                                .cateName ??
                                                            '',
                                                        style: FTypoSkin.title5
                                                            .copyWith(
                                                                color: FColorSkin
                                                                    .grey1_background),
                                                      ),
                                                      action: Text(
                                                        '${moneyController.top3ExpenseMoneyList[index].moneyValue.wToMoney(0)}',
                                                        style: FTypoSkin.title5
                                                            .copyWith(
                                                                color: FColorSkin
                                                                    .grey1_background),
                                                      ),
                                                    ),
                                                  ),
                                                );
                                              })
                                            ],
                                          )))))
                    ],
                  ),
                );
              }))
        ]),
      ),
    );
  }
}

Widget ColumnChart({double value, double money, String title, Color color}) {
  return Container(
    margin: EdgeInsets.symmetric(horizontal: 8),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Text(
          title,
          style: FTypoSkin.subtitle3.copyWith(color: FColorSkin.subtitle),
        ),
        Text(
          '${WConvert.moneyShort(money ?? 0.0)}',
          style: FTypoSkin.title5.copyWith(color: FColorSkin.title),
        ),
        AnimatedContainer(
          duration: Duration(milliseconds: 500),
          decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(4.0),
                  topLeft: Radius.circular(4.0))),
          height: value ?? 0.0,
          width: 64,
        ),
      ],
    ),
  );
}

Widget actionAppbar(BuildContext context, {bool isDark = true}) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      FFilledButton.icon(
        backgroundColor: FColorSkin.transparent,
        child: Container(
            // ConfigApp.langApp = 'en'
            decoration: BoxDecoration(
                color: FColorSkin.grey1_background,
                border: Border.all(
                    color: ConfigApp.langApp == 'en'
                        ? FColorSkin.grey9_background
                        : FColorSkin.grey4_background)),
            padding: EdgeInsets.fromLTRB(1, 1, 0, 0.7),
            child: SvgPicture.asset(StringIcon.eng_icon)),
        onPressed: () => EnumCore.loadingCustom(loadingEN(context)),
      ),
      FFilledButton.icon(
        backgroundColor: FColorSkin.transparent,
        child: Container(
          decoration: BoxDecoration(
              color: FColorSkin.grey1_background,
              border: Border.all(
                  color: ConfigApp.langApp != 'en'
                      ? FColorSkin.grey9_background
                      : FColorSkin.grey4_background)),
          padding: EdgeInsets.all(1),
          child: SvgPicture.asset(StringIcon.vietnam_icon),
        ),
        onPressed: () => EnumCore.loadingCustom(loadingVI(context)),
      ),
    ],
  );
}

// body: NestedScrollView(
//   headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
//     return <Widget>[
//       SliverList(
//         delegate: SliverChildListDelegate([
//           Container(
//             height: 85,
//             padding: EdgeInsets.only(top: 10),
//             width: double.infinity,
//             color: FColorSkin.title,
//             child: Row(
//               children: [
//                 Expanded(
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Container(
//                         padding: EdgeInsets.only(left: 16.0),
//                         child: Text(
//                           'Thời gian',
//                           style: FTypoSkin.bodyText2
//                               .copyWith(color: FColorSkin.subtitle),
//                         ),
//                       ),
//                       FListTile(
//                           backgroundColor: FColorSkin.transparent,
//                           title: Obx(() {
//                             return Text(
//                               '${moneyController.startDateValue} - ${moneyController.endDateValue}',
//                               style: FTypoSkin.title2.copyWith(
//                                   color: FColorSkin.grey1_background),
//                             );
//                           })),
//                     ],
//                   ),
//                 ),
//                 Container(
//                   padding: EdgeInsets.only(right: 8, top: 10),
//                   child: FFilledButton.icon(
//                       backgroundColor: FColorSkin.transparent,
//                       child: FIcon(
//                         icon: FFilled.calendar,
//                         size: 24,
//                         color: FColorSkin.subtitle,
//                       ),
//                       onPressed: () {
//                         // Hive.deleteFromDisk();
//                         // return;
//                         Get.dialog(Scaffold(
//                           backgroundColor: FColorSkin.transparent,
//                           body: Center(
//                             child: Container(
//                               height: Get.height / 2,
//                               width: Get.width - 32,
//                               child: ClipRRect(
//                                 borderRadius: BorderRadius.circular(8.0),
//                                 child: SfDateRangePicker(
//                                   showActionButtons: true,
//                                   onSelectionChanged: (vl) {
//                                     print(vl);
//                                   },
//                                   // init range start date and end date
//                                   initialSelectedRange:
//                                       PickerDateRange(now, more7day),
//                                   onCancel: () {
//                                     CoreRoutes.instance.pop();
//                                   },
//                                   onSubmit: (vl) {
//                                     if (vl is PickerDateRange) {
//                                       final _range =
//                                           '${FDate.dMy(vl.startDate)} -'
//                                           // ignore: lines_longer_than_80_chars
//                                           ' ${FDate.dMy(vl.endDate ?? vl.startDate)}';
//                                       // print(_range);
//                                       moneyController
//                                           .changeDateShowMoneyList(
//                                               vl.startDate,
//                                               vl.endDate ?? vl.startDate);
//                                       setState(() {
//                                         now = vl.startDate;
//                                         more7day =
//                                             vl.endDate ?? vl.startDate;
//                                       });
//                                       CoreRoutes.instance.pop();
//                                     }
//                                   },
//                                   // maxDate: DateTime.now()
//                                   //     .add(const Duration(days: 30)),
//                                   // minDate: DateTime.now()
//                                   //     .subtract(const Duration(days: 30)),
//
//                                   selectionMode:
//                                       DateRangePickerSelectionMode.range,
//                                   backgroundColor:
//                                       FColorSkin.grey1_background,
//                                   startRangeSelectionColor:
//                                       FColorSkin.primaryColor,
//                                   endRangeSelectionColor:
//                                       FColorSkin.primaryColor,
//                                   selectionColor: FColorSkin.title,
//                                   monthCellStyle:
//                                       DateRangePickerMonthCellStyle(
//                                           leadingDatesTextStyle:
//                                               TextStyle(
//                                             color: FColorSkin.title,
//                                           ),
//                                           todayTextStyle: TextStyle(
//                                               color: FColorSkin.title),
//                                           trailingDatesTextStyle:
//                                               TextStyle(
//                                             color: FColorSkin.title,
//                                           ),
//                                           weekendTextStyle: TextStyle(
//                                             color: FColorSkin.title,
//                                           ),
//                                           textStyle: TextStyle(
//                                             color: FColorSkin.title,
//                                           )),
//                                   headerStyle: DateRangePickerHeaderStyle(
//                                       textStyle: TextStyle(
//                                     // color choose year
//                                     color: FColorSkin.title,
//                                   )),
//                                   rangeSelectionColor: FColorSkin
//                                       .primaryColorTagBackground,
//                                   selectionTextStyle: TextStyle(
//                                     // change color range selected
//                                     color: FColorSkin.grey1_background,
//                                   ),
//                                   yearCellStyle:
//                                       DateRangePickerYearCellStyle(
//                                     textStyle: TextStyle(
//                                       color: FColorSkin.title,
//                                     ),
//                                   ),
//                                   rangeTextStyle:
//                                       TextStyle(color: FColorSkin.title),
//
//                                   monthViewSettings:
//                                       DateRangePickerMonthViewSettings(
//                                           viewHeaderStyle:
//                                               DateRangePickerViewHeaderStyle(
//                                                   textStyle: TextStyle(
//                                                       color: FColorSkin
//                                                           .title)),
//                                           firstDayOfWeek: 1),
//                                 ),
//                               ),
//                             ),
//                           ),
//                         ));
//                       }),
//                 )
//               ],
//             ),
//           )
//         ]),
//       ),
//     ];
//   },
//   body: Obx(() {
//     return
//     DefaultTabController(
//       length: walletController.walletList.length + 1,
//       child: Column(
//         children: <Widget>[
//           Obx(() {
//             return Container(
//               height: 45,
//               width: Get.width,
//               color: FColorSkin.title,
//               child: TabBar(
//                   onTap: (index) {},
//                   isScrollable: walletController.walletList.length > 4
//                       ? true
//                       : false,
//                   indicatorSize: TabBarIndicatorSize.label,
//                   indicatorColor: FColorSkin.grey1_background,
//                   labelColor: FColorSkin.grey1_background,
//                   tabs: [
//                     Tab(
//                       text: 'Tất cả ví',
//                     ),
//                     ...List<Tab>.generate(
//                         walletController.walletList.length, (index) {
//                       return Tab(
//                         text: walletController.walletList[index].title,
//                       );
//                     })
//                   ]),
//             );
//           }),
//           Expanded(
//             child: TabBarView(
//               children: [
//                 // tab1
//                 ListView(
//                   children: [
//                     // card
//                     Container(
//                       height: 148 + 84.0,
//                       child: Stack(
//                         children: [
//                           Column(
//                             children: [
//                               Container(
//                                 height: 148.0,
//                                 color: FColorSkin.title,
//                               ),
//                               Container(
//                                 height: 84.0,
//                                 color: FColorSkin.grey1_background,
//                               ),
//                             ],
//                           ),
//                           Column(
//                             children: [
//                               Container(
//                                 height: 148 - 16.0,
//                                 width: double.infinity,
//                                 padding: EdgeInsets.all(24.0),
//                                 margin: EdgeInsets.only(
//                                     top: 16, left: 16, right: 16),
//                                 decoration: BoxDecoration(
//                                     gradient: LinearGradient(
//                                       colors: [
//                                         FColorSkin.primaryColor,
//                                         FColorSkin
//                                             .primaryColorTagBackground
//                                       ],
//                                       begin: const FractionalOffset(
//                                           1.0, 0.0),
//                                       end: const FractionalOffset(
//                                           0.5, 0.0),
//                                       tileMode: TileMode.mirror,
//                                       stops: const [
//                                         1.0,
//                                         0.9,
//                                       ],
//                                     ),
//                                     borderRadius: BorderRadius.only(
//                                       topLeft: Radius.circular(12.0),
//                                       topRight: Radius.circular(12.0),
//                                     )),
//                                 child: Column(
//                                   crossAxisAlignment:
//                                       CrossAxisAlignment.start,
//                                   children: [
//                                     Text(
//                                       'Số dư cuối kỳ',
//                                       style: FTypoSkin.bodyText2.copyWith(
//                                           color: FColorSkin.subtitle),
//                                     ),
//                                     Obx(() {
//                                       return AutoSizeText(
//                                         '${moneyController?.surplusMoneyWallet?.wToMoney(0) ?? 0}',
//                                         maxLines: 1,
//                                         maxFontSize: 24,
//                                         style: FTypoSkin.largeTitle
//                                             .copyWith(
//                                                 color: FColorSkin
//                                                     .grey1_background),
//                                       );
//                                     }),
//                                   ],
//                                 ),
//                               ),
//                               Container(
//                                 height: 84.0,
//                                 margin:
//                                     EdgeInsets.only(left: 16, right: 16),
//                                 padding: EdgeInsets.symmetric(
//                                     vertical: 12.0, horizontal: 24.0),
//                                 decoration: BoxDecoration(
//                                     color: FColorSkin.title,
//                                     borderRadius: BorderRadius.only(
//                                       bottomRight: Radius.circular(12.0),
//                                       bottomLeft: Radius.circular(12.0),
//                                     )),
//                                 child: Row(
//                                   children: [
//                                     Expanded(
//                                       child: Column(
//                                         crossAxisAlignment:
//                                             CrossAxisAlignment.start,
//                                         children: [
//                                           Text(
//                                             'Chi tiêu',
//                                             style: FTypoSkin.bodyText2
//                                                 .copyWith(
//                                                     color: FColorSkin
//                                                         .subtitle),
//                                           ),
//                                           Obx(() {
//                                             return AutoSizeText(
//                                               '${moneyController?.expenseAllMoneyWallet?.wToMoney(0) ?? 0.0}',
//                                               maxLines: 1,
//                                               maxFontSize: 24,
//                                               style: FTypoSkin.title2
//                                                   .copyWith(
//                                                       color: FColorSkin
//                                                           .grey1_background),
//                                             );
//                                           }),
//                                         ],
//                                       ),
//                                     ),
//                                     Expanded(
//                                       child: Column(
//                                         crossAxisAlignment:
//                                             CrossAxisAlignment.start,
//                                         children: [
//                                           Text(
//                                             'Thu nhập',
//                                             style: FTypoSkin.bodyText2
//                                                 .copyWith(
//                                                     color: FColorSkin
//                                                         .subtitle),
//                                           ),
//                                           Obx(() {
//                                             return AutoSizeText(
//                                               '${moneyController.incomeAllMoneyWallet.wToMoney(0) ?? 0}',
//                                               maxLines: 1,
//                                               maxFontSize: 24,
//                                               style: FTypoSkin.title2
//                                                   .copyWith(
//                                                       color: FColorSkin
//                                                           .grey1_background),
//                                             );
//                                           }),
//                                         ],
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                             ],
//                           )
//                         ],
//                       ),
//                     ),
//                     // Chi tiêu nổi bật
//                     Container(
//                       padding: EdgeInsets.only(top: 16, bottom: 16.0),
//                       child: FListTile(
//                         title: Text(
//                           'Chi tiêu nổi bật',
//                           style: FTypoSkin.title3
//                               .copyWith(color: FColorSkin.title),
//                         ),
//                         action: TextButton(
//                             onPressed: () {},
//                             child: Text(
//                               'Xem tất cả',
//                               style: FTypoSkin.buttonText2.copyWith(
//                                   color: FColorSkin.primaryColor),
//                             )),
//                       ),
//                     ),
//                     Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         // Container(
//                         //     height: 48.0 * 5,
//                         //     child: ListView.builder(
//                         //       itemCount: moneyController
//                         //               .top5ExpenseMoneyList.length ??
//                         //           0,
//                         //       itemBuilder: (context, index) => Container(
//                         //         padding: EdgeInsets.only(bottom: 10.0),
//                         //         child: FListTile(
//                         //           onTap: () {
//                         //             CoreRoutes.instance
//                         //                 .navigatorPushDownToUp(InputMoney(
//                         //               idType: int.parse(moneyController
//                         //                   .top5ExpenseMoneyList[index]
//                         //                   .moneyType),
//                         //               moneyItem: moneyController
//                         //                   .top5ExpenseMoneyList[index],
//                         //             ));
//                         //           },
//                         //           avatar: FBoundingBox(),
//                         //           title: Text(
//                         //             moneyController
//                         //                     .top5ExpenseMoneyList[index]
//                         //                     .moneyCateType
//                         //                     .cateName ??
//                         //                 '',
//                         //             style: FTypoSkin.title5
//                         //                 .copyWith(color: FColorSkin.body),
//                         //           ),
//                         //           action: Text(
//                         //             '-${moneyController.top5ExpenseMoneyList[index].moneyValue.wToMoney(0)}',
//                         //             style: FTypoSkin.title5
//                         //                 .copyWith(color: FColorSkin.body),
//                         //           ),
//                         //         ),
//                         //       ),
//                         //     )),
//                         ...List.generate(
//                           moneyController.top3ExpenseMoneyList.length ??
//                               0,
//                           (index) => Container(
//                             padding: EdgeInsets.only(bottom: 10.0),
//                             child: FListTile(
//                               onTap: () {
//                                 CoreRoutes.instance
//                                     .navigatorPushDownToUp(InputMoney(
//                                   idType: int.parse(moneyController
//                                       .top3ExpenseMoneyList[index]
//                                       .moneyType),
//                                   moneyItem: moneyController
//                                       .top3ExpenseMoneyList[index],
//                                 ));
//                               },
//                               avatar: FBoundingBox(),
//                               title: Text(
//                                 moneyController
//                                         .top3ExpenseMoneyList[index]
//                                         .moneyCateType
//                                         .cateName ??
//                                     '',
//                                 style: FTypoSkin.title5
//                                     .copyWith(color: FColorSkin.body),
//                               ),
//                               action: Text(
//                                 '-${moneyController.top3ExpenseMoneyList[index].moneyValue.wToMoney(0)}',
//                                 style: FTypoSkin.title5
//                                     .copyWith(color: FColorSkin.body),
//                               ),
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                     Container(
//                       height: 16,
//                       color: FColorSkin.grey3_background,
//                     ),
//                     // Thu nhập nổi bật
//                     Container(
//                       padding: EdgeInsets.only(top: 16, bottom: 16),
//                       child: FListTile(
//                         title: Text(
//                           'Thu nhập nổi bật',
//                           style: FTypoSkin.title3
//                               .copyWith(color: FColorSkin.title),
//                         ),
//                         action: TextButton(
//                             onPressed: () {},
//                             child: Text(
//                               'Xem tất cả',
//                               style: FTypoSkin.buttonText2.copyWith(
//                                   color: FColorSkin.primaryColor),
//                             )),
//                       ),
//                     ),
//                     Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         ...List.generate(
//                           moneyController.top5IncomeMoneyList.length ?? 0,
//                           (index) => Container(
//                             padding: EdgeInsets.only(bottom: 10.0),
//                             child: FListTile(
//                               avatar: FBoundingBox(),
//                               title: Text(
//                                 moneyController.top5IncomeMoneyList[index]
//                                         .moneyCateType.cateName ??
//                                     '',
//                                 style: FTypoSkin.title5
//                                     .copyWith(color: FColorSkin.body),
//                               ),
//                               action: Text(
//                                 '+${moneyController.top5IncomeMoneyList[index].moneyValue.wToMoney(0)}',
//                                 style: FTypoSkin.title5
//                                     .copyWith(color: FColorSkin.body),
//                               ),
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ],
//                 ),
//                 ...List<Widget>.generate(
//                     walletController.walletList.length, (index) {
//                   return Container();
//                 })
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }),
// ),
