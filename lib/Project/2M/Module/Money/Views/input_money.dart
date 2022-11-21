import 'dart:async';
import 'dart:io';
import 'dart:typed_data';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:coresystem/Components/base_component.dart';
import 'package:coresystem/Components/widgets/SnackBar.dart';
import 'package:coresystem/Core/routes.dart';
import 'package:coresystem/Project/2M/Contains/constants.dart';
import 'package:coresystem/Project/2M/Contains/skin/color_skin.dart';
import 'package:coresystem/Project/2M/Contains/skin/skin_route.dart';
import 'package:coresystem/Project/2M/LocalDatabase/model_lib.dart';
import 'package:coresystem/Project/2M/Module/Category/DA/category_controller.dart';
import 'package:coresystem/Project/2M/Module/Category/Views/create_category.dart';
import 'package:coresystem/Project/2M/Module/Money/DA/money_controller.dart';
import 'package:coresystem/Project/2M/Module/Wallet/DA/wallet_controller.dart';
import 'package:coresystem/Project/2M/Module/Wallet/Views/create_wallet.dart';
import 'package:coresystem/Utils/ConvertUtils.dart';
import 'package:coresystem/Utils/Ocr_scan/ocr_scan.dart';
import 'package:date_picker_timeline/date_picker_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

import '../../../../../Utils/CalculatorKeyBoard/components/keyboard.dart';
import '../../../../../Utils/CalculatorKeyBoard/models/memory.dart';
import '../../../../../Utils/PickImage/imagePickerHandler.dart';

class InputMoney extends StatefulWidget {
  final int idType;
  final MoneyItem moneyItem;

  const InputMoney({Key key, this.idType, this.moneyItem}) : super(key: key);

  @override
  State<InputMoney> createState() => _InputMoneyState();
}

class _InputMoneyState extends State<InputMoney>
    with TickerProviderStateMixin, ImagePickerListener {
  final CategoryController categoryController = Get.find();
  final WalletController walletController = Get.find();
  final MoneyController moneyController = Get.find();
  AnimationController _controller;
  ImagePickerHandler imagePicker;
  Uint8List _imagesFile;

  bool isCalculator = false;
  String getNote = '';
  final cateScrollController = ScrollController();
  final walletScrollController = ScrollController();
  final DatePickerController _controllerDatePicker = DatePickerController();

  @override
  void initState() {
    moneyController.imgOCR = <Uint8List>[].obs;
    //edit
    if (widget.moneyItem != null) {
      isCalculator = false;
      memory.setStringResult(widget.moneyItem.moneyValue.toInt().toString());
      Future.delayed(Duration(milliseconds: 100), () {
        categoryController.getTypeCate(widget.idType);
        final indexCateType = categoryController.cateByTypeList.indexWhere(
            (element) => element.iD == widget.moneyItem.moneyCateType.iD);
        categoryController.getIndex(indexCateType);
        cateScrollController.jumpTo(indexCateType * 100.0);
        final indexWallet = walletController.walletList
            .indexWhere((element) => element.iD == widget.moneyItem.wallet.iD);
        walletController.getIndex(indexWallet);
        walletController.walletChoosenBefore = widget.moneyItem.wallet;
        walletScrollController.jumpTo(indexCateType * 50.0);
        moneyController.selectedValue.value = widget.moneyItem.creMoneyDate;
        getNote = widget.moneyItem.noteMoney.noteValue;
        _imagesFile = widget.moneyItem.noteMoney.noteImg.first;
      });
    } else {
      Future.delayed(Duration(milliseconds: 100), () {
        moneyController.selectedValue.value = DateTime.now();
      });
      walletController.getIndex(0);
      categoryController.getIndex(0);
      isCalculator = true;
    }
    Future.delayed(Duration(milliseconds: 100), () {
      _controllerDatePicker.animateToDate(moneyController.selectedValue.value);
      _controllerDatePicker.jumpToSelection;
    });
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    imagePicker = ImagePickerHandler(
      this,
      _controller,
      chooseMutil: true,
    );
    imagePicker.init();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    isCalculator = false;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
          isCalculator = false;
          setState(() {});
        },
        child: Scaffold(
            backgroundColor: FColorSkin.grey1_background,
            appBar: appbarNoTitle(
                iconBack: FOutlined.close,
                actionBack: () {
                  moneyController.selectedValue.value = DateTime.now();
                  CoreRoutes.instance.pop();
                },
                action: [
                  Container(
                    padding: EdgeInsets.only(right: 8),
                    child: FFilledButton.icon(
                        backgroundColor: FColorSkin.transparent,
                        child: FIcon(icon: FFilled.camera),
                        onPressed: () async {
                          final ocr = OcrScan();
                          final rs = await ocr.TakeImgAndOCR();
                          if (rs != null) {
                            isCalculator = false;
                            memory.setStringResult('');
                            final textMoney =
                                rs.replaceAll(RegExp(r'[^\d.]+'), '');
                            print(textMoney);
                            memory.setStringResult(textMoney);
                            setState(() {});
                          }
                        }),
                  ),
                ],
                systemUiOverlayStyle: SystemUiOverlayStyle.dark),
            body: SafeArea(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: Get.width,
                    color: FColorSkin.grey1_background,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: EdgeInsets.only(bottom: 5, left: 24),
                          child: Text(
                            widget.idType == 0 ? 'Expense' : 'Income',
                            style: FTypoSkin.title
                                .copyWith(color: FColorSkin.title),
                          ),
                        ),
                        // input
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: 24,
                            ),
                            AutoSizeText(
                              'VND ',
                              style: FTypoSkin.title
                                  .copyWith(color: FColorSkin.primaryColor),
                            ),
                            Expanded(
                              child: GestureDetector(
                                onTap: () {
                                  isCalculator = true;
                                  setState(() {});
                                },
                                child: Container(
                                  color: FColorSkin.transparent,
                                  child: AutoSizeText(
                                    cmd != '='
                                        // check if having a calculation [moneyHasSign]
                                        ? memory.equation
                                        : memory.result.replaceAll('.', ','),
                                    maxLines: 1,
                                    maxFontSize: 32,
                                    minFontSize: 16,
                                    style: FTypoSkin.title.copyWith(
                                        color: FColorSkin.primaryColor),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                      child: SingleChildScrollView(
                    padding: EdgeInsets.only(bottom: 30, left: 24),
                    child: Column(
                      children: [
                        Container(
                          padding: EdgeInsets.only(top: 16, bottom: 5.0),
                          child: FListTile(
                            padding: EdgeInsets.zero,
                            title: Row(
                              children: [
                                Text(
                                  '${widget.idType == 0 ? 'Expense' : 'Income'} cho ',
                                  style: FTypoSkin.title3
                                      .copyWith(color: FColorSkin.title),
                                ),
                                Obx(() {
                                  return Text(
                                    categoryController.cateByTypeList.length ==
                                                0 ||
                                            categoryController.cateByTypeList ==
                                                null
                                        ? 'Danh mục ?'
                                        : '${categoryController?.showNameCate}',
                                    style: FTypoSkin.title3.copyWith(
                                        color: FColorSkin.primaryColor),
                                  );
                                }),
                              ],
                            ),
                          ),
                        ),
                        Obx(() {
                          return Container(
                            height: categoryController.cateByTypeList.length ==
                                        0 ||
                                    categoryController.cateByTypeList == null
                                ? 40
                                : 108,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                // add cate
                                Container(
                                  margin: EdgeInsets.only(right: 8),
                                  child: FFilledButton.icon(
                                      onPressed: () async {
                                        FocusScope.of(context).unfocus();
                                        final rs = await CoreRoutes.instance
                                            .navigatorPushDownToUp(
                                                CreateCategory(
                                          idType: widget.idType,
                                        ));
                                        if (rs != null) {
                                          await cateScrollController.animateTo(
                                              0.0,
                                              duration:
                                                  Duration(milliseconds: 400),
                                              curve: Curves.linear);
                                        }
                                      },
                                      backgroundColor: FColorSkin.primaryColor,
                                      child: FIcon(
                                        icon: FOutlined.plus,
                                        color: FColorSkin.grey1_background,
                                        size: 25,
                                      )),
                                ),
                                Expanded(
                                    child: categoryController.cateByTypeList ==
                                                null &&
                                            categoryController.idCate.value ==
                                                null
                                        ? Container()
                                        : ListView.builder(
                                            controller: cateScrollController,
                                            scrollDirection: Axis.horizontal,
                                            itemCount: categoryController
                                                .cateByTypeList.length,
                                            itemBuilder: (context, index) {
                                              final item = categoryController
                                                  .cateByTypeList[index];
                                              return Obx(() {
                                                return Container(
                                                  height: 108,
                                                  margin: EdgeInsets.only(
                                                      right: 8.0),
                                                  child: Ink(
                                                    decoration: BoxDecoration(
                                                        color: categoryController
                                                                    .idCate
                                                                    .value ==
                                                                index
                                                            ? FColorSkin
                                                                .grey1_background
                                                            : FColorSkin
                                                                .primaryColorTagBackground,
                                                        border: Border.all(
                                                            color: categoryController
                                                                        .idCate
                                                                        .value ==
                                                                    index
                                                                ? FColorSkin
                                                                    .primaryColor
                                                                : FColorSkin
                                                                    .transparent),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(8.0)),
                                                    child: InkWell(
                                                      onTap: () {
                                                        categoryController
                                                            .getIndex(index);
                                                      },
                                                      child: Container(
                                                        height: 108,
                                                        width: 84,
                                                        alignment:
                                                            Alignment.center,
                                                        padding:
                                                            EdgeInsets.only(
                                                                top: 10.0),
                                                        child: Column(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .center,
                                                          children: [
                                                            Image.asset(
                                                              item.cateIcon,
                                                              height: 55,
                                                            ),
                                                            Expanded(
                                                              child: Text(
                                                                item.cateName,
                                                                textAlign:
                                                                    TextAlign
                                                                        .center,
                                                                maxLines: 3,
                                                                style: FTypoSkin
                                                                    .buttonText3
                                                                    .copyWith(
                                                                        color: FColorSkin
                                                                            .title),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                );
                                              });
                                            })),
                              ],
                            ),
                          );
                        }),
                        Container(
                          padding: EdgeInsets.only(top: 16, bottom: 5.0),
                          child: FListTile(
                            padding: EdgeInsets.zero,
                            title: Row(
                              children: [
                                Text(
                                  '${widget.idType == 0 ? 'Sử dụng' : 'Thêm vào'} ',
                                  style: FTypoSkin.title3
                                      .copyWith(color: FColorSkin.title),
                                ),
                                Obx(() {
                                  return Text(
                                    walletController.walletList.length == 0 ||
                                            walletController.walletList == null
                                        ? 'Ví nào ?'
                                        : '${walletController.showNameWallet}',
                                    style: FTypoSkin.title3.copyWith(
                                        color: FColorSkin.primaryColor),
                                  );
                                }),
                              ],
                            ),
                          ),
                        ),
                        // wallet list
                        Container(
                          height: 40,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              // add cate
                              Container(
                                margin: EdgeInsets.only(right: 8),
                                child: FFilledButton.icon(
                                    onPressed: () {
                                      FocusScope.of(context).unfocus();
                                      CoreRoutes.instance.navigatorPushDownToUp(
                                          CreateWallet());
                                    },
                                    backgroundColor: FColorSkin.primaryColor,
                                    child: FIcon(
                                      icon: FOutlined.plus,
                                      color: FColorSkin.grey1_background,
                                      size: 25,
                                    )),
                              ),
                              Expanded(
                                  child: walletController.walletList == null &&
                                          walletController.idWallet.value ==
                                              null
                                      ? Container()
                                      : Obx(() {
                                          return ListView.builder(
                                              controller:
                                                  walletScrollController,
                                              scrollDirection: Axis.horizontal,
                                              itemCount: walletController
                                                  .walletList.length,
                                              itemBuilder: (context, index) {
                                                final item = walletController
                                                    .walletList[index];
                                                return Obx(() {
                                                  return Container(
                                                    margin: EdgeInsets.only(
                                                        right: 8.0),
                                                    child: Ink(
                                                      decoration: BoxDecoration(
                                                          color: walletController
                                                                      .idWallet
                                                                      .value ==
                                                                  index
                                                              ? FColorSkin
                                                                  .grey1_background
                                                              : FColorSkin
                                                                  .primaryColorTagBackground,
                                                          border: Border.all(
                                                              color: walletController
                                                                          .idWallet
                                                                          .value ==
                                                                      index
                                                                  ? FColorSkin
                                                                      .primaryColor
                                                                  : FColorSkin
                                                                      .transparent),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      8.0)),
                                                      child: InkWell(
                                                        onTap: () {
                                                          walletController
                                                              .getIndex(index);
                                                        },
                                                        child: Container(
                                                          height: 108,
                                                          alignment:
                                                              Alignment.center,
                                                          padding: EdgeInsets
                                                              .symmetric(
                                                                  vertical:
                                                                      12.0,
                                                                  horizontal:
                                                                      9.0),
                                                          child: Text(
                                                            item.title,
                                                            textAlign: TextAlign
                                                                .center,
                                                            style: FTypoSkin
                                                                .buttonText3
                                                                .copyWith(
                                                                    color: FColorSkin
                                                                        .title),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  );
                                                });
                                              });
                                        })),
                            ],
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.only(top: 16, bottom: 16.0),
                          child: FListTile(
                            padding: EdgeInsets.zero,
                            title: Row(
                              children: [
                                Text(
                                  'Vào ngày ',
                                  style: FTypoSkin.title3
                                      .copyWith(color: FColorSkin.title),
                                ),
                                Text(
                                  '${FDate.dMy(moneyController.selectedValue.value)}',
                                  style: FTypoSkin.title3
                                      .copyWith(color: FColorSkin.primaryColor),
                                ),
                              ],
                            ),
                            action: Padding(
                              padding: const EdgeInsets.only(right: 16.0),
                              child: TextButton(
                                  onPressed: () {
                                    Get.dialog(Scaffold(
                                      backgroundColor: FColorSkin.transparent,
                                      body: Center(
                                        child: Container(
                                          height: Get.height / 2,
                                          width: Get.width - 32,
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(8.0),
                                            child: Obx(() {
                                              return SfDateRangePicker(
                                                showActionButtons: true,
                                                onSelectionChanged: (vl) {
                                                  print(vl);
                                                },
                                                onCancel: () {
                                                  CoreRoutes.instance.pop();
                                                },
                                                initialDisplayDate:
                                                    moneyController
                                                        .selectedValue.value,
                                                initialSelectedDate:
                                                    moneyController
                                                        .selectedValue.value,
                                                onSubmit: (vl) {
                                                  setState(() {
                                                    moneyController
                                                        .selectedValue
                                                        .value = vl as DateTime;
                                                  });
                                                  CoreRoutes.instance.pop();
                                                  print(moneyController
                                                      .selectedValue.value);
                                                  Future.delayed(
                                                      Duration(
                                                          milliseconds: 100),
                                                      () {
                                                    _controllerDatePicker
                                                        .animateToDate(
                                                            moneyController
                                                                .selectedValue
                                                                .value);
                                                    _controllerDatePicker
                                                        .jumpToSelection();
                                                    setState(() {});
                                                    print(1111);
                                                  });
                                                },
                                                maxDate: DateTime.now().add(
                                                    const Duration(days: 30)),
                                                // minDate: DateTime.now()
                                                //     .subtract(const Duration(days: 30)),
                                                selectionMode:
                                                    DateRangePickerSelectionMode
                                                        .single,
                                                backgroundColor:
                                                    FColorSkin.grey1_background,
                                                selectionColor:
                                                    FColorSkin.title,
                                                monthCellStyle:
                                                    DateRangePickerMonthCellStyle(
                                                        leadingDatesTextStyle:
                                                            TextStyle(
                                                          color:
                                                              FColorSkin.title,
                                                        ),
                                                        todayTextStyle:
                                                            TextStyle(
                                                                color:
                                                                    FColorSkin
                                                                        .title),
                                                        trailingDatesTextStyle:
                                                            TextStyle(
                                                          color:
                                                              FColorSkin.title,
                                                        ),
                                                        weekendTextStyle:
                                                            TextStyle(
                                                          color:
                                                              FColorSkin.title,
                                                        ),
                                                        textStyle: TextStyle(
                                                          color:
                                                              FColorSkin.title,
                                                        )),
                                                headerStyle:
                                                    DateRangePickerHeaderStyle(
                                                        textStyle: TextStyle(
                                                  // color choose year
                                                  color: FColorSkin.title,
                                                )),
                                                selectionTextStyle: TextStyle(
                                                  // change color range selected
                                                  color: FColorSkin
                                                      .grey1_background,
                                                ),
                                                yearCellStyle:
                                                    DateRangePickerYearCellStyle(
                                                  textStyle: TextStyle(
                                                    color: FColorSkin.title,
                                                  ),
                                                ),
                                                monthViewSettings:
                                                    DateRangePickerMonthViewSettings(
                                                        viewHeaderStyle:
                                                            DateRangePickerViewHeaderStyle(
                                                                textStyle: TextStyle(
                                                                    color: FColorSkin
                                                                        .title)),
                                                        firstDayOfWeek: 1),
                                              );
                                            }),
                                          ),
                                        ),
                                      ),
                                    ));
                                  },
                                  child: Row(
                                    children: [
                                      Text(
                                        'More',
                                        style: FTypoSkin.buttonText3.copyWith(
                                            color: FColorSkin.primaryColor),
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(left: 4.0),
                                        child: FIcon(
                                          icon: FOutlined.right,
                                          size: 16,
                                          color: FColorSkin.primaryColor,
                                        ),
                                      )
                                    ],
                                  )),
                            ),
                          ),
                        ),
                        // date picker
                        Obx(() {
                          return DatePicker(
                            DateTime.now().subtract(Duration(days: 365)),
                            controller: _controllerDatePicker,
                            initialSelectedDate:
                                moneyController.selectedValue.value,
                            selectionColor: FColorSkin.primaryColor,
                            selectedTextColor: Colors.white,
                            height: 113,
                            width: 64,
                            onDateChange: (date) {
                              // New date selected
                              setState(() {
                                moneyController.selectedValue.value = date;
                              });
                            },
                          );
                        }),
                        Container(
                          padding: EdgeInsets.only(
                            top: 16,
                          ),
                          child: FListTile(
                            padding: EdgeInsets.zero,
                            title: Text(
                              'Nội dung ghi chú',
                              style: FTypoSkin.title3
                                  .copyWith(color: FColorSkin.title),
                            ),
                          ),
                        ),
                        FListTile(
                          padding: EdgeInsets.zero,
                          size: getNote == '' || getNote.isEmpty
                              ? FListTileSize.size48
                              : FListTileSize.size80,
                          avatar: FFilledButton.icon(
                              onPressed: () async {
                                var rs = await takeNote(widget.idType,
                                    note: getNote);
                                if (rs != null) {
                                  getNote = rs;
                                  setState(() {});
                                }
                              },
                              backgroundColor: FColorSkin.primaryColor,
                              child: FIcon(
                                icon: getNote == '' || getNote.isEmpty
                                    ? FOutlined.plus
                                    : FFilled.edit,
                                color: FColorSkin.grey1_background,
                                size: 25,
                              )),
                          title: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                getNote,
                                maxLines: maxLines,
                                overflow: TextOverflow.ellipsis,
                              ),
                              if (getNote != '' || getNote.isNotEmpty)
                                if (getNote.length > 100)
                                  FTextButton(
                                      size: FButtonSize.size32
                                          .copyWith(padding: EdgeInsets.zero),
                                      child: Text(
                                        'Xem thêm',
                                        style: FTypoSkin.bodyText2,
                                      ),
                                      onPressed: () {
                                        takeNote(widget.idType,
                                            note: getNote, readOnly: true);
                                      })
                            ],
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.only(top: 16, bottom: 5),
                          child: FListTile(
                            padding: EdgeInsets.zero,
                            title: Text(
                              'Tải ảnh đính kèm',
                              style: FTypoSkin.title3
                                  .copyWith(color: FColorSkin.title),
                            ),
                          ),
                        ),
                        Obx(() {
                          if (moneyController.imgOCR != null &&
                              moneyController.imgOCR.isNotEmpty) {
                            _imagesFile = moneyController.imgOCR.first;
                          }
                          return Row(
                            children: [
                              if (_imagesFile == null && isLoadImg == false)
                                FFilledButton.icon(
                                    onPressed: () {
                                      imagePicker.showDialog(context);
                                    },
                                    backgroundColor: FColorSkin.primaryColor,
                                    child: FIcon(
                                      icon: FOutlined.plus,
                                      color: FColorSkin.grey1_background,
                                      size: 25,
                                    )),
                              if (isLoadImg)
                                SpinKitThreeBounce(
                                    size: 24, color: FColorSkin.primaryColor),
                              if (_imagesFile != null)
                                Container(
                                  padding: EdgeInsets.only(
                                      left: _imagesFile == null ? 16 : 0),
                                  child: Stack(
                                    clipBehavior: Clip.none,
                                    children: [
                                      GestureDetector(
                                        onTap: () {
                                          print(1);
                                          CoreRoutes.instance
                                              .navigatorPushFade(ViewImg(
                                            img: _imagesFile,
                                            keyHero: 'imageViewer',
                                          ));
                                        },
                                        child: Hero(
                                          tag: 'imageViewer',
                                          transitionOnUserGestures: true,
                                          child: FBoundingBox(
                                              size: FBoxSize.size72,
                                              backgroundColor:
                                                  FColorSkin.transparent,
                                              child: _imagesFile != null
                                                  ? Image.memory(
                                                      _imagesFile,
                                                      width: 72,
                                                      height: 72,
                                                      fit: BoxFit.cover,
                                                    )
                                                  : FIcon(
                                                      icon: FFilled.image,
                                                      color: FColorSkin
                                                          .grey9_background,
                                                      size: 20,
                                                    )),
                                        ),
                                      ),
                                      Positioned(
                                        top: -17.0,
                                        right: -17.0,
                                        child: FFilledButton.icon(
                                            size: FButtonSize.size24.copyWith(
                                                padding: EdgeInsets.zero),
                                            backgroundColor:
                                                FColorSkin.grey1_background,
                                            child: FIcon(
                                              icon: FFilled.close_circle,
                                              size: 24,
                                              color: FColorSkin.errorPrimary,
                                            ),
                                            onPressed: () {
                                              _imagesFile = null;
                                              moneyController.imgOCR.clear();
                                              setState(() {});
                                            }),
                                      )
                                    ],
                                  ),
                                )
                            ],
                          );
                        }),
                      ],
                    ),
                  )),
                ],
              ),
            ),
            bottomNavigationBar: AnimatedCrossFade(
              duration: Duration(milliseconds: 250),
              secondChild: Container(
                color: FColorSkin.transparent,
                child: Keyboard(_onPressed),
              ),
              firstChild: Container(
                padding: EdgeInsets.fromLTRB(16, 0, 16, 0),
                alignment: Alignment.topCenter,
                color: FColorSkin.grey1_background,
                height: 69,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    FFilledButton(
                      size: FButtonSize.size40,
                      borderRadius: BorderRadius.circular(20.0),
                      onPressed: () async {
                        // add
                        if (memory.result.startsWith('-')) {
                          await Get.dialog(
                            CupertinoAlertDialog(
                              content: Text(
                                  'You need to enter the positive amount to continue'),
                              actions: <Widget>[
                                CupertinoDialogAction(
                                  child: Text('Cancel'),
                                  onPressed: () => CoreRoutes.instance.pop(),
                                )
                              ],
                            ),
                            barrierDismissible: false,
                          );
                          isCalculator = true;
                          setState(() {});
                          return;
                        }
                        if (walletController.walletList.isEmpty) {
                          await Get.dialog(
                            CupertinoAlertDialog(
                              content: Text('You need to choose a wallet'),
                              actions: <Widget>[
                                CupertinoDialogAction(
                                  child: Text('Cancel'),
                                  onPressed: () => CoreRoutes.instance.pop(),
                                )
                              ],
                            ),
                            barrierDismissible: false,
                          );
                          isCalculator = true;
                          setState(() {});
                          return;
                        }
                        final moneyValue = double.parse(memory.result
                            .replaceAll(RegExp(r'[^\d.]+'), '')
                            .replaceAll('.', ''));

                        var moneyItem = MoneyItem(
                            iD: uuid.v4(),
                            moneyType: widget.idType.toString(),
                            moneyValue: moneyValue,
                            noteMoney: NoteItem(
                                iD: uuid.v4(),
                                noteValue: getNote ?? '',
                                noteImg: [_imagesFile] ?? []),
                            creMoneyDate: moneyController.selectedValue.value,
                            moneyCateType: categoryController.cateChoose,
                            wallet: walletController.walletChoose.value);
                        if (widget.moneyItem != null) {
                          //edit
                          moneyItem = MoneyItem(
                              iD: widget.moneyItem.iD,
                              moneyType: widget.idType.toString(),
                              moneyValue: moneyValue,
                              noteMoney: NoteItem(
                                  iD: widget.moneyItem.noteMoney.iD,
                                  noteValue: getNote ?? '',
                                  noteImg: [_imagesFile] ?? []),
                              creMoneyDate: moneyController.selectedValue.value,
                              moneyCateType: categoryController.cateChoose,
                              wallet: walletController.walletChoose.value);
                        }
                        await moneyController.addMoneyNote(moneyItem);
                        if (moneyItem.moneyValue != 0.0 &&
                            moneyItem.wallet.iD != null) {
                          if (mounted) {
                            setState(() {
                              isCalculator = true;
                              memory.allClearInputted();
                            });
                          }
                        }
                      },
                      backgroundColor: FColorSkin.title,
                      child: Container(
                        alignment: Alignment.center,
                        child: Text(
                          '${widget.moneyItem != null ? 'Sửa' : 'Thêm'} khoản ${widget.idType == 0 ? 'chi' : 'thu'}',
                          style: FTextStyle.regular14_22
                              .copyWith(color: FColorSkin.grey1_background),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              crossFadeState: isCalculator
                  ? CrossFadeState.showSecond
                  : CrossFadeState.showFirst,
            )),
      ),
    );
  }

  int maxLines = 2;

  final Memory memory = Memory();
  String cmd = '';

  void _onPressed(String command) {
    setState(() {
      cmd = command;
      memory.applyCommand(command);
    });
    if (cmd == '=') {
      isCalculator = false;
    }
  }

  final noteController = TextEditingController();

  final ScrollController _scrollController = ScrollController();

  Future takeNote(int idType, {String note, bool readOnly = false}) {
    if (note == null || note == '' || note.isEmpty) {
      noteController.clear();
    } else {
      noteController.text = note;
    }

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
        height: MediaQuery.of(context).size.height - 200,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(12),
            topRight: Radius.circular(12),
          ),
          color: FColorSkin.grey1_background,
        ),
        child: StatefulBuilder(
          builder: (context, setStatefulBuilder) {
            return Scaffold(
              backgroundColor: FColorSkin.transparent,
              appBar: PreferredSize(
                preferredSize: Size.fromHeight(16),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(12),
                      topRight: Radius.circular(12),
                    ),
                    color: FColorSkin.transparent,
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
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  readOnly
                                      ? 'Ghi chú cho ${idType == 0 ? 'Expense' : 'Income'} này'
                                      : 'Thêm ghi chú cho ${idType == 0 ? 'Expense' : 'Income'} này',
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: FTypoSkin.title1
                                      .copyWith(color: FColorSkin.title),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(top: 5),
                                  child: Text(
                                    '${noteController.text.length}/1000 ký tự',
                                    maxLines: 1,
                                    style: FTypoSkin.subtitle1.copyWith(
                                        color: noteController.text.length > 1000
                                            ? FColorSkin.errorPrimary
                                            : FColorSkin.title),
                                  ),
                                ),
                              ],
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
                    Expanded(
                      child: Scrollbar(
                        controller: _scrollController,
                        isAlwaysShown: true,
                        child: SingleChildScrollView(
                          child: Container(
                            margin: EdgeInsets.all(16),
                            width: double.infinity,
                            child: TextField(
                              scrollController: _scrollController,
                              controller: noteController,
                              maxLines: null,
                              autofocus: true,
                              keyboardType: TextInputType.multiline,
                              textInputAction: TextInputAction.done,
                              readOnly: readOnly,
                              onSubmitted: (vl) {
                                if (noteController.text.length > 1000) {
                                  SnackBarCore.warning(
                                      title: 'Quá ký tự cho phép !');
                                  return;
                                }
                                CoreRoutes.instance
                                    .pop(result: noteController.text);
                              },
                              onChanged: (v) {
                                setStatefulBuilder(() {});
                              },
                              style: FTypoSkin.bodyText1
                                  .copyWith(color: FColorSkin.body),
                              decoration: InputDecoration(
                                hintText: 'Nội dung ghi chú',
                                isCollapsed: true,
                                border: InputBorder.none,
                                labelStyle: FTypoSkin.bodyText1
                                    .copyWith(color: FColorSkin.body),
                                hintStyle: FTypoSkin.bodyText1
                                    .copyWith(color: FColorSkin.body),
                                filled: true,
                              ),
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  bool isLoadImg = false;

  @override
  userImageList(List<File> _image) async {
    setState(() {
      isLoadImg = true;
    });
    final Uint8List imageByteArray = await ImageHelper.compressImage(_image[0]);
    this._imagesFile = imageByteArray;

    setState(() {
      print('add img');
      print(_imagesFile);
      isLoadImg = false;
    });
  }
}

class ViewImg extends StatefulWidget {
  final Uint8List img;
  final String keyHero;

  const ViewImg({Key key, this.img, this.keyHero}) : super(key: key);

  @override
  State<ViewImg> createState() => _ViewImgState();
}

class _ViewImgState extends State<ViewImg> with TickerProviderStateMixin {
  // zoom in zoom out map
  final TransformationController transformationController =
      TransformationController();
  Animation<Matrix4> _animationReset;
  AnimationController _controllerReset;
  TapDownDetails _doubleTapDetails;

  void _onAnimateReset() {
    transformationController.value = _animationReset.value;
    if (!_controllerReset.isAnimating) {
      _animationReset?.removeListener(_onAnimateReset);
      _animationReset = null;
      _controllerReset.reset();
    }
  }

  void _handleDoubleTapDown(TapDownDetails details) {
    _doubleTapDetails = details;
  }

  void _animateResetInitialize() {
    if (transformationController.value != Matrix4.identity()) {
      print('reset zoom');
      _controllerReset.reset();
      _animationReset = Matrix4Tween(
        begin: transformationController.value,
        end: Matrix4.identity(),
      ).animate(_controllerReset);
      _animationReset.addListener(_onAnimateReset);
      _controllerReset.forward();
    } else {
      print('zoom');
      final position = _doubleTapDetails.localPosition;
      transformationController.value = Matrix4.identity()
        ..translate(-position.dx, -position.dy)
        ..scale(1.8);
      _controllerReset.reset();
      _animationReset = Matrix4Tween(
        begin: Matrix4.identity(),
        end: transformationController.value,
      ).animate(_controllerReset);
      _animationReset.addListener(_onAnimateReset);
      _controllerReset.forward();
    }
  }

  @override
  void initState() {
    super.initState();
    _controllerReset = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );
  }

  @override
  void dispose() {
    _controllerReset.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onDoubleTap: _animateResetInitialize,
      onDoubleTapDown: _handleDoubleTapDown,
      child: Scaffold(
        backgroundColor: FColorSkin.grey1_background,
        appBar: appbarNoTitle(),
        body: Center(
          child: InteractiveViewer(
            transformationController: transformationController,
            boundaryMargin: EdgeInsets.all(80),
            minScale: 0.5,
            maxScale: 4,
            child: Hero(
                transitionOnUserGestures: true,
                tag: widget.keyHero,
                child: Image.memory(
                  widget.img,
                  width: double.infinity,
                  fit: BoxFit.cover,
                )),
          ),
        ),
      ),
    );
  }
}
