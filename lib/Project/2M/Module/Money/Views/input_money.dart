import 'dart:io';

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
import 'package:get/get.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:uuid/uuid.dart';

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
  List<File> _imagesFile;

  bool isLoading = false;
  bool isCalculator = false;
  String getNote = '';

  final DatePickerController _controllerDatePicker = DatePickerController();

  @override
  void initState() {
    //edit
    if (widget.moneyItem != null) {
      memory.setStringResult(widget.moneyItem.moneyValue.wToMoney(0));
      Future.delayed(Duration(milliseconds: 100), () {
        categoryController.getTypeCate(widget.idType);
        final indexCateType = categoryController.cateList.indexWhere(
            (element) => element.iD == widget.moneyItem.moneyCateType.iD);
        categoryController.getIndex(indexCateType);
        final indexWallet = walletController.walletList
            .indexWhere((element) => element.iD == widget.moneyItem.wallet.iD);
        walletController.getIndex(indexWallet);
        moneyController.selectedValue.value = widget.moneyItem.creMoneyDate;
        getNote = widget.moneyItem.noteMoney.noteValue;
        _imagesFile = widget.moneyItem.noteMoney.noteImg ?? [];
      });
    }
    isCalculator = true;
    Future.delayed(
        Duration(milliseconds: 100), _controllerDatePicker.animateToSelection);
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
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
        isCalculator = false;
        setState(() {});
      },
      child: Scaffold(
          backgroundColor: FColorSkin.grey1_background,
          appBar: appbarNoTitle(
              iconBack: FOutlined.close,
              action: [
                Container(
                  padding: EdgeInsets.only(right: 8),
                  child: FFilledButton.icon(
                      backgroundColor: FColorSkin.transparent,
                      child: FIcon(icon: FFilled.camera),
                      onPressed: () async {
                        final OcrScan ocr = OcrScan();
                        await ocr.TakeImgAndOCR();
                      }),
                )
              ],
              systemUiOverlayStyle: SystemUiOverlayStyle.dark),
          body: SafeArea(
            child: Container(
              padding: EdgeInsets.fromLTRB(24, 0, 24, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    color: FColorSkin.grey1_background,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: EdgeInsets.only(bottom: 5),
                          child: Text(
                            widget.idType == 0 ? 'Chi tiêu' : 'Thu nhập',
                            style: FTypoSkin.title
                                .copyWith(color: FColorSkin.title),
                          ),
                        ),
                        // input
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
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
                                        ? moneyHasSign
                                            ? memory.equation
                                            : '${double.parse(memory.equation).wToMoney(0)}'
                                                .replaceAll('.', ',')
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
                    padding: EdgeInsets.only(bottom: 30),
                    child: Column(
                      children: [
                        Container(
                          padding: EdgeInsets.only(top: 16, bottom: 5.0),
                          child: FListTile(
                            padding: EdgeInsets.zero,
                            title: Row(
                              children: [
                                Text(
                                  '${widget.idType == 0 ? 'Chi tiêu' : 'Thu nhập'} cho ',
                                  style: FTypoSkin.title3
                                      .copyWith(color: FColorSkin.title),
                                ),
                                Obx(() {
                                  return Text(
                                    categoryController.cateList.length == 0 ||
                                            categoryController.cateList == null
                                        ? 'Danh mục ?'
                                        : '${categoryController.showNameCate}',
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
                            height: categoryController.cateList.length == 0 ||
                                    categoryController.cateList == null
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
                                          // await getCateList(addMore: true, Id: rs);
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
                                    child: categoryController.cateList ==
                                                null &&
                                            categoryController.idCate.value ==
                                                null
                                        ? Container()
                                        : ListView.builder(
                                            scrollDirection: Axis.horizontal,
                                            itemCount: categoryController
                                                .cateList.length,
                                            itemBuilder: (context, index) {
                                              final item = categoryController
                                                  .cateList[index];
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
                                                        padding: EdgeInsets
                                                            .symmetric(
                                                                vertical: 12.0,
                                                                horizontal:
                                                                    9.0),
                                                        child: Text(
                                                          item.cateName,
                                                          textAlign:
                                                              TextAlign.center,
                                                          style: FTypoSkin
                                                              .buttonText3
                                                              .copyWith(
                                                                  color:
                                                                      FColorSkin
                                                                          .title),
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
                                                          width: 84,
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
                            action: TextButton(
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
                                                  moneyController.selectedValue
                                                      .value = vl as DateTime;
                                                });
                                                CoreRoutes.instance.pop();
                                                print(moneyController
                                                    .selectedValue.value);
                                                _controllerDatePicker
                                                    .animateToDate(
                                                        moneyController
                                                            .selectedValue
                                                            .value,
                                                        duration: Duration(
                                                            milliseconds: 300));
                                                Future.delayed(
                                                    Duration(milliseconds: 50),
                                                    _controllerDatePicker
                                                        .animateToSelection);
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
                                              selectionColor: FColorSkin.title,
                                              monthCellStyle:
                                                  DateRangePickerMonthCellStyle(
                                                      leadingDatesTextStyle:
                                                          TextStyle(
                                                        color: FColorSkin.title,
                                                      ),
                                                      todayTextStyle: TextStyle(
                                                          color:
                                                              FColorSkin.title),
                                                      trailingDatesTextStyle:
                                                          TextStyle(
                                                        color: FColorSkin.title,
                                                      ),
                                                      weekendTextStyle:
                                                          TextStyle(
                                                        color: FColorSkin.title,
                                                      ),
                                                      textStyle: TextStyle(
                                                        color: FColorSkin.title,
                                                      )),
                                              headerStyle:
                                                  DateRangePickerHeaderStyle(
                                                      textStyle: TextStyle(
                                                // color choose year
                                                color: FColorSkin.title,
                                              )),
                                              selectionTextStyle: TextStyle(
                                                // change color range selected
                                                color:
                                                    FColorSkin.grey1_background,
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
                                      padding: const EdgeInsets.only(left: 4.0),
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
                        Row(
                          children: [
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
                            if (_imagesFile != [])
                              ...List.generate(_imagesFile?.length ?? 0,
                                  (index) {
                                final item = _imagesFile[index];
                                return Container(
                                  padding: EdgeInsets.only(left: 16),
                                  child: Stack(
                                    clipBehavior: Clip.none,
                                    children: [
                                      GestureDetector(
                                        onTap: () {
                                          print(1);
                                          CoreRoutes.instance
                                              .navigatorPushFade(ViewImg(
                                            img: item.absolute,
                                            keyHero: 'image$index',
                                          ));
                                        },
                                        child: Hero(
                                          tag: 'image$index',
                                          transitionOnUserGestures: true,
                                          child: FBoundingBox(
                                              size: FBoxSize.size48,
                                              backgroundColor:
                                                  FColorSkin.transparent,
                                              child: _imagesFile != null
                                                  ? Image.file(
                                                      item.absolute,
                                                      width: 64,
                                                      height: 64,
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
                                                FColorSkin.transparent,
                                            child: FIcon(
                                              icon: FFilled.minus_circle,
                                              size: 16,
                                              color: FColorSkin.errorPrimary,
                                            ),
                                            onPressed: () {
                                              _imagesFile.removeWhere(
                                                  (element) =>
                                                      element.path ==
                                                          item.path &&
                                                      element.uri == item.uri);
                                              setState(() {});
                                            }),
                                      )
                                    ],
                                  ),
                                );
                              })
                          ],
                        ),
                      ],
                    ),
                  )),
                ],
              ),
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
                      double moneyValue =
                          double.parse(memory.result.replaceAll('.', ''));
                      if (!moneyHasSign) {
                        moneyValue =
                            double.parse(memory.equation.replaceAll('.', ''));
                      }
                      final idMoney = Uuid().v1();
                      MoneyItem moneyItem = MoneyItem(
                          iD: idMoney,
                          moneyType: widget.idType.toString(),
                          moneyValue: moneyValue,
                          noteMoney: NoteItem(
                            noteValue: getNote ?? '',
                            // noteImg:
                            //     _imagesFile == null ? [] : [..._imagesFile]
                          ),
                          creMoneyDate: moneyController.selectedValue.value,
                          moneyCateType: categoryController.cateChoose,
                          wallet: walletController.walletChoose);
                      if (widget.moneyItem != null) {
                        //edit
                        moneyItem = MoneyItem(
                            iD: widget.moneyItem.iD,
                            moneyType: widget.idType.toString(),
                            moneyValue: moneyValue,
                            noteMoney: NoteItem(
                                noteValue: getNote ?? '',
                                // noteImg: _imagesFile == null
                                //     ? []
                                //     : [..._imagesFile]
                            ),
                            creMoneyDate: moneyController.selectedValue.value,
                            moneyCateType: categoryController.cateChoose,
                            wallet: walletController.walletChoose);
                      }
                      await moneyController.addMoneyNote(moneyItem);
                      setState(() {
                        isCalculator = true;
                        memory.allClearInputted();
                      });
                    },
                    isLoading: isLoading,
                    backgroundColor: FColorSkin.title,
                    child: Container(
                      alignment: Alignment.center,
                      child: Text(
                        'Thêm khoản ${widget.idType == 0 ? 'chi' : 'thu'}',
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

  ScrollController _scrollController = ScrollController();

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
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  readOnly
                                      ? 'Ghi chú cho ${idType == 0 ? 'chi tiêu' : 'thu nhập'} này'
                                      : 'Thêm ghi chú cho ${idType == 0 ? 'chi tiêu' : 'thu nhập'} này',
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

  bool get moneyHasSign => memory.equation.contains(RegExp(r'[÷|×|-|+]'));

  @override
  userImageList(List<File> _image) {
    setState(() {
      this._imagesFile = _image;
    });
  }
}

class ViewImg extends StatelessWidget {
  final File img;
  final String keyHero;

  const ViewImg({Key key, this.img, this.keyHero}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: FColorSkin.grey1_background,
      body: GestureDetector(
        onTap: () {
          CoreRoutes.instance.pop();
        },
        child: Center(
          child: Hero(
              transitionOnUserGestures: true,
              tag: keyHero,
              child: Image.file(
                img,
                width: double.infinity,
                height: 300,
                fit: BoxFit.fill,
              )),
        ),
      ),
    );
  }
}
