import 'dart:async';
import 'dart:io';

import 'package:coresystem/Components/base_component.dart';
import 'package:coresystem/Project/VNPost/CommonDA.dart';
import 'package:coresystem/Project/VNPost/Module/User/DA/UserDA.dart';
import 'package:coresystem/Core/routes.dart';
import 'package:coresystem/Project/VNPost/Contains/skin/skin_route.dart';
import 'package:coresystem/Project/VNPost/Module/User/Model/user_info.dart';
import 'package:coresystem/Project/VNPost/Module/User/Views/ForgotPassword/ForgotWithEmail/forgot_with_email.dart';
import 'package:coresystem/Project/VNPost/Module/User/Views/ForgotPassword/ForgotWithPhone/forgot_with_phone.dart';
import 'package:coresystem/Project/VNPost/Module/User/Views/sign_up.dart';
import 'package:coresystem/Project/VNPost/Contains/constants.dart';
import 'package:coresystem/Project/VNPost/Contains/skin/color_skin.dart';
import 'package:coresystem/Utils/parseJwt.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../../Components/widgets/SnackBar.dart';
import '../../../../../Core/userService.dart';

class Login extends StatefulWidget {
  final int type;

  Login({Key key, this.type = 0}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final userController = TextEditingController();
  final passController = TextEditingController();

  final formKey = GlobalKey<FFormState>();

  bool hasInteracted = false;
  bool hasVisible = true;
  bool isLoading = false;
  // bool _selected = UserService.userInfo.remember;
  // File _imagesFile;

  @override
  void initState() {
    if (widget.type == 1) {
      Timer(Duration(milliseconds: 0), () async {
        await popupWithStatus(
          context,
          backGroundAvatar: FColorSkin.transparent,
          typePopup: TypePopup.success,
          textTitle: 'Đăng ký thành công',
          childSubtitle: Text(
            'Vui lòng đăng nhập bằng tài khoản bạn vừa đăng ký.',
            style:
                FTextStyle.regular14_22.copyWith(color: FColorSkin.primaryText),
            textAlign: TextAlign.center,
          ),
          onlyOneButton: true,
          backGroundAction: FColorSkin.successPrimary,
          textAction: 'Tôi đã hiểu',
          action: () {
            CoreRoutes.instance.pop();
          },
        );
      });
    } else if (widget.type == 2) {
      Timer(Duration(milliseconds: 0), () async {
        await popupWithStatus(
          context,
          backGroundAvatar: FColorSkin.transparent,
          typePopup: TypePopup.success,
          textTitle: 'Đổi mật khẩu thành công',
          childSubtitle: Text(
            'Vui lòng đăng nhập bằng mật khẩu mới',
            style:
                FTextStyle.regular14_22.copyWith(color: FColorSkin.primaryText),
            textAlign: TextAlign.center,
          ),
          onlyOneButton: true,
          backGroundAction: FColorSkin.successPrimary,
          textAction: 'Tôi đã hiểu',
          action: () {
            CoreRoutes.instance.pop();
          },
        );
      });
    }
    super.initState();
    if (UserService.getUserName() != null) {
      userController.text = UserService.getUserName();
    }
  }

  @override
  Widget build(BuildContext context) {
    // isLoading = false;
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: FColorSkin.grey1_background,
        body: SafeArea(
          child: SingleChildScrollView(
            padding: EdgeInsets.all(24.0),
            child: FForm(
              key: formKey,
              autovalidateMode: hasInteracted
                  ? AutovalidateMode.onUserInteraction
                  : AutovalidateMode.disabled,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: 100,
                  ),
                  Container(
                    padding: EdgeInsets.only(bottom: 32),
                    child: Column(
                      children: [
                        Text(
                          'Đăng ký',
                          style: FTypoSkin.title2
                              .copyWith(color: FColorSkin.title),
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              child: Text(
                                'Chưa có tài khoản?',
                                style: FTypoSkin.bodyText2
                                    .copyWith(color: FColorSkin.title),
                              ),
                            ),
                            FTextButton(
                              size: FButtonSize.size24,
                              child: Text(
                                'Đăng ký ngay',
                                style: FTextStyle.regular14_22
                                    .copyWith(color: FColorSkin.infoPrimary),
                              ),
                              onPressed: () {
                                CoreRoutes.instance
                                    .navigatorPushRoutes(SignUp());
                              },
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                  FTextFormField(
                    borderColor: FColorSkin.grey3_background,
                    labelText: 'Số điện thoại/Email',
                    focusColor: FColorSkin.infoPrimary,
                    size: FInputSize.size64,
                    onChanged: (vl) {
                      setState(() {});
                    },
                    controller: userController,
                    clearIcon: userController.text.isEmpty
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
                              setState(userController.clear);
                            }),
                    validator: _UserValidate,
                    maxLine: 1,
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
                      controller: passController,
                      clearIcon: passController.text.isEmpty
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
                                setState(passController.clear);
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
                  Container(
                    padding: EdgeInsets.only(top: 8, bottom: 32),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        FFilledButton(
                          backgroundColor: FColorSkin.transparent,
                          size: FButtonSize.size24,
                          onPressed: _ForgetPass,
                          child: Text(
                            'Quên mật khẩu',
                            style: FTextStyle.regular14_22
                                .copyWith(color: FColorSkin.infoPrimary),
                          ),
                        )
                      ],
                    ),
                  ),
                  FFilledButton(
                    size: FButtonSize.size40,
                    isLoading: isLoading,
                    onPressed: () {
                      _login();
                    },
                    backgroundColor: FColorSkin.primaryColor,
                    child: Container(
                      alignment: Alignment.center,
                      child: Text(
                        'Đăng nhập',
                        style: FTextStyle.regular14_22
                            .copyWith(color: FColorSkin.grey1_background),
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(top: 49, bottom: 9),
                    child: Text(
                      'Hoặc đăng nhập với',
                      style: FTypoSkin.label4
                          .copyWith(color: FColorSkin.primaryText),
                    ),
                  ),
                  FFilledButton(
                    size: FButtonSize.size40,
                    onPressed: () {},
                    backgroundColor: FColorSkin.secondaryColor1TagBackground,
                    child: Container(
                      width: 150,
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SvgPicture.asset(
                            StringIcon.post_id,
                            color: FColorSkin.secondaryColor1,
                          ),
                          SizedBox(
                            width: 4,
                          ),
                          Text(
                            'POST ID',
                            style: FTextStyle.regular14_22
                                .copyWith(color: FColorSkin.secondaryColor1),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future _login() async {
    FocusScope.of(context).unfocus();
    if (!hasInteracted) {
      setState(() {
        hasInteracted = true;
      });
    }
    if (!formKey.currentState.validate()) {
      return;
    }
    setState(() {
      isLoading = true;
    });
    final data = await UserDA.login(userController.text, passController.text);
    if (data.code == 200) {
      try {
        if (data.data.accessToken == null || data.data.accessToken == '') {
          await SnackBarCore.fail(title: data.data.message, isBottom: true);
        } else {
          final user = await parseJwt(data.data.accessToken);
          user.token = data.data.accessToken;
          setState(() {
            isLoading = false;
          });
          UserService.setUser(user, userController.text);
          await CoreRoutes.instance
              .navigateAndRemove(CoreRouteNames.PAGE_INDEX);
        }
      } catch (e) {
        await SnackBarCore.fail(title: e.toString(), isBottom: true);
      }
    } else {
      setState(() {
        isLoading = false;
      });
    }
    return;
  }

  int typeId = 0;

  Future _ForgetPass() {
    // CoreRoutes.instance.navigatorPushDownToUp(ForgotPassword());
    return showModalBottomSheet(
      elevation: 0,
      enableDrag: true,
      isDismissible: true,
      isScrollControlled: true,
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(12),
          topRight: Radius.circular(12),
        ),
      ),
      builder: (context) => Container(
        height: 56.0 * 3 + 68 + 32.0,
        child: StatefulBuilder(
          builder: (context, setStatefulBuilder) {
            return Scaffold(
              backgroundColor: FColors.transparent,
              appBar: PreferredSize(
                preferredSize: Size.fromHeight(68.0 + 16),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(12),
                      topRight: Radius.circular(12),
                    ),
                    color: FColorSkin.grey1_background,
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        width: 32,
                        height: 4,
                        margin: EdgeInsets.only(top: 8),
                        decoration: BoxDecoration(
                            color: FColorSkin.grey4_background,
                            borderRadius: BorderRadius.circular(8.0)),
                      ),
                      AppBar(
                        backgroundColor: FColors.grey1,
                        centerTitle: true,
                        elevation: 0.2,
                        leading: Container(
                          child: FFilledButton.icon(
                            size: FButtonSize.size48,
                            backgroundColor: FColors.transparent,
                            child: FIcon(icon: FOutlined.close),
                            onPressed: () {
                              Navigator.pop(context);
                            },
                          ),
                        ),
                        title: Text(
                          'Chọn hình thức xác thực',
                          style: FTextStyle.semibold16_24
                              .copyWith(color: FColors.grey10),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              bottomNavigationBar: Container(
                padding: EdgeInsets.fromLTRB(16, 6, 16, 0),
                alignment: Alignment.topCenter,
                color: FColorSkin.grey1_background,
                height: 80,
                child: FFilledButton(
                  size: FButtonSize.size40,
                  onPressed: () {
                    if (typeId == 0) {
                      CoreRoutes.instance
                          .navigatorPushRoutes(ForgotWithPhone());
                    } else {
                      CoreRoutes.instance
                          .navigatorPushRoutes(ForgotWithEmail());
                    }
                  },
                  backgroundColor: FColorSkin.primaryColor,
                  child: Container(
                    alignment: Alignment.center,
                    child: Text(
                      'Xác nhận',
                      style: FTextStyle.regular14_22
                          .copyWith(color: FColorSkin.grey1_background),
                    ),
                  ),
                ),
              ),
              body: Container(
                  color: FColorSkin.grey1_background,
                  child: ListView.builder(
                      itemCount: listType.length,
                      itemBuilder: (context, i) {
                        final item = listType[i];
                        return FListTile(
                          onTap: () {
                            setStatefulBuilder(() {
                              typeId = item.id;
                            });
                          },
                          size: FListTileSize.size56,
                          title: Text(
                            item.title,
                            style: FTypoSkin.title4
                                .copyWith(color: FColorSkin.title),
                          ),
                          action: FRadio(
                              onChanged: (vl) {
                                setStatefulBuilder(() {
                                  typeId = vl;
                                });
                              },
                              value: item.id,
                              groupValue: typeId,
                              activeColor: FColorSkin.primaryColor),
                        );
                      })),
            );
          },
        ),
      ),
    );
  }

  FTextFieldStatus _UserValidate(
    String value,
  ) {
    if (value.trim().isEmpty) {
      return FTextFieldStatus(
          status: TFStatus.error, message: 'Bạn chưa nhập thông tin tài khoản');
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

  List<ForgotPassTypeItem> listType = [
    ForgotPassTypeItem(
      title: 'Xác thực qua số điện thoại',
      id: 0,
    ),
    ForgotPassTypeItem(
      title: 'Xác thực qua email',
      id: 1,
    ),
  ];
}

class ForgotPassTypeItem {
  String title;
  int id;

  ForgotPassTypeItem({this.title, this.id});
}
