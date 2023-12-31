




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
  const Assignments({super.key, required this.subject,required this.student_id,required this.section,required this.className});

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
              physics: const BouncingScrollPhysics(),
              shrinkWrap: true,
              itemCount: assignment.length,
              itemBuilder: (context,index){
                return SizedBox(
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
                                        style: const TextStyle(
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
                                    SizedBox(width: 200.w,child: Text(assignment[index].title,style: TextStyle(color: Colors.black,fontSize: 18.sp,),maxLines: 1,)),
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
          return const Center(child: Text('No Assignment'));

        },
        error:  (err, stack) => Center(child: Text('$err')),
        loading: () => const Center(child: ShimmerListTile2())
    );


  }
}