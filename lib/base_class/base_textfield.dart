import 'package:untitled/constants/app.export.dart';
import 'package:untitled/constants/constant.dart';

class BaseTextField extends TextFormField {
  final String? labelText;
  final String? hintText;
  final String? obscuringCharacter;
  final TextEditingController controller;
  final TextInputType? textInputType;
  final bool? isSecure;
  final bool enabled;
  final String? Function(String?)? validator;
  final Widget? suffixIcon;
  final Color? fillColor;
  final Color? borderColor;
  final Color? textColor;
  final Color? cursorColor;
  final Widget? prefixIcon;
  final TextAlign? textAlign;
  final bool readOnly;
  final Function()? onEditingComplete;
  final Function(String?)? onSaved;
  final Function(String)? onChanged;
  final Function()? onTap;
  final TextCapitalization? textCapitalization;
  final double? borderRadius;
  final EdgeInsets? contentPadding;
  final TextInputAction? textInputAction;
  final List<TextInputFormatter>? inputFormatters;
  final int? maxLines;
  final int? errorMaxLines;
  final int? hintMaxLines;
  final Function(String?)? onFieldSubmitted;
  final int? minLines;
  final TextStyle? hintStyle;
  final TextStyle? labelStyle;
  final InputBorder? customBorder;

  BaseTextField({
    this.hintText,
    this.labelText,
    this.maxLines,
    this.errorMaxLines,
    this.suffixIcon,
    required this.controller,
    this.onEditingComplete,
    this.borderRadius,
    this.cursorColor,
    this.onChanged,
    this.onTap,
    this.textCapitalization,
    this.prefixIcon,
    this.textAlign,
    this.readOnly = false,
    this.fillColor,
    this.borderColor,
    this.obscuringCharacter,
    this.textColor,
    this.textInputType,
    this.isSecure = false,
    this.enabled = true,
    this.validator,
    this.textInputAction,
    this.contentPadding,
    this.inputFormatters,
    this.hintMaxLines,
    this.onSaved,
    this.onFieldSubmitted,
    this.minLines,
    this.hintStyle,
    this.labelStyle,
    this.customBorder,
  }) : super(
          controller: controller,
          keyboardType: textInputType ?? TextInputType.text,
          obscureText: isSecure ?? false,
          style: TextStyle(
            fontSize: Utils.getFontSize(16),
            fontWeight: FontWeight.normal,
            color: textColor ?? ColorRes.blackColor,
            letterSpacing: Utils.getSize(0.5),
            fontFamily: "Montserrat",
          ),
          textCapitalization: textCapitalization ?? TextCapitalization.none,
          onEditingComplete: onEditingComplete,
          onChanged: onChanged,
          onTap: onTap,
          textInputAction: textInputAction ?? TextInputAction.next,
          enabled: enabled,
          cursorColor: cursorColor ?? ColorRes.blackColor,
          textAlign: textAlign ?? TextAlign.start,
          readOnly: readOnly,
          maxLines: maxLines ?? 1,
          onSaved: onSaved,
          onFieldSubmitted: onFieldSubmitted,
          minLines: minLines,
          obscuringCharacter: obscuringCharacter ?? '•',
          inputFormatters: inputFormatters ?? [],
          decoration: InputDecoration(
              prefixIcon: prefixIcon,
              suffixIcon: suffixIcon,
              fillColor: fillColor ?? ColorRes.whiteColor,
              filled: true,
              counterText: '',
              border: customBorder ??
                  UnderlineInputBorder(
                      borderRadius: BorderRadius.circular(borderRadius ?? 7.0),
                      borderSide: BorderSide(color: borderColor ?? ColorRes.whiteColor, width: 0.0)),
              focusedBorder: customBorder ??
                  UnderlineInputBorder(
                      borderRadius: BorderRadius.circular(borderRadius ?? 7.0),
                      borderSide: BorderSide(color: borderColor ?? ColorRes.whiteColor, width: 0.0)),
              enabledBorder: customBorder ??
                  UnderlineInputBorder(
                      borderRadius: BorderRadius.circular(borderRadius ?? 7.0),
                      borderSide: BorderSide(color: borderColor ?? ColorRes.whiteColor, width: 0.0)),
              errorBorder: customBorder ??
                  UnderlineInputBorder(
                      borderRadius: BorderRadius.circular(borderRadius ?? 7.0),
                      borderSide: BorderSide(color: borderColor ?? ColorRes.whiteColor, width: 0.0)),
              focusedErrorBorder: customBorder ??
                  UnderlineInputBorder(
                      borderRadius: BorderRadius.circular(borderRadius ?? 7.0),
                      borderSide: BorderSide(color: borderColor ?? ColorRes.whiteColor, width: 0.0)),
              disabledBorder: customBorder ??
                  UnderlineInputBorder(
                      borderRadius: BorderRadius.circular(borderRadius ?? 7.0),
                      borderSide: BorderSide(color: borderColor ?? ColorRes.whiteColor, width: 0.0)),
              contentPadding: contentPadding ?? EdgeInsets.symmetric(vertical: Utils.getSize(22), horizontal: Utils.getSize(20)),
              errorMaxLines: errorMaxLines ?? 1,
              hintText: hintText,
              hintMaxLines: hintMaxLines ?? 1,
              labelText: labelText,
              labelStyle: labelStyle ??
                  TextStyle(
                      fontSize: Utils.getFontSize(15),
                      fontWeight: FontWeight.normal,
                      letterSpacing: Utils.getSize(0.5),
                      color: textColor ?? ColorRes.textGreyColor,
                      fontFamily: "Montserrat"),
              hintStyle: hintStyle ??
                  TextStyle(
                      fontFamily: "Montserrat",
                      fontSize: Utils.getFontSize(14),
                      fontWeight: FontWeight.normal,
                      letterSpacing: Utils.getSize(0.5),
                      color: textColor ?? ColorRes.textGreyColor)),
          validator: (name) {
            validator;
            return null;
          },
        );
}

