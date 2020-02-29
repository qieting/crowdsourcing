//import 'package:crowdsourcing/common/MyThemes.dart';
//import 'package:flutter/material.dart';
//import 'package:flutter/services.dart';
//
//class ChangeColorTextFiled extends StatefulWidget {
//  Key key;
//  String initialValue;
//  FocusNode focusNode;
//  InputDecoration decoration = const InputDecoration();
//  TextInputType keyboardType;
//  TextCapitalization textCapitalization = TextCapitalization.none;
//  TextInputAction textInputAction;
//  TextStyle style;
//  StrutStyle strutStyle;
//  TextDirection textDirection;
//  TextAlign textAlign = TextAlign.start;
//  TextAlignVertical textAlignVertical;
//  bool autofocus = false;
//  bool readOnly = false;
//  ToolbarOptions toolbarOptions;
//  bool showCursor;
//  bool obscureText = false;
//  bool autocorrect = true;
//  bool enableSuggestions = true;
//  bool autovalidate = false;
//  bool maxLengthEnforced = true;
//  int maxLines = 1;
//  int minLines;
//  bool expands = false;
//  int maxLength;
//  ValueChanged<String> onChanged;
//  GestureTapCallback onTap;
//  VoidCallback onEditingComplete;
//  ValueChanged<String> onFieldSubmitted;
//  FormFieldSetter<String> onSaved;
//  FormFieldValidator<String> validator;
//  List<TextInputFormatter> inputFormatters;
//  bool enabled = true;
//  double cursorWidth = 2.0;
//  Radius cursorRadius;
//  Color cursorColor;
//  Brightness keyboardAppearance;
//  EdgeInsets scrollPadding = const EdgeInsets.all(20.0);
//  bool enableInteractiveSelection = true;
//  InputCounterWidgetBuilder buildCounter;
//  TextEditingController controller;
//
//  ChangeColorTextFiled({
//    this.key,
//    this.controller,
//    this.initialValue,
//    this.focusNode,
//    this.decoration = const InputDecoration(),
//    this.keyboardType,
//    this.textCapitalization = TextCapitalization.none,
//    this.textInputAction,
//    this.style,
//    this.strutStyle,
//    this.textDirection,
//    this.textAlign = TextAlign.start,
//    this.textAlignVertical,
//    this.autofocus = false,
//    this.readOnly = false,
//    this.toolbarOptions,
//    this.showCursor,
//    this.obscureText = false,
//    this.autocorrect = true,
//    this.enableSuggestions = true,
//    this.autovalidate = false,
//    this.maxLengthEnforced = true,
//    this.maxLines = 1,
//    this.minLines,
//    this.expands = false,
//    this.maxLength,
//    this.onChanged,
//    this.onTap,
//    this.onEditingComplete,
//    this.onFieldSubmitted,
//    this.onSaved,
//    this.validator,
//    this.inputFormatters,
//    this.enabled = true,
//    this.cursorWidth = 2.0,
//    this.cursorRadius,
//    this.cursorColor,
//    this.keyboardAppearance,
//    this.scrollPadding = const EdgeInsets.all(20.0),
//    this.enableInteractiveSelection = true,
//    this.buildCounter,
//  });
//
//  @override
//  _ChangeColorTextFiledState createState() => _ChangeColorTextFiledState();
//}
//
//class _ChangeColorTextFiledState extends State<ChangeColorTextFiled> {
//
//  int i = 0;
//
//  changeColor() {
//    i = ++i % 7;
//    setState(() {
//
//    });
//  }
//
//  @override
//  Widget build(BuildContext context) {
//    return TextFormField(
//        key: widget.key,
//        controller: widget.controller,
//        initialValue: widget.initialValue,
//        focusNode: widget.focusNode,
//        decoration: widget.decoration.copyWith(prefixStyle: ),
//        keyboardType: widget.keyboardType,
//        textCapitalization: widget.textCapitalization,
//        textInputAction: widget.textInputAction,
//        style: TextStyle(color:Rainbows[i]),
//        strutStyle: widget.strutStyle,
//        textDirection: widget.textDirection,
//        textAlign: widget.textAlign,
//        textAlignVertical: widget.textAlignVertical,
//        autofocus: widget.autofocus,
//        readOnly: widget.readOnly,
//        toolbarOptions: widget.toolbarOptions,
//        showCursor: widget.showCursor,
//        obscureText: widget.obscureText,
//        autocorrect: widget.autocorrect,
//        enableSuggestions: widget.enableSuggestions,
//        autovalidate: widget.autovalidate,
//        maxLengthEnforced: widget.maxLengthEnforced,
//        maxLines: widget.maxLines,
//        minLines: widget.minLines,
//        expands: widget.expands,
//        maxLength: widget.maxLength,
//        onChanged: (value) {
//          if(widget.onChanged!=null){
//            widget.onChanged(value);
//          }
//          changeColor();
//        },
//        onTap: widget.onTap,
//        onEditingComplete: widget.onEditingComplete,
//        onFieldSubmitted: widget.onFieldSubmitted,
//        onSaved: widget.onSaved,
//        validator: widget.validator,
//        inputFormatters: widget.inputFormatters,
//        enabled: widget.enabled,
//        cursorWidth: widget.cursorWidth,
//        cursorRadius: widget.cursorRadius,
//        cursorColor: Rainbows[6-i],
//        keyboardAppearance: widget.keyboardAppearance,
//        scrollPadding: widget.scrollPadding,
//        enableInteractiveSelection: widget.enableInteractiveSelection,
//        buildCounter: widget.buildCounter);
//    ;
//  }
//}
