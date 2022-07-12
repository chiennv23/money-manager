import 'package:coresystem/Components/base_component.dart';
import 'package:coresystem/Components/styles/input_size.dart';
import 'package:coresystem/Components/widgets/text_form_field.dart';
import 'package:coresystem/Project/2M/Contains/skin/color_skin.dart';
import 'package:coresystem/Project/2M/Contains/skin/typo_skin.dart';
import 'package:flutter/material.dart';

class TextFormWithExample extends StatefulWidget {
  final TextEditingController controller;
  final Function(String) fTextFieldStatus;
  final Function(String) onChange;
  final Function(String) onSubmit;
  final TextInputType textInputType;
  final bool important;
  final String example;
  final String titleTextForm;

  const TextFormWithExample({
    Key key,
    @required this.controller,
    this.fTextFieldStatus,
    this.example,
    this.textInputType = TextInputType.text,
    @required this.onChange,
    this.onSubmit,
    @required this.titleTextForm,
    this.important = true,
  }) : super(key: key);

  @override
  State<TextFormWithExample> createState() => _TextFormWithExampleState();
}

class _TextFormWithExampleState extends State<TextFormWithExample> {
  bool change = false;
  final FocusNode _focusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: EdgeInsets.only(bottom: 8, top: 10),
          child: Focus(
            onFocusChange: (vl) {
              setState(() {
                change = vl;
              });
            },
            child: FTextFormField(
              borderColor: FColorSkin.grey3_background,
              focusColor: FColorSkin.infoPrimary,
              labelText: widget.titleTextForm,
              keyboardType: widget.textInputType,
              labelImportant: widget.important,
              size: FInputSize.size64,
              // autovalidateMode: widget.controller.text.isEmpty
              //     ? AutovalidateMode.disabled
              //     : AutovalidateMode.onUserInteraction,
              textCapitalization: TextCapitalization.none,
              onTap: () {},
              clearIcon: widget.controller.text.isEmpty
                  ? Container()
                  : FFilledButton.icon(
                      size: FButtonSize.size24,
                      backgroundColor: FColorSkin.transparent,
                      child: FIcon(
                        icon: FFilled.close_circle,
                        size: 16,
                        color: FColorSkin.subtitle,
                      ),
                      onPressed: () {
                        setState(widget.controller.clear);
                      }),
              onChanged: widget.onChange,
              onSubmitted: widget.onSubmit,
              controller: widget.controller,
              validator: widget.fTextFieldStatus,
              maxLine: 1,
            ),
          ),
        ),
        // if (change)
        //   Container(
        //     padding: EdgeInsets.only(bottom: 10),
        //     child: Text(
        //       widget.example,
        //       style:
        //           FTypoSkin.subtitle3.copyWith(color: FColorSkin.secondaryText),
        //     ),
        //   ),
      ],
    );
  }
}
