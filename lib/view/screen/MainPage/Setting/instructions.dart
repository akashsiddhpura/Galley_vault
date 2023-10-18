import 'package:flutter/material.dart';
import 'package:gallery_vault/view/utils/size_utils.dart';

import '../../../res/app_colors.dart';
import '../../../utils/navigation_utils/navigation.dart';

class InstructionsScreen extends StatefulWidget {
  const InstructionsScreen({super.key});

  @override
  State<InstructionsScreen> createState() => _InstructionsScreenState();
}

class _InstructionsScreenState extends State<InstructionsScreen> {
  List name = [
    "Where are the locked files?",
    "How to lock files?",
    "How to unlocked files?",
  ];
  List name2 = [
    'For the security, locked files can only be viewed in the Vault.\n\n click the "Lock" buttom of the homepage and enter your password to view.',
    'Option 1: Long press to select the files, the select "Hide" within more option at the page. \n\nOption 2: Go to "Vault". Click the "+" Button at the bottom of the page to import files.',
    '1. Go to "Vault".\n2. Long press to select files.\n3. Select "Unhide" within more option at the top of the page.',
  ];
  List iconsss = [
    Icons.lock,
    Icons.lock,
    Icons.lock_open,
  ];
  int select = -1;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColor.blackdark,
        leading: InkWell(
          onTap: () {
            Navigation.pop();
          },
          child: Icon(
            Icons.arrow_back_ios_new,
            color: AppColor.white,
          ),
        ),
        title: Text(
          "InstructionsScreen",
          style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 18,
              color: AppColor.white),
        ),
        centerTitle: true,
      ),
      backgroundColor: AppColor.black,
      body: SingleChildScrollView(
        child: Padding(
          padding:  EdgeInsets.symmetric(horizontal:  SizeUtils.horizontalBlockSize * 8,),
          child: Column(
            children: [
              SizedBox(
                height: SizeUtils.verticalBlockSize * 3,
              ),
              Column(
                children: List.generate(3, (index) =>      Column(
                  children: [
                    InkWell(
                      onTap: () {
                        setState(() {
                          select = index ;
                        });
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: AppColor.blackdark,
                        ),
                        child: Padding(
                          padding:  EdgeInsets.symmetric(horizontal: SizeUtils.horizontalBlockSize *4),
                          child: Column(children: [
                            SizedBox(
                              height: SizeUtils.verticalBlockSize * 2,
                            ),
                            Row(
                              children: [
                                Icon(Icons.lock,color: AppColor.white.withOpacity(0.8),),
                                SizedBox(width: SizeUtils.horizontalBlockSize * 3,),
                                Text(name[index],style: TextStyle(color: AppColor.white,fontWeight: FontWeight.w700,fontSize: 14),),
                                const Spacer(),
                                Icon(select ==index? Icons.keyboard_arrow_up:Icons.keyboard_arrow_down_sharp,color: AppColor.white,size: 30,)
                              ],
                            ),
                            SizedBox(
                              height: SizeUtils.verticalBlockSize * 2,
                            ),
                            select==index?  Padding(
                              padding:  EdgeInsets.symmetric(horizontal: SizeUtils.horizontalBlockSize * 5),
                              child: Text(name2[index],style: const TextStyle(fontSize: 12,color: AppColor.greyText),),
                            ):SizedBox(),
                           select==index? SizedBox(
                              height: SizeUtils.verticalBlockSize * 2,
                            ):const SizedBox(),
                          ],),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: SizeUtils.verticalBlockSize * 3,
                    ),
                  ],
                ),
                  ),
              )

            ],
          ),
        ),
      ),
    );
  }
}
