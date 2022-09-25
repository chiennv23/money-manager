import 'package:coresystem/Components/base_component.dart';
import 'package:coresystem/Core/routes.dart';
import 'package:coresystem/Project/2M/Contains/constants.dart';
import 'package:coresystem/Project/2M/Contains/skin/color_skin.dart';
import 'package:coresystem/Project/2M/Contains/skin/typo_skin.dart';
import 'package:coresystem/Project/2M/LocalDatabase/Models/wallet_item.dart';
import 'package:coresystem/Project/2M/Module/Wallet/Views/wallet_detail_history.dart';
import 'package:coresystem/Project/2M/Screen/wallet_index.dart';
import 'package:coresystem/Utils/ConvertUtils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../Money/DA/money_controller.dart';
import '../../Money/Views/input_money.dart';
import '../DA/wallet_controller.dart';
import 'create_wallet.dart';

class WalletDetail extends StatefulWidget {
  final int itemIndex;
  final WalletItem walletItem;

  const WalletDetail({Key key, this.itemIndex, this.walletItem})
      : super(key: key);

  @override
  State<WalletDetail> createState() => _WalletDetailState();
}

class _WalletDetailState extends State<WalletDetail> {
  WalletController walletController = Get.find();
  MoneyController moneyController = Get.find();

