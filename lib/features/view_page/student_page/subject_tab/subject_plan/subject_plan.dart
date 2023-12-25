




import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../../../constants/colors.dart';
import '../../../../../authentication/providers/auth_provider.dart';

import '../../../../model/class_model.dart';
import '../../../../services/subject_services.dart';

class SubjectPlan extends ConsumerWidget {

  final int classSubject_id;
  final int subject_id;
  final String subjectName;
  final String className;
  final String section;


  SubjectPlan({required this.section,required this.className, required this.subject_id ,required this.classSubject_id,required this.subjectName});


  @override
  Widget build(BuildContext context,ref) {

    //print("adasd is $subject_id");
    final auth = ref.watch(authProvider);
    final planList = ref.watch(subPlanList(subject_id));

    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Container(
            height: MediaQuery.of(context).size.height * 1 / 5,
            width: double.infinity,
            decoration: BoxDecoration(
                color: bgColor,
                borderRadius:
                BorderRadius.vertical(bottom: Radius.circular(25))),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      onPressed: () {
                        Get.back();
                      },
                      icon: Icon(
                        Icons.arrow_back,
                        color: Colors.white,
                      ),
                    ),

                  ],
                ),

                Center(
                  child: Column(
                    children: [
                      Text(
                        'Subject Plan',
                        style: TextStyle(color: Colors.white, fontSize: 28.sp),
                      ),
                      Text(
                        '${subjectName} | Class ${className} ${section}',
                        style: TextStyle(color: Colors.white, fontSize: 15.sp),
                      )
                    ],
                  ),
                ),


                SizedBox(height: 20.h),

              ],
            ),
          ),
          Expanded(
            child: Container(
              // color: Colors.red,
              padding: EdgeInsets.symmetric(horizontal: 15.w,vertical: 10.h),
              child: planList.when(
                  data: (plan_data){
                    if(plan_data.isNotEmpty){
                      return  Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 15.w,vertical: 10.h),
                            decoration: BoxDecoration(
                                color: shimmerHighlightColor,
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(
                                    color: Colors.black
                                )
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('Teaching duration',style: TextStyle(color: Colors.black,fontSize: 15.sp),),
                                Text(plan_data.first.teachingDuration,style: TextStyle(color: Colors.black,fontSize: 15.sp,),),
                              ],
                            ),
                          ),
                          SizedBox(height: 10.h,),
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 15.w,vertical: 10.h),
                            decoration: BoxDecoration(
                                color: shimmerHighlightColor,
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(
                                    color: Colors.black
                                )
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('Expected Outcome',style: TextStyle(color: Colors.black,fontSize: 15.sp,),),
                                Text(plan_data.first.expectedOutcome,style: TextStyle(color: Colors.black,fontSize: 15.sp,),),
                              ],
                            ),
                          ),
                          SizedBox(height: 20.h,),
                          Text('Description',style: TextStyle(color: Colors.black,fontSize: 18.sp,fontWeight: FontWeight.bold),),
                          Divider(
                            thickness: 1,
                            color: Colors.black,
                          ),
                          Container(
                            height: MediaQuery.of(context).size.height * 2.5/5,
                            child: Text(plan_data.first.description,style: TextStyle(color: Colors.black,fontSize: 15.sp,),),

                          ),




                        ],
                      );
                    } else {
                      return Center(
                          child: Column(
                        children: [
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 15.w,vertical: 10.h),
                            decoration: BoxDecoration(
                                color: shimmerHighlightColor,
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(
                                    color: Colors.black
                                )
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('Teaching duration',style: TextStyle(color: Colors.black,fontSize: 15.sp,fontWeight: FontWeight.bold),),
                                Text('-',style: TextStyle(color: Colors.black,fontSize: 15.sp,fontWeight: FontWeight.bold),),
                              ],
                            ),
                          ),
                          SizedBox(height: 10.h,),
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 15.w,vertical: 10.h),
                            decoration: BoxDecoration(
                                color: shimmerHighlightColor,
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(
                                    color: Colors.black
                                )
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('Expected Outcome',style: TextStyle(color: Colors.black,fontSize: 15.sp,fontWeight: FontWeight.bold),),
                                Text('-',style: TextStyle(color: Colors.black,fontSize: 15.sp,fontWeight: FontWeight.bold),),
                              ],
                            ),
                          ),
                          SizedBox(height: 20.h,),
                          Container(
                              height: MediaQuery.of(context).size.height * 2.5/5,
                              child: Text('Add a plan',style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 18.sp),)),

                        ],
                      ));
                    }


                  },
                error: (err, stack) => Center(child: Text('$err')),
                loading: () => Center(child: CircularProgressIndicator()),
     )




            ),
          )
        ],
      ),
    );
  }
}
