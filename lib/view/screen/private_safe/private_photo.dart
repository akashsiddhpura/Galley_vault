import 'package:flutter/material.dart';

class PrivatePhoto extends StatefulWidget {
  const PrivatePhoto({super.key});

  @override
  State<PrivatePhoto> createState() => _PrivatePhotoState();
}

class _PrivatePhotoState extends State<PrivatePhoto> {
  bool lodding = false;
  @override
  void initState() {
    super.initState();
    setState(() {
      lodding = true;
    });
  }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: lodding == false
          ? Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            // child: Image.asset(AssetsPath.recyclebin),
          ),
          SizedBox(
            height: 20,
          ),
          Text(
            "This Recycle Bin is Empty",
            style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w600,
                color: AppColor.white),
          )
        ],
      )
          : const Column(
        children: [],
      ),
    );
  }
}
