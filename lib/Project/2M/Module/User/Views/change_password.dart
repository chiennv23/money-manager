import 'dart:async';

import 'package:coresystem/Components/base_component.dart';
import 'package:coresystem/Components/widgets/SnackBar.dart';
import 'package:coresystem/Components/widgets/form.dart';
import 'package:coresystem/Core/routes.dart';
import 'package:coresystem/Project/2M/Contains/constants.dart';
import 'package:coresystem/Project/2M/Contains/skin/color_skin.dart';
import 'package:coresystem/Project/2M/Module/User/DA/UserDA.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../Contains/skin/typo_skin.dart';

class ChangePassword extends StatefulWidget {
  const ChangePassword({Key key}) : super(key: key);

  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  final oldPassController = TextEditingController();
  final newPassController = TextEditingController();
  final confirmPassController = TextEditingController();

  final formKey = GlobalKey<FFormState>();
  StreamController passwordErrorController1 = StreamController<int>();
  StreamController passwordErrorController2 = StreamController<int>();
  int passwordError1 = 0; // 0: hide, 1: defaul, 2: error, 3: success
  int passwordErro2 = 0;
  bool hasInteracted = false;
  bool hasVisible = true;
  bool hasVisible2 = true;
  bool hasVisible3 = true;
  bool isLoading = false;
  bool clickNewPass = false;
  bool passErrorType1 = null;

