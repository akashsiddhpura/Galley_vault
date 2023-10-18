

import 'package:flutter/material.dart';
import 'package:gallery_vault/view/utils/size_utils.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../res/app_colors.dart';
import '../../../utils/navigation_utils/navigation.dart';
import '../../../widgets/custom_textfield.dart';


class SendFeedbackScreen extends StatefulWidget {
  const SendFeedbackScreen({super.key});

  @override
  State<SendFeedbackScreen> createState() => _SendFeedbackScreenState();
}

class _SendFeedbackScreenState extends State<SendFeedbackScreen> {
  // int? select;
  bool select = true;
  String? subject;
  TextEditingController feedbackC = TextEditingController();
  List select1 = [];
  List name = [
    'View Image',
    'Private Folder',
      'Bugs',
    'Edit Photo',
    'Too Slow ',
    'Others'
  ];
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
          padding:  EdgeInsets.symmetric(horizontal: SizeUtils.horizontalBlockSize * 8),
          child: Column(crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: SizeUtils.verticalBlockSize * 4,
              ),
              Center(child: Image.asset('asset/images/sendfeedback.png',height: SizeUtils.verticalBlockSize * 15,)),
              SizedBox(
                height: SizeUtils.verticalBlockSize * 5,
              ),
              Text("What are you not satisfied with?",style: TextStyle(color: AppColor.white,fontSize: 20,fontWeight: FontWeight.w600),),
              SizedBox(
                height: SizeUtils.verticalBlockSize * 3,
              ),
              const Align(
                  alignment: Alignment.centerLeft,
                  child: Text("Select Type",style: TextStyle(color: AppColor.greyText,fontWeight: FontWeight.w600,fontSize: 20),)),
              SizedBox(
                height: SizeUtils.verticalBlockSize * 2,
              ),
              Wrap(
                children: List.generate(6, (index) => InkWell(
                  onTap: () {
                    setState(() {
                      select1.contains(index) ? select1.remove(index): select1.add(index);
                    });

                  },
                  child: Container(
                    height: SizeUtils.verticalBlockSize * 5.5,
                    width: SizeUtils.horizontalBlockSize * 23,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(width: 1,color: AppColor.greyText),
                      color: select1.contains(index)? AppColor.purpal: Colors.transparent,
                    ),
                    margin: const EdgeInsets.only(left: 18,bottom: 10,top: 10),
                    child: Center(
                      child: Text(name[index],style: TextStyle(color:select1.contains(index)? AppColor.white:AppColor.greyText,fontSize: 12,fontWeight: FontWeight.w500),),
                    ),
                  ),
                )),
              ),
              SizedBox(
                height: SizeUtils.verticalBlockSize * 2,
              ),
              CustomTextField(controller:feedbackC,
                maxLine: 5,
                fillColor: AppColor.blackdark,
                hintText: 'Enter your feedback',
                hintTextWeight: FontWeight.w400,
                fontSize: 17,
                hintTextColor: AppColor.greyText,
                textColor: AppColor.greyText,
                cursorColor: AppColor.greyText,

              ),
              SizedBox(height: SizeUtils.verticalBlockSize * 3,),
              Center(
                child: IconButton(
                  onPressed: () async{
                    final Uri go = Uri.parse('mailto: avipansuriya8787@gmail.com?Subject=FeedBack&body=${feedbackC.text}');

                    await launchUrl(go);

                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          backgroundColor: AppColor.blackdark,
                          actions: <Widget>[
                            Column(mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                SizedBox(
                                  height: SizeUtils.verticalBlockSize * 5,
                                ),
                                Center(child: Image.asset("asset/images/done.png",height: SizeUtils.verticalBlockSize * 8,)),
                                SizedBox(
                                  height: SizeUtils.verticalBlockSize * 3,
                                ),
                                Center(child: Text('Feedback send',style: TextStyle(fontWeight: FontWeight.w600,fontSize: 12,color: AppColor.white),)),
                                SizedBox(
                                  height: SizeUtils.verticalBlockSize * 1,
                                ),
                                Center(child: Text('Successfully',style: TextStyle(fontWeight: FontWeight.w700,fontSize: 30,color: AppColor.green),)),
                                SizedBox(
                                  height: SizeUtils.verticalBlockSize * 2,
                                ),
                              ],
                            ),

                          ],
                        );
                      },
                    );
                  },
                  icon: Container(
                    height: SizeUtils.verticalBlockSize * 7,
                    width: SizeUtils.horizontalBlockSize * 80,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: AppColor.purpal.withOpacity(0.7),
                    ),
                    child: Center(
                      child: Text(
                        "Other",
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: AppColor.white),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
