import 'dart:math';

import 'package:coresystem/Components/base_component.dart';
import 'package:coresystem/Components/widgets/SnackBar.dart';
import 'package:coresystem/Components/widgets/form.dart';
import 'package:coresystem/Core/routes.dart';
import 'package:coresystem/Project/VNPost/Contains/textform_with_example.dart';
import 'package:coresystem/Project/VNPost/Contains/constants.dart';
import 'package:coresystem/Project/VNPost/Contains/skin/color_skin.dart';
import 'package:coresystem/Project/VNPost/Contains/skin/skin_route.dart';
import 'package:coresystem/Project/VNPost/Module/User/Model/LocationItem.dart';
import 'package:coresystem/Project/VNPost/Module/User/Model/registerItem.dart';
import 'package:coresystem/Project/VNPost/Module/User/Views/confirm_signup.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../../../Utils/Validate.dart';
import '../../../CommonDA.dart';
import '../../../Model/DrodownItem.dart';
import '../DA/UserDA.dart';
import 'login.dart';

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
  final rePasswordController = TextEditingController();

  final formKey = GlobalKey<FFormState>();
  // LocationItem agenData = LocationItem();
  // LocationItem placeOfIssueData = LocationItem();
  List<LocationItem> unit = [];
  String wardscode;
  String districtcode;
  String citycode;
  bool hasInteracted = false;
  bool hasVisible = true;
  bool hasVisible2 = true;
  bool isLoading = false;

  @override
  void initState() {
    // agenData.value = agencyTypeList.first.value;
    super.initState();
    getData();
  }

  Future<void> getData() async {
    final data = await CommonDA.GetUnit();
    if (data.code == 200) {
      unit = data.data;
      setState(() {});
    }
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
      action: () {
        CoreRoutes.instance.navigateAndRemoveDownToUp(Login());
      },
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
                                'Bạn đã có tài khoản?',
                                style: FTypoSkin.bodyText2
                                    .copyWith(color: FColorSkin.title),
                              ),
                            ),
                            FTextButton(
                              size: FButtonSize.size24,
                              child: Text(
                                'Đăng nhập',
                                style: FTextStyle.regular14_22
                                    .copyWith(color: FColorSkin.infoPrimary),
                              ),
                              onPressed: () {
                                _ConfirmCancel();
                              },
                            )
                          ],
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
                  TextFormWithExample(
                    titleTextForm: 'Địa chỉ chi tiết',
                    important: false,
                    controller: addressController,
                    onSubmit: (value) async {
                      final result = await UserDA.addresssearch(value);
                      if (result.code == 200) {
                        setState(() {
                          wardscode = result.data[0].code;
                          provinceController.text = result.data[0].code;
                          districtcode = result.data[0].distCode;
                          districtController.text = result.data[0].distName;
                          citycode = result.data[0].provCode;
                          cityController.text = result.data[0].provName;
                        });
                      }
                    },
                    onChange: (vl) {
                      // setState(() {});
                    },
                    example: 'Vd: Hà nội',
                    fTextFieldStatus: (value) {
                      if (value.trim().length > 300) {
                        return FTextFieldStatus(
                            status: TFStatus.error,
                            message: 'Độ dài địa chỉ phải nhỏ hơn 300 ký tự');
                      } else {
                        return FTextFieldStatus(
                            status: TFStatus.normal, message: null);
                      }
                    },
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 20),
                    child: FTextFormField(
                      borderColor: FColorSkin.grey3_background,
                      focusColor: FColorSkin.infoPrimary,
                      labelText: 'Tỉnh/Thành phố',
                      readOnly: true,
                      size: FInputSize.size64,
                      textCapitalization: TextCapitalization.none,
                      clearIcon: FIcon(
                        icon: FOutlined.down,
                        size: 16,
                        color: FColorSkin.subtitle,
                      ),
                      onChanged: (vl) {
                        setState(() {});
                      },
                      controller: cityController,
                      maxLine: 1,
                      onTap: () {
                        showAgencyType(
                            citycode,
                            unit
                                .where((element) => element.unitType == '1')
                                .toList(),
                            cityController,
                            'Chọn Tỉnh - Thành phố', (data) {
                          citycode = data.code;
                          cityController.text = data.name;
                        });
                      },
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 20),
                    child: FTextFormField(
                      borderColor: FColorSkin.grey3_background,
                      focusColor: FColorSkin.infoPrimary,
                      labelText: 'Quận/Huyện',
                      readOnly: true,
                      size: FInputSize.size64,
                      textCapitalization: TextCapitalization.none,
                      clearIcon: FIcon(
                        icon: FOutlined.down,
                        size: 16,
                        color: FColorSkin.subtitle,
                      ),
                      onChanged: (vl) {
                        setState(() {});
                      },
                      controller: districtController,
                      maxLine: 1,
                      onTap: () {
                        // showAgencyType(placeOfIssueData, placeOfIssues,
                        //     districtController, 'Chọn Quận - Huyện', (data) {
                        //   placeOfIssueData = data;
                        // });
                        showAgencyType(
                            districtcode,
                            unit
                                .where((element) =>
                                    element.unitType == '2' &&
                                    element.parentCode == citycode)
                                .toList(),
                            districtController,
                            'Chọn Quận - Huyện', (data) {
                          districtcode = data.code;
                          // cityController.text = data.name;
                        });
                      },
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 20),
                    child: FTextFormField(
                      borderColor: FColorSkin.grey3_background,
                      focusColor: FColorSkin.infoPrimary,
                      labelText: 'Phường/Xã',
                      readOnly: true,
                      size: FInputSize.size64,
                      textCapitalization: TextCapitalization.none,
                      clearIcon: FIcon(
                        icon: FOutlined.down,
                        size: 16,
                        color: FColorSkin.subtitle,
                      ),
                      onChanged: (vl) {
                        setState(() {});
                      },
                      controller: provinceController,
                      maxLine: 1,
                      onTap: () {
                        // showAgencyType(placeOfIssueData, placeOfIssues,
                        //     provinceController, 'Chọn Phường - Xã', (data) {
                        //   placeOfIssueData = data;
                        // });
                        showAgencyType(
                            wardscode,
                            unit
                                .where((element) =>
                                    element.unitType == '3' &&
                                    element.parentCode == districtcode)
                                .toList(),
                            provinceController,
                            'Chọn Quận - Huyện', (data) {
                          wardscode = data.code;
                          // cityController.text = data.name;
                        });
                      },
                    ),
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
                  Container(
                    margin: EdgeInsets.only(top: 20),
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
                            icon: hasVisible2
                                ? FFilled.eye_invisible
                                : FFilled.eye,
                            size: 16,
                            color: FColorSkin.subtitle,
                          )),
                      validator: _RePassValidate,
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
                onPressed: _signup,
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
        passwordController.text.isEmpty ||
        rePasswordController.text.isEmpty;
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
    final obj = registerItem(
      fullname: NameController.text,
      phoneNumber: phoneNumberController.text,
      email: emailController.text,
      address: addressController.text,
      password: passwordController.text,
      communeCode: wardscode,
      provinceCode: citycode,
      districtCode: districtcode,
    );
    final result = await UserDA.register(obj);
    if (result.code == 200) {
      setState(() {
        isLoading = false;
      });
      await CoreRoutes.instance.navigatorPushRoutes(ConfirmSignup(
        phoneNumber: phoneNumberController.text,
        username: result.data.username,
        email: result.data.email,
        type: 1,
      ));
    }

    setState(() {
      isLoading = false;
    });
  }

  Future showAgencyType(
      String code,
      List<LocationItem> datas,
      TextEditingController controller,
      String title,
      Function(LocationItem) callback) async {
    var moneyTemp = code == null || code == ''
        ? LocationItem()
        : datas.firstWhere((element) => element.code == (code ?? ''));

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
        height: 56.0 * 5 + 68 + 32.0,
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
                          '$title',
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
                    CoreRoutes.instance.pop();
                    callback(moneyTemp);
                    controller.text = moneyTemp?.name;
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
                child: ListView.separated(
                  itemCount: datas.length,
                  itemBuilder: (context, i) {
                    final moneyItem = datas[i];
                    return FListTile(
                      onTap: () {
                        setStatefulBuilder(() {
                          moneyTemp = moneyItem;
                        });
                      },
                      size: FListTileSize.size56,
                      title: Text(
                        '${moneyItem.name}',
                        style: FTextStyle.regular16_24
                            .copyWith(color: FColorSkin.title),
                      ),
                      action: moneyTemp?.code == moneyItem.code
                          ? FIcon(
                              icon: FOutlined.check,
                              size: 20,
                              color: FColorSkin.primaryColor,
                            )
                          : Container(),
                    );
                  },
                  separatorBuilder: (BuildContext context, int index) {
                    return Divider(
                      height: 1.0,
                      thickness: 1.0,
                      color: FColorSkin.grey3_background,
                    );
                  },
                ),
              ),
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

final agencyTypeList = [
  DropdownItem(text: 'Tổ chức', value: 'C'),
  DropdownItem(text: 'Cá nhân', value: 'I'),
];
