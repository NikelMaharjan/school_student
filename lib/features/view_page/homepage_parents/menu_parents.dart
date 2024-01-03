import 'package:eschool/constants/colors.dart';
import 'package:eschool/features/view_page/homepage_parents/menu_items_parents/assignment_parents/assignment_parents.dart';
import 'package:eschool/utils/commonWidgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../authentication/providers/auth_provider.dart';
import '../../services/parent_services.dart';
import '../student_page/menu_items/attendance/attendance_page.dart';
import '../student_page/menu_items/exam/exam_page.dart';
import '../student_page/menu_items/report_page.dart';
import '../student_page/menu_items/result/result_page.dart';
import '../student_page/menu_items/school_calender.dart';
import '../student_page/menu_items/timetable/timetable_page.dart';
import 'menu_items_parents/fee_page/fee_page.dart';

class MenuParents extends ConsumerWidget {
  final int student_id;
  const MenuParents({super.key, required this.student_id});
  @override
  Widget build(BuildContext context,ref) {
    final auth = ref.watch(authProvider);
    final studentClass = ref.watch(studentClassListProvider(student_id));
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
                    borderRadius: const BorderRadius.vertical(bottom: Radius.circular(20))),
                child: Center(
                    child: Text(
                  'Menu',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 30.sp,
                  ),
                )),
              ),
              Center(
                child: SizedBox(
                  width: 350.w,
                  height: MediaQuery.of(context).size.height * 4.5 / 6,
                  // color: Colors.red,
                  child: studentClass.when(
                      data: (studentData){
                        final data = studentData.firstWhere((element) => element.currentLevel==true);
                        return ListView(
                          padding:
                          EdgeInsets.symmetric(vertical: 10.h, horizontal: 0.w),
                          children: [
                            InfoTileWidget(
                              title: 'Assignments',
                              onTap: () => Get.to(() => AssignmentParents(student_id: student_id,)),
                              svgPath: 'assets/icons/assignments copy.svg',
                            ),
                            InfoTileWidget(
                              title: 'Teachers',
                              onTap: () {},
                              svgPath: 'assets/icons/teacher copy.svg',
                            ),
                            InfoTileWidget(
                              title: 'Attendance',
                              onTap : ()=>Get.to(()=>Attendance(student_id: student_id,)),
                              svgPath: 'assets/icons/attendance 1 copy.svg',
                            ),
                            InfoTileWidget(
                              title: 'Routine',
                              onTap: (){
                                Get.to(()=>TimeTable(className: data.className!.className.classLevel.name,section: data.className!.sectionName.sectionName,class_sec_id: data.className!.id,));
                              },
                              svgPath: 'assets/icons/time table copy.svg',
                            ),
                            InfoTileWidget(
                              title: 'Calendar',
                              onTap: () => Get.to(() => Calender()),
                              svgPath: 'assets/icons/holiday.svg',
                            ),
                            InfoTileWidget(
                              title: 'Exams',
                              onTap: () {
                                Get.to(()=>ExamPage(class_id: data.className!.className.id,));
                              },
                              svgPath: 'assets/icons/exam copy.svg',
                            ),
                            InfoTileWidget(
                              title: 'Results',
                              onTap: () {
                                Get.to(()=>ExamResults(class_id: data.className!.className.id,student_id: data.student.id,));
                              },
                              svgPath: 'assets/icons/result copy.svg',
                            ),
                            InfoTileWidget(
                              title: 'Report',
                              onTap: () {
                                Get.to(()=>ReportPage(class_data: data, student_id: student_id));
                              },
                              svgPath: 'assets/icons/report copy.svg',
                            ),
                            InfoTileWidget(
                              title: 'Fees',
                              onTap: () {
                                Get.to(()=>FeePage(student_id: student_id,));
                              },
                              pngPath: 'assets/icons/fees.png',
                            ),
                          ],
                        );
                      },
                      error: (err, stack) => Center(child: Text('$err')),
                      loading: () => const Center(child: CircularProgressIndicator())),

                )



                ),

            ],
          ),
          Positioned(
            left: 15.w,
            top: 50.h,
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
