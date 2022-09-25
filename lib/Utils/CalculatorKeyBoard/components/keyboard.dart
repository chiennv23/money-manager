import 'package:coresystem/Project/2M/Contains/skin/color_skin.dart';
import 'package:flutter/material.dart';

import 'button.dart';
import 'button_row.dart';

class Keyboard extends StatelessWidget {
  final void Function(String) cb;

  Keyboard(this.cb);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 400,
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border(top: BorderSide(color: FColorSkin.grey3_background))),
      child: Column(
        children: <Widget>[
          ButtonRow([
            Button.clear(text: 'AC', cb: cb),
            Button.delete(text: '⌫', cb: cb),
            Button.operation(text: '÷', cb: cb),
          ]),
          SizedBox(height: 0.2),
          ButtonRow([
            Button(text: '7', cb: cb),
            Button(text: '8', cb: cb),
            Button(text: '9', cb: cb),
            Button.operation(text: '×', cb: cb),
          ]),
          SizedBox(height: 0.2),
          ButtonRow([
            Button(text: '4', cb: cb),
            Button(text: '5', cb: cb),
            Button(text: '6', cb: cb),
            Button.operation(text: '-', cb: cb),
          ]),
          SizedBox(height: 0.2),
          ButtonRow([
            Button(text: '1', cb: cb),
            Button(text: '2', cb: cb),
            Button(text: '3', cb: cb),
            Button.operation(text: '+', cb: cb),
          ]),
          SizedBox(height: 0.2),
          ButtonRow([
            Button.big(text: '0', cb: cb),
            Button(text: '00', cb: cb),
            Button.operation(
              text: '=',
              cb: cb,
            ),
          ])
        ],
      ),
    );
  }
}
