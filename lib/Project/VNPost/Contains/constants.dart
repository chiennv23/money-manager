import 'package:coresystem/Components/base_component.dart';
import 'package:coresystem/Components/styles/icon_data.dart';
import 'package:coresystem/Components/styles/text_style.dart';
import 'package:coresystem/Components/widgets/SnackBar.dart';
import 'package:coresystem/Config/AppConfig.dart';
import 'package:coresystem/Core/enum_core.dart';
import 'package:coresystem/Core/routes.dart';
import 'package:coresystem/Core/storageKeys_helper.dart';
import 'package:coresystem/Project/VNPost/Contains/skin/color_skin.dart';
import 'package:coresystem/Project/VNPost/Contains/skin/typo_skin.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/svg.dart';

import '../../../main.dart';

AppBar appbarWithBottom(
    {String title,
    Widget customTitle,
    List<Widget> actions,
    String iconBack = FOutlined.close,
    double elevation = 0.0,
    VoidCallback funBack,
    PreferredSizeWidget bottom,
    SystemUiOverlayStyle systemUiOverlayStyle = SystemUiOverlayStyle.light,
    GlobalKey abKey}) {
  return AppBar(
    key: abKey,
    automaticallyImplyLeading: false,
    backgroundColor: FColorSkin.grey1_background,
    systemOverlayStyle: systemUiOverlayStyle,
    toolbarHeight: 48.0 * 2.0,
    centerTitle: true,
    actions: actions,
    title: customTitle ??
        Text(
          title,
          style: FTextStyle.semibold16_24.copyWith(color: FColorSkin.title),
        ),
    elevation: elevation,
    leading: Container(
      child: FFilledButton.icon(
        size: FButtonSize.size40,
        backgroundColor: FColorSkin.transparent,
        onPressed: funBack ?? CoreRoutes.instance.pop,
        child: FIcon(icon: iconBack, size: 25),
      ),
    ),
    bottom: bottom,
  );
}

AppBar appbarWithBottomSearch(
    {String title,
    Widget customTitle,
    String iconBack = FOutlined.close,
    double elevation = 0.0,
    VoidCallback funBack,
    VoidCallback onTapFilter,
    VoidCallback onTapClear,
    String titleFilter = 'Sắp xếp',
    TextEditingController searchController,
    ValueChanged<String> onChangeSearch,
    String hintText = 'Số điện thoại, mã đơn hàng, ...',
    List<Widget> action,
    bool noFilter = false,
    SystemUiOverlayStyle systemUiOverlayStyle = SystemUiOverlayStyle.light,
    Widget betweenBottom,
    Widget bottomWidget,
    EdgeInsets marginBottom,
    EdgeInsets marginSearch,
    Color filterTextColor = FColorSkin.secondaryText,
    Color filterBackgroundColor,
    GlobalKey abKey}) {
  return AppBar(
      key: abKey,
      automaticallyImplyLeading: false,
      centerTitle: true,
      systemOverlayStyle: systemUiOverlayStyle,
      backgroundColor: FColorSkin.grey1_background,
      toolbarHeight: 48.0 + 48.0,
      title: customTitle ??
          Text(
            title,
            style: FTextStyle.semibold16_24.copyWith(color: FColorSkin.title),
          ),
      elevation: elevation,
      leading: Container(
        child: FFilledButton.icon(
          size: FButtonSize.size40,
          backgroundColor: FColorSkin.transparent,
          onPressed: funBack ??
              () {
                CoreRoutes.instance.pop();
              },
          child: FIcon(icon: iconBack, size: 25),
        ),
      ),
      actions: action,
      bottom: PreferredSize(
        preferredSize:
            bottomWidget != null ? Size.fromHeight(56.0) : Size.fromHeight(0.0),
        child: Container(
          margin:
              marginBottom ?? EdgeInsets.only(left: 16, right: 16, bottom: 8),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              betweenBottom ?? Container(),
              Container(
                margin: marginSearch ?? EdgeInsets.zero,
                width: double.infinity,
                child: Row(
                  children: [
                    Expanded(
                      child: FTextField(
                        focusColor: FColorSkin.grey3_background,
                        borderColor: FColors.transparent,
                        controller: searchController,
                        backgroundColor: FColorSkin.grey3_background,
                        size: FInputSize.size32,
                        maxLines: 1,
                        hintText: hintText,
                        hintStyle:
                            TextStyle(fontSize: 14, color: FColorSkin.subtitle),
                        prefixIcon: FIcon(
                          icon: FOutlined.search,
                          color: FColorSkin.subtitle,
                          size: 16,
                        ),
                        clearIcon: searchController.text.isEmpty ||
                                searchController.text == ''
                            ? null
                            : FFilledButton.icon(
                                backgroundColor: FColorSkin.transparent,
                                size: FButtonSize.size32,
                                onPressed: onTapClear,
                                child: FIcon(
                                  icon: FFilled.close_circle,
                                  size: 16,
                                  color: FColorSkin.subtitle,
                                ),
                              ),
                        onChanged: onChangeSearch,
                      ),
                    ),
                    noFilter
                        ? Container()
                        : GestureDetector(
                            onTap: onTapFilter,
                            child: Container(
                                height: 32,
                                margin: EdgeInsets.only(left: 8),
                                padding: EdgeInsets.only(left: 8, right: 8),
                                decoration: BoxDecoration(
                                  color: filterBackgroundColor,
                                  borderRadius: BorderRadius.circular(8.0),
                                  border: Border.all(
                                      width: 0.5,
                                      color: FColorSkin.grey4_background),
                                ),
                                child: Row(
                                  children: [
                                    Container(
                                      padding: EdgeInsets.only(right: 6),
                                      child: Text(
                                        titleFilter,
                                        style: TextStyle(
                                            color: filterTextColor,
                                            fontSize: 14),
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 1,
                                        softWrap: true,
                                      ),
                                    ),
                                    FIcon(
                                      icon: FOutlined.filter,
                                      color: filterTextColor,
                                      size: 14,
                                    )
                                  ],
                                )),
                          ),
                  ],
                ),
              ),
              bottomWidget ?? Container()
            ],
          ),
        ),
      ));
}

