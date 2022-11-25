import 'dart:math';

import 'package:coresystem/Components/base_component.dart';
import 'package:coresystem/Components/widgets/SnackBar.dart';
import 'package:coresystem/Core/routes.dart';
import 'package:coresystem/Project/2M/Contains/constants.dart';
import 'package:coresystem/Project/2M/Contains/skin/color_skin.dart';
import 'package:coresystem/Project/2M/Contains/skin/skin_route.dart';
import 'package:coresystem/Project/2M/LocalDatabase/model_lib.dart';
import 'package:coresystem/Project/2M/Module/Category/DA/category_controller.dart';
import 'package:coresystem/Project/2M/Module/Category/Views/create_category.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class CategoryList extends StatefulWidget {
  const CategoryList({Key key}) : super(key: key);

  @override
  State<CategoryList> createState() => _CategoryListState();
}

class _CategoryListState extends State<CategoryList>
    with SingleTickerProviderStateMixin {
  int indexType = 1;

  CategoryController categoryController = Get.find();
  bool isEdit = false;
  AnimationController _animationController;

  @override
  void initState() {
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 250),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (isEdit) {
          _animationController.stop();
          isEdit = false;
          setState(() {});
        }
      },
      child: Scaffold(
        backgroundColor: FColorSkin.grey1_background,
        appBar: appbarNoTitle(
            noBack: isEdit,
            systemUiOverlayStyle: SystemUiOverlayStyle.dark,
            iconBack: FOutlined.left,
            action: [
              FFilledButton(
                  backgroundColor: FColorSkin.transparent,
                  child: Text(
                    isEdit ? 'Done' : 'Edit',
                    style: FTypoSkin.title3.copyWith(color: FColorSkin.title),
                  ),
                  onPressed: () {
                    isEdit = !isEdit;
                    if (isEdit) {
                      _animationController.repeat();
                    } else {
                      _animationController.stop();
                    }
                    setState(() {});
                  })
            ]),
        body: Container(
          padding: EdgeInsets.fromLTRB(24, 0, 24, 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 48,
                margin: EdgeInsets.only(bottom: 16, top: 0.0),
                padding: EdgeInsets.symmetric(horizontal: 4),
                decoration: BoxDecoration(
                    color: FColorSkin.grey3_background,
                    borderRadius: BorderRadius.circular(16.0)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: FFilledButton(
                        size: FButtonSize.size40
                            .copyWith(borderRadius: Radius.circular(16.0)),
                        backgroundColor: indexType == 1
                            ? FColorSkin.title
                            : FColorSkin.transparent,
                        child: Center(
                          child: Text(
                            'Income',
                            style: FTypoSkin.buttonText2.copyWith(
                                color: indexType == 1
                                    ? FColorSkin.grey1_background
                                    : FColorSkin.subtitle),
                          ),
                        ),
                        onPressed: () {
                          indexType = 1;

                          setState(() {});
                        },
                      ),
                    ),
                    Expanded(
                      child: FFilledButton(
                        size: FButtonSize.size40
                            .copyWith(borderRadius: Radius.circular(16.0)),
                        backgroundColor: indexType == 0
                            ? FColorSkin.title
                            : FColorSkin.transparent,
                        child: Center(
                          child: Text(
                            'Expense',
                            style: FTypoSkin.buttonText2.copyWith(
                                color: indexType == 0
                                    ? FColorSkin.grey1_background
                                    : FColorSkin.subtitle),
                          ),
                        ),
                        onPressed: () {
                          indexType = 0;

                          setState(() {});
                        },
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(0, 0, 0, 24),
                child: Text(
                  'Category',
                  style: FTypoSkin.title1.copyWith(color: FColorSkin.title),
                ),
              ),
              Obx(() {
                return Expanded(
                    child: GridView.builder(
                  itemCount: categoryController.allCateList
                      .where(
                          (element) => element.cateType == indexType.toString())
                      .toList()
                      .length,
                  itemBuilder: (context, index) {
                    final item = categoryController.allCateList
                        .where((element) =>
                            element.cateType == indexType.toString())
                        .toList()[index];
                    return AnimatedBuilder(
                      animation: _animationController,
                      builder: (BuildContext context, Widget child) {
                        final dx =
                            sin(_animationController.value * 2 * pi) * 1.9;
                        return Transform.translate(
                          offset: Offset(dx, 0),
                          child: child,
                        );
                      },
                      child: Stack(
                        clipBehavior: Clip.none,
                        children: [
                          InkWell(
                            onTap: isEdit
                                ? null
                                : () {
                                    CoreRoutes.instance
                                        .navigatorPushDownToUp(CreateCategory(
                                      categoryItem: item,
                                      idType: int.parse(item.cateType),
                                    ));
                                  },
                            child: Column(
                              children: [
                                Image.asset(
                                  item.cateIcon,
                                  height: 64,
                                  width: 64,
                                ),
                                Expanded(
                                  child: Text(
                                    item.cateName,
                                    textAlign: TextAlign.center,
                                    maxLines: 3,
                                    style: FTypoSkin.title6
                                        .copyWith(color: FColorSkin.title),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          if (isEdit)
                            Positioned(
                              top: 0.0,
                              right: -0.0,
                              child: FFilledButton.icon(
                                  size: FButtonSize.size24
                                      .copyWith(padding: EdgeInsets.zero),
                                  backgroundColor: FColorSkin.grey1_background,
                                  child: FIcon(
                                    icon: FFilled.close_circle,
                                    size: 24,
                                    color: FColorSkin.errorPrimary,
                                  ),
                                  onPressed: () {
                                    if (categoryController.allCateList
                                            .where((element) =>
                                                element.cateType ==
                                                indexType.toString())
                                            .toList()
                                            .length ==
                                        1) {
                                      SnackBarCore.warning(
                                          isBottom: true,
                                          title:
                                              'Can not delete all categories');
                                      return;
                                    }
                                    categoryController.deleteCategory(item);
                                  }),
                            )
                        ],
                      ),
                    );
                  },
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      childAspectRatio: 84 / 120,
                      crossAxisSpacing: 12,
                      crossAxisCount: 4,
                      mainAxisSpacing: 16),
                ));
              }),
            ],
          ),
        ),
        bottomNavigationBar: isEdit
            ? Container(
                height: 0.0,
              )
            : Container(
                padding: EdgeInsets.fromLTRB(16, 6, 16, 0),
                alignment: Alignment.topCenter,
                color: FColorSkin.transparent,
                height: 80,
                child: FFilledButton(
                  size: FButtonSize.size40
                      .copyWith(borderRadius: Radius.circular(20.0)),
                  onPressed: () {
                    _ActionCreate();
                  },
                  backgroundColor: FColorSkin.title,
                  child: Container(
                    alignment: Alignment.center,
                    child: Text(
                      'Add new category',
                      style: FTextStyle.regular14_22
                          .copyWith(color: FColorSkin.grey1_background),
                    ),
                  ),
                ),
              ),
      ),
    );
  }

  Future _ActionCreate() {
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
                              'Add new Category',
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: FTypoSkin.title1
                                  .copyWith(color: FColorSkin.title),
                            ),
                          ),
                          FTextButton(
                              child: Text(
                                'Cancel',
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
                            2,
                            (index) => Expanded(
                              child: Container(
                                margin: EdgeInsets.only(right: 16),
                                child: InkWell(
                                  onTap: () {
                                    // index 0 chi tieu
                                    // index 1 thu nhap
                                    CoreRoutes.instance
                                        .navigatorPushDownToUp(CreateCategory(
                                      idType: index,
                                    ));
                                  },
                                  child: AnimatedContainer(
                                      height: 140,
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                          color: FColorSkin.title,
                                          borderRadius:
                                              BorderRadius.circular(16.0)),
                                      duration: Duration(milliseconds: 250),
                                      child: Text(
                                        index == 0 ? 'Expense' : 'Income',
                                        style: FTypoSkin.title3.copyWith(
                                            color: FColorSkin.grey1_background),
                                      )),
                                ),
                              ),
                            ),
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
}
