import 'dart:async';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../../resources/app_localization.dart';
import '../../resources/resources.dart';

class MyLoader extends StatefulWidget {
  final Color color;

  const MyLoader({Key? key, this.color = Colors.red}) : super(key: key);

  @override
  MyLoaderState createState() => MyLoaderState();
}

class MyLoaderState extends State<MyLoader> {
  bool loading = false;
  Timer? _timer;
  final int _start = 10;
  int? start;

  void startTimer() {
    const oneSec = Duration(seconds: 1);
    _timer = Timer.periodic(
      oneSec,
          (Timer timer) => setState(
            () {
          if (_start < 1) {
            timer.cancel();
            setState(() {
              inDialog('Loading timeout', true);
              loading = false;
            });
          } else {
            start = start! - 1;
            if (loading == false) {
              _timer!.cancel();
            }
          }
        },
      ),
    );
  }

  @override
  void initState() {
// startTimer();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: R.colors.themeColor.withOpacity(.05),
      child: Center(
        child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
            child: Container(
              width: 20.w,
              height: 20.w,
              padding: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                color: R.colors.white,
                borderRadius: BorderRadius.circular(12),
              ),
              child: SpinKitSpinningLines(
                color: R.colors.themeColor,
              ),
            )),
      ),
    );
  }

  void inDialog(String message, bool isError) {
    Color color = isError ? Colors.redAccent : Colors.green;
    Get.defaultDialog(
        title: '',
        titleStyle: TextStyle(
            fontFamily: 'poppins',
            fontSize: Get.height * 0.0,
            fontWeight: FontWeight.bold),
        content: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            CircleAvatar(
              radius: Get.height * 0.032,
              backgroundColor: color,
              child: CircleAvatar(
                  backgroundColor: Colors.white,
                  radius: Get.height * 0.030,
                  child: Icon(
                    isError ? Icons.warning : Icons.done_outline,
                    color: color,
                    size: Get.height * 0.042,
                  )),
            ),
            SizedBox(
              height: Get.height * 0.016,
            ),
            Text(message,
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontFamily: 'poppins', fontSize: Get.height * 0.022)),
            SizedBox(height: Get.height * 0.02),
          ],
        ),
        actions: [
          Wrap(
            alignment: WrapAlignment.center,
            spacing: 8,
            runSpacing: 8,
            children: [
              GestureDetector(
                onTap: () {
                  Get.back();
                  setState(() {
                    _timer!.cancel();
                  });
                },
                child: Container(
                  alignment: Alignment.center,
                  margin: const EdgeInsets.only(bottom: 16),
                  width: Get.width * .32,
                  height: Get.height * .05,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: R.colors.green),
                  child: Text(
                    LocalizationMap.getValue("ok"),
                    style: R.textStyles.poppins(),
                  ),
                ),
              )
            ],
          )
        ]);
  }
}
