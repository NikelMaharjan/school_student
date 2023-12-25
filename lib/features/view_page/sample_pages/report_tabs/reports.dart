import 'package:eschool/constants/colors.dart';
import 'package:eschool/features/view_page/sample_pages/report_tabs/report_assignment.dart';
import 'package:eschool/features/view_page/sample_pages/report_tabs/report_exam.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:eschool/features/model/class_model.dart';

class Report extends StatefulWidget {
  final int student_id;
  final ClassSubject classSubject;
  Report({required this.classSubject,required this.student_id});
  @override
  State<Report> createState() => _ReportState();
}

class _ReportState extends State<Report> with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    TabController _tabController = TabController(length: 2, vsync: this);
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Container(
            width: double.infinity,
            height: 220.h,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.vertical(
                  bottom: Radius.circular(40),
                ),
                color: Color(0xff205578)),
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
          Align(
            alignment: Alignment.topCenter,
            child: Column(
              children: [
                SizedBox(
                  height: 50.h,
                ),
                Text(
                  widget.classSubject.subject.subjectName,
                  style: TextStyle(color: Colors.white, fontSize: 25.sp),
                ),
                SizedBox(height: 40.h),
                TabBar(
                    controller: _tabController,
                    padding:
                        EdgeInsets.symmetric(vertical: 15.h, horizontal: 30.w),
                    labelStyle: TextStyle(
                      fontSize: 15.sp,
                    ),
                    unselectedLabelStyle: TextStyle(
                      fontSize: 15.sp,
                    ),
                    isScrollable: false,
                    labelPadding: EdgeInsets.only(left: 15.w, right: 15.w),
                    labelColor: primary,
                    unselectedLabelColor: Colors.white,
                    // indicatorColor: primary,
                    indicator: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10)),
                    tabs: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Tab(
                          text: 'Assignment',
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Tab(text: 'Exams'),
                      ),
                    ]),
                SizedBox(
                  height: 40.h,
                ),
                Container(
                  height: MediaQuery.of(context).size.height * 3.8 / 6,
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 15.h),
                    child: TabBarView(
                      controller: _tabController,
                      children: [
                        ReportAssign(classSubject: widget.classSubject,),
                        ReportExam(classSubject: widget.classSubject,student_id: widget.student_id,),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