class BasePangramTextField extends TextFormField {
  final String? labelText;
  final String? hintText;
  final String? obscuringCharacter;
  final TextEditingController controller;
  final TextInputType? textInputType;
  final bool? isSecure;
  final bool enabled;
  final String? Function(String?)? validator;
  final Widget? suffixIcon;
  final Color? fillColor;
  final Color? borderColor;
  final Color? textColor;
  final Color? cursorColor;
  final Widget? prefixIcon;
  final TextAlign? textAlign;
  final bool readOnly;
  final Function()? onEditingComplete;
  final Function(String?)? onSaved;
  final Function(String)? onChanged;
  final Function()? onTap;
  final TextCapitalization? textCapitalization;
  final double? borderRadius;
  final EdgeInsets? contentPadding;
  final TextInputAction? textInputAction;
  final List<TextInputFormatter>? inputFormatters;
  final int? maxLines;
  final int? errorMaxLines;
  final int? hintMaxLines;
  final Function(String?)? onFieldSubmitted;
  final int? minLines;
  final TextStyle? hintStyle;
  final TextStyle? labelStyle;
  final InputBorder? customBorder;
  final InputBorder? focusedBorder;
  final int? maxLength;
  final bool autofocus;
  final FocusNode? focusNode;

  BasePangramTextField({
    this.focusNode,
    this.autofocus = false,
    this.focusedBorder,
    this.maxLength,
    this.hintText,
    this.labelText,
    this.maxLines,
    this.errorMaxLines,
    this.suffixIcon,
    required this.controller,
    this.onEditingComplete,
    this.borderRadius,
    this.cursorColor,
    this.onChanged,
    this.onTap,
    this.textCapitalization,
    this.prefixIcon,
    this.textAlign,
    this.readOnly = false,
    this.fillColor,
    this.borderColor,
    this.obscuringCharacter,
    this.textColor,
    this.textInputType,
    this.isSecure = false,
    this.enabled = true,
    this.validator,
    this.textInputAction,
    this.contentPadding,
    this.inputFormatters,
    this.hintMaxLines,
    this.onSaved,
    this.onFieldSubmitted,
    this.minLines,
    this.hintStyle,
    this.labelStyle,
    this.customBorder,
  }) : super(
    focusNode: focusNode,
    autofocus: autofocus,
          maxLength: maxLength,
          controller: controller,
          keyboardType: textInputType ?? TextInputType.text,
          obscureText: isSecure ?? false,
          style: TextStyle(
            fontSize: Utils.getFontSize(16),
            fontWeight: FontWeight.normal,
            color: textColor ?? ColorRes.blackColor,
            letterSpacing: Utils.getSize(0.5),
            fontFamily: "Pangram",
          ),
          onTapOutside: (event) {
            Utils.hideKeyboard();
          },
          textCapitalization: textCapitalization ?? TextCapitalization.none,
          onEditingComplete: onEditingComplete,
          onChanged: onChanged,
          onTap: onTap,
          textInputAction: textInputAction ?? TextInputAction.next,
          enabled: enabled,
          cursorColor: cursorColor ?? ColorRes.blackColor,
          textAlign: textAlign ?? TextAlign.start,
          readOnly: readOnly,
          maxLines: maxLines ?? 1,
          onSaved: onSaved,
          onFieldSubmitted: onFieldSubmitted,
          minLines: minLines,
          obscuringCharacter: obscuringCharacter ?? '•',
          inputFormatters: inputFormatters ?? [],
          decoration: InputDecoration(
              prefixIcon: prefixIcon,
              suffixIcon: suffixIcon,
              fillColor: fillColor ?? ColorRes.whiteColor,
              filled: true,
              counterText: '',
              border: customBorder ?? OutlineInputBorder(
                borderRadius: BorderRadius.circular(20.getSize),
                borderSide: BorderSide(
                  color: ColorRes.textFieldGreyColor,
                  width: Utils.getSize(1.5),
                ),
              ),
              focusedBorder: focusedBorder ?? OutlineInputBorder(
                borderRadius: BorderRadius.circular(20.getSize),
                borderSide: BorderSide(
                  color: ColorRes.textFieldGreyColor,
                  width: Utils.getSize(1.5),
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20.getSize),
                borderSide: BorderSide(
                  color: ColorRes.textFieldGreyColor,
                  width: Utils.getSize(1.5),
                ),
              ),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20.getSize),
                borderSide: BorderSide(
                  color: ColorRes.textFieldGreyColor,
                  width: Utils.getSize(1.5),
                ),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20.getSize),
                borderSide: BorderSide(
                  color: ColorRes.textFieldGreyColor,
                  width: Utils.getSize(1.5),
                ),
              ),
              disabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20.getSize),
                borderSide: BorderSide(
                  color: ColorRes.textFieldGreyColor,
                  width: Utils.getSize(1.5),
                ),
              ),
              contentPadding: contentPadding ?? EdgeInsets.symmetric(vertical: Utils.getSize(18), horizontal: Utils.getSize(16),),
              errorMaxLines: errorMaxLines ?? 1,
              hintText: hintText,
              hintMaxLines: hintMaxLines ?? 1,
              labelText: labelText,
              labelStyle: labelStyle ??
                  TextStyle(
                      fontSize: Utils.getFontSize(15),
                      fontWeight: FontWeight.normal,
                      letterSpacing: Utils.getSize(0.5),
                      color: textColor ?? ColorRes.textGreyColor,
                      fontFamily: "Pangram"),
              hintStyle: hintStyle ??
                  TextStyle(
                      fontFamily: "Pangram",
                      fontSize: Utils.getFontSize(14),
                      fontWeight: FontWeight.w400,
                      letterSpacing: Utils.getSize(0.5),
                      color: textColor ?? ColorRes.silverColor)),
          validator: (name) {
            validator;
            return null;
          },
        );
}
