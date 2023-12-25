
import 'package:eschool/features/view_page/student_page/subject_tab/subject_plan/subject_plan.dart';
import 'package:eschool/utils/commonWidgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../constants/colors.dart';
import '../../../services/feature_services.dart';




class Chapters extends ConsumerWidget {

  final int subject_id;
  final String className;
  final String section ;
  final int class_sec_id;
  final int class_sec_sub_id;
  final String subjectName;

  Chapters({required this.className,required this.section,required this.class_sec_id,required this.class_sec_sub_id,required this.subject_id,required this.subjectName});

  @override
  Widget build(BuildContext context,ref) {






    return Column(
      children: [
        Container(
          width : 350.w,
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 15.w),
            child: Card(
              elevation: 8,
              color: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: ListTile(
                contentPadding:
                EdgeInsets.symmetric(horizontal:15.w, vertical: 8.h),
                onTap: ()=>Get.to(()=>SubjectPlan(className: className,subject_id: subject_id, section: section,classSubject_id: class_sec_sub_id,subjectName: subjectName,)),
                title: Text('Subject Plan',style: TextStyle(color: Colors.black,fontSize: 15.sp),),
                trailing: Icon(Icons.arrow_circle_right_rounded,color: Colors.black,),
              ),
            ),
          ),
        ),

        Container(
          width: 350.w,

          child: ListView(
            padding: EdgeInsets.zero,
            shrinkWrap: true,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 15.w),
                child: Card(
                  elevation: 8,
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: ListTile(
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.h),
                    // onTap: ()=>Get.to(()=>AssignmentPage()),
                    title: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8.w),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Lesson name',
                              style: TextStyle(
                                  color: Colors.black, fontSize: 12.sp)),
                          SizedBox(
                            height: 10.h,
                          ),
                          Text('Lesson 1',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold)),
                          SizedBox(
                            height: 30.h,
                          ),
                          Text('Lesson description',
                              style:
                                  TextStyle(color: Colors.black, fontSize: 12.sp)),
                          SizedBox(
                            height: 10.h,
                          ),
                          Text('Basic Lessons',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold)),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
