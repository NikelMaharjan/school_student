

import 'dart:io';

import 'package:eschool/features/providers/assignment_providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../../../../api/api.dart';
import '../../../../authentication/providers/auth_provider.dart';
import '../../../../constants/colors.dart';
import '../../../../constants/snackshow.dart';
import '../../../../utils/commonWidgets.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../model/assignment_model.dart';
import '../../../services/assignment_services.dart';

class AssignmentStatus extends ConsumerStatefulWidget {

  final Assignment assignment;
  final int student_id;
  AssignmentStatus({required this.assignment,required this.student_id});

  @override
  ConsumerState<AssignmentStatus> createState() => _AssignmentStatusState();
}

class _AssignmentStatusState extends ConsumerState<AssignmentStatus> {


  @override
  Widget build(BuildContext context) {



    final auth = ref.watch(authProvider);
    final studentAssignment = ref.watch(studentAssignmentProvider(auth.user.token));
    final assignmentStatus = ref.watch(assignmentStatusList(auth.user.token));
    print('assignment id ${widget.assignment.id}');
    print('student id ${widget.student_id}');



    _launchURL(String url) async {
      if (await canLaunchUrlString(url)) {
        await launchUrlString(url);
      } else {
        throw 'Could not launch $url';
      }
    }



    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(height: 20.h,),
          Container(
              padding: EdgeInsets.symmetric(horizontal: 15.w),

              child: Text(widget.assignment.title,style: TextStyle(color: Colors.black,fontSize: 15.sp),maxLines: null,)),
          Divider(
            thickness: 1,
            color: Colors.black,
            indent: 15.w,
            endIndent: 15.w,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 15.w),
            child: studentAssignment.when(
                data: (data){
                  final stud_data = data.firstWhereOrNull((element) => element.assignment.id == widget.assignment.id&& element.student.id == widget.student_id);
                  if(stud_data != null ){
                    final url = Uri.parse('${Api.basePicUrl}${stud_data.studentAssignment.path}');

                    return Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [

                        assignmentStatus.when(
                            data: (status_data){
                              final status = status_data.firstWhereOrNull((element) => element.studentAssignment.id == stud_data.id);

                              if(status == null){
                                return Container(

                                    decoration: BoxDecoration(
                                        color: shimmerHighlightColor,
                                        borderRadius: BorderRadius.circular(10),
                                        border: Border.all(
                                            color: Colors.black
                                        )
                                    ),
                                    child: ListTile(
                                        title: Text('Status',style: TextStyle(color: Colors.black),),
                                        trailing:Text('Pending',style: TextStyle(color: Colors.grey),)
                                    )
                                );
                              }

                              else{
                                return Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Container(

                                        decoration: BoxDecoration(
                                            color: status.status == 'Accepted' ? pre_color : abs_color,
                                            borderRadius: BorderRadius.circular(10),
                                            border: Border.all(
                                                color: Colors.black
                                            )
                                        ),
                                        child: ListTile(
                                            title: Text('Status',style: TextStyle(color: Colors.white),),
                                            trailing:Text(status.status,style: TextStyle(color: Colors.white),)
                                        )
                                    ),
                                    NoticeCard(
                                        title: 'Remarks',
                                        description: status.remarks,
                                        createdAt: status.createdAt
                                    )
                                  ],
                                );
                              }


                            },
                            error: (err, stack) => Container(

                                decoration: BoxDecoration(
                                    color: shimmerHighlightColor,
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(
                                        color: Colors.black
                                    )
                                ),
                                child: ListTile(
                                    title: Text('Status',style: TextStyle(color: Colors.black),),
                                    trailing:Text('Pending',style: TextStyle(color: Colors.grey),)
                                )
                            ),
                            loading: () =>
                                Container(
                                    height:100.h,
                                    child: ShimmerListTile3())
                        ),



                      ],
                    );

                  }
                  else{
                    return Container(
                      child: Text(
                        'No Submission',style: TextStyle(color: Colors.black,fontSize: 15.sp,fontWeight: FontWeight.bold),
                      ),
                    );

                  }

                },
                error: (err, stack) => Center(child: Text('$err')),
                loading: () =>
                    Container(
                        height: 100.h,
                        child: ShimmerListTile3())),
          ),





        ],
      ),
    );
  }
}
