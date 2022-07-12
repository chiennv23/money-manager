import 'dart:io';

import 'package:coresystem/Components/base_component.dart';
import 'package:coresystem/Core/routes.dart';
import 'package:coresystem/Project/2M/Contains/constants.dart';
import 'package:coresystem/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:flutter_svg/flutter_svg.dart';

import '../../../Config/AppConfig.dart';
import '../../../Core/enum_core.dart';
import '../../../Core/userService.dart';
import '../Contains/skin/color_skin.dart';
import '../Contains/skin/typo_skin.dart';

class OrderIndex extends StatefulWidget {
  const OrderIndex({Key key}) : super(key: key);

  @override
  State<OrderIndex> createState() => _OrderIndexState();
}

class _OrderIndexState extends State<OrderIndex> {
  File _imagesFile;
  static const imgBG = StringImage.Home;

  @override
  void initState() {
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(statusBarBrightness: Brightness.dark));
    if (UserService.getAvtUsername != null) {
      _imagesFile = File(UserService.getAvtUsername);
    }
    super.initState();
  }

  // final _mainMenu1 = [
  //   {
  //     'title': 'Tạo đơn hàng',
  //     'icon': StringIcon.create_order,
  //     'route': CoreRouteNames.ACCOUNT_INFO
  //   },
  //   {
  //     'title': 'Quản lý đơn \nhàng gửi',
  //     'icon': StringIcon.search_order,
  //     'route': CoreRouteNames.ACCOUNT_INFO
  //   },
  // ];

  @override
  Widget build(BuildContext context) {
    final px = MediaQuery.of(context).size;
    final lg = S.of(context);

    return Scaffold(
      backgroundColor: FColorSkin.grey1_background,
      body: Stack(
        alignment: AlignmentDirectional.topCenter,
        children: [
          Container(
              height: px.height / 2,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: const AssetImage(
                    imgBG,
                  ),
                  fit: BoxFit.fitHeight,
                ),
              )),
          SafeArea(
            child: ListView(
              shrinkWrap: true,
              children: [
                Container(
                  padding: EdgeInsets.fromLTRB(16, 0, 8, 10),
                  child: FListTile(
                    padding: EdgeInsets.zero,
                    backgroundColor: FColorSkin.transparent,
                    avatar: Stack(
                      alignment: AlignmentDirectional.center,
                      children: [
                        FBoundingBox(
                            shape: FBoxShape.circle,
                            backgroundColor: FColorSkin.transparent,
                            size: FBoxSize.size48,
                            child: _imagesFile != null
                                ? Image.file(
                                    _imagesFile,
                                    width: 48,
                                    height: 48,
                                    fit: BoxFit.cover,
                                  )
                                : FIcon(
                                    icon: FFilled.user,
                                    color: FColorSkin.grey9_background,
                                    size: 20,
                                  )),
                        Container(
                          width: 50,
                          height: 50,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                  color: FColorSkin.grey1_background)),
                        ),
                      ],
                    ),
                    title: Text(
                      lg.hello_world,
                      style: FTypoSkin.subtitle3.copyWith(
                        color: FColorSkin.grey1_background,
                      ),
                    ),
                    subtitle: Text(
                      '/...',
                      style: FTypoSkin.title3.copyWith(
                        color: FColorSkin.grey1_background,
                      ),
                    ),
                    action: actionAppbar(context, isDark: false),
                  ),
                ),
                SizedBox(
                  height: 220,
                ),
                // Container(
                //   height: 196,
                //   padding: EdgeInsets.only(left: 16, right: 16, top: 16),
                //   child: Row(
                //     mainAxisAlignment: MainAxisAlignment.center,
                //     children: List.generate(_mainMenu1.length, (index) {
                //       final item = _mainMenu1[index];
                //       return Container(
                //         height: 166,
                //         width: px.width / 2 - 24,
                //         padding: EdgeInsets.fromLTRB(16, 24, 16, 0),
                //         margin: EdgeInsets.only(right: index == 0 ? 16 : 0),
                //         decoration: BoxDecoration(
                //             color: FColorSkin.grey1_background,
                //             border:
                //                 Border.all(color: FColorSkin.grey3_background),
                //             boxShadow: [FElevation.elevation2],
                //             borderRadius: BorderRadius.circular(8.0)),
                //         child: Column(
                //           crossAxisAlignment: CrossAxisAlignment.start,
                //           mainAxisAlignment: MainAxisAlignment.start,
                //           children: [
                //             SvgPicture.asset(item['icon']),
                //             Padding(
                //               padding: const EdgeInsets.only(top: 13.0),
                //               child: Text(
                //                 item['title'],
                //                 style: FTypoSkin.title3
                //                     .copyWith(color: FColorSkin.title),
                //               ),
                //             )
                //           ],
                //         ),
                //       );
                //     }),
                //   ),
                // ),
                // Container(
                //   padding: EdgeInsets.only(left: 16, top: 20, bottom: 16),
                //   child: Text(
                //     'Chức năng khác',
                //     style: FTypoSkin.title3.copyWith(color: FColorSkin.title),
                //   ),
                // ),
                // Container(
                //     padding: EdgeInsets.only(left: 16, right: 16),
                //     child: GridView(
                //       shrinkWrap: true,
                //       physics: NeverScrollableScrollPhysics(),
                //       gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                //           maxCrossAxisExtent: 117,
                //           crossAxisSpacing: 16,
                //           mainAxisSpacing: 16.0,
                //           mainAxisExtent: 130),
                //       children: List.generate(_mainMenu.length, (index) {
                //         final item = _mainMenu[index];
                //         return Container(
                //           width: 117,
                //           height: 130,
                //           child: Material(
                //             color: FColorSkin.transparent,
                //             borderRadius: BorderRadius.circular(8.0),
                //             child: InkWell(
                //               borderRadius: BorderRadius.circular(8.0),
                //               onTap: () {
                //                 CoreRoutes.instance
                //                     .navigateToRouteString(item['route']);
                //               },
                //               child: Column(
                //                 crossAxisAlignment: CrossAxisAlignment.center,
                //                 mainAxisAlignment: MainAxisAlignment.start,
                //                 children: [
                //                   FMediaView(
                //                     size: FBoxSize.size64,
                //                     shape: FBoxShape.circle,
                //                     backgroundColor: FColorSkin.transparent,
                //                     child: Center(
                //                         child: SvgPicture.asset(item['icon'])),
                //                   ),
                //                   SizedBox(height: 13),
                //                   Container(
                //                     height: 22 * 2.0,
                //                     child: Text(
                //                       item['title'],
                //                       style: FTypoSkin.title6
                //                           .copyWith(color: FColorSkin.title),
                //                       textAlign: TextAlign.center,
                //                       maxLines: 2,
                //                       overflow: TextOverflow.ellipsis,
                //                     ),
                //                   ),
                //                 ],
                //               ),
                //             ),
                //           ),
                //         );
                //       }),
                //     ))
              ],
            ),
          ),
        ],
      ),
    );
  }
}

