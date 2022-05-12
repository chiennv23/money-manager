// import 'package:intl/intl.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:date_range_picker/date_range_picker.dart' as DateRagePicker;

// Future _selectDate(BuildContext context) async {
//     final List<DateTime> picked = await DateRagePicker.showDatePicker(
//       context: context,
//       initialFirstDate: new DateTime.now(),
//       initialLastDate: (new DateTime.now()).add(new Duration(days: 1)),
//       firstDate: new DateTime(2021, 1, 1),
//       lastDate: new DateTime(2022, 1, 1),
//     );
//     if (picked != null && picked.length == 2) {
//       setState(() => _saleTime.text =
//           '${DateFormat('dd/MM/yyyy').format(picked[0])} - ${DateFormat('dd/MM/yyyy').format(picked[1])}');
//     }
//   }
