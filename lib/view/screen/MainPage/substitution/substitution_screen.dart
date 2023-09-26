import 'package:flutter/material.dart';
import 'package:gallery_vault/view/res/assets_path.dart';
import 'package:gallery_vault/view/utils/size_utils.dart';

import '../../../res/app_colors.dart';
import '../../../res/strings_utils.dart';
import '../../../utils/navigation_utils/navigation.dart';

class SubStitution extends StatefulWidget {
  const SubStitution({super.key});

  @override
  State<SubStitution> createState() => _SubStitutionState();
}

class _SubStitutionState extends State<SubStitution> {
  int select = 1;
  List name = [
    "Weekly",
    "Yearly",
    "Life Time",
  ];
  List name2 = [
    '\$125',
    '\$100',
    '\$50',
  ];
  List name3 = [
    "SAVE 10%",
    'SAVE 10%',
    'SAVE 10%',
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigation.pop();
          },
          icon: Icon(
            Icons.arrow_back_ios_new,
            color: AppColor.white,
          ),
        ),
        title: Text(
          "SubStitution",
          style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18, color: AppColor.white),
        ),
        centerTitle: true,
        backgroundColor: AppColor.blackdark,
      ),
      backgroundColor: AppColor.black,
      body: Stack(
        children: [
          Container(
            height: SizeUtils.screenHeight,
            width: SizeUtils.screenWidth,
            color: AppColor.black,
          ),
          Positioned(
            child: Image.asset(
              AssetsPath.substitution,
              fit: BoxFit.cover,
              width: double.infinity,
            ),
          ),
          Positioned(
            child: Image.asset(
              AssetsPath.substitution2,
              fit: BoxFit.cover,
              width: double.infinity,
            ),
          ),
          Positioned(
              top: 250,
              right: 0,
              left: 0,
              child: Column(
                children: [
                  Text(
                    "NOW ENJOY AD FREE",
                    style: TextStyle(fontSize: 23, fontWeight: FontWeight.w600, color: AppColor.white,fontFamily:  AppString.kMuseoModerno,),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    height: SizeUtils.verticalBlockSize * 15,
                    width: SizeUtils.horizontalBlockSize * 91.05,
                    decoration: BoxDecoration(
                      border: Border.all(color: AppColor.graydark,width: 2),
                      color: AppColor.blackdark,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      children: List.generate(
                          3,
                          (index) => InkWell(
                                onTap: () {
                                  setState(() {
                                    select = index;
                                  });
                                },
                                child: Container(
                                  height: SizeUtils.verticalBlockSize * 15,
                                  width: SizeUtils.horizontalBlockSize * 30,
                                  decoration: BoxDecoration(
                                    border: select==index ? Border.all(color: AppColor.white,width: 1):Border.all(color: Colors.transparent),
                                    borderRadius: ((index == 0)
                                        ? const BorderRadius.only(bottomLeft: Radius.circular(20), topLeft: Radius.circular(20))
                                        : index == 2
                                            ? const BorderRadius.only(bottomRight: Radius.circular(20), topRight: Radius.circular(20))
                                            : BorderRadius.circular(0)),
                                    color: select == index ? AppColor.purpal : AppColor.blackdark,
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Text(
                                        name[index],
                                        style: TextStyle(color: AppColor.white, fontWeight: FontWeight.w500, fontSize: 15),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Text(
                                        name2[index],
                                        style: TextStyle(color: AppColor.white, fontSize: 15, fontWeight: FontWeight.w700),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Container(
                                          height: SizeUtils.verticalBlockSize * 2,
                                          width: SizeUtils.horizontalBlockSize * 12,
                                          decoration: BoxDecoration(
                                              color: select == index ? Color(0xffA39CF9).withOpacity(0.4) : Color(0xffA39CF9).withOpacity(0.2),
                                              borderRadius: BorderRadius.circular(10)),
                                          child: Center(
                                              child: Text(
                                            name3[index],
                                            style: TextStyle(
                                                color: select == index ? AppColor.white : Color(0xffA39CF9),
                                                fontSize: 6,
                                                fontWeight: FontWeight.w700),
                                          ))),
                                    ],
                                  ),
                                ),
                              )),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: SizeUtils.horizontalBlockSize * 5),
                    child: Text(
                      "Lorem Ipsum is simply dummy text of the printing and typesetting \nindustry. Lorem Ipsum has been the industry's standard dummy text \never since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type \nspecimen book.",
                      style: TextStyle(fontSize: 11, fontWeight: FontWeight.w400, color: AppColor.greyText),
                    ),
                  ),
                  SizedBox(
                    height: 35,
                  ),
                  Container(
                    height: SizeUtils.verticalBlockSize * 7.5,
                    width: SizeUtils.horizontalBlockSize * 70,
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(30), color: AppColor.purpal),
                    child: Center(
                      child: Text(
                        "Buy Now",
                        style: TextStyle(color: AppColor.white, fontWeight: FontWeight.w700, fontSize: 16),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  const Center(
                    child: Text(
                      'Restore',
                      style: TextStyle(color: AppColor.greyText, fontSize: 15, fontWeight: FontWeight.w500),
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  const Center(
                    child: Text(
                      'Cancel Any Time',
                      style: TextStyle(color: AppColor.greyText, fontSize: 15, fontWeight: FontWeight.w500),
                    ),
                  ),
                ],
              ))
        ],
      ),
    );
  }
}
