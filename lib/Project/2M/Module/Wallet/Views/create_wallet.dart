import 'package:coresystem/Components/base_component.dart';
import 'package:coresystem/Project/2M/Contains/constants.dart';
import 'package:coresystem/Project/2M/Contains/skin/color_skin.dart';
import 'package:coresystem/Project/2M/LocalDatabase/Models/wallet_item.dart';
import 'package:coresystem/Project/2M/Module/Wallet/DA/wallet_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:uuid/uuid.dart';

import '../../../../../Utils/ConvertUtils.dart';
import '../../../Contains/skin/typo_skin.dart';

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

  @override
  void initState() {
    // edit wallet
    if (widget.walletItem != null) {
      nameWalletController.text = widget.walletItem.title;
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
        backgroundColor: FColorSkin.grey3_background,
        appBar: appbarOnlyTitle(
          title: widget.walletItem != null ? 'Edit Wallet' : 'Create Wallet',
          systemUiOverlayStyle: SystemUiOverlayStyle.dark,
        ),
        body: SingleChildScrollView(
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 8.0, bottom: 8),
                child: Text(
                  "Name's wallet: ",
                  style: FTypoSkin.title3.copyWith(color: FColorSkin.title),
                ),
              ),
              FTextFormField(
                maxLine: 1,
                controller: nameWalletController,
                autoFocus: true,
                onChanged: (vl) {
                  setState(() {});
                },
                textInputAction: TextInputAction.done,
                // hintText: 'Money',
                size: FInputSize.size48,
                focusColor: FColorSkin.transparent,
                hintStyle: TextStyle(color: FColorSkin.subtitle),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  top: 16.0,
                ),
                child: Text(
                  'Preview',
                  style: FTypoSkin.title3.copyWith(color: FColorSkin.title),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: Hero(
                  tag: '${widget.indexHero}',
                  child: Stack(
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
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            FIcon(
                              icon: FFilled.gold_coin,
                              size: 20,
                              color: FColorSkin.grey1_background,
                            ),
                            Text(
                              nameWalletController.text,
                              style: FTypoSkin.bodyText2
                                  .copyWith(color: FColorSkin.grey1_background),
                            ),
                            Text(
                              widget.walletItem != null
                                  ? '${widget.walletItem.moneyWallet.wToMoney(0).replaceAll('.', ',')} VND'
                                  : '0 VND',
                              style: FTypoSkin.title2
                                  .copyWith(color: FColorSkin.grey1_background),
                            ),
                          ],
                        ),
                      ),
                      Positioned(
                        bottom: 30.0,
                        right: 16.0,
                        child: Text(
                          'Created: ${widget.walletItem != null ? FDate.dMy(widget.walletItem.creWalletDate) : FDate.dMy(DateTime.now())}',
                          style: FTypoSkin.bodyText2
                              .copyWith(color: FColorSkin.grey1_background),
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
            onPressed: checkEmpty
                ? null
                : () {
                    final id = widget.walletItem != null
                        ? widget.walletItem.iD
                        : Uuid().v1();
                    walletController.addWallet(
                      id,
                      nameWalletController.text.trim(),
                    );
                  },
            backgroundColor: checkEmpty
                ? FColorSkin.disableBackground
                : FColorSkin.primaryColor,
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
