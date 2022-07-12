import 'package:coresystem/Components/base_component.dart';
import 'package:coresystem/Project/2M/Contains/skin/color_skin.dart';
import 'package:coresystem/Project/2M/Module/User/Views/account_info.dart';
import 'package:coresystem/Project/2M/Screen/account_index.dart';
import 'package:coresystem/Project/2M/Screen/order_index.dart';
import 'package:coresystem/Project/2M/Screen/setting_index.dart';
import 'package:coresystem/Project/2M/Screen/support_index.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class TabNavigationItem {
  final Widget page;
  final String title;
  final Widget unActiveIcon;
  final Widget activeIcon;
  final ScrollController scrollController;

  TabNavigationItem({
    this.scrollController,
    @required this.page,
    @required this.title,
    @required this.unActiveIcon,
    @required this.activeIcon,
  });

  static Color activeColor = FColorSkin.primaryColor;
  static Color unActiveColor = FColorSkin.subtitle;

  static Widget iconActive(
    String icon,
  ) {
    return Container(
      padding: EdgeInsets.only(bottom: 5),
      child: FIcon(
        icon: icon,
        color: activeColor,
      ),
    );
  }

  static Widget iconUnActive(
    String icon,
  ) {
    return Container(
      padding: EdgeInsets.only(bottom: 5),
      child: FIcon(
        icon: icon,
        color: unActiveColor,
      ),
    );
  }

  static List<TabNavigationItem> itemNav = [
    TabNavigationItem(
      page: OrderIndex(),
      unActiveIcon: iconUnActive(
        FOutlined.box,
      ),
      activeIcon: iconActive(
        FFilled.box,
      ),
      title: 'Đơn hàng',
    ),
    TabNavigationItem(
      page: SettingIndex(),
      activeIcon: iconActive(
        FFilled.tool,
      ),
      unActiveIcon: iconUnActive(
        FOutlined.tool,
      ),
      title: 'Cấu hình',
    ),
    TabNavigationItem(
      page: Container(),
      unActiveIcon: Container(),
      activeIcon: Container(),
      title: '',
      scrollController: null,
    ),
    TabNavigationItem(
      page: SupportIndex(),
      unActiveIcon: iconUnActive(
        FOutlined.question_circle,
      ),
      activeIcon: iconActive(
        FFilled.question_circle,
      ),
      title: 'Hỗ trợ',
    ),
    TabNavigationItem(
      page: AccountIndex(),
      unActiveIcon: iconUnActive(
        FOutlined.user_1,
      ),
      activeIcon: iconActive(
        FFilled.user,
      ),
      title: 'Cá nhân',
    ),
  ];
}
