import 'package:coresystem/Components/base_component.dart';
import 'package:coresystem/Core/routes.dart';
import 'package:coresystem/Project/VNPost/Contains/constants.dart';
import 'package:coresystem/Project/VNPost/Contains/skin/color_skin.dart';
import 'package:coresystem/Project/VNPost/Contains/skin/skin_route.dart';
import 'package:coresystem/Project/VNPost/Module/User/Views/ForgotPassword/input_new_pass.dart';
import 'package:coresystem/Utils/Validate.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../../../Contains/textform_with_example.dart';

class ForgotWithEmail extends StatefulWidget {
  const ForgotWithEmail({Key key}) : super(key: key);

  @override
  State<ForgotWithEmail> createState() => _ForgotWithEmailState();
}

class _ForgotWithEmailState extends State<ForgotWithEmail> {
  final emailController = TextEditingController();
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
                      'Nhập email của bạn',
                      style: FTypoSkin.title2.copyWith(color: FColorSkin.title),
                    )),
                Container(
                  padding: EdgeInsets.only(top: 16, bottom: 32),
                  child: TextFormWithExample(
                    important: false,
                    titleTextForm: 'Email',
                    controller: emailController,
                    fTextFieldStatus: _EmailValidate,
                    textInputType: TextInputType.emailAddress,
                    onChange: (vl) {
                      setState(() {});
                    },
                    example: 'Vd: nguyenvanthuan@gmail.com',
                    // fTextFieldStatus: _EmailValidate,
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
                      type: 1,
                      keyCheck: emailController.text,
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
