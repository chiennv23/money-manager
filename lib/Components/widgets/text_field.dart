import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../base_component.dart';

class FTextField extends StatefulWidget {
  FTextField({
    Key key,
    this.helperText,
    this.labelText,
    this.prefixIcon,
    this.suffixIcon,
    this.backgroundColor = FColors.grey1,
    this.borderColor = FColors.grey4,
    this.subtitleColor,
    this.size = FInputSize.size56,
    this.autoFocus = false,
    this.controller,
    this.clearIcon,
    this.enabled = true,
    this.readOnly = false,
    this.focusColor = FColors.blue6,
    this.keyboardType,
    this.onTap,
    this.onChanged,
    this.validator,
    this.onSave,
    this.onEditingComplete,
    this.onFieldSubmitted,
    this.obscureText = false,
    this.obscuringCharacter = "*",
    this.maxLength,
    this.counterText,
    this.errorText,
    this.maxLines,
    this.inputFormatter,
    this.borderErrorColor = FColors.red6,
    this.hintText = '',
    this.hintStyle,
    this.style,
    this.cursorHeight = 15,
    this.focusNode,
    this.textCapitalization = TextCapitalization.none,
    this.labelStyle,
    this.padding = const EdgeInsets.fromLTRB(8, 0, 8, 0),
    this.textAlign = TextAlign.start,
    this.helperTextColor,
    this.textInputAction,
    this.textImportant = false,
  }) : super(key: key);

  final TextEditingController controller;
  final String helperText;
  final String labelText;
  final Widget prefixIcon;
  final Widget clearIcon;
  final Widget suffixIcon;
  final Color backgroundColor;
  final Color borderColor;
  final Color focusColor;
  final Color subtitleColor;
  final Color borderErrorColor;
  final FInputSize size;
  final bool autoFocus;
  final bool enabled;
  final bool readOnly;
  final bool textImportant;
  final TextInputType keyboardType;
  final VoidCallback onTap;
  final Function onChanged;
  final Function onSave;
  final FormFieldValidator<String> validator;
  final VoidCallback onEditingComplete;
  final Function onFieldSubmitted;
  final bool obscureText;
  final String obscuringCharacter;
  final int maxLength;
  final String counterText;
  final String errorText;
  final Color helperTextColor;
  final String hintText;
  final TextStyle hintStyle;
  final TextStyle style;
  final TextStyle labelStyle;
  final double cursorHeight;
  final int maxLines;
  final List<TextInputFormatter> inputFormatter;
  final FocusNode focusNode;
  final TextCapitalization textCapitalization;
  final EdgeInsets padding;
  final TextAlign textAlign;

  final TextInputAction textInputAction;

  @override
  _FTextFieldState createState() => _FTextFieldState();
}

class _FTextFieldState extends State<FTextField> {
  bool _isFocus = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: widget.padding,
          height: widget.size.height,
          decoration: BoxDecoration(
            color: widget.backgroundColor,
            borderRadius: BorderRadius.all(widget.size.borderRadius),
            border: Border.all(
              width: 1,
              color: widget.helperText != null
                  ? widget.borderErrorColor
                  : _isFocus
                      ? widget.focusColor
                      : widget.borderColor,
            ),
          ),
          child: Row(
            children: [
              _buildPrefixIcon(),
              Expanded(
                child: Focus(
                  onFocusChange: (value) {
                    setState(() {
                      _isFocus = value;
                    });
                  },
                  child: TextFormField(
                    textAlign: widget.textAlign,
                    textCapitalization: widget.textCapitalization,
                    focusNode: widget.focusNode,
                    inputFormatters: widget.inputFormatter,
                    textInputAction: widget.textInputAction,
                    maxLines: widget.maxLines,
                    maxLength: widget.maxLength,
                    onChanged: widget.onChanged,
                    onTap: widget.onTap,
                    onFieldSubmitted: widget.onFieldSubmitted,
                    validator: widget.validator,
                    keyboardType: widget.keyboardType,
                    controller: widget.controller,
                    autofocus: widget.autoFocus,
                    enabled: widget.enabled,
                    readOnly: widget.readOnly,
                    textAlignVertical: TextAlignVertical.center,
                    style: widget.style ??
                        TextStyle(
                          fontSize: 14,
                          color: FColors.grey10,
                        ),
                    cursorColor: FColors.grey10,
                    cursorHeight: widget.cursorHeight,
                    obscureText: widget.obscureText,
                    obscuringCharacter: widget.obscuringCharacter,
                    cursorWidth: 1,
                    onEditingComplete: widget.onEditingComplete,
                    decoration: InputDecoration(
                      counterText: widget.counterText,
                      hintText: widget.hintText,
                      label: widget.textImportant == true
                          ? Text.rich(
                              TextSpan(
                                children: <InlineSpan>[
                                  WidgetSpan(
                                    child: Text(
                                      widget.labelText,
                                    ),
                                  ),
                                  WidgetSpan(
                                    child: Text(
                                      ' *',
                                      style: TextStyle(
                                        color: Colors.red,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            )
                          : null,
                      labelText: widget.textImportant == false
                          ? widget.labelText
                          : null,
                      labelStyle: widget.labelStyle ??
                          TextStyle(
                              color: widget.helperText != null
                                  ? widget.borderErrorColor
                                  : _isFocus
                                      ? widget.focusColor
                                      : FColors.grey6,
                              height: 0.8),
                      hintStyle: widget.hintStyle,
                      contentPadding: EdgeInsets.zero,
                      border: InputBorder.none,
                      isDense: true,
                    ),
                  ),
                ),
              ),
              _buildClear(),
              _buildSeparator(),
              _buildSuffix(),
            ],
          ),
        ),
        if (widget.helperText != null)
          Container(
            margin: EdgeInsets.fromLTRB(0, 4, 0, 0),
            constraints: BoxConstraints(maxHeight: 32, minHeight: 16),
            child: Text(
              widget.helperText,
              overflow: TextOverflow.ellipsis,
              style: FTextStyle.regular12_16.copyWith(color: FColors.red6),
              maxLines: 2,
            ),
          ),
      ],
    );
  }

  Widget _buildPrefixIcon() => widget.prefixIcon != null
      ? Container(
          margin: EdgeInsets.only(right: 12, left: 8),
          alignment: Alignment.center,
          child: widget.prefixIcon,
        )
      : Container(width: 8);

  Widget _buildClear() => widget.clearIcon != null
      ? Container(
          height: 32,
          width: 32,
          alignment: Alignment.center,
          child: widget.clearIcon,
        )
      : Container(width: 0);

  Widget _buildSeparator() =>
      widget.clearIcon != null && widget.suffixIcon != null
          ? Container(
              height: 12,
              width: 1,
              color: FColors.grey4,
            )
          : Container(width: 0);

  Widget _buildSuffix() => widget.suffixIcon != null
      ? Container(
          height: 32,
          width: 32,
          alignment: Alignment.center,
          child: widget.suffixIcon,
        )
      : Container(width: widget.clearIcon != null ? 0 : 8);
}
