import 'package:gallery_vault/view/utils/size_utils.dart';
import 'package:flutter/material.dart';

import '../res/app_colors.dart';
import '../res/assets_path.dart';
import '../res/strings_utils.dart';

class CustomButton extends StatelessWidget {
  double? width;

  final double? height;
  final ButtonStyle? style;
  final void Function()? onPressed;
  final String? text;
  final FontWeight? fontWeight;
  final double? fontSize;
  final Color? textColor;
  bool? bordered = false;
  final Color? buttonColor;
  final Color? color;
  final Color? borderColor;
  final double? radius;
  final Gradient? gradient;
  final TextStyle? textStyle;
  final List<BoxShadow>? buttonShadow;
  final String? buttonIcon;
  final double? iconSize;

  CustomButton(
      {Key? key, this.buttonShadow, this.width, this.height, this.style, required this.onPressed, required this.text, this.fontWeight, this.fontSize, this.textColor, this.buttonColor, this.bordered, this.borderColor, this.gradient, this.radius, this.textStyle, this.buttonIcon, this.iconSize,  this.color })
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: onPressed,
      splashColor: AppColor.primaryClr.withOpacity(0.5),
      minWidth: 0,
      padding: EdgeInsets.zero,
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Container(
        padding: EdgeInsets.all(5),
        width: width ?? double.infinity,
        height: height ?? SizeUtils.horizontalBlockSize * 16,
        decoration: BoxDecoration(
          // color: buttonColor ?? AppColor.primaryClr,
          color: color?? AppColor.blackdark,
          borderRadius: BorderRadius.circular(radius ?? 30),
          border: Border.all(
            color: bordered == true ? Color(0xFF4F5051) : Colors.transparent,
            width: 2,
          ),
        ),
        child: Center(
          child: Text(
            text ?? "",
            textAlign: TextAlign.center,
            style: textStyle ?? TextStyle(fontWeight: fontWeight ?? FontWeight.w600, fontSize: fontSize ?? SizeUtils.fSize_16(), color: textColor ?? AppColor.white),
          ),
        ),
      ),
    );
  }
}


class CustomButton2 extends StatelessWidget {
  double? width;

  final double? height;
  final ButtonStyle? style;
  final void Function()? onPressed;
  final String? text;
  final FontWeight? fontWeight;
  final double? fontSize;
  final Color? textColor;
  bool? bordered = false;
  final Color? buttonColor;
  final Color? borderColor;
  final double? radius;
  final Gradient? gradient;
  final TextStyle? textStyle;
  final List<BoxShadow>? buttonShadow;
  final String? buttonIcon;
  final double? iconSize;

  CustomButton2(
      {Key? key, this.buttonShadow, this.width, this.height, this.style, required this.onPressed, required this.text, this.fontWeight, this.fontSize, this.textColor, this.buttonColor, this.bordered, this.borderColor, this.gradient, this.radius, this.textStyle, this.buttonIcon, this.iconSize, required Color color})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: onPressed,
      child: Container(
        height: SizeUtils.verticalBlockSize * 7,
        width: SizeUtils.horizontalBlockSize * 80,
        decoration: BoxDecoration(
            color: AppColor.purpal,
            borderRadius: BorderRadius.circular(30)
        ),
        child: Center(child: Text( text ?? "",style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w700,
          color: AppColor.white,
        )),),
      ),
    );
  }
}
