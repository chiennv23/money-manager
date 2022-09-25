import 'package:coresystem/Components/base_component.dart';
import 'package:coresystem/Core/routes.dart';
import 'package:coresystem/Project/2M/Contains/skin/color_skin.dart';
import 'package:coresystem/Project/2M/Contains/skin/typo_skin.dart';
import 'package:coresystem/Project/2M/Module/Category/DA/category_controller.dart';
import 'package:coresystem/Project/2M/Module/TabIndex/NavigationTabItem.dart';
import 'package:coresystem/Project/2M/Module/Money/Views/input_money.dart';
import 'package:coresystem/Utils/Ocr_scan/ocr_scan.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PageIndex extends StatefulWidget {
  final int indexTab;

  const PageIndex({
    Key key,
    this.indexTab = 0,
  }) : super(key: key);

  @override
  _PageIndexState createState() => _PageIndexState();
}

class _PageIndexState extends State<PageIndex>
    with SingleTickerProviderStateMixin {
  int currentIndex = 0;
  final CategoryController categoryController = Get.find();

  @override
  void initState() {
    currentIndex = widget.indexTab;
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
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
        height: 200 + 68 + 32.0,
        child: StatefulBuilder(
          builder: (context, setStatefulBuilder) {
            return Scaffold(
              backgroundColor: FColors.transparent,
              appBar: PreferredSize(
                preferredSize: Size.fromHeight(16),
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
                    ],
                  ),
                ),
              ),
              body: Container(
                color: FColorSkin.grey1_background,
                child: Column(
                  children: [
                    Container(
                      padding: EdgeInsets.all(16.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width / 1.8,
                            child: Text(
                              'Thêm thông tin giao dịch',
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: FTypoSkin.title1
                                  .copyWith(color: FColorSkin.title),
                            ),
                          ),
                          FTextButton(
                              child: Text(
                                'Huỷ bỏ',
                                style: FTypoSkin.bodyText1
                                    .copyWith(color: FColorSkin.subtitle),
                              ),
                              onPressed: () {
                                CoreRoutes.instance.pop();
                              })
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(left: 16.0, right: 0.0),
                      child: Row(
                        children: [
                          ...List.generate(
                            typeList.length,
                            (index) => Obx(() {
                              return Expanded(
                                child: Container(
                                  margin: EdgeInsets.only(right: 16),
                                  child: InkWell(
                                    onTap: () {
                                      categoryController
                                          .getTypeCate(typeList[index].id);
                                      CoreRoutes.instance
                                          .navigatorPushDownToUp(InputMoney(
                                        idType:
                                            categoryController.idCateType.value,
                                      ));
                                    },
                                    child: AnimatedContainer(
                                        height: 140,
                                        alignment: Alignment.center,
                                        decoration: BoxDecoration(
                                            color: categoryController
                                                        .idCateType.value ==
                                                    typeList[index].id
                                                ? FColorSkin.primaryColor
                                                : FColorSkin.title,
                                            borderRadius:
                                                BorderRadius.circular(16.0)),
                                        duration: Duration(milliseconds: 250),
                                        child: Text(
                                          typeList[index].title,
                                          style: FTypoSkin.title3.copyWith(
                                              color:
                                                  FColorSkin.grey1_background),
                                        )),
                                  ),
                                ),
                              );
                            }),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: TabNavigationItem.itemNav[currentIndex].page,
      floatingActionButton: Container(
        padding: EdgeInsets.only(top: 53),
        child: FFilledButton.icon(
            size: FButtonSize.size48,
            backgroundColor: currentIndex == 0
                ? FColorSkin.grey1_background
                : FColorSkin.primaryColor,
            onPressed: _Action,
            child: FIcon(
              icon: FOutlined.plus,
              size: 28,
              color: currentIndex == 0
                  ? FColorSkin.title
                  : FColorSkin.grey1_background,
            )),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: DecoratedBox(
        decoration: BoxDecoration(boxShadow: [FElevation.elevation2]),
        child: BottomNavigationBar(
          backgroundColor: currentIndex == 0
              ? FColorSkin.title
              : FColorSkin.grey1_background,
          currentIndex: currentIndex,
          selectedItemColor: currentIndex == 0
              ? FColorSkin.primaryColorBorderColor
              : FColorSkin.primaryColor,
          selectedFontSize: 10,
          unselectedFontSize: 10,
          elevation: 0.0,
          unselectedItemColor: currentIndex == 0
              ? FColorSkin.primaryColorBorderColor
              : FColorSkin.subtitle,
          type: BottomNavigationBarType.fixed,
          selectedLabelStyle: currentIndex == 0
              ? FTypoSkin.subtitle2
                  .copyWith(color: FColorSkin.primaryColorBorderColor)
              : FTypoSkin.subtitle2,
          unselectedLabelStyle: FTypoSkin.subtitle2,
          onTap: (int index) async {
            if (index == 2) {
              return;
            }
            setState(() {
              currentIndex = index;
            });
          },
          items: [
            for (final tabItem in TabNavigationItem.itemNav)
              BottomNavigationBarItem(
                icon: tabItem.unActiveIcon,
                activeIcon: tabItem.activeIcon,
                label: tabItem.title,
              )
          ],
        ),
      ),
    );
  }
}

final List<InputTypeItem> typeList = [
  InputTypeItem(id: 0, title: 'Chi tiêu', imgAvt: ''),
  InputTypeItem(id: 1, title: 'Thu nhập', imgAvt: ''),
];

class InputTypeItem {
  int id;
  String title, imgAvt;

  InputTypeItem({this.id, this.title, this.imgAvt});
}
