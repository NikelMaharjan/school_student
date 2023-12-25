

import 'package:eschool/authentication/login_pages/parent_login.dart';
import 'package:eschool/authentication/login_pages/student_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:eschool/constants/colors.dart';

class LoginPage extends StatefulWidget {


  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> with SingleTickerProviderStateMixin{

  double boxX= 0;
  double boxY= 10;

  @override
  void initState() {
    super.initState();
    // Rebuild the screen after 3s which will process the animation from green to blue
    Future.delayed(Duration(milliseconds: 300)).then((value) => setState(() {
      boxX = 0;
      boxY = 1;
    }));
  }

  // void _moveBox(){
  //   setState(() {
  //     boxX = 0;
  //     boxY = 1;
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      body: Stack(
        children: [
          Container(
              height: 350.h,
              width: double.infinity,
              // color: Colors.white,
              child: Center(
                child: Image.asset('assets/images/reading.JPG',height: 220.h,width:220.w),
              )
          ),
          AnimatedContainer(
          duration: Duration(milliseconds: 700) ,
            alignment: Alignment(boxX, boxY),
            curve: Curves.bounceIn,
            child: Container(
              height: 450.h,
              width: 392.w,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(40))
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 8.h,horizontal: 8.w),
                    child: Text('eSchool',style: TextStyle(fontSize: 35.sp,fontWeight: FontWeight.bold,color: Colors.black)),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 8.h,horizontal: 8.w),
                    child: Text('eSchool serves you virtual education at your home',style: TextStyle(color: Colors.blueGrey,fontSize: 15.sp),),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 8.h,horizontal: 8.w),
                    child: TextButton(
                      style: TextButton.styleFrom(
                        backgroundColor: primary,
                        foregroundColor: Colors.white,
                        fixedSize: Size.fromWidth(320.w),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        )
                      ),
                      onPressed: (){
                        Get.to(()=>StudentLogin());
                      },
                      child: Padding(
                        padding: EdgeInsets.symmetric(vertical: 8.h,horizontal: 8.w),
                        child: Text('Login as Student',style: TextStyle(fontSize: 20.sp),),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 8.h,horizontal: 8.w),
                    child: TextButton(
                      style: TextButton.styleFrom(
                          backgroundColor: Colors.white,
                          foregroundColor: Colors.black,
                          fixedSize: Size.fromWidth(320.w),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            side: BorderSide(
                              color: Colors.black,
                            )
                          )
                      ),
                      onPressed: (){
                        Get.to(()=>Parent_login());
                      },
                      child: Padding(
                        padding: EdgeInsets.symmetric(vertical: 8.h,horizontal: 8.w),
                        child: Text('Login as Parent',style: TextStyle(fontSize: 20.sp),),
                      ),
                    ),
                  ),

                ],
              ),
            ),

          ),
        ],
      )
    );
  }

  
}