AppBar appbarOnlyTitle(
    {String title,
    String iconBack = FOutlined.close,
    double elevation = 0.0,
    Color backgroundColor = FColors.grey1,
    Color titleColor = FColorSkin.title,
    SystemUiOverlayStyle systemUiOverlayStyle = SystemUiOverlayStyle.light,
    bool noBack = false,
    VoidCallback funBack,
    List<Widget> action,
    int countback = 1}) {
  return AppBar(
    centerTitle: true,
    automaticallyImplyLeading: false,
    systemOverlayStyle: systemUiOverlayStyle,
    backgroundColor: backgroundColor,
    title: Text(
      title,
      style: FTypoSkin.title3.copyWith(color: titleColor),
      maxLines: 2,
      overflow: TextOverflow.ellipsis,
      textAlign: TextAlign.center,
    ),
    elevation: elevation,
    leading: noBack
        ? Container()
        : FFilledButton.icon(
            size: FButtonSize.size40,
            backgroundColor: FColors.transparent,
            onPressed: funBack ??
                () {
                  var count = 0;
                  CoreRoutes.instance.popUntil(
                    func: (route) {
                      return count++ == countback;
                    },
                  );
                },
            child: FIcon(
              icon: iconBack,
              size: 25,
              color: titleColor,
            ),
          ),
    actions: action ??
        [
          Container(
            height: 40,
            width: 40,
          )
        ],
  );
}

AppBar appbarNoTitle(
    {bool noBack = false,
    String iconBack = FOutlined.close,
    VoidCallback actionBack,
    double toolbarHeight = 60.0,
    SystemUiOverlayStyle systemUiOverlayStyle = SystemUiOverlayStyle.light,
    List<Widget> action}) {
  return AppBar(
    automaticallyImplyLeading: false,
    backgroundColor: FColorSkin.grey1_background,
    systemOverlayStyle: systemUiOverlayStyle,
    toolbarHeight: toolbarHeight,
    elevation: 0,
    leading: noBack
        ? Container()
        : FFilledButton.icon(
            size: FButtonSize.size40,
            backgroundColor: FColorSkin.transparent,
            onPressed: actionBack ??
                () {
                  CoreRoutes.instance.pop();
                },
            child: FIcon(icon: iconBack, size: 25),
          ),
    actions: action,
  );
}

AppBar appBarForLogin(BuildContext context,
    {Function tapBack,
    String icon = FOutlined.left,
    SystemUiOverlayStyle systemUiOverlayStyle}) {
  return appbarNoTitle(
      systemUiOverlayStyle: systemUiOverlayStyle,
      actionBack: tapBack,
      iconBack: icon,
      action: [
        // FFilledButton.icon(
        //     backgroundColor: FColorSkin.transparent,
        //     child: SvgPicture.asset(StringIcon.eng_icon),
        //     onPressed: () {}),
        // FFilledButton.icon(
        //     backgroundColor: FColorSkin.transparent,
        //     child: SvgPicture.asset(StringIcon.vietnam_icon),
        //     onPressed: () async {}),
        // SizedBox(
        //   width: 12,
        // ),
      ]);
}

