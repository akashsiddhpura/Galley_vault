import 'package:gallery_vault/view/res/strings_utils.dart';
import 'package:gallery_vault/view/utils/size_utils.dart';
import 'package:flutter/material.dart';

import '../res/app_colors.dart';


class CommonTextStyle {
  static TextStyle titleStyle = TextStyle(color: AppColor.primaryClr, fontWeight: FontWeight.w500, fontSize: SizeUtils.fSize_20());
  static TextStyle title =  const TextStyle(fontWeight: FontWeight.w600,fontSize: 18,fontFamily: AppString.kMuseoModerno,color: AppColor.purpal);
  // static TextStyle titleStyle = TextStyle(color: AppColor.primaryClr, fontWeight: FontWeight.w600, fontSize: SizeUtils.fSize_24());
  static TextStyle detailStyle = TextStyle(color: AppColor.primaryClr.withOpacity(0.5), fontWeight: FontWeight.w400, fontSize: SizeUtils.fSize_14());
  static TextStyle listTileBold = TextStyle(color: AppColor.primaryClr, fontWeight: FontWeight.w600, fontSize: SizeUtils.fSize_16());
}
