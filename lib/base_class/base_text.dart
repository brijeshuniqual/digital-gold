

import 'package:google_fonts/google_fonts.dart';

import '../constants/app.export.dart';

class BaseText extends Text {
  final String text;
  final Color? color;
  final TextAlign? textAlign;
  final double? fontSize;
  final FontWeight? fontWeight;
  final TextOverflow? overflow;
  final int? maxLines;
  final double? letterSpacing;
  final String? fontFamily;
  final TextDecoration? textDecoration;
  final double? lineHeight;
  final TextDirection? textDirection;
  final bool softWrap;

  BaseText({
    required this.text,
    this.color,
    this.textAlign,
    this.fontSize,
    this.fontWeight,
    this.overflow,
    this.fontFamily,
    this.maxLines,
    this.letterSpacing,
    this.textDecoration,
    this.lineHeight,
    this.textDirection,
    this.softWrap = true,
  }) : super(text,
            textScaleFactor: 0.80,
            textAlign: textAlign ?? TextAlign.center,
            overflow: overflow ?? TextOverflow.ellipsis,
            maxLines: maxLines,
            softWrap: softWrap,
            textDirection: textDirection,
            style: TextStyle(
              decoration: textDecoration ?? TextDecoration.none,
              color: color ?? ColorRes.blackColor,
              fontSize: fontSize != null ? Utils.getFontSize(fontSize) : Utils.getFontSize(20),
              fontWeight: (fontWeight ?? FontWeight.normal),
              fontFamily: (fontFamily ?? "IBM_Plex_Sans"),
              height: lineHeight,
              letterSpacing: letterSpacing ?? 0.1,
            ));
}

class BasePoppinsText extends Text {
  final String text;
  final Color? color;
  final TextAlign? textAlign;
  final double? fontSize;
  final FontWeight? fontWeight;
  final TextOverflow? overflow;
  final int? maxLines;
  final double? letterSpacing;
  final String? fontFamily;
  final TextDecoration? textDecoration;
  final double? lineHeight;
  final TextDirection? textDirection;
  final bool softWrap;

  BasePoppinsText({
    required this.text,
    this.color,
    this.textAlign,
    this.fontSize,
    this.fontWeight,
    this.overflow,
    this.fontFamily,
    this.maxLines,
    this.letterSpacing,
    this.textDecoration,
    this.lineHeight,
    this.textDirection,
    this.softWrap = true,
  }) : super(text,
      textScaleFactor: 0.80,
      textAlign: textAlign ?? TextAlign.center,
      overflow: overflow ?? TextOverflow.ellipsis,
      maxLines: maxLines,
      softWrap: softWrap,
      textDirection: textDirection,
      style: GoogleFonts.poppins(
        decoration: textDecoration ?? TextDecoration.none,
        color: color ?? ColorRes.blackColor,
        fontSize: fontSize != null ? Utils.getFontSize(fontSize+2) : Utils.getFontSize(20),
        fontWeight: (fontWeight ?? FontWeight.normal),
        height: lineHeight,
        letterSpacing: letterSpacing ?? 0.1,
      ));
}

class BasePangramText extends Text {
  final String text;
  final Color? color;
  final TextAlign? textAlign;
  final double? fontSize;
  final FontWeight? fontWeight;
  final TextOverflow? overflow;
  final int? maxLines;
  final double? letterSpacing;
  final String? fontFamily;
  final TextDecoration? textDecoration;
  final double? lineHeight;
  final TextDirection? textDirection;
  final bool softWrap;

  BasePangramText({
    required this.text,
    this.color,
    this.textAlign,
    this.fontSize,
    this.fontWeight,
    this.overflow,
    this.fontFamily,
    this.maxLines,
    this.letterSpacing,
    this.textDecoration,
    this.lineHeight,
    this.textDirection,
    this.softWrap = true,
  }) : super(text,
      textScaleFactor: 0.80,
      textAlign: textAlign ?? TextAlign.center,
      overflow: overflow ?? TextOverflow.ellipsis,
      maxLines: maxLines,
      softWrap: softWrap,
      textDirection: textDirection,
      style: TextStyle(
        fontFamily: 'Pangram',
        decoration: textDecoration ?? TextDecoration.none,
        color: color ?? ColorRes.blackColor,
        fontSize: fontSize != null ? Utils.getFontSize(fontSize+2) : Utils.getFontSize(20),
        fontWeight: (fontWeight ?? FontWeight.normal),
        height: lineHeight,
        letterSpacing: letterSpacing ?? 0.1,
      ));
}