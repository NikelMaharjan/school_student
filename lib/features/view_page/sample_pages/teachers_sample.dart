import 'package:eschool/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class TeacherPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Column(
            children: [
              Container(
                height: 150.h,
                width: double.infinity,
                decoration: BoxDecoration(
                    color: primary,
                    borderRadius:
                        BorderRadius.vertical(bottom: Radius.circular(20))),
                child: Center(
                    child: Text(
                  'Teachers',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 30.sp,
                  ),
                )),
              ),
              Center(
                child: Container(
                  width: 350.w,
                  height: 670.h,
                  // color: Colors.red,
                  child: ListView(
                    physics: BouncingScrollPhysics(),
                    padding:
                        EdgeInsets.symmetric(vertical: 10.h, horizontal: 0.w),
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 8.h),
                        child: Card(
                          elevation: 8,
                          color: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: ListTile(
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 8.w, vertical: 8.h),
                            // onTap: ()=>Get.to(()=>AssignmentPage()),
                            title: Row(
                              children: [
                                Container(
                                  height: 60.h,
                                  width: 80.w,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10)),
                                  child: Center(
                                      child: Icon(
                                    Icons.person,
                                    color: Colors.grey,
                                    size: 40.sp,
                                  )),
                                ),
                                SizedBox(
                                  width: 8.h,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('Name',
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold)),
                                    Text('Subject',
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 12.sp)),
                                    Text('Number',
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 12.sp)),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 8.h),
                        child: Card(
                          elevation: 8,
                          color: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: ListTile(
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 8.w, vertical: 8.h),
                            // onTap: ()=>Get.to(()=>AssignmentPage()),
                            title: Row(
                              children: [
                                Container(
                                  height: 60.h,
                                  width: 80.w,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10)),
                                  child: Center(
                                      child: Icon(
                                    Icons.person,
                                    color: Colors.grey,
                                    size: 40.sp,
                                  )),
                                ),
                                SizedBox(
                                  width: 8.h,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('Name',
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold)),
                                    Text('Subject',
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 12.sp)),
                                    Text('Number',
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 12.sp)),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 8.h),
                        child: Card(
                          elevation: 8,
                          color: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: ListTile(
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 8.w, vertical: 8.h),
                            // onTap: ()=>Get.to(()=>AssignmentPage()),
                            title: Row(
                              children: [
                                Container(
                                  height: 60.h,
                                  width: 80.w,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10)),
                                  child: Center(
                                      child: Icon(
                                    Icons.person,
                                    color: Colors.grey,
                                    size: 40.sp,
                                  )),
                                ),
                                SizedBox(
                                  width: 8.h,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('Name',
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold)),
                                    Text('Subject',
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 12.sp)),
                                    Text('Number',
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 12.sp)),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 8.h),
                        child: Card(
                          elevation: 8,
                          color: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: ListTile(
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 8.w, vertical: 8.h),
                            // onTap: ()=>Get.to(()=>AssignmentPage()),
                            title: Row(
                              children: [
                                Container(
                                  height: 60.h,
                                  width: 80.w,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10)),
                                  child: Center(
                                      child: Icon(
                                    Icons.person,
                                    color: Colors.grey,
                                    size: 40.sp,
                                  )),
                                ),
                                SizedBox(
                                  width: 8.h,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('Name',
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold)),
                                    Text('Subject',
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 12.sp)),
                                    Text('Number',
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 12.sp)),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 8.h),
                        child: Card(
                          elevation: 8,
                          color: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: ListTile(
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 8.w, vertical: 8.h),
                            // onTap: ()=>Get.to(()=>AssignmentPage()),
                            title: Row(
                              children: [
                                Container(
                                  height: 60.h,
                                  width: 80.w,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10)),
                                  child: Center(
                                      child: Icon(
                                    Icons.person,
                                    color: Colors.grey,
                                    size: 40.sp,
                                  )),
                                ),
                                SizedBox(
                                  width: 8.h,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('Name',
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold)),
                                    Text('Subject',
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 12.sp)),
                                    Text('Number',
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 12.sp)),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
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
