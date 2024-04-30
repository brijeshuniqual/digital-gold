import 'package:untitled/constants/app.export.dart';
import 'package:untitled/constants/constant.dart';

// class BaseRaisedButton extends ElevatedButton {
//   final VoidCallback onPressed;
//   final String buttonText;
//   final double? fontSize;
//   final double? borderRadius;
//   final FontWeight? fontWeight;
//   final Color? buttonColor;
//   final Color? textColor;
//   final double? buttonVerticalPadding;
//   final double? buttonHorizontalPadding;
//
//   BaseRaisedButton(
//       {Key? key,
//       required this.buttonText,
//       required this.onPressed,
//       this.fontSize,
//       this.fontWeight,
//       this.buttonColor,
//       this.buttonVerticalPadding,
//       this.buttonHorizontalPadding,
//       this.borderRadius,
//       this.textColor})
//       : super(
//           key: key,
//           child: BaseText(
//             text: buttonText,
//             color: textColor ?? ColorRes.whiteColor,
//             fontSize: fontSize ?? 18,
//             fontWeight: fontWeight ?? FontWeight.w600,
//             fontFamily: "Montserrat",
//           ),
//           onPressed: (){
//             HapticFeedback.lightImpact();
//           },
//           style: ButtonStyle(
//               shape: MaterialStateProperty.all<RoundedRectangleBorder>(
//                 RoundedRectangleBorder(borderRadius: BorderRadius.circular(borderRadius ?? 7.0), side: const BorderSide(color: Colors.transparent)),
//               ),
//               backgroundColor: MaterialStateProperty.all(buttonColor ?? ColorRes.primaryColor),
//               elevation: MaterialStateProperty.all(0),
//               padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
//                   EdgeInsets.symmetric(vertical: buttonVerticalPadding ?? 18, horizontal: buttonHorizontalPadding ?? 0))),
//         );
// }

class BaseRaisedButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String buttonText;
  final double? fontSize;
  final double? borderRadius;
  final FontWeight? fontWeight;
  final Color? buttonColor;
  final Color? textColor;
  final double? buttonVerticalPadding;
  final double? buttonHorizontalPadding;
  final Color? borderColor;
  final double? borderWidth;

  const BaseRaisedButton(
      {super.key,
      required this.buttonText,
      required this.onPressed,
      this.fontSize,
      this.fontWeight,
      this.buttonColor,
      this.buttonVerticalPadding,
      this.buttonHorizontalPadding,
      this.borderRadius,
      this.textColor,
      this.borderColor,
      this.borderWidth,});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      key: key,
      onPressed: () {
        HapticFeedback.lightImpact();
        onPressed();
      },
      style: ButtonStyle(
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(borderRadius ?? 7.0), side: BorderSide(width: borderWidth ?? 1.getSize, color: borderColor ?? Colors.transparent)),
          ),
          backgroundColor: MaterialStateProperty.all(buttonColor ?? ColorRes.primaryColor),
          elevation: MaterialStateProperty.all(0),
          padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
              EdgeInsets.symmetric(vertical: buttonVerticalPadding ?? 18, horizontal: buttonHorizontalPadding ?? 0))),
      child: BaseText(
        text: buttonText,
        color: textColor ?? ColorRes.whiteColor,
        fontSize: fontSize ?? 18,
        fontWeight: fontWeight ?? FontWeight.w600,
        fontFamily: "Pangram",
      ),
    );
  }
}
