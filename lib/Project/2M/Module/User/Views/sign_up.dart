import 'dart:math';

import 'package:coresystem/Components/base_component.dart';
import 'package:coresystem/Components/widgets/SnackBar.dart';
import 'package:coresystem/Components/widgets/form.dart';
import 'package:coresystem/Core/routes.dart';
import 'package:coresystem/Project/2M/Contains/textform_with_example.dart';
import 'package:coresystem/Project/2M/Contains/constants.dart';
import 'package:coresystem/Project/2M/Contains/skin/color_skin.dart';
import 'package:coresystem/Project/2M/Contains/skin/skin_route.dart';
import 'package:coresystem/Project/2M/LocalDatabase/Models/user_info.dart';
import 'package:coresystem/Project/2M/LocalDatabase/model_lib.dart';
import 'package:coresystem/Project/2M/Module/Money/DA/money_controller.dart';
import 'package:coresystem/Project/2M/Module/User/DA/user_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:uuid/uuid.dart';

import '../../../../../Utils/Validate.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final NameController = TextEditingController();
  final phoneNumberController = TextEditingController();
  final emailController = TextEditingController();
  final addressController = TextEditingController();
  final cityController = TextEditingController();
  final districtController = TextEditingController();
  final provinceController = TextEditingController();
  final passwordController = TextEditingController();

  final formKey = GlobalKey<FFormState>();

  String wardscode;
  String districtcode;
  String citycode;
  bool hasInteracted = false;
  bool hasVisible = true;
  bool hasVisible2 = true;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
  }

  void _ConfirmCancel() {
    popupWithStatus(
      context,
      backGroundAvatar: FColorSkin.transparent,
      typePopup: TypePopup.warning,
      textTitle: 'Hủy đăng ký',
      childSubtitle: Text(
        'Thông tin đăng ký sẽ không được lưu lại khi bạn thoát ra.',
        style: FTextStyle.regular14_22.copyWith(color: FColorSkin.primaryText),
        textAlign: TextAlign.center,
      ),
      textCancel: 'Tiếp tục đăng ký',
      actionCancel: () {
        CoreRoutes.instance.pop();
      },
      backGroundAction: FColorSkin.warningPrimary,
      textAction: 'Hủy đăng ký',
      action: () {},
    );
  }

  Future popUpPhoneNumber(BuildContext context) {
    return showGeneralDialog(
      barrierLabel: 'Barrier',
      barrierDismissible: false,
      barrierColor: Colors.black.withOpacity(0.5),
      transitionDuration: Duration(milliseconds: 400),
      context: context,
      pageBuilder: (context, __, ___) {
        return StatefulBuilder(builder: (context, setState) {
          setState(() {});
          return Center(
            child: Card(
              color: FColors.grey1,
              margin: EdgeInsets.only(left: 16, right: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
              elevation: 0.0,
              child: Container(
                margin: EdgeInsets.all(24),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      padding: EdgeInsets.only(bottom: 25),
                      child: Text(
                        'Số điện thoại đã đăng ký tài khoản. Vui lòng liên hệ đơn vị quản lý hoặc tổng đài CSKH 1900545481 để được hỗ trợ.',
                        style: FTypoSkin.bodyText2
                            .copyWith(color: FColorSkin.primaryText),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Row(
                      children: [
                        Expanded(
                            child: FFilledButton(
                          onPressed: () {
                            CoreRoutes.instance.pop();
                          },
                          backgroundColor: FColorSkin.infoPrimary,
                          size: FButtonSize.size40,
                          child: Container(
                            alignment: Alignment.center,
                            child: Text(
                              'Tôi đã hiểu',
                              style: FTextStyle.regular14_22
                                  .copyWith(color: FColorSkin.grey1_background),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        )),
                      ],
                    )
                  ],
                ),
              ),
            ),
          );
        });
      },
      transitionBuilder: (_, anim, __, child) {
        return SlideTransition(
          position: Tween(begin: Offset(0, 1), end: Offset(0, 0)).animate(anim),
          child: child,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        backgroundColor: FColorSkin.grey1_background,
        appBar: appbarNoTitle(
            iconBack: FOutlined.left,
            systemUiOverlayStyle: SystemUiOverlayStyle.dark),
        body: SafeArea(
          child: SingleChildScrollView(
            padding: EdgeInsets.fromLTRB(24, 10, 24, 24),
            child: FForm(
              key: formKey,
              autovalidateMode: hasInteracted
                  ? AutovalidateMode.onUserInteraction
                  : AutovalidateMode.disabled,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: EdgeInsets.only(bottom: 15),
                    child: Column(
                      children: [
                        Text(
                          'Create money note',
                          style: FTypoSkin.title2
                              .copyWith(color: FColorSkin.title),
                        ),

                      ],
                    ),
                  ),
                  TextFormWithExample(
                    titleTextForm: 'Họ và tên',
                    controller: NameController,
                    onChange: (vl) {
                      setState(() {});
                    },
                    fTextFieldStatus: _UserValidate,
                  ),
                  TextFormWithExample(
                    titleTextForm: 'Số điện thoại',
                    important: true,
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
                  TextFormWithExample(
                    important: false,
                    titleTextForm: 'Email',
                    controller: emailController,
                    textInputType: TextInputType.emailAddress,
                    onChange: (vl) {
                      setState(() {});
                    },
                    example: 'Vd: nguyenvanthuan@gmail.com',
                    // fTextFieldStatus: _EmailValidate,
                  ),
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
                ],
              ),
            ),
          ),
        ),
        bottomNavigationBar: Container(
          padding: EdgeInsets.fromLTRB(16, 0, 16, 0),
          alignment: Alignment.topCenter,
          color: FColorSkin.grey1_background,
          height: 69,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              FFilledButton(
                size: FButtonSize.size40,
                onPressed: () async {
                  MoneyController userController = MoneyController();

                   var moneyItem = MoneyItem(
                      iD: Uuid().v1(),
                     creMoneyDate:  DateTime.now(),moneyCateType: CategoryItem(iD: Uuid().v1(),cateIcon: 'a',cateName: 'b',cateType: 'c'),
                     );
                   print(Uuid().v1());
                 await userController.addMoneyNote(moneyItem).whenComplete(SnackBarCore.success);

                  print(Uuid().v1());
                  var getAllMoneyNotes = await userController.getAllMoneyNotes();
                 print(getAllMoneyNotes);
                },
                isLoading: isLoading,
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
    );
  }

  bool get emptyImportantTF {
    return NameController.text.isEmpty ||
        phoneNumberController.text.isEmpty ||
        emailController.text.isEmpty ||
        passwordController.text.isEmpty;
  }

  Future<void> _signup() async {
    FocusScope.of(context).unfocus();
    if (!hasInteracted) {
      setState(() {
        hasInteracted = true;
      });
    }
    if (!formKey.currentState.validate()) {
      if (emptyImportantTF) {
        await SnackBarCore.fail(
            isBottom: true, title: 'Bạn cần hoàn thành các thông tin bắt buộc');
      }
      return;
    }
    setState(() {
      isLoading = true;
    });

    setState(() {
      isLoading = false;
    });
  }

  FTextFieldStatus _UserValidate(
    String value,
  ) {
    if (value.trim().isEmpty) {
      return FTextFieldStatus(
          status: TFStatus.error, message: 'Họ tên không được để trống.');
    } else if (value.trim().length > 300) {
      return FTextFieldStatus(
          status: TFStatus.error,
          message: 'Độ dài tên đại lý phải nhỏ hơn 300 ký tự');
    } else {
      return FTextFieldStatus(status: TFStatus.normal, message: null);
    }
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

  FTextFieldStatus _EmailValidate(
    String value,
  ) {
    if (value.trim().isEmpty) {
      return FTextFieldStatus(
          status: TFStatus.error, message: 'Email không được để trống.');
    } else if (!Validate.isValidEmail(value)) {
      return FTextFieldStatus(
          status: TFStatus.error, message: 'Email không đúng định dạng.');
    } else if (value.trim().length > 50) {
      return FTextFieldStatus(
          status: TFStatus.error,
          message: 'Độ dài email phải nhỏ hơn 50 ký tự');
    } else {
      return FTextFieldStatus(status: TFStatus.normal, message: null);
    }
  }
}

final agencyTypeList = [];
