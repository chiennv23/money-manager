import 'dart:math';

import 'package:clickable_list_wheel_view/clickable_list_wheel_widget.dart';
import 'package:coresystem/Project/2M/Contains/skin/color_skin.dart';
import 'package:coresystem/Project/2M/Module/Money/DA/money_controller.dart';
import 'package:coresystem/Project/2M/Module/Wallet/DA/wallet_controller.dart';
import 'package:coresystem/Project/2M/Module/Wallet/Views/wallet_detail.dart';
import 'package:coresystem/Utils/ConvertUtils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../../Components/base_component.dart';
import '../../../Core/routes.dart';
import '../Contains/skin/typo_skin.dart';
import '../Module/Wallet/Views/create_wallet.dart';

class SupportIndex extends StatefulWidget {
  const SupportIndex({Key key}) : super(key: key);

  @override
  State<SupportIndex> createState() => _SupportIndexState();
}

class _SupportIndexState extends State<SupportIndex>
    with SingleTickerProviderStateMixin {
  AnimationController _animationController;
  List<int> indexCardWalletList = [];

  @override
  void initState() {
    moneyController.walletIdInTab.value = '';
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 250),
    );
    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  WalletController walletController = Get.find();
  MoneyController moneyController = Get.find();
  bool deleteMode = false;
  final _controller = FixedExtentScrollController(initialItem: 0);

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.dark,
      child: Scaffold(
        backgroundColor: FColorSkin.grey1_background,
        body: Obx(() {
          return SafeArea(
            child: Column(
              children: [
                Container(
                  height: 156,
                  width: double.infinity,
                  padding: EdgeInsets.all(24),
                  color: FColorSkin.grey1_background,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'List',
                            style: FTypoSkin.title1.copyWith(
                              color: FColorSkin.title,
                            ),
                          ),
                          Obx(() {
                            return Container(
                              padding: EdgeInsets.only(top: 5, bottom: 5),
                              child: Text(
                                '${walletController.walletList != null && walletController.walletList.length != 0 ? walletController.walletList.length > 1 ? '0${walletController?.walletList?.length}' : walletController?.walletList?.length : '0'} Wallets',
                                style: FTypoSkin.title1.copyWith(
                                  color: FColorSkin.primaryColor,
                                ),
                              ),
                            );
                          }),
                        ],
                      ),
                      if (walletController.walletList.isNotEmpty)
                        FFilledButton.icon(
                            size: FButtonSize.size40,
                            backgroundColor: deleteMode
                                ? FColorSkin.errorPrimary
                                : FColorSkin.title,
                            onPressed: () {
                              if (deleteMode) {
                                indexCardWalletList.forEach((element) async {
                                  final String id =
                                      walletController.walletList[element].iD;
                                  await walletController.deleteThisWallet(
                                      id,
                                      walletController
                                          .walletList[element].title);
                                });

                                indexCardWalletList.clear();
                                _animationController.stop();
                                deleteMode = false;
                                print('deleteMode $deleteMode}');
                                setState(() {});
                                return;
                              }
                              CoreRoutes.instance
                                  .navigatorPushDownToUp(CreateWallet());
                            },
                            child: FIcon(
                              icon: deleteMode
                                  ? indexCardWalletList.isEmpty
                                      ? FOutlined.close
                                      : FOutlined.delete_2
                                  : FOutlined.wallet,
                              size: 24,
                              color: FColorSkin.grey1_background,
                            )),
                    ],
                  ),
                ),
                walletController.walletList.isEmpty
                    ? Expanded(
                        child: Container(
                          alignment: Alignment.center,
                          padding: EdgeInsets.all(24),
                          child: Hero(
                            key: Key('0'),
                            tag: '0',
                            child: Stack(
                              alignment: AlignmentDirectional.center,
                              children: [
                                Image.asset(
                                  'lib/Assets/Images/wallet.png',
                                ),
                                FFilledButton.icon(
                                    size: FButtonSize.size48,
                                    backgroundColor: deleteMode
                                        ? FColorSkin.errorPrimary
                                        : FColorSkin.primaryColor,
                                    onPressed: () {
                                      if (deleteMode) {
                                        indexCardWalletList
                                            .forEach((element) async {
                                          final String id = walletController
                                              .walletList[element].iD;
                                          await walletController
                                              .deleteThisWallet(
                                                  id,
                                                  walletController
                                                      .walletList[element]
                                                      .title);
                                        });

                                        indexCardWalletList.clear();
                                        _animationController.stop();
                                        deleteMode = false;
                                        print('deleteMode $deleteMode}');
                                        setState(() {});
                                        return;
                                      }
                                      CoreRoutes.instance.navigatorPushDownToUp(
                                          CreateWallet());
                                    },
                                    child: FIcon(
                                      icon: deleteMode
                                          ? indexCardWalletList.isEmpty
                                              ? FOutlined.close
                                              : FOutlined.delete_2
                                          : FOutlined.plus,
                                      size: 28,
                                      color: FColorSkin.grey1_background,
                                    )),
                              ],
                            ),
                          ),
                        ),
                      )
                    : Expanded(
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
                                      '${moneyController.surplusMoneyWallet.wToMoney(0).replaceAll('.', ',')}',
                                      style: FTypoSkin.title4.copyWith(
                                          color: FColorSkin.title,
                                          fontWeight: FontWeight.w500),
                                    );
                                  }),
                                  Text(
                                    'Total balance',
                                    style: FTypoSkin.subtitle3.copyWith(
                                      color: FColorSkin.subtitle,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 24.0),
                                    child: Obx(() {
                                      return Text(
                                        '${moneyController.incomeAllMoneyWallet.wToMoney(0).replaceAll('.', ',')}',
                                        style: FTypoSkin.title4.copyWith(
                                            color: FColorSkin.primaryColor,
                                            fontWeight: FontWeight.w500),
                                      );
                                    }),
                                  ),
                                  Padding(
                                    padding:
                                        const EdgeInsets.only(bottom: 24.0),
                                    child: Text(
                                      'Total inc T${moneyController.selectedValue.value.month}',
                                      style: FTypoSkin.subtitle3.copyWith(
                                        color: FColorSkin.subtitle,
                                      ),
                                    ),
                                  ),
                                  Obx(() {
                                    return Text(
                                      '${moneyController.expenseAllMoneyWallet.wToMoney(0).replaceAll('.', ',')}',
                                      style: FTypoSkin.title4.copyWith(
                                          color: FColorSkin.warningPrimary,
                                          fontWeight: FontWeight.w500),
                                    );
                                  }),
                                  Text(
                                    'Total exp T${moneyController.selectedValue.value.month}',
                                    style: FTypoSkin.subtitle3.copyWith(
                                      color: FColorSkin.subtitle,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                              child: GestureDetector(
                                onLongPress: () {
                                  _animationController.repeat();
                                  deleteMode = true;
                                  print('deleteMode $deleteMode}');
                                  setState(() {});
                                },
                                child: Container(
                                  color: FColorSkin.transparent,
                                  child: Transform.translate(
                                    offset: Offset(50, -80),
                                    child: Obx(() {
                                      return ClickableListWheelScrollView(
                                        scrollController: _controller,
                                        itemCount:
                                            walletController.walletList.length,
                                        loop: true,
                                        onItemTapCallback: (index) {
                                          print(
                                              'onItemTapCallback index: $index');
                                          if (deleteMode) {
                                            if (!indexCardWalletList.any(
                                                (element) =>
                                                    element == index)) {
                                              indexCardWalletList.add(index);
                                            } else {
                                              indexCardWalletList.removeWhere(
                                                  (element) =>
                                                      element == index);
                                            }
                                            setState(() {});
                                            return;
                                          }
                                          CoreRoutes.instance
                                              .navigatorPushRoutes(WalletDetail(
                                            walletItem: walletController
                                                .walletList[index],
                                            itemIndex: index,
                                          ));
                                        },
                                        itemHeight: 250,
                                        child: ListWheelScrollView.useDelegate(
                                          controller: _controller,
                                          itemExtent: 250,
                                          diameterRatio: .6,
                                          perspective: 0.0001,
                                          offAxisFraction: -2.5,
                                          squeeze: 1.7,
                                          physics: FixedExtentScrollPhysics(),
                                          onSelectedItemChanged: (vl) {
                                            print(vl);
                                          },
                                          childDelegate:
                                              ListWheelChildBuilderDelegate(
                                                  childCount: walletController
                                                      .walletList.length,
                                                  builder:
                                                      (BuildContext context,
                                                          int itemIndex) {
                                                    final item =
                                                        walletController
                                                                .walletList[
                                                            itemIndex];
                                                    return AnimatedBuilder(
                                                      animation:
                                                          _animationController,
                                                      builder:
                                                          (BuildContext context,
                                                              Widget child) {
                                                        final dx = sin(
                                                                _animationController
                                                                        .value *
                                                                    2 *
                                                                    pi) *
                                                            1.9;
                                                        return Transform
                                                            .translate(
                                                          offset: Offset(dx, 0),
                                                          child: child,
                                                        );
                                                      },
                                                      child: Hero(
                                                        key: Key('$itemIndex'),
                                                        tag: '$itemIndex',
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .only(
                                                                  top: 32),
                                                          child: Stack(
                                                            alignment:
                                                                AlignmentDirectional
                                                                    .center,
                                                            children: [
                                                              Image.asset(
                                                                item.avt ??
                                                                    'lib/Assets/Images/wallet.png',
                                                                width: double
                                                                    .infinity,
                                                                fit: BoxFit
                                                                    .cover,
                                                              ),
                                                              Positioned(
                                                                right: 0.0,
                                                                left: 20.0,
                                                                top: 50,
                                                                child: Column(
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .start,
                                                                  children: [
                                                                    deleteMode
                                                                        ? FCheckbox(
                                                                            size: FCheckboxSize
                                                                                .size24,
                                                                            borderColor: listTypeCardWallet.firstWhere((element) => element.img == item.avt).tone
                                                                                ? FColorSkin
                                                                                    .title
                                                                                : FColorSkin
                                                                                    .grey1_background,
                                                                            activeColor: FColorSkin
                                                                                .primaryColor,
                                                                            value: indexCardWalletList.any((element) =>
                                                                                element ==
                                                                                itemIndex),
                                                                            onChanged:
                                                                                (vl) {})
                                                                        : FIcon(
                                                                            icon: FFilled
                                                                                .gold_coin,
                                                                            size:
                                                                                20,
                                                                            color: listTypeCardWallet.firstWhere((element) => element.img == item.avt).tone
                                                                                ? FColorSkin.title
                                                                                : FColorSkin.grey1_background),
                                                                    Padding(
                                                                      padding: const EdgeInsets
                                                                              .only(
                                                                          top:
                                                                              10.0,
                                                                          bottom:
                                                                              5),
                                                                      child:
                                                                          Material(
                                                                        color: FColorSkin
                                                                            .transparent,
                                                                        child:
                                                                            Text(
                                                                          item.title,
                                                                          style: FTypoSkin
                                                                              .bodyText2
                                                                              .copyWith(color: listTypeCardWallet.firstWhere((element) => element.img == item.avt).tone ? FColorSkin.title : FColorSkin.grey1_background),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    Material(
                                                                      color: FColorSkin
                                                                          .transparent,
                                                                      child:
                                                                          Text(
                                                                        '${WConvert.money(double.parse(item.moneyWallet.toString()), 0).replaceAll('.', ',')} VND',
                                                                        style: FTypoSkin
                                                                            .title2
                                                                            .copyWith(color: listTypeCardWallet.firstWhere((element) => element.img == item.avt).tone ? FColorSkin.title : FColorSkin.grey1_background),
                                                                      ),
                                                                    ),
                                                                    Padding(
                                                                      padding: const EdgeInsets
                                                                              .only(
                                                                          top:
                                                                              5.0),
                                                                      child:
                                                                          Material(
                                                                        color: FColorSkin
                                                                            .transparent,
                                                                        child:
                                                                            Text(
                                                                          '${FDate.dMy(item.creWalletDate)}',
                                                                          style: FTypoSkin
                                                                              .bodyText2
                                                                              .copyWith(color: listTypeCardWallet.firstWhere((element) => element.img == item.avt).tone ? FColorSkin.title : FColorSkin.grey1_background),
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
                                                    );
                                                  }),
                                        ),
                                      );
                                    }),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
              ],
            ),
          );
        }),
      ),
    );
  }
}

List<TypeItem> listTypeCardWallet = [
  TypeItem(id: 0, img: 'lib/Assets/Images/wallet.png', tone: false),
  TypeItem(id: 1, img: 'lib/Assets/Images/wallet2.png', tone: true),
  TypeItem(id: 2, img: 'lib/Assets/Images/wallet3.png', tone: false),
  TypeItem(id: 3, img: 'lib/Assets/Images/wallet4.png', tone: true),
];

class TypeItem {
  int id;
  String img;
  bool tone;

  TypeItem({this.id, this.img, this.tone});
}

abstract class AnimationControllerState<T extends StatefulWidget>
    extends State<T> with SingleTickerProviderStateMixin {
  AnimationControllerState(animationDuration);

  Duration animationDuration;
  AnimationController animationController;

  @override
  void initState() {
    animationController =
        AnimationController(vsync: this, duration: animationDuration);

    super.initState();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }
}

class ShakeWidget extends StatefulWidget {
  const ShakeWidget({
    Key key,
    this.child,
    this.shakeOffset,
    this.shakeCount = 3,
    this.shakeDuration = const Duration(milliseconds: 400),
  }) : super(key: key);
  final Widget child;
  final double shakeOffset;
  final int shakeCount;
  final Duration shakeDuration;

  @override
  ShakeWidgetState createState() => ShakeWidgetState(shakeDuration);
}

class ShakeWidgetState extends AnimationControllerState<ShakeWidget> {
  ShakeWidgetState(Duration duration) : super(duration);

  @override
  void initState() {
    super.initState();
    animationController.addStatusListener(_updateStatus);
  }

  @override
  void dispose() {
    animationController.removeStatusListener(_updateStatus);
    super.dispose();
  }

  void _updateStatus(AnimationStatus status) {
    if (status == AnimationStatus.completed) {
      animationController.reset();
    }
  }

  void shake() {
    animationController.repeat();
  }

  @override
  Widget build(BuildContext context) {
    // 1. return an AnimatedBuilder
    return AnimatedBuilder(
      // 2. pass our custom animation as an argument
      animation: animationController,
      // 3. optimization: pass the given child as an argument
      child: widget.child,
      builder: (context, child) {
        final sineValue =
            sin(widget.shakeCount * 2 * pi * animationController.value);
        return Transform.translate(
          // 4. apply a translation as a function of the animation value
          offset: Offset(sineValue * widget.shakeOffset, 0),
          // 5. use the child widget
          child: child,
        );
      },
    );
  }
}
