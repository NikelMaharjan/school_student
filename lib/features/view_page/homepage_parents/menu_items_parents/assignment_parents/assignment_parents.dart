import 'package:eschool/constants/colors.dart';
import 'package:eschool/features/view_page/homepage_parents/menu_items_parents/assignment_parents/assignment_tabs_parents.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';


class AssignmentParents extends StatefulWidget {
  final int student_id;
  AssignmentParents({required this.student_id});

  @override
  State<AssignmentParents> createState() => _AssignmentParentsState();
}

class _AssignmentParentsState extends State<AssignmentParents>
    with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    TabController _tabController = TabController(length: 2, vsync: this);
    return Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          children: [
            Container(
                height: MediaQuery.of(context).size.height * 1.2 / 5,
                width: double.infinity,
                decoration: BoxDecoration(
                    color: bgColor,
                    borderRadius:
                    BorderRadius.vertical(bottom: Radius.circular(25))),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                            onPressed: () {
                              Get.back();
                            },
                            icon: Icon(Icons.arrow_back, color: Colors.white, size: 25.sp)),
                        SizedBox(
                         width: 20.h,
                        ),
                      ],
                    ),
                    Text('Assignments',
                        style: TextStyle(color: Colors.white, fontSize: 25.sp)),
                    SizedBox(
                      height: 10.h,
                    ),
                    TabBar(
                        controller: _tabController,
                        padding: EdgeInsets.symmetric(
                            vertical: 15.h, horizontal: 30.w),
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
                          Tab(
                            text: 'Assigned',
                          ),
                          Tab(text: 'Submitted'),
                        ])
                  ],
                )),
            Container(
              // color: Colors.red,
                height: MediaQuery.of(context).size.height * 3.8 / 5,
                child: Padding(
                  padding:
                  EdgeInsets.symmetric(vertical: 0.h, horizontal: 15.w),
                  child: TabBarView(
                    // physics: NeverScrollableScrollPhysics(),

                    controller: _tabController,
                    children: [
                      AssignmentTabsParents(student_id: widget.student_id),
                      AssignmentTabsParents(student_id: widget.student_id),

                    ],
                  ),
                )),
          ],
        ));
  }
}
