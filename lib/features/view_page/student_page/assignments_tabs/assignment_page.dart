







import 'package:eschool/authentication/providers/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../constants/colors.dart';
import '../../../../exceptions/internet_exceptions.dart';
import '../../../model/assignment_model.dart';
import '../../../services/assignment_services.dart';
import 'assignment_details.dart';
import 'assignment_status.dart';

class AssignmentPage extends ConsumerStatefulWidget {


  final Assignment assignment;
  final String className;
  final String section;
  final int student_id;
  AssignmentPage({required this.assignment,required this.student_id,required this.className,required this.section});

  @override
  ConsumerState<AssignmentPage> createState() => _AssignmentTabState();
}

class _AssignmentTabState extends ConsumerState<AssignmentPage> with TickerProviderStateMixin{
  @override
  Widget build(BuildContext context) {
    final auth = ref.watch(authProvider);

    TabController _tabController = TabController(length: 2, vsync: this);
    return ConnectivityChecker(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Column(
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
                          tabs: [
                            const Padding(
                              padding: EdgeInsets.symmetric(horizontal: 20.0),
                              child: Tab(
                                text: 'Task',
                              ),
                            ),
                            const Padding(
                              padding: EdgeInsets.symmetric(horizontal: 20.0),
                              child: Tab(text: 'Status'),
                            ),
                          ])
                    ],
                  )),
              Container(
                // color: Colors.red,
                  height: MediaQuery.of(context).size.height * 3.6 / 5,
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 0.h, horizontal: 15.w),
                    child: TabBarView(
                      // physics: NeverScrollableScrollPhysics(),

                      controller: _tabController,
                      children: [
                        AssignmentDetails(assignment: widget.assignment,student_id: widget.student_id,),
                        AssignmentStatus(assignment: widget.assignment, student_id: widget.student_id)],
                      //MyClass(id: class_id, school_id: school_id, class_teacher: class_teacher, teacher_subject: teacher_subject, classSub_id: classSub_id,)
                    ),
                  )),
            ],
          ),
        ),

        floatingActionButton: FloatingActionButton(
          onPressed: (){
            ref.invalidate(studentAssignmentProvider(auth.user.token));
            ref.invalidate(assignmentStatusList(auth.user.token));
          },
          backgroundColor: primary,
          child: const Icon(Icons.refresh,color: Colors.white,),
        ),

      ),
    );
  }
}