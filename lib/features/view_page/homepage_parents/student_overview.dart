import 'package:eschool/authentication/providers/auth_provider.dart';
import 'package:eschool/constants/colors.dart';
import 'package:eschool/exceptions/internet_exceptions.dart';
import 'package:eschool/features/services/parent_services.dart';
import 'package:eschool/features/services/student_services.dart';
import 'package:eschool/features/view_page/homepage_parents/menu_parents.dart';
import 'package:eschool/features/view_page/sample_pages/profile_samples/sample_profile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../api/api.dart';
import '../../../utils/commonWidgets.dart';

import '../student_page/subject_tab/subject_page.dart';

class StudentOverview extends ConsumerStatefulWidget {
  final int student_id;
  StudentOverview({required this.student_id});

  @override
  ConsumerState<StudentOverview> createState() => _StudentOverviewState();
}

class _StudentOverviewState extends ConsumerState<StudentOverview> {



  @override
  Widget build(BuildContext context) {

    final auth = ref.watch(authProvider);
    final studentClass = ref.watch(studentClassListProvider(widget.student_id));

    return ConnectivityChecker(
      child: Scaffold(
          backgroundColor: Colors.white,
          body: studentClass.when(
              data: (student_data){
                final student = student_data.firstWhere((element) => element.currentLevel==true);
                print(student.className!.id);
                final subjects = ref.watch(secWiseSubjectProvider(student.className!.id));
               return Stack(
                  children: [
                    Column(
                      children: [
                        Container(
                          height: 200.h,
                          width: double.infinity,
                          decoration: BoxDecoration(
                              color: primary,
                              borderRadius: const BorderRadius.vertical(bottom: Radius.circular(20))),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(
                                height: 15.h,
                              ),
                              InkWell(
                                onTap: () => Get.to(() => StudentProfile(student_id: student.student.id,className: student.className!.className.classLevel.name,rollNo: student.rollNo,)),
                                child: CircleAvatar(
                                  radius: 30.sp,
                                  backgroundImage: NetworkImage('${Api.basePicUrl}${student.student.studentPhoto}'),
                                ),
                              ),
                              SizedBox(
                                height: 5.h,
                              ),
                              Text(
                                student.student.studentName,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20.sp,
                                ),
                              ),
                              Text(
                                '${student.className!.className.classLevel.name} ${student.className!.sectionName.sectionName}',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 15.sp,
                                ),
                              )
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 5.h,
                        ),
                        Container(
                            width: 350.w,
                            // color: Colors.red,
                            child: subjects.when(
                data: (subject_data){
                  return  GridView.builder(
                    shrinkWrap: true,
                    itemCount: subject_data.length,
                    physics: const BouncingScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        childAspectRatio: 2.w / 2.4.h,
                        crossAxisCount: 3,
                        mainAxisSpacing: 5.h,
                        crossAxisSpacing: 5.w),
                    itemBuilder: (context,index){
                      return Column(
                        children: [
                          GridTile(
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: InkWell(
                                onTap: () => Get.to(() => Subjects(sec_name: student.className!.sectionName.sectionName, class_level_name: student.className!.className.classLevel.name, class_sec_id: student.className!.id, subject_name: subject_data[index].subject.subjectName, subject_id: subject_data[index].subject.id, teacher_id: subject_data[index].teacher.id, class_Sec_Sub_id: subject_data[index].id)),
                                child: Container(
                                    height: 90.h,
                                    width: 90.w,
                                    color: Colors.lightBlueAccent,
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 8.w, vertical: 8.h),
                            child: Text(
                              subject_data[index].subject.subjectName,
                              style: const TextStyle(color: Colors.black),
                            ),
                          )
                        ],
                      );
                    },

                  );
                },
                error: (err, stack) => Center(child: Text('$err')),
                loading: () => const Center(child: GridShimmer2())),
                ),

                        SizedBox(
                          height: 15.h,
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
                          icon:
                          Icon(Icons.arrow_back, color: Colors.white, size: 25.sp)),
                    ),
                    Positioned(
                      right: 10.w,
                      top: 40.h,
                      child: IconButton(
                          onPressed: () {
                            Get.to(() => MenuParents(student_id: widget.student_id,));
                          },
                          icon: Icon(Icons.more_vert_rounded,
                              color: Colors.white, size: 25.sp)),
                    ),
                  ],
                );

              },
              error: (err, stack) => Center(child: Text('$err')),
              loading: () => const Center(child: CircularProgressIndicator())),


          ),
    );
  }
}
