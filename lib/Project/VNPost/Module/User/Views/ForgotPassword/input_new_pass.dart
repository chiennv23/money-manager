import 'package:coresystem/Core/routes.dart';
import 'package:coresystem/Project/VNPost/Module/User/Views/ForgotPassword/ForgotWithEmail/forgot_pass_confirm_email.dart';
import 'package:coresystem/Project/VNPost/Module/User/Views/ForgotPassword/ForgotWithPhone/forgot_pass_confirm_phone.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../../../../Components/base_component.dart';
import '../../../../Contains/constants.dart';
import '../../../../Contains/skin/color_skin.dart';
import '../../../../Contains/skin/typo_skin.dart';

class InputNewPassword extends StatefulWidget {
  final String keyCheck;
  final int type;

  const InputNewPassword(
      {Key key, @required this.type, @required this.keyCheck})
      : super(key: key);

  @override
  State<InputNewPassword> createState() => _InputNewPasswordState();
}

class _InputNewPasswordState extends State<InputNewPassword> {
  final passwordController = TextEditingController();
  final rePasswordController = TextEditingController();

  bool hasVisible = true;
  bool hasVisible2 = true;
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
                      'Nhập mật khẩu mới',
                      style: FTypoSkin.title2.copyWith(color: FColorSkin.title),
                    )),
                Container(
                  margin: EdgeInsets.only(top: 20),
                  child: FTextFormField(
                    borderColor: FColorSkin.grey3_background,
                    labelText: 'Mật khẩu',
                    focusColor: FColorSkin.infoPrimary,
                    size: FInputSize.size64,
                    obscureText: hasVisible,
                    onChanged: (vl) {
                      setState(() {});
                    },
                    onSubmitted: (vl) {},
                    labelImportant: true,
                    controller: passwordController,
                    clearIcon: passwordController.text.isEmpty
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
                              setState(passwordController.clear);
                            }),
                    suffixIcon: FFilledButton.icon(
                        backgroundColor: FColorSkin.transparent,
                        onPressed: () {
                          setState(() {
                            hasVisible = !hasVisible;
                          });
                        },
                        child: FIcon(
                          icon:
                              hasVisible ? FFilled.eye_invisible : FFilled.eye,
                          size: 16,
                          color: FColorSkin.subtitle,
                        )),
                    validator: _PassValidate,
                    maxLine: 1,
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 20, bottom: 32),
                  child: FTextFormField(
                    borderColor: FColorSkin.grey3_background,
                    labelText: 'Nhập lại mật khẩu',
                    labelImportant: true,
                    focusColor: FColorSkin.infoPrimary,
                    size: FInputSize.size64,
                    obscureText: hasVisible2,
                    onChanged: (vl) {
                      setState(() {});
                    },
                    onSubmitted: (vl) {},
                    controller: rePasswordController,
                    clearIcon: rePasswordController.text.isEmpty
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
                              setState(rePasswordController.clear);
                            }),
                    suffixIcon: FFilledButton.icon(
                        backgroundColor: FColorSkin.transparent,
                        onPressed: () {
                          setState(() {
                            hasVisible2 = !hasVisible2;
                          });
                        },
                        child: FIcon(
                          icon:
                              hasVisible2 ? FFilled.eye_invisible : FFilled.eye,
                          size: 16,
                          color: FColorSkin.subtitle,
                        )),
                    validator: _RePassValidate,
                    maxLine: 1,
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
                    if (widget.type == 0) {
                      CoreRoutes.instance
                          .navigatorPushRoutes(ForgotPConfirmPhone(
                        phoneNumber: widget.keyCheck,
                      ));
                    } else {
                      CoreRoutes.instance
                          .navigatorPushRoutes(ForgotPConfirmEmail(
                        email: widget.keyCheck,
                      ));
                    }
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

  FTextFieldStatus _PassValidate(
    String value,
  ) {
    if (value.trim().isEmpty) {
      return FTextFieldStatus(
          status: TFStatus.error, message: 'Mật khẩu không được để trống.');
    } else {
      return FTextFieldStatus(status: TFStatus.normal, message: null);
    }
  }

  FTextFieldStatus _RePassValidate(
    String value,
  ) {
    if (value.trim().isEmpty) {
      return FTextFieldStatus(
          status: TFStatus.error, message: 'Mật khẩu không được để trống.');
    } else if (value.trim() != passwordController.text) {
      return FTextFieldStatus(
          status: TFStatus.error, message: 'Mật khẩu không chính xác');
    } else {
      return FTextFieldStatus(status: TFStatus.normal, message: null);
    }
  }
}