  void _ConfirmCancel() {
    popupWithStatus(
      context,
      backGroundAvatar: FColorSkin.transparent,
      typePopup: TypePopup.error,
      textTitle: 'Bạn có chắc muốn thoát?',
      childSubtitle: Text(
        'Nếu bạn thoát bây giờ, mật khẩu mới bạn đã tạo sẽ không được lưu lại.',
        style: FTextStyle.regular14_22.copyWith(color: FColorSkin.primaryText),
        textAlign: TextAlign.center,
      ),
      textCancel: 'Ở lại',
      actionCancel: () {
        CoreRoutes.instance.pop();
      },
      backGroundAction: FColorSkin.errorPrimary,
      textAction: 'Thoát ngay',
      action: () {
        CoreRoutes.instance.pop();
        CoreRoutes.instance.pop();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Scaffold(
          backgroundColor: FColorSkin.grey3_background,
          appBar: appbarOnlyTitle(
              title: 'Đổi mật khẩu',
              systemUiOverlayStyle: SystemUiOverlayStyle.dark,
              funBack: _ConfirmCancel),
          body: SingleChildScrollView(
            padding: EdgeInsets.all(16),
            child: FForm(
              key: formKey,
              autovalidateMode: hasInteracted
                  ? AutovalidateMode.onUserInteraction
                  : AutovalidateMode.disabled,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: EdgeInsets.only(top: 16),
                    child: FTextFormField(
                      borderColor: FColorSkin.grey3_background,
                      labelText: 'Nhập mật khẩu cũ',
                      focusColor: FColorSkin.infoPrimary,
                      size: FInputSize.size64,
                      obscureText: hasVisible,
                      onChanged: (vl) {},
                      onSubmitted: (vl) {},
                      controller: oldPassController,
                      clearIcon: FFilledButton.icon(
                          backgroundColor: FColorSkin.transparent,
                          onPressed: () {
                            setState(() {
                              hasVisible = !hasVisible;
                            });
                          },
                          child: FIcon(
                            icon: hasVisible
                                ? FFilled.eye_invisible
                                : FFilled.eye,
                            size: 16,
                            color: FColorSkin.subtitle,
                          )),
                      validator: _PassValidate,
                      maxLine: 1,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 20),
                    child: FTextFormField(
                      borderColor: FColorSkin.grey3_background,
                      labelText: 'Mật khẩu mới',
                      focusColor: FColorSkin.infoPrimary,
                      size: FInputSize.size64,
                      obscureText: hasVisible2,
                      onTap: () {
                        passwordErrorController1.sink
                            .add(passwordError1 == 0 ? 1 : passwordError1);
                        passwordErrorController2.sink
                            .add(passwordErro2 == 0 ? 1 : passwordErro2);
                      },
                      onChanged: (vl) {
                        validatePassword(vl);
                      },
                      onSubmitted: (vl) {},
                      controller: newPassController,
                      clearIcon: FFilledButton.icon(
                          backgroundColor: FColorSkin.transparent,
                          onPressed: () {
                            setState(() {
                              hasVisible2 = !hasVisible2;
                            });
                          },
                          child: FIcon(
                            icon: hasVisible2
                                ? FFilled.eye_invisible
                                : FFilled.eye,
                            size: 16,
                            color: FColorSkin.subtitle,
                          )),
                      validator: _NewPassValidate,
                      maxLine: 1,
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 8,
                      ),
                      Container(
                        padding: EdgeInsets.only(
                          bottom: 0,
                        ),
                        child: StreamBuilder(
                          stream: passwordErrorController1.stream,
                          initialData: 0,
                          builder:
                              (BuildContext context, AsyncSnapshot snapshot) {
                            return snapshot.data == 0
                                ? Container()
                                : Container(
                                    child: Text(
                                      '* Mật khẩu phải bao gồm chữ hoa chữ thường, số và ký tự đặc biệt',
                                      style: FTypoSkin.subtitle3.copyWith(
                                          color: snapshot.data == 1
                                              ? FColorSkin.secondaryText
                                              : snapshot.data == 2
                                                  ? FColorSkin.errorPrimary
                                                  : FColorSkin.successPrimary),
                                    ),
                                  );
                          },
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(
                          bottom: 0,
                        ),
                        child: StreamBuilder(
                          stream: passwordErrorController2.stream,
                          initialData: 0,
                          builder:
                              (BuildContext context, AsyncSnapshot snapshot) {
                            return snapshot.data == 0
                                ? Container()
                                : Container(
                                    child: Text(
                                      '* Mật khẩu phải có độ dài từ 6 đến 50 ký tự',
                                      style: FTypoSkin.subtitle3.copyWith(
                                          color: snapshot.data == 1
                                              ? FColorSkin.secondaryText
                                              : snapshot.data == 2
                                                  ? FColorSkin.errorPrimary
                                                  : FColorSkin.successPrimary),
                                    ),
                                  );
                          },
                        ),
                      ),
                    ],
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 20),
                    child: FTextFormField(
                      borderColor: FColorSkin.grey3_background,
                      labelText: 'Nhập lại mật khẩu mới',
                      focusColor: FColorSkin.infoPrimary,
                      size: FInputSize.size64,
                      obscureText: hasVisible3,
                      onChanged: (vl) {},
                      onSubmitted: (vl) {},
                      controller: confirmPassController,
                      clearIcon: FFilledButton.icon(
                          backgroundColor: FColorSkin.transparent,
                          onPressed: () {
                            setState(() {
                              hasVisible3 = !hasVisible3;
                            });
                          },
                          child: FIcon(
                            icon: hasVisible3
                                ? FFilled.eye_invisible
                                : FFilled.eye,
                            size: 16,
                            color: FColorSkin.subtitle,
                          )),
                      validator: _ConfirmPassValidate,
                      maxLine: 1,
                    ),
                  ),
                ],
              ),
            ),
          ),
          bottomNavigationBar: Container(
            padding: EdgeInsets.fromLTRB(16, 6, 16, 0),
            alignment: Alignment.topCenter,
            color: FColorSkin.transparent,
            height: 80,
            child: FFilledButton(
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
                updatePass();
              },
              backgroundColor: FColorSkin.primaryColor,
              child: Container(
                alignment: Alignment.center,
                child: Text(
                  'Xác nhận đổi mật khẩu',
                  style: FTextStyle.regular14_22
                      .copyWith(color: FColorSkin.grey1_background),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> updatePass() async {
    setState(() {
      isLoading = true;
    });
    try {
      // final data = await UserDA.ChangePassword(oldPassController.text,
      //     newPassController.text, confirmPassController.text);
      // if (data.code == 200) {
      //   Navigator.of(context).pop();
      //   await SnackBarCore.success(title: 'Đổi mật khẩu thành công');
      // }
    } catch (e) {
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  void validatePassword(String value) {
    if (value.trim().isEmpty ||
        !value.contains(RegExp(r'[0-9]')) ||
        !value.contains(RegExp(r'[a-z]')) ||
        !value.contains(RegExp(r'[A-Z]')) ||
        !value.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) {
      passwordError1 = 2;
    } else {
      passwordError1 = 3;
    }

    if (value.trim().length < 6 || value.trim().length > 50) {
      passwordErro2 = 2;
    } else {
      passwordErro2 = 3;
    }

    passwordErrorController1.sink.add(passwordError1);
    passwordErrorController2.sink.add(passwordErro2);
  }

  FTextFieldStatus _PassValidate(
    String value,
  ) {
    if (value.trim().isEmpty) {
      return FTextFieldStatus(
          status: TFStatus.error, message: 'Bạn hãy nhập mật khẩu cũ!');
    } else {
      return FTextFieldStatus(status: TFStatus.normal, message: null);
    }
  }

  FTextFieldStatus _NewPassValidate(
    String value,
  ) {
    if (value.trim().isEmpty ||
        !value.contains(RegExp(r'[0-9]')) ||
        !value.contains(RegExp(r'[a-z]')) ||
        !value.contains(RegExp(r'[A-Z]')) ||
        !value.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]')) ||
        value.trim().length < 6 ||
        value.trim().length > 50) {
      return FTextFieldStatus(status: TFStatus.error, message: '');
    } else {
      return FTextFieldStatus(status: TFStatus.normal, message: null);
    }

    // if (value.trim().length < 6 || value.trim().length > 50) {
    //   passErrorType2 = false;
    // } else {
    //   passErrorType2 = true;
    // }

    // if (temp1 == 2 || !passErrorType2) {
    //   return FTextFieldStatus(status: TFStatus.error, message: '');
    // } else {
    //   return FTextFieldStatus(status: TFStatus.normal, message: null);
    // }

    // if (value.trim().isEmpty) {
    //   return FTextFieldStatus(
    //       status: TFStatus.error, message: 'Mật khẩu mới không được để trống');
    // } else if (value.trim().length < 6) {
    //   return FTextFieldStatus(
    //       status: TFStatus.error,
    //       message: 'Mật khẩu phải chứa tối thiểu 6 kí tự');
    // } else if (value.trim().length > 50) {
    //   return FTextFieldStatus(
    //       status: TFStatus.error,
    //       message: 'Độ dài mật khẩu phải nhỏ hơn 50 ký tự');
    // } else if (!value.contains(RegExp(r'[0-9]'))) {
    //   return FTextFieldStatus(
    //       status: TFStatus.error, message: 'Mật khẩu phải bao gồm số');
    // } else if (!value.contains(RegExp(r'[a-z]'))) {
    //   return FTextFieldStatus(
    //       status: TFStatus.error, message: 'Mật khẩu phải bao gồm chữ');
    // } else if (!value.contains(RegExp(r'[A-Z]'))) {
    //   return FTextFieldStatus(
    //       status: TFStatus.error,
    //       message: 'Mật khẩu phải bao gồm chữ viết hoa');
    // } else if (!value.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) {
    //   return FTextFieldStatus(
    //       status: TFStatus.error,
    //       message: 'Mật khẩu phải bao gồm ký tự đặc biệt');
    // } else {
    //   return FTextFieldStatus(status: TFStatus.normal, message: null);
    // }
  }

  FTextFieldStatus _ConfirmPassValidate(
    String value,
  ) {
    if (value.trim().isEmpty) {
      return FTextFieldStatus(
          status: TFStatus.error, message: 'Bạn chưa nhập lại mật khẩu mới');
    } else if (value.trim() != newPassController.text) {
      return FTextFieldStatus(
          status: TFStatus.error, message: 'Mật khẩu không chính xác');
    } else {
      return FTextFieldStatus(status: TFStatus.normal, message: null);
    }
  }
}
