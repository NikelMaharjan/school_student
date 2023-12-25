import 'package:eschool/constants/colors.dart';

import 'package:eschool/authentication/login_pages/login_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../authentication/providers/auth_provider.dart';
import '../../../../authentication/services/auth_services.dart';
import '../../../../authentication/login_pages/status_page.dart';

class Settings extends ConsumerWidget {
  @override
  Widget build(BuildContext context,ref) {

    final auth = ref.watch(authProvider);

    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Container(
            width: double.infinity,
            height: 150.h,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.vertical(
                  bottom: Radius.circular(40),
                ),
                color: Color(0xff205578)),
          ),
          Center(
            child: Column(
              children: [
                SizedBox(
                  height: 70.h,
                ),
                Text('Settings',
                    style: TextStyle(fontSize: 25.sp, color: Colors.white)),
                SizedBox(
                  height: 50.h,
                ),
                Center(
                  child: Container(
                    width: 350.w,
                    height: 320.h,
                    child: ListView(
                      padding: EdgeInsets.symmetric(vertical: 5.h),
                      children: [
                        ListTile(
                          visualDensity: VisualDensity(vertical: -3),
                          title: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Change Password',
                                  style: TextStyle(color: Colors.black)),
                              Icon(
                                Icons.arrow_forward_ios,
                                color: Colors.black,
                                size: 15.sp,
                              )
                            ],
                          ),
                        ),
                        ListTile(
                          visualDensity: VisualDensity(vertical: -4),
                          title: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Privacy Policy',
                                  style: TextStyle(color: Colors.black)),
                              Icon(
                                Icons.arrow_forward_ios,
                                color: Colors.black,
                                size: 15.sp,
                              )
                            ],
                          ),
                        ),
                        ListTile(
                          visualDensity: VisualDensity(vertical: -3),
                          title: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Terms & Condition',
                                  style: TextStyle(color: Colors.black)),
                              Icon(
                                Icons.arrow_forward_ios,
                                color: Colors.black,
                                size: 15.sp,
                              )
                            ],
                          ),
                        ),
                        ListTile(
                          visualDensity: VisualDensity(vertical: -3),
                          title: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('About Us',
                                  style: TextStyle(color: Colors.black)),
                              Icon(
                                Icons.arrow_forward_ios,
                                color: Colors.black,
                                size: 15.sp,
                              )
                            ],
                          ),
                        ),
                        ListTile(
                          visualDensity: VisualDensity(vertical: -3),
                          title: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Contact Us',
                                  style: TextStyle(color: Colors.black)),
                              Icon(
                                Icons.arrow_forward_ios,
                                color: Colors.black,
                                size: 15.sp,
                              )
                            ],
                          ),
                        ),
                        ListTile(
                          visualDensity: VisualDensity(vertical: -3),
                          title: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Rate Us',
                                  style: TextStyle(color: Colors.black)),
                              Icon(
                                Icons.arrow_forward_ios,
                                color: Colors.black,
                                size: 15.sp,
                              )
                            ],
                          ),
                        ),
                        ListTile(
                          visualDensity: VisualDensity(vertical: -3),
                          title: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Share',
                                  style: TextStyle(color: Colors.black)),
                              Icon(
                                Icons.arrow_forward_ios,
                                color: Colors.black,
                                size: 15.sp,
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                TextButton(
                    style: TextButton.styleFrom(
                        backgroundColor: Colors.black,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20))),
                    onPressed: () async {
                     await ref.read(authProvider.notifier).userLogout(auth.user!.token);
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (context) => LoginPage()),
                            (route) => false,
                      );


                    },

                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 25.w),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.logout,
                            size: 15.sp,
                          ),
                          SizedBox(
                            width: 5.h,
                          ),
                          Text('Log Out'),
                        ],
                      ),
                    ))
              ],
            ),
          ),
          Positioned(
            left: 15.w,
            top: 40.h,
            child: IconButton(
                onPressed: () {
                  Get.back();
                },
                icon: Icon(Icons.arrow_back, color: Colors.white, size: 25.sp)),
          ),
        ],
      ),
    );
  }
}