Future popupWithStatus(
  BuildContext context, {
  TypePopup typePopup = TypePopup.success,
  Widget childSubtitle,
  Color backGroundAvatar,
  Color backGroundAction,
  String textTitle,
  String textCancel = 'Huỷ',
  String textSubTitle,
  String textAction,
  bool onlyOneButton = false,
  bool noAvatar = false,
  bool noTitle = false,
  bool isWaiting = false,
  Function action,
  VoidCallback actionCancel,
}) {
  return showGeneralDialog(
    barrierLabel: 'Barrier',
    barrierDismissible: false,
    barrierColor: Colors.black.withOpacity(0.5),
    transitionDuration: Duration(milliseconds: 400),
    context: context,
    pageBuilder: (context, __, ___) {
      // String icon = typePopup == TypePopup.success ? StringsIconPopup.success :TypePopup.success;
      String commentMark(typePopup) {
        String icon;
        switch (typePopup) {
          case TypePopup.success:
            icon = StringIcon.success;
            break;
          case TypePopup.error:
            icon = StringIcon.error;
            break;
          case TypePopup.warning:
            icon = StringIcon.warning;
            break;
          case TypePopup.info:
            icon = StringIcon.info;
            break;
          case TypePopup.approval:
            icon = StringIcon.approval;
            break;
          case TypePopup.decline:
            icon = StringIcon.decline;
            break;
          // case TypePopup.mapPopup:
          //   icon = StringIcon.mapPopup;
          //   break;
        }
        return icon;
      }

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
                  noAvatar
                      ? Container()
                      : CircleAvatar(
                          backgroundColor:
                              backGroundAvatar ?? FColorSkin.transparent,
                          radius: 32,
                          child: SvgPicture.asset(
                            commentMark(typePopup),
                            height: 64,
                          )),
                  noTitle
                      ? Container()
                      : Container(
                          padding: EdgeInsets.only(top: 12, bottom: 4),
                          child: Text(
                            textTitle,
                            style: FTextStyle.semibold20_28
                                .copyWith(color: FColorSkin.title),
                            textAlign: TextAlign.center,
                          ),
                        ),
                  Container(
                    padding: EdgeInsets.only(bottom: 24),
                    child: childSubtitle ??
                        Text(
                          textSubTitle,
                          style: FTextStyle.regular14_22
                              .copyWith(color: FColorSkin.primaryText),
                          textAlign: TextAlign.center,
                        ),
                  ),
                  Row(
                    children: [
                      !onlyOneButton
                          ? Expanded(
                              child: FFilledButton(
                              onPressed: () {
                                if (actionCancel != null) {
                                  actionCancel();
                                } else {
                                  CoreRoutes.instance.pop();
                                }
                              },
                              backgroundColor: FColorSkin.grey3_background,
                              size: FButtonSize.size40,
                              child: Container(
                                alignment: Alignment.center,
                                child: Text(
                                  textCancel,
                                  style: FTextStyle.regular14_22.copyWith(
                                      color: FColorSkin.secondaryText),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ))
                          : Container(),
                      !onlyOneButton
                          ? SizedBox(
                              width: 8,
                            )
                          : Container(),
                      Expanded(
                          child: FFilledButton(
                        onPressed: action,
                        backgroundColor:
                            backGroundAction ?? FColorSkin.primaryColor,
                        size: FButtonSize.size40,
                        isLoading: isWaiting,
                        child: Container(
                          alignment: Alignment.center,
                          child: Text(
                            textAction,
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

class StringIcon {
  static const success = 'lib/Assets/Svg/Success.svg';
  static const error = 'lib/Assets/Svg/Error.svg';
  static const warning = 'lib/Assets/Svg/Warning.svg';
  static const info = 'lib/Assets/Svg/Info.svg';
  static const approval = 'lib/Assets/Svg/Approval.svg';
  static const decline = 'lib/Assets/Svg/Decline.svg';
  static const create_success = 'lib/Assets/Svg/CreateSuccess.svg';
  static const customer = 'lib/Assets/Svg/customer.svg';
  static const list_file = 'lib/Assets/Svg/storDepot.svg';
  static const qr_code = 'lib/Assets/Svg/qrCode.svg';
  static const search = 'lib/Assets/Svg/search.svg';
  static const approval_file = 'lib/Assets/Svg/approved.svg';
  static const empty = 'lib/Assets/Svg/empty.svg';
  static const success_transaction = 'lib/Assets/Svg/shakeHand.svg';
  static const fail_transaction = 'lib/Assets/Svg/failTransaction.svg';
  static const dien_luc = 'lib/Assets/Svg/dienLuc.svg';
  static const nuoc_sach = 'lib/Assets/Svg/nuocSach.svg';
  static const truyen_hinh = 'lib/Assets/Svg/truyenHinh.svg';
  static const internet = 'lib/Assets/Svg/interNet.svg';
  static const vay_tieu_dung = 'lib/Assets/Svg/vayTieuDung.svg';
  static const vnpt = 'lib/Assets/Svg/vnpt.svg';
  static const cuoc_dt_tra_sau_dt_co_dinh = 'lib/Assets/Svg/cuocDtTraSauDtCoDinh.svg';
  static const create_order = 'lib/Assets/Svg/createOrder.svg';
  static const search_order = 'lib/Assets/Svg/searchOrder.svg';
  static const post_id = 'lib/Assets/Svg/PostID.svg';
}

class StringImage {
  static const Home = 'lib/Assets/Images/home.png';
  static const on_boarding = 'lib/Assets/Images/Onboarding.png';
}

enum TypePopup { success, warning, error, info, approval, decline, mapPopup }
