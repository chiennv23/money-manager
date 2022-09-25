import 'package:coresystem/Components/base_component.dart';
import 'package:coresystem/Project/2M/Contains/constants.dart';
import 'package:coresystem/Project/2M/Contains/skin/color_skin.dart';
import 'package:coresystem/Project/2M/LocalDatabase/Models/wallet_item.dart';
import 'package:coresystem/Project/2M/Module/Wallet/DA/wallet_controller.dart';
import 'package:coresystem/Project/2M/Screen/wallet_index.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:uuid/uuid.dart';

import '../../../../../Utils/ConvertUtils.dart';
import '../../../Contains/skin/typo_skin.dart';
import '../../../LocalDatabase/model_lib.dart';

class CreateWallet extends StatefulWidget {
  final WalletItem walletItem;
  final int indexHero;

  const CreateWallet({
    Key key,
    this.walletItem,
    this.indexHero = 0,
  }) : super(key: key);

  @override
  State<CreateWallet> createState() => _CreateWalletState();
}

class _CreateWalletState extends State<CreateWallet> {
  final nameWalletController = TextEditingController();
  WalletController walletController = Get.find();
  int indexWalletColor = 0;

  @override
  void initState() {
    // edit wallet
    if (widget.walletItem != null) {
      nameWalletController.text = widget.walletItem.title;
      indexWalletColor = listTypeCardWallet
          .firstWhere((element) => element.img == widget.walletItem.avt)
          .id;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        backgroundColor: FColorSkin.grey1_background,
        resizeToAvoidBottomInset: false,
        appBar: appbarNoTitle(
          iconBack: FOutlined.left,
          systemUiOverlayStyle: SystemUiOverlayStyle.dark,
        ),
        body: SingleChildScrollView(
          // padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(
                    top: 8.0, bottom: 8, left: 16, right: 16),
                child: Text(
                  'Your Wallet',
                  style: FTypoSkin.title.copyWith(color: FColorSkin.title),
                ),
              ),
              FTextFormField(
                maxLine: 1,
                cursorHeight: 42,
                controller: nameWalletController,
                autoFocus: true,
                borderColor: FColorSkin.transparent,
                onChanged: (vl) {
                  setState(() {});
                },
                textInputAction: TextInputAction.done,
                hintText: 'Wallet Name',
                style:
                    TextStyle(fontSize: 40.0, color: FColorSkin.primaryColor),
                size: FInputSize.size64
                    .copyWith(contentPadding: EdgeInsets.zero, height: 42),
                focusColor: FColorSkin.transparent,
                hintStyle: TextStyle(
                    color: FColorSkin.subtitle.withOpacity(.3), fontSize: 40),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 40.0, left: 16, right: 16),
                child: Text(
                  'Wallet Theme',
                  style: FTypoSkin.title3.copyWith(color: FColorSkin.title),
                ),
              ),
              Container(
                  padding:
                      const EdgeInsets.only(top: 16.0, left: 16, right: 16),
                  height: 50,
                  child: Wrap(
                    children: List.generate(listTypeCardWallet.length, (index) {
                      final item = listTypeCardWallet[index];
                      return Container(
                        margin: EdgeInsets.only(right: 16),
                        decoration: BoxDecoration(
                            border: Border.all(
                                color: indexWalletColor == index
                                    ? FColorSkin.primaryColor
                                    : FColorSkin.transparent)),
                        child: InkWell(
                          onTap: () {
                            indexWalletColor = index;
                            setState(() {});
                          },
                          child: FBoundingBox(
                            backgroundColor: FColorSkin.grey1_background,
                            size: FBoxSize.size48,
                            child: Image.asset(
                              item.img,
                              height: 48,
                              width: 48,
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                      );
                    }),
                  )),
              Padding(
                padding: const EdgeInsets.only(top: 55.0, left: 16, right: 16),
                child: Text(
                  'Preview',
                  style: FTypoSkin.title3.copyWith(color: FColorSkin.title),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16.0, left: 16, right: 16),
                child: Hero(
                  tag: '${widget.indexHero}',
                  child: Stack(
                    children: [
                      Image.asset(
                        listTypeCardWallet
                            .firstWhere(
                                (element) => element.id == indexWalletColor)
                            .img,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),
                      Positioned(
                        right: 0.0,
                        left: 20.0,
                        top: 50,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            FIcon(
                                icon: FFilled.gold_coin,
                                size: 20,
                                color: listTypeCardWallet
                                        .firstWhere((element) =>
                                            element.id == indexWalletColor)
                                        .tone
                                    ? FColorSkin.title
                                    : FColorSkin.grey1_background),
                            Padding(
                              padding:
                                  const EdgeInsets.only(top: 10.0, bottom: 5),
                              child: Material(
                                color: FColorSkin.transparent,
                                child: Text(
                                  nameWalletController.text,
                                  style: FTypoSkin.bodyText2.copyWith(
                                      color: listTypeCardWallet
                                              .firstWhere((element) =>
                                                  element.id ==
                                                  indexWalletColor)
                                              .tone
                                          ? FColorSkin.title
                                          : FColorSkin.grey1_background),
                                ),
                              ),
                            ),
                            Material(
                              color: FColorSkin.transparent,
                              child: Text(
                                widget.walletItem != null
                                    ? '${widget.walletItem.moneyWallet.wToMoney(0).replaceAll('.', ',')} VND'
                                    : '0 VND',
                                style: FTypoSkin.title2.copyWith(
                                    color: listTypeCardWallet
                                            .firstWhere((element) =>
                                                element.id == indexWalletColor)
                                            .tone
                                        ? FColorSkin.title
                                        : FColorSkin.grey1_background),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Positioned(
                        bottom: 30.0,
                        right: 16.0,
                        child: Material(
                          color: FColorSkin.transparent,
                          child: Text(
                            'Created: ${widget.walletItem != null ? FDate.dMy(widget.walletItem.creWalletDate) : FDate.dMy(DateTime.now())}',
                            style: FTypoSkin.bodyText2.copyWith(
                                color: listTypeCardWallet
                                        .firstWhere((element) =>
                                            element.id == indexWalletColor)
                                        .tone
                                    ? FColorSkin.title
                                    : FColorSkin.grey1_background),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
        bottomNavigationBar: Container(
          padding: EdgeInsets.fromLTRB(16, 6, 16, 0),
          alignment: Alignment.topCenter,
          color: FColorSkin.transparent,
          height: 80,
          child: FFilledButton(
            size: FButtonSize.size40,
            borderRadius: BorderRadius.circular(20.0),
            onPressed: checkEmpty
                ? null
                : () {
                    final id = widget.walletItem != null
                        ? widget.walletItem.iD
                        : uuid.v4();
                    walletController.addWallet(
                      id,
                      nameWalletController.text.trim(),
                      listTypeCardWallet
                          .firstWhere(
                              (element) => element.id == indexWalletColor)
                          .img,
                    );
                  },
            backgroundColor:
                checkEmpty ? FColorSkin.disableBackground : FColorSkin.title,
            child: Container(
              alignment: Alignment.center,
              child: Text(
                'Save',
                style: FTextStyle.regular14_22
                    .copyWith(color: FColorSkin.grey1_background),
              ),
            ),
          ),
        ),
      ),
    );
  }

  bool get checkEmpty {
    return nameWalletController.text.isEmpty ||
        nameWalletController.text.trim() == '';
  }
}
