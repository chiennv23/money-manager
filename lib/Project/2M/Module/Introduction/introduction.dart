import 'dart:async';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:coresystem/Components/base_component.dart';
import 'package:coresystem/Core/routes.dart';
import 'package:coresystem/Project/2M/Contains/skin/color_skin.dart';
import 'package:coresystem/Project/2M/Contains/skin/skin_route.dart';
import 'package:coresystem/Project/2M/Module/TabIndex/Index.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class IntroduceApp extends StatefulWidget {
  const IntroduceApp({Key key}) : super(key: key);

  @override
  State<IntroduceApp> createState() => _IntroduceAppState();
}

class _IntroduceAppState extends State<IntroduceApp> {
  int pageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              FColorSkin.primaryColorTagBackground,
              FColorSkin.primaryColor,
              FColorSkin.primaryColorTagBackground
            ],
            begin: const FractionalOffset(0.0, 1.5),
            end: const FractionalOffset(0.0, 0.0),
            tileMode: TileMode.mirror,
            stops: const [0.0, 0.75, 1.0],
          ),
        ),
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: PageView(
                    onPageChanged: (index) {
                      pageIndex = index;
                      setState(() {});
                    },
                    children: [
                      ...List.generate(
                          IntroPageList.length,
                          (index) => Container(
                                key: Key(index.toString()),
                                padding: EdgeInsets.symmetric(horizontal: 30),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Image.asset(
                                      IntroPageList[index].image,
                                      width: 350,
                                      height: 350,
                                    ),
                                    Container(
                                      padding:
                                          EdgeInsets.only(top: 28, bottom: 16),
                                      child: Text(
                                        IntroPageList[index].title,
                                        maxLines: 1,
                                        textAlign: TextAlign.center,
                                        style: FTypoSkin.title1,
                                      ),
                                    ),
                                    Text(
                                      IntroPageList[index].subTitle,
                                      maxLines: 3,
                                      textAlign: TextAlign.center,
                                      style: FTypoSkin.bodyText1,
                                    ),
                                  ],
                                ),
                              ))
                    ]),
              ),
              Container(
                padding: EdgeInsets.only(top: 28, bottom: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ...List.generate(
                        IntroPageList.length,
                        (index) => Container(
                              height: 8,
                              width: 8,
                              margin: EdgeInsets.only(right: 5),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: pageIndex == index
                                    ? FColorSkin.primaryColor
                                    : FColorSkin.grey1_background,
                              ),
                            ))
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.only(bottom: 16),
                child: FFilledButton(
                    backgroundColor: FColorSkin.primaryColor,
                    borderRadius: BorderRadius.circular(20.0),
                    child: Text('Start using Monage', style: FTypoSkin.title5),
                    onPressed: () async {
                      await CoreRoutes.instance
                          .navigateAndRemoveFade(PageIndex());
                    }),
              )
            ],
          ),
        ),
      ),
    );
  }
}

List<PageItem> IntroPageList = [
  PageItem(
      id: 0,
      title: 'Quản lý tài chính cá nhân',
      subTitle:
          'Theo dõi chi tiêu và hoạch định kế hoạch tích luỹ tài sản dành cho tương lai',
      image: 'lib/Assets/Images/intro.png'),
  PageItem(
      id: 1,
      title: 'Bảo mật thông tin',
      subTitle:
          'Theo dõi chi tiêu và hoạch định kế hoạch tích luỹ tài sản dành cho tương lai',
      image: 'lib/Assets/Images/intro.png'),
  PageItem(
      id: 2,
      title: 'Lên kế hoạch tài chính',
      subTitle:
          'Theo dõi chi tiêu và hoạch định kế hoạch tích luỹ tài sản dành cho tương lai',
      image: 'lib/Assets/Images/intro.png'),
];

class PageItem {
  int id;
  String title, subTitle, image;

  PageItem({this.id, this.title, this.subTitle, this.image});
}