  @override
  void initState() {
    moneyController.walletItemDetail = widget.walletItem;
    moneyController.selectedWalletDetailValue.value = DateTime.now();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: FColorSkin.grey3_background,
      appBar: appbarNoTitle(
          systemUiOverlayStyle: SystemUiOverlayStyle.dark,
          iconBack: FOutlined.left,
          action: [
            FFilledButton.icon(
              backgroundColor: FColorSkin.grey3_background,
              child: FIcon(
                icon: FFilled.edit,
                size: 20,
                color: FColorSkin.subtitle,
              ),
              onPressed: () {
                CoreRoutes.instance.navigatorPushRoutes(CreateWallet(
                  walletItem: widget.walletItem,
                  indexHero: widget.itemIndex,
                ));
              },
            ),
            if (moneyController.moneyListPageView.length != 0)
              SizedBox(
                width: 16,
              ),
            if (moneyController.moneyListPageView.length == 0)
              Padding(
                padding: const EdgeInsets.only(left: 16.0, right: 16),
                child: FFilledButton.icon(
                  backgroundColor: FColorSkin.grey3_background,
                  child: FIcon(
                    icon: FFilled.delete,
                    size: 20,
                    color: FColorSkin.subtitle,
                  ),
                  onPressed: () {
                    CoreRoutes.instance.navigatorPushFade(CreateWallet(
                      walletItem: widget.walletItem,
                      indexHero: widget.itemIndex,
                    ));
                  },
                ),
              ),
          ]),
      body: Obx(() {
        return SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                color: FColorSkin.grey1_background,
                padding: EdgeInsets.only(bottom: 32),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding:
                          const EdgeInsets.only(top: 18.0, left: 24, right: 24),
                      child: Text(
                        'Wallet information',
                        style:
                            FTypoSkin.title.copyWith(color: FColorSkin.title),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          bottom: 16, left: 24, right: 24),
                      child: Text(
                        widget.walletItem.title,
                        style: FTypoSkin.title
                            .copyWith(color: FColorSkin.primaryColor),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 24, right: 24),
                      child: Divider(
                        color: FColorSkin.grey3_background,
                        height: 0.0,
                        thickness: 2.0,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 24.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            padding: EdgeInsets.only(left: 24),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Obx(() {
                                  return Text(
                                    '${moneyController.surplusMoneyWalletDetail.wToMoney(0).replaceAll('.', ',')}',
                                    style: FTypoSkin.title4.copyWith(
                                        color: FColorSkin.title,
                                        fontWeight: FontWeight.w500),
                                  );
                                }),
                                Text(
                                  'Balance T${moneyController.selectedWalletDetailValue.value.month}',
                                  style: FTypoSkin.subtitle3.copyWith(
                                    color: FColorSkin.subtitle,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 24.0),
                                  child: Obx(() {
                                    return Text(
                                      '${moneyController.incomeAllMoneyWalletDetail.wToMoney(0).replaceAll('.', ',')}',
                                      style: FTypoSkin.title4.copyWith(
                                          color: FColorSkin.primaryColor,
                                          fontWeight: FontWeight.w500),
                                    );
                                  }),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 24.0),
                                  child: Text(
                                    'Income T${moneyController.selectedWalletDetailValue.value.month}',
                                    style: FTypoSkin.subtitle3.copyWith(
                                      color: FColorSkin.subtitle,
                                    ),
                                  ),
                                ),
                                Obx(() {
                                  return Text(
                                    '${moneyController.expenseAllMoneyWalletDetail.wToMoney(0).replaceAll('.', ',')}',
                                    style: FTypoSkin.title4.copyWith(
                                        color: FColorSkin.warningPrimary,
                                        fontWeight: FontWeight.w500),
                                  );
                                }),
                                Text(
                                  'Expense T${moneyController.selectedWalletDetailValue.value.month}',
                                  style: FTypoSkin.subtitle3.copyWith(
                                    color: FColorSkin.subtitle,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            child: Transform.translate(
                              offset: Offset(100, 0),
                              child: Hero(
                                key: Key('${widget.itemIndex}'),
                                tag: '${widget.itemIndex}',
                                child: Stack(
                                  alignment: AlignmentDirectional.center,
                                  children: [
                                    Image.asset(
                                      widget.walletItem.avt ??
                                          'lib/Assets/Images/wallet.png',
                                      width: double.infinity,
                                      fit: BoxFit.cover,
                                    ),
                                    Positioned(
                                      top: 20.0,
                                      left: 20.0,
                                      child: FIcon(
                                          icon: FFilled.gold_coin,
                                          size: 20,
                                          color: listTypeCardWallet
                                                  .firstWhere((element) =>
                                                      element.img ==
                                                      widget.walletItem.avt)
                                                  .tone
                                              ? FColorSkin.title
                                              : FColorSkin.grey1_background),
                                    ),
                                    Positioned(
                                      right: 0.0,
                                      left: 20.0,
                                      top: 80.0,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Material(
                                            color: FColorSkin.transparent,
                                            child: Text(
                                              'Created',
                                              style: FTypoSkin.bodyText2.copyWith(
                                                  color: listTypeCardWallet
                                                          .firstWhere(
                                                              (element) =>
                                                                  element.img ==
                                                                  widget
                                                                      .walletItem
                                                                      .avt)
                                                          .tone
                                                      ? FColorSkin.title
                                                      : FColorSkin
                                                          .grey1_background),
                                            ),
                                          ),
                                          Padding(
                                            padding:
                                                const EdgeInsets.only(top: 5.0),
                                            child: Material(
                                              color: FColorSkin.transparent,
                                              child: Text(
                                                '${FDate.dMy(widget.walletItem.creWalletDate)}',
                                                style: FTypoSkin.bodyText2.copyWith(
                                                    color: listTypeCardWallet
                                                            .firstWhere(
                                                                (element) =>
                                                                    element
                                                                        .img ==
                                                                    widget
                                                                        .walletItem
                                                                        .avt)
                                                            .tone
                                                        ? FColorSkin.title
                                                        : FColorSkin
                                                            .grey1_background),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              // date change
              Container(
                margin: EdgeInsets.all(24),
                height: 48.0,
                decoration: BoxDecoration(
                    color: FColorSkin.grey1_background,
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
                            moneyController.changeDateTimeWalletDetail('minus');
                          },
                        ),
                      ),
                    ),
                    Text(
                      '${FDate.My(moneyController.selectedWalletDetailValue.value)}',
                      style: FTypoSkin.title5.copyWith(color: FColorSkin.title),
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
                            moneyController.changeDateTimeWalletDetail('plus');
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              ...List.generate(
                  moneyController.moneyListPageView.take(10).toList().length,
                  (index) {
                final item =
                    moneyController.moneyListPageView.take(10).toList()[index];
                return Container(
                  margin: EdgeInsets.only(bottom: 16, left: 16, right: 16),
                  child: FListTile(
                    size: FListTileSize.size64,
                    rounded: true,
                    backgroundColor: FColorSkin.grey1_background,
                    onTap: () {
                      CoreRoutes.instance.navigatorPushDownToUp(InputMoney(
                        idType: int.parse(item.moneyType),
                        moneyItem: item,
                      ));
                    },
                    avatar: FBoundingBox(size: FBoxSize.size24),
                    title: Text(
                      item.moneyCateType.cateName ?? '',
                      style: FTypoSkin.title5.copyWith(color: FColorSkin.title),
                    ),
                    action: Text(
                      '${item.moneyType == '0' ? '-' : '+'}${item.moneyValue.wToMoney(0)}',
                      style: FTypoSkin.title5.copyWith(
                          color: item.moneyType == '0'
                              ? FColorSkin.warningPrimary
                              : FColorSkin.primaryColor),
                    ),
                  ),
                );
              }),
              if (moneyController.moneyListPageView.length > 10)
                Center(
                    child: Text(
                  'Lots of transitions. Click detail to see...',
                  style:
                      FTypoSkin.subtitle2.copyWith(color: FColorSkin.subtitle),
                ))
            ],
          ),
        );
      }),
      bottomNavigationBar: Container(
        padding: EdgeInsets.fromLTRB(16, 6, 16, 0),
        alignment: Alignment.topCenter,
        color: FColorSkin.transparent,
        height: 80,
        child: FFilledButton(
          size: FButtonSize.size40,
          borderRadius: BorderRadius.circular(20.0),
          onPressed: () {
            CoreRoutes.instance.navigatorPushRoutes(WalletDetailHistory(
              walletItem: widget.walletItem,
            ));
          },
          backgroundColor: FColorSkin.title,
          child: Container(
            alignment: Alignment.center,
            child: Text(
              'Transaction history details',
              style: FTextStyle.regular14_22
                  .copyWith(color: FColorSkin.grey1_background),
            ),
          ),
        ),
      ),
    );
  }
}
