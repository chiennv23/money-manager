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
      length: walletController.walletList.length + 1,
      vsync: this,
    );
    tabController.addListener(_handleTabSelection);
    moneyController.walletIdInTab.value = '';
    // scrollController.addListener(handleScroll);
    if (UserService.getAvtUsername != null) {
      _imagesFile = File(UserService.getAvtUsername);
    }
  }

  void _handleTabSelection() {
    if (tabController.indexIsChanging ||
        tabController.index != tabController.previousIndex) {
      // setState(() {
      //   indexTab = tabController.index;
      // });
      // print(indexTab);
      if (tabController.index == 0) {
        moneyController.changeWalletIndex('');
      } else {
        moneyController.changeWalletIndex(
            walletController.walletList[tabController.index - 1].iD);
      }
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
                              : 'Hello, Owner',
                  style: FTypoSkin.title1.copyWith(
                      color: FColorSkin.title, fontWeight: FontWeight.w400),
                ),
              ),
              Text(
                'Owner',
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
          // Padding(
          //   padding: const EdgeInsets.only(right: 16.0, top: 40),
          //   child: FFilledButton.icon(
          //       size: FButtonSize.size32,
          //       backgroundColor: FColorSkin.grey3_background,
          //       child: FIcon(
          //         icon: FFilled.setting,
          //         size: 20,
          //         color: FColorSkin.secondaryText,
          //       ),
          //       onPressed: () {}),
          // )
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
                          money: moneyController.incomeAllMoneyWalletbyDates,
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
                          money: moneyController.expenseAllMoneyWalletByDates,
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
                    opacity: (moneyController.incomeAllMoneyWalletbyDates != 0.0 &&
                            moneyController.expenseAllMoneyWalletByDates != 0.0 &&
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
                            controller: tabController,
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
                                  controller: tabController,
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
                                                    // detail
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
                                                          String title = '';
                                                          if (tabController
                                                                  .index !=
                                                              0) {
                                                            title = walletController
                                                                .walletList[
                                                                    tabController
                                                                            .index -
                                                                        1]
                                                                .title;
                                                          }
                                                          CoreRoutes.instance
                                                              .navigatorPushRoutes(
                                                                  ExpenseMoneyDetail(
                                                                      walletName:
                                                                          title));
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
                                                        size: FBoxSize.size24,
                                                        backgroundColor:
                                                            FColorSkin
                                                                .grey1_background,
                                                        child: Image.asset(
                                                            moneyController
                                                                .top3ExpenseMoneyList[
                                                                    index]
                                                                .moneyCateType
                                                                .cateIcon),
                                                      ),
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
                    color: langApp == 'en'
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
                  color: langApp != 'en'
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