Future PopupQRCode(BuildContext context) {
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
                  Text(
                    'Mã QRCode',
                    style: FTypoSkin.title3.copyWith(color: FColorSkin.title),
                  ),
                  Row(
                    children: [
                      Expanded(
                          child: FFilledButton(
                        onPressed: () {
                          CoreRoutes.instance.pop();
                        },
                        backgroundColor: FColorSkin.grey3_background,
                        size: FButtonSize.size40,
                        child: Container(
                          alignment: Alignment.center,
                          child: Text(
                            'Đóng',
                            style: FTypoSkin.buttonText2
                                .copyWith(color: FColorSkin.secondaryText),
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

Widget actionAppbar(BuildContext context, {bool isDark = true}) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      FFilledButton.icon(
        backgroundColor: FColorSkin.transparent,
        child: Container(
            // ConfigApp.langApp = 'en'
            decoration: BoxDecoration(
                color: FColorSkin.grey1_background,
                border: Border.all(
                    color: ConfigApp.langApp == 'en'
                        ? FColorSkin.grey9_background
                        : FColorSkin.grey4_background)),
            padding: EdgeInsets.fromLTRB(1, 1, 0, 0.7),
            child: SvgPicture.asset(StringIcon.eng_icon)),
        onPressed: () => EnumCore.loadingCustom(loadingEN(context)),
      ),
      FFilledButton.icon(
        backgroundColor: FColorSkin.transparent,
        child: Container(
          decoration: BoxDecoration(
              color: FColorSkin.grey1_background,
              border: Border.all(
                  color: ConfigApp.langApp != 'en'
                      ? FColorSkin.grey9_background
                      : FColorSkin.grey4_background)),
          padding: EdgeInsets.all(1),
          child: SvgPicture.asset(StringIcon.vietnam_icon),
        ),
        onPressed: () => EnumCore.loadingCustom(loadingVI(context)),
      ),
    ],
  );
}
