import 'package:coresystem/Components/base_component.dart';
import 'package:coresystem/Project/2M/Contains/skin/color_skin.dart';
import 'package:coresystem/Project/2M/Contains/skin/typo_skin.dart';
import 'package:coresystem/Project/2M/Module/TabIndex/NavigationTabItem.dart';
import 'package:coresystem/Utils/Ocr_scan/ocr_scan.dart';
import 'package:flutter/material.dart';

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
                  children: [
                    FListTile(
                        border: Border(
                            bottom:
                                BorderSide(color: FColorSkin.grey3_background)),
                        onTap: () async {
                          OcrScan ocr = OcrScan();
                          await ocr.TakeImgAndOCR();
                        },
                        size: FListTileSize.size56,
                        title: Text(
                          'Tạo ticket',
                          style: FTypoSkin.buttonText2
                              .copyWith(color: FColorSkin.primaryText),
                        )),
                    FListTile(
                        onTap: () {},
                        size: FListTileSize.size56,
                        title: Text(
                          'Tạo đơn hàng',
                          style: FTypoSkin.buttonText2
                              .copyWith(color: FColorSkin.primaryText),
                        )),
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
      backgroundColor: FColorSkin.transparent,
      resizeToAvoidBottomInset: false,
      body: Stack(
        alignment: AlignmentDirectional.center,
        children: [
          TabNavigationItem.itemNav[currentIndex].page,
          Positioned(
            bottom: 18,
            right: 16,
            child: FFilledButton.icon(
                size: FButtonSize.size64,
                backgroundColor: FColorSkin.primaryColor,
                child: FIcon(
                  icon: FFilled.message,
                  size: 40,
                  color: FColorSkin.grey1_background,
                ),
                onPressed: () {}),
          )
        ],
      ),
      floatingActionButton: Container(
        padding: EdgeInsets.only(top: 53),
        child: FFilledButton.icon(
            backgroundColor: FColorSkin.primaryColor,
            onPressed: _Action,
            child: FIcon(
              icon: FOutlined.plus,
              color: FColorSkin.grey1_background,
            )),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: DecoratedBox(
        decoration: BoxDecoration(boxShadow: [FElevation.elevation2]),
        child: BottomNavigationBar(
          backgroundColor: FColorSkin.grey1_background,
          currentIndex: currentIndex,
          selectedItemColor: FColorSkin.primaryColor,
          selectedFontSize: 10,
          unselectedFontSize: 10,
          elevation: 0.0,
          unselectedItemColor: FColorSkin.subtitle,
          type: BottomNavigationBarType.fixed,
          selectedLabelStyle: FTypoSkin.subtitle2,
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
