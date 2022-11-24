import 'dart:io';

import 'package:coresystem/Components/base_component.dart';
import 'package:coresystem/Project/2M/Contains/constants.dart';
import 'package:coresystem/Project/2M/Contains/skin/color_skin.dart';
import 'package:coresystem/Project/2M/Contains/skin/skin_route.dart';
import 'package:coresystem/Project/2M/Module/Money/DA/money_controller.dart';
import 'package:coresystem/Utils/ConvertUtils.dart';
import 'package:excel/excel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'save_file.dart' as helper;

// await helper.saveAndLaunchFile(bytes, 'DataGrid.xlsx');

class ExportCSV extends StatefulWidget {
  const ExportCSV({Key key}) : super(key: key);

  @override
  State<ExportCSV> createState() => _ExportCSVState();
}

class _ExportCSVState extends State<ExportCSV> {
  Duration executionTime;
  MoneyController moneyController = Get.find();
  bool isLoading = false;

  @override
  void initState() {
    executionTime = Duration(milliseconds: 0);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: FColorSkin.grey1_background,
      appBar: appbarOnlyTitle(
        title: 'Export Excel',
        iconBack: FOutlined.left,
        systemUiOverlayStyle: SystemUiOverlayStyle.dark,
        action: [
          FFilledButton(
              isLoading: isLoading,
              backgroundColor: FColorSkin.transparent,
              child: Text(
                'Export',
                style: FTypoSkin.label4.copyWith(color: FColorSkin.title),
              ),
              onPressed: () {
                getExcel();
              })
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Total data: ${moneyController.allMoneyList.length}',
              style: FTypoSkin.buttonText2.copyWith(color: FColorSkin.title),
            ),
            Text(
              'Time export: ${executionTime.inMilliseconds / 1000}s',
              style: FTypoSkin.buttonText2.copyWith(color: FColorSkin.title),
            ),
            // Row(
            //   children: [
            //     Expanded(
            //       child: FFilledButton(
            //           isLoading: isLoading,
            //           child: Text('Export Excel'),
            //           onPressed: () {
            //             getExcel();
            //           }),
            //     ),
            //   ],
            // ),
          ],
        ),
      ),
    );
  }

  Future<void> getExcel() async {
    setState(() {
      isLoading = true;
    });
    final stopWatch = Stopwatch()..start();
    final excel = Excel.createExcel(); // automatically creates 1 empty sheet 1
    final sheet = excel[excel.getDefaultSheet()];
    sheet.cell(CellIndex.indexByColumnRow(columnIndex: 0, rowIndex: 0)).value =
        'Serial';
    sheet.cell(CellIndex.indexByColumnRow(columnIndex: 1, rowIndex: 0)).value =
        'Money';
    sheet.cell(CellIndex.indexByColumnRow(columnIndex: 2, rowIndex: 0)).value =
        'Date';
    sheet.cell(CellIndex.indexByColumnRow(columnIndex: 3, rowIndex: 0)).value =
        'Type';
    for (var row = 0; row < moneyController.allMoneyList.length; row++) {
      sheet
          .cell(CellIndex.indexByColumnRow(columnIndex: 0, rowIndex: row + 1))
          .value = (row + 1).toString();

      sheet
              .cell(CellIndex.indexByColumnRow(columnIndex: 1, rowIndex: row + 1))
              .value =
          WConvert.money(
              moneyController.allMoneyList[row].moneyValue ?? 0.0, 0);
      sheet
          .cell(CellIndex.indexByColumnRow(columnIndex: 2, rowIndex: row + 1))
          .value = moneyController.allMoneyList[row].creMoneyDate.toString();
      sheet
          .cell(CellIndex.indexByColumnRow(columnIndex: 3, rowIndex: row + 1))
          .value = moneyController.allMoneyList[row].moneyType ==
              '0'
          ? 'Expense'
          : 'Income';
    }
    final rs = excel.save();
    await helper.saveAndLaunchFile(rs, 'FlutterExcel.xlsx');
    setState(() {
      isLoading = false;
      executionTime = stopWatch.elapsed;
    });
  }
}
