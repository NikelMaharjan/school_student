




import 'package:eschool/authentication/providers/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../constants/colors.dart';
import '../../../../utils/commonWidgets.dart';
import '../../../services/assignment_services.dart';
import 'assignment_page.dart';



class Assignments extends ConsumerWidget {
  final int subject;
  final int student_id;
  final String className;
  final String section;
  Assignments({required this.subject,required this.student_id,required this.section,required this.className});

  @override
  Widget build(BuildContext context,ref) {



    final auth = ref.watch(authProvider);
    final assignmentInfo = ref.watch(assignmentList(auth.user.token));
    return assignmentInfo.when(
        data: (data){
          final assignment = data.where((element) => element.classSubject.id==subject).toList();

          if(assignment.isNotEmpty){
            return ListView.builder(
              padding: EdgeInsets.zero,
              physics: BouncingScrollPhysics(),
              shrinkWrap: true,
              itemCount: assignment.length,
              itemBuilder: (context,index){
                return Container(
                  height: 110.h,
                  // color: Colors.red,

                  child: Stack(
                      children:[

                        Align(
                          alignment: Alignment.centerRight,
                          child: Card(
                              elevation: 0,
                              color: shimmerHighlightColor,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20)
                              ),
                              child: SizedBox(
                                height: 100.h,
                                width: 300.w,
                              )
                          ),
                        ),

                        Align(
                          alignment: Alignment.centerLeft,
                          child: ListTile(
                            onTap:()=>  Get.to(()=>AssignmentPage(assignment: assignment[index], student_id: student_id, className: className, section: section,)),
                            contentPadding: EdgeInsets.symmetric(vertical: 0.h),
                            title: Row(
                              children: [
                                Container(
                                  height: 60.h,
                                  width: 80.w,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: Colors.red
                                  ),
                                  child: Center(
                                      child: Text((index + 1).toString(),
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20
                                        ),
                                      )
                                  ),
                                ),
                                SizedBox(width: 15.w),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Container(width: 200.w,child: Text(assignment[index].title,style: TextStyle(color: Colors.black,fontSize: 18.sp,),maxLines: 1,)),
                                    Text(assignment[index].description,style: TextStyle(color: Colors.black54,fontSize: 12.sp),maxLines: 1,),
                                    SizedBox(height: 10.h,),
                                    assignment[index].hasDeadline==true? Text(assignment[index].deadline!,style: TextStyle(color: Colors.black45,fontSize: 12.sp),):Text('No Deadline',style: TextStyle(color: Colors.black45,fontSize: 12.sp),) ,
                                  ],
                                ),
                              ],
                            ),


                          ),
                        )


                      ]
                  ),
                );
              },
            );
          }
          return Center(child: Text('No Assignment'));

        },
        error:  (err, stack) => Center(child: Text('$err')),
        loading: () => Container(child: Center(child: ShimmerListTile2()))
    );


  }
}