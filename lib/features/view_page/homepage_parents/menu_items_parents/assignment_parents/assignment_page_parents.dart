






import 'package:eschool/features/view_page/homepage_parents/menu_items_parents/assignment_parents/assignment_details_parents.dart';
import 'package:eschool/features/view_page/homepage_parents/menu_items_parents/assignment_parents/assignment_status_parents.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../../constants/colors.dart';
import '../../../../../exceptions/internet_exceptions.dart';
import '../../../../model/assignment_model.dart';

class AssignmentPageParents extends ConsumerStatefulWidget {


  final Assignment assignment;
  final String className;
  final String section;
  final int student_id;
  AssignmentPageParents({required this.assignment,required this.student_id,required this.className,required this.section});

  @override
  ConsumerState<AssignmentPageParents> createState() => _AssignmentTabState();
}

class _AssignmentTabState extends ConsumerState<AssignmentPageParents> with TickerProviderStateMixin{
  @override
  Widget build(BuildContext context) {

    TabController _tabController = TabController(length: 2, vsync: this);
    return ConnectivityChecker(
      child: Scaffold(
        backgroundColor: Colors.white,
        body:
        Column(
          children: [
            Container(
                height: MediaQuery.of(context).size.height * 1.4 / 5,
                width: double.infinity,
                decoration: BoxDecoration(
                    color: bgColor,
                    borderRadius:
                    const BorderRadius.vertical(bottom: Radius.circular(25))),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 20.h,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                          onPressed: () {
                            Get.back();
                          },
                          icon: const Icon(
                            Icons.arrow_back,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),

                    Center(
                      child: Text('Assignment',
                          style: TextStyle(color: Colors.white, fontSize: 25.sp)),
                    ),




                    SizedBox(
                      height: 10.h,
                    ),
                    TabBar(
                        controller: _tabController,
                        padding: EdgeInsets.symmetric(
                            vertical: 15.h, horizontal: 30.w),
                        labelStyle: TextStyle(
                          fontSize: 18.sp,
                        ),
                        unselectedLabelStyle: TextStyle(
                          fontSize: 18.sp,
                        ),
                        isScrollable: false,
                        labelPadding: EdgeInsets.only(left: 15.w, right: 15.w),
                        labelColor: primary,
                        unselectedLabelColor: Colors.white,
                        // indicatorColor: primary,
                        indicator: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10)),
                        tabs: const [
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 8.0),
                            child: Tab(
                              text: 'Task',
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 8.0),
                            child: Tab(text: 'Status'),
                          ),
                        ])
                  ],
                )),
            SizedBox(
              // color: Colors.red,
                height: MediaQuery.of(context).size.height * 3.6 / 5,
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 0.h, horizontal: 15.w),
                  child: TabBarView(
                    // physics: NeverScrollableScrollPhysics(),

                    controller: _tabController,
                    children: [
                      AssignmentDetailsParents(assignment: widget.assignment,student_id: widget.student_id,),
                      AssignmentStatusParents(assignment: widget.assignment, student_id: widget.student_id)],
                    //MyClass(id: class_id, school_id: school_id, class_teacher: class_teacher, teacher_subject: teacher_subject, classSub_id: classSub_id,)
                  ),
                )),
          ],
        ),

      ),
    );
  }
}