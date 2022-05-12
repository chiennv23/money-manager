import 'package:coresystem/Components/base_component.dart';
import 'package:coresystem/Core/routes.dart';
import 'package:coresystem/Project/VNPost/Contains/constants.dart';
import 'package:coresystem/Project/VNPost/Contains/skin/color_skin.dart';
import 'package:coresystem/Project/VNPost/Contains/skin/skin_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../Model/DrodownItem.dart';

class NotificationIndex extends StatefulWidget {
  const NotificationIndex({Key key}) : super(key: key);

  @override
  State<NotificationIndex> createState() => _NotificationIndexState();
}

class _NotificationIndexState extends State<NotificationIndex> {
  static List<DropdownItem> filterList = [
    DropdownItem(text: 'Tất cả', value: '0'),
    DropdownItem(text: 'Trạng thái đơn hàng', value: '1'),
    DropdownItem(text: 'Chuyển tiếp, phát hoàn', value: '2'),
    DropdownItem(text: 'Yêu cầu hiệu chỉnh', value: '3'),
    DropdownItem(text: 'Yêu cầu hỗ trợ', value: '4'),
    DropdownItem(text: 'Thông báo chung', value: '5'),
  ];
  static List<DropdownItem> actionList = [
    DropdownItem(text: 'Đánh dấu tất cả đã đọc', value: '0'),
    DropdownItem(text: 'Xóa thông báo đã đọc', value: '1'),
    DropdownItem(text: 'Xóa tất cả thông báo', value: '2'),
  ];

