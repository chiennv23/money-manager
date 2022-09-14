import 'package:coresystem/Components/base_component.dart';
import 'package:coresystem/Components/widgets/SnackBar.dart';
import 'package:coresystem/Core/routes.dart';
import 'package:coresystem/Project/2M/Contains/constants.dart';
import 'package:coresystem/Project/2M/Contains/skin/color_skin.dart';
import 'package:coresystem/Project/2M/LocalDatabase/model_lib.dart';
import 'package:coresystem/Project/2M/Module/Category/DA/category_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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

  @override
  void initState() {
    // edit category
    if (widget.categoryItem != null) {}
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        backgroundColor: FColorSkin.grey3_background,
        appBar: appbarOnlyTitle(
          title: 'Create Category',
          systemUiOverlayStyle: SystemUiOverlayStyle.dark,
          // bottom: PreferredSize(
          //   preferredSize: Size.fromHeight(45.0),
          //   child: Container(
          //     height: 45,
          //     color: FColorSkin.title,
          //     child: TabBar(
          //         onTap: (index) {},
          //         labelPadding: EdgeInsets.zero,
          //         indicatorSize: TabBarIndicatorSize.label,
          //         indicatorColor: FColorSkin.grey1_background,
          //         labelColor: FColorSkin.grey1_background,
          //         tabs: const [
          //           Tab(
          //             text: 'Chi tiêu',
          //           ),
          //           Tab(
          //             text: 'Thu nhập',
          //           )
          //         ]),
          //   ),
          // )
        ),
        body: SingleChildScrollView(
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 8.0, bottom: 8),
                child: Text(
                  'Name: ',
                  style: FTypoSkin.title3.copyWith(color: FColorSkin.title),
                ),
              ),
              FTextFormField(
                autoFocus: true,
                maxLine: 1,
                controller: nameCateController,
                textInputAction: TextInputAction.done,
                hintText: "Name's category",
                size: FInputSize.size56,
                focusColor: FColorSkin.transparent,
                hintStyle: TextStyle(color: FColorSkin.title),
                onSubmitted: (v) {
                  final id = Uuid().v1();
                  categoryController.addCategory(
                      id, nameCateController.text.trim(), widget.idType);
                },
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Text(
                  'Icon: ',
                  style: FTypoSkin.title3.copyWith(color: FColorSkin.title),
                ),
              ),
            ],
          ),
        ),
        bottomNavigationBar: Container(
          padding: EdgeInsets.fromLTRB(16, 6, 16, 0),
          alignment: Alignment.topCenter,
          color: FColorSkin.transparent,
          height: 80,
          child: FFilledButton(
            size: FButtonSize.size40,
            onPressed: checkEmpty
                ? null
                : () async {
                    final id = Uuid().v1();
                    await categoryController.addCategory(
                        id, nameCateController.text.trim(), widget.idType);
                  },
            backgroundColor: checkEmpty
                ? FColorSkin.disableBackground
                : FColorSkin.primaryColor,
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
