import 'package:coresystem/Components/base_component.dart';
import 'package:coresystem/Components/widgets/SnackBar.dart';
import 'package:coresystem/Core/routes.dart';
import 'package:coresystem/Project/2M/Contains/constants.dart';
import 'package:coresystem/Project/2M/Contains/skin/color_skin.dart';
import 'package:coresystem/Project/2M/LocalDatabase/model_lib.dart';
import 'package:coresystem/Project/2M/Module/Category/DA/category_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:uuid/uuid.dart';

import '../../../Contains/skin/typo_skin.dart';

class CreateCategory extends StatefulWidget {
  final CategoryItem categoryItem;
  final int idType;

  const CreateCategory({Key key, this.categoryItem, this.idType})
      : super(key: key);

  @override
  State<CreateCategory> createState() => _CreateCategoryState();
}

class _CreateCategoryState extends State<CreateCategory> {
  final nameCateController = TextEditingController();
  CategoryController categoryController = Get.find();
  int indexSel = 0;

  @override
  void initState() {
    // edit category
    if (widget.categoryItem != null) {
      nameCateController.text = widget.categoryItem.cateName;
      indexSel = iconsList
          .indexWhere((element) => element == widget.categoryItem.cateIcon);
    }
    super.initState();
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
          systemUiOverlayStyle: SystemUiOverlayStyle.dark,
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: const EdgeInsets.only(bottom: 5, left: 24, right: 24),
                child: Text(
                  'Your Category',
                  style: FTypoSkin.title.copyWith(color: FColorSkin.title),
                ),
              ),
              Container(
                padding: const EdgeInsets.only(left: 12),
                child: FTextFormField(
                  maxLine: 1,
                  cursorHeight: 42,
                  controller: nameCateController,
                  autoFocus: true,
                  borderColor: FColorSkin.transparent,
                  onChanged: (vl) {
                    setState(() {});
                  },
                  textInputAction: TextInputAction.done,
                  hintText: "Name's category",
                  onSubmitted: (v) {
                    if (checkEmpty) {
                      return;
                    }
                    if (widget.categoryItem != null) {
                      categoryController.addCategory(
                          widget.categoryItem.iD,
                          nameCateController.text.trim(),
                          iconsList[indexSel],
                          widget.idType);
                    } else {
                      final id = uuid.v4();
                      categoryController.addCategory(
                          id,
                          nameCateController.text.trim(),
                          iconsList[indexSel],
                          widget.idType);
                    }
                  },
                  style:
                      TextStyle(fontSize: 40.0, color: FColorSkin.primaryColor),
                  size: FInputSize.size64
                      .copyWith(contentPadding: EdgeInsets.zero, height: 45),
                  focusColor: FColorSkin.transparent,
                  hintStyle: TextStyle(
                      color: FColorSkin.subtitle.withOpacity(.3), fontSize: 38),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 40.0, bottom: 12, left: 24),
                child: Text(
                  'Icon: ',
                  style: FTypoSkin.title2.copyWith(color: FColorSkin.title),
                ),
              ),
              Container(
                  margin: const EdgeInsets.only(
                      top: 8.0, bottom: 16, left: 24, right: 24),
                  height: 114.0 * iconsList.length,
                  child: GridView.builder(
                    shrinkWrap: true,
                    itemCount: iconsList.length,
                    itemBuilder: (context, index) {
                      final icon = iconsList[index];
                      return Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8.0),
                            border: Border.all(
                                color: indexSel == index
                                    ? FColorSkin.primaryColor
                                    : FColorSkin.transparent)),
                        child: Material(
                          borderRadius: BorderRadius.circular(8.0),
                          color: FColorSkin.transparent,
                          child: InkWell(
                            onTap: () {
                              indexSel = index;
                              setState(() {});
                            },
                            radius: 8.0,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(8.0),
                              child: Image.asset(
                                icon,
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisSpacing: 12,
                            crossAxisCount: 6,
                            mainAxisSpacing: 16),
                  ))
            ],
          ),
        ),
        bottomNavigationBar: Container(
          padding: EdgeInsets.fromLTRB(16, 6, 16, 0),
          alignment: Alignment.topCenter,
          color: FColorSkin.transparent,
          height: 80,
          child: FFilledButton(
            size: FButtonSize.size40
                .copyWith(borderRadius: Radius.circular(20.0)),
            onPressed: checkEmpty
                ? null
                : () async {
                    if (widget.categoryItem != null) {
                      await categoryController.addCategory(
                          widget.categoryItem.iD,
                          nameCateController.text.trim(),
                          iconsList[indexSel],
                          widget.idType);
                    } else {
                      final id = uuid.v4();
                      await categoryController.addCategory(
                          id,
                          nameCateController.text.trim(),
                          iconsList[indexSel],
                          widget.idType);
                    }
                  },
            backgroundColor:
                checkEmpty ? FColorSkin.disableBackground : FColorSkin.title,
            child: Container(
              alignment: Alignment.center,
              child: Text(
                'Save',
                style: FTextStyle.regular14_22
                    .copyWith(color: FColorSkin.grey1_background),
              ),
            ),
          ),
        ),
      ),
    );
  }

  bool get checkEmpty {
    return nameCateController.text.isEmpty ||
        nameCateController.text.trim() == '';
  }
}
