import 'package:coresystem/Components/base_component.dart';
import 'package:coresystem/Project/VNPost/Contains/constants.dart';
import 'package:coresystem/Project/VNPost/Contains/skin/color_skin.dart';
import 'package:coresystem/Project/VNPost/Contains/skin/skin_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../../../../../Core/routes.dart';
import '../../../../../Contains/textform_with_example.dart';
import '../input_new_pass.dart';

class ForgotWithPhone extends StatefulWidget {
  const ForgotWithPhone({Key key}) : super(key: key);

  @override
  State<ForgotWithPhone> createState() => _ForgotWithPhoneState();
}

class _ForgotWithPhoneState extends State<ForgotWithPhone> {
  final phoneNumberController = TextEditingController();
  bool isLoading = false;

  final formKey = GlobalKey<FFormState>();
  bool hasInteracted = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: FColorSkin.grey1_background,
        appBar: appbarNoTitle(
            systemUiOverlayStyle: SystemUiOverlayStyle.dark,
            iconBack: FOutlined.left),
        body: SingleChildScrollView(
          padding: EdgeInsets.all(16.0),
          child: FForm(
            key: formKey,
            autovalidateMode: hasInteracted
                ? AutovalidateMode.onUserInteraction
                : AutovalidateMode.disabled,
            child: Column(
              children: [
                FListTile(
                    size: FListTileSize.size64,
                    title: Text(
                      'Nhập số điện thoại của bạn',
                      style: FTypoSkin.title2.copyWith(color: FColorSkin.title),
                    )),
                Container(
                  padding: EdgeInsets.only(top: 16, bottom: 32),
                  child: TextFormWithExample(
                    titleTextForm: 'Số điện thoại',
                    important: false,
                    controller: phoneNumberController,
                    textInputType: TextInputType.number,
                    onChange: (vl) {
                      setState(() {});
                    },
                    example: 'Vd: 099 499 1497',
                    fTextFieldStatus: (value) {
                      if (value.trim().length != 10) {
                        return FTextFieldStatus(
                            status: TFStatus.error,
                            message: 'Số điện thoại không đúng định dạng');
                      } else if (!value.trim().startsWith('0')) {
                        return FTextFieldStatus(
                            status: TFStatus.error,
                            message: 'Số điện thoại nên bắt đầu là 0xxxxxxxxx');
                      } else {
                        return FTextFieldStatus(
                            status: TFStatus.normal, message: null);
                      }
                    },
                  ),
                ),
                FFilledButton(
                  size: FButtonSize.size40,
                  isLoading: isLoading,
                  onPressed: () {
                    FocusScope.of(context).unfocus();
                    if (!hasInteracted) {
                      setState(() {
                        hasInteracted = true;
                      });
                    }
                    if (!formKey.currentState.validate()) {
                      return;
                    }
                    CoreRoutes.instance.navigatorPushRoutes(InputNewPassword(
                      type: 0,
                      keyCheck: phoneNumberController.text,
                    ));
                  },
                  backgroundColor: FColorSkin.primaryColor,
                  child: Container(
                    alignment: Alignment.center,
                    child: Text(
                      'Tiếp tục',
                      style: FTextStyle.regular14_22
                          .copyWith(color: FColorSkin.grey1_background),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