  String filterTitle = filterList.first.text;
  String action = actionList.first.value;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: FColorSkin.grey1_background,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(48.0 + 54),
        child: Container(
          decoration: BoxDecoration(boxShadow: [FElevation.elevation2]),
          child: appbarWithBottom(
              title: 'Thông báo',
              iconBack: FOutlined.left,
              systemUiOverlayStyle: SystemUiOverlayStyle.dark,
              actions: [
                FFilledButton.icon(
                    backgroundColor: FColorSkin.transparent,
                    onPressed: _Action,
                    child: FIcon(
                      icon: FOutlined.ellipsis,
                      size: 24,
                      color: FColorSkin.title,
                    )),
                SizedBox(
                  width: 8,
                ),
              ],
              bottom: PreferredSize(
                preferredSize: Size.fromHeight(0),
                child: Container(
                  padding: EdgeInsets.only(
                    bottom: 10.0,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      FFilledButton(
                          backgroundColor: FColorSkin.transparent,
                          onPressed: _filter,
                          child: Row(
                            children: [
                              Text(
                                filterTitle,
                                style: FTypoSkin.buttonText2
                                    .copyWith(color: FColorSkin.infoPrimary),
                              ),
                              SizedBox(
                                width: 4,
                              ),
                              FIcon(
                                icon: FOutlined.down,
                                size: 16,
                                color: FColorSkin.infoPrimary,
                              ),
                            ],
                          ))
                    ],
                  ),
                ),
              )),
        ),
      ),
      body: ListView.builder(
          itemCount: 10,
          padding: EdgeInsets.only(top: 16.0, bottom: 16.0),
          itemBuilder: (context, index) {
            return notifyCard();
          }),
    );
  }

  Widget notifyCard({bool isChecked = false}) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      decoration: BoxDecoration(
          color: FColorSkin.grey1_background,
          border:
              Border(bottom: BorderSide(color: FColorSkin.grey3_background))),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.only(right: 12),
            child: FBoundingBox(
                backgroundColor: isChecked
                    ? FColorSkin.grey3_background
                    : FColorSkin.secondaryColor3TagBackground,
                shape: FBoxShape.circle,
                size: FBoxSize.size32,
                child: FIcon(
                  icon: FFilled.shopping,
                  size: 20,
                  color: isChecked
                      ? FColorSkin.subtitle
                      : FColorSkin.secondaryColor3,
                )),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Tiêu đề thông báo',
                  style: FTypoSkin.title3.copyWith(
                      color: isChecked
                          ? FColorSkin.secondaryText
                          : FColorSkin.title),
                ),
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.only(top: 4, bottom: 8),
                        child: Text(
                          'Nội dung thông báo: is simply dummy text of the printing and typesettingông báo: is simply dummy text of the printing and typesetting industry.',
                          style: FTypoSkin.bodyText2.copyWith(
                              color: isChecked
                                  ? FColorSkin.subtitle
                                  : FColorSkin.primaryText),
                          maxLines: 10,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 4,
                    ),
                    isChecked
                        ? FBoundingBox(
                            backgroundColor: FColorSkin.transparent,
                            size: FBoxSize.size8,
                            shape: FBoxShape.circle,
                          )
                        : FBoundingBox(
                            backgroundColor: FColorSkin.errorPrimary,
                            size: FBoxSize.size8,
                            shape: FBoxShape.circle,
                          )
                  ],
                ),
                Text(
                  '5 giờ trước',
                  style:
                      FTypoSkin.subtitle3.copyWith(color: FColorSkin.subtitle),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future _filter() {
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
        height: 56.0 * filterList.length + 68 + 32.0,
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
                          'Hiển thị thông báo',
                          style: FTextStyle.semibold16_24
                              .copyWith(color: FColors.grey10),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              body: Container(
                color: FColorSkin.grey1_background,
                child: Column(
                  children: List.generate(filterList.length, (index) {
                    final item = filterList[index];
                    return FListTile(
                      border: index == filterList.length - 1
                          ? null
                          : Border(
                              bottom: BorderSide(
                                  color: FColorSkin.grey3_background)),
                      onTap: () {
                        CoreRoutes.instance.pop();
                        setStatefulBuilder(() {
                          filterTitle = item.text;
                        });
                        setState(() {});
                      },
                      size: FListTileSize.size56,
                      title: Text(
                        item.text,
                        style: FTypoSkin.buttonText2
                            .copyWith(color: FColorSkin.primaryText),
                      ),
                      action: item.text == filterTitle
                          ? FIcon(
                              icon: FFilled.check_circle,
                              size: 20,
                              color: FColorSkin.primaryColor,
                            )
                          : Container(),
                    );
                  }),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Future _Action() {
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
        height: 56.0 * actionList.length + 68 + 32.0,
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
                          'Hành động',
                          style: FTextStyle.semibold16_24
                              .copyWith(color: FColors.grey10),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              body: Container(
                color: FColorSkin.grey1_background,
                child: Column(
                  children: List.generate(actionList.length, (index) {
                    final item = actionList[index];
                    return FListTile(
                      border: index == actionList.length - 1
                          ? null
                          : Border(
                              bottom: BorderSide(
                                  color: FColorSkin.grey3_background)),
                      onTap: () {
                        CoreRoutes.instance.pop();
                        setStatefulBuilder(() {
                          action = item.text;
                        });
                        if (index == actionList.length - 1) {
                          _ConfirmDelAll();
                        }
                        setState(() {});
                      },
                      size: FListTileSize.size56,
                      title: Text(
                        item.text,
                        style: FTypoSkin.buttonText2.copyWith(
                            color: index == actionList.length - 1
                                ? FColorSkin.errorPrimary
                                : FColorSkin.primaryText),
                      ),
                    );
                  }),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  void _ConfirmDelAll() {
    popupWithStatus(
      context,
      backGroundAvatar: FColorSkin.transparent,
      typePopup: TypePopup.error,
      textTitle: 'Xóa tất cả thông báo',
      childSubtitle: Text(
        'Tất cả thông báo sẽ bị xóa',
        style: FTextStyle.regular14_22.copyWith(color: FColorSkin.primaryText),
        textAlign: TextAlign.center,
      ),
      textCancel: 'Hủy',
      actionCancel: () {
        CoreRoutes.instance.pop();
      },
      backGroundAction: FColorSkin.errorPrimary,
      textAction: 'Xóa tất cả',
      action: () {},
    );
  }
}
