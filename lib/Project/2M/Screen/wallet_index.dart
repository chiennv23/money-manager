import 'package:clickable_list_wheel_view/clickable_list_wheel_widget.dart';
import 'package:coresystem/Project/2M/Contains/skin/color_skin.dart';
import 'package:coresystem/Project/2M/Module/Wallet/DA/wallet_controller.dart';
import 'package:coresystem/Utils/ConvertUtils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../../Components/base_component.dart';
import '../../../Core/routes.dart';
import '../Contains/skin/typo_skin.dart';
import '../Module/Wallet/Views/create_wallet.dart';
import 'transaction_index.dart';

class SupportIndex extends StatefulWidget {
  const SupportIndex({Key key}) : super(key: key);

  @override
  State<SupportIndex> createState() => _SupportIndexState();
}

class _SupportIndexState extends State<SupportIndex> {
  WalletController walletController = Get.find();
  final _controller = FixedExtentScrollController(initialItem: 0);

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.dark,
      child: Scaffold(
        backgroundColor: FColorSkin.grey1_background,
        body: SafeArea(
          child: Column(
            children: [
              Container(
                height: 156,
                width: double.infinity,
                padding: EdgeInsets.all(24),
                color: FColorSkin.grey1_background,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Tổng số dư',
                          style: FTypoSkin.title1.copyWith(
                            color: FColorSkin.title,
                          ),
                        ),
                        Obx(() {
                          return Container(
                            padding: EdgeInsets.only(top: 5, bottom: 5),
                            child: Text(
                              '${walletController.totalMoneyinWallets.wToMoney(0).replaceAll('.', ',')} VND',
                              style: FTypoSkin.title2.copyWith(
                                color: FColorSkin.primaryColor,
                              ),
                            ),
                          );
                        }),
                        Obx(() {
                          return Text(
                            'Thông tin ${walletController.walletList.length} ví',
                            style: FTypoSkin.subtitle1.copyWith(
                              color: FColorSkin.title,
                            ),
                          );
                        }),
                      ],
                    ),
                    FFilledButton.icon(
                        size: FButtonSize.size48,
                        backgroundColor: FColorSkin.primaryColor,
                        onPressed: () {
                          CoreRoutes.instance
                              .navigatorPushDownToUp(CreateWallet());
                        },
                        child: FIcon(
                          icon: FOutlined.plus,
                          size: 28,
                          color: FColorSkin.grey1_background,
                        )),
                  ],
                ),
              ),
              Expanded(
                // height: walletController.walletList.length * 56.0,
                child: Obx(() {
                  return ClickableListWheelScrollView(
                    scrollController: _controller,
                    itemCount: walletController.walletList.length,
                    loop: true,
                    onItemTapCallback: (index) {
                      print("onItemTapCallback index: $index");
                      Future.delayed(Duration(milliseconds: 50), () {
                        CoreRoutes.instance.navigatorPushFade(CreateWallet(
                          walletItem: walletController.walletList[index],
                          indexHero: index,
                        ));
                      });
                    },
                    itemHeight: 250,
                    child: ListWheelScrollView.useDelegate(
                      controller: _controller,
                      itemExtent: 250,
                      diameterRatio: 1,
                      physics: FixedExtentScrollPhysics(),
                      // perspective: 0.0019,
                      onSelectedItemChanged: (vl) {
                        print(vl);
                      },
                      childDelegate: ListWheelChildBuilderDelegate(
                          childCount: walletController.walletList.length,
                          builder: (BuildContext context, int itemIndex) {
                            final item = walletController.walletList[itemIndex];
                            return Hero(
                              key: Key('itemIndex'),
                              tag: '$itemIndex',
                              child: Padding(
                                padding: const EdgeInsets.all(16),
                                child: Stack(
                                  alignment: AlignmentDirectional.center,
                                  children: [
                                    Image.asset(
                                      'lib/Assets/Images/wallet.png',
                                      width: double.infinity,
                                      fit: BoxFit.cover,
                                    ),
                                    Positioned(
                                      right: 0.0,
                                      left: 20.0,
                                      top: 50,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          FIcon(
                                            icon: FFilled.gold_coin,
                                            size: 20,
                                            color: FColorSkin.grey1_background,
                                          ),
                                          Text(
                                            item.title,
                                            style: FTypoSkin.bodyText2.copyWith(
                                                color: FColorSkin
                                                    .grey1_background),
                                          ),
                                          Text(
                                            '${WConvert.money(double.parse(item.moneyWallet.toString()), 0).replaceAll('.', ',')} VND',
                                            style: FTypoSkin.title2.copyWith(
                                                color: FColorSkin
                                                    .grey1_background),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Positioned(
                                      bottom: 30.0,
                                      right: 16.0,
                                      child: Text(
                                        'Created: ${FDate.dMy(item.creWalletDate)}',
                                        style: FTypoSkin.bodyText2.copyWith(
                                            color: FColorSkin.grey1_background),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            );
                          }),
                    ),
                  );
                  return ListView.builder(
                      itemCount: walletController.walletList.length,
                      itemBuilder: (context, i) {
                        final item = walletController.walletList[i];
                        return GestureDetector(
                          onLongPress: () {
                            print(111);
                            walletController.deleteThisWallet(item.iD);
                          },
                          child: FListTile(
                            size: FListTileSize.size56,
                            onTap: () {
                              CoreRoutes.instance
                                  .navigatorPushDownToUp(CreateWallet(
                                walletItem: item,
                              ));
                            },
                            padding: EdgeInsets.only(left: 16),
                            border: Border(
                                bottom: BorderSide(
                                    color: FColorSkin.grey3_background)),
                            avatar: FBoundingBox(size: FBoxSize.size20),
                            title: Text(
                              item.title,
                              style: FTypoSkin.title4
                                  .copyWith(color: FColorSkin.title),
                            ),
                            subtitle: Text(
                              '${WConvert.money(double.parse(item.moneyWallet.toString()), 0).replaceAll('.', ',')} VND -- Created: ${FDate.dMy(item.creWalletDate)}',
                              style: FTypoSkin.subtitle2
                                  .copyWith(color: FColorSkin.title),
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
                        );
                      });
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
