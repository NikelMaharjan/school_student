

import 'dart:io';

import 'package:eschool/features/providers/assignment_providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../../../../../api/api.dart';
import '../../../../../authentication/providers/auth_provider.dart';
import '../../../../../constants/colors.dart';
import '../../../../../constants/snackshow.dart';
import '../../../../../utils/commonWidgets.dart';
import '../../../../model/assignment_model.dart';
import '../../../../services/assignment_services.dart';
import 'package:url_launcher/url_launcher.dart';

class AssignmentStatusParents extends ConsumerStatefulWidget {

  final Assignment assignment;
  final int student_id;
  AssignmentStatusParents({required this.assignment,required this.student_id});

  @override
  ConsumerState<AssignmentStatusParents> createState() => _AssignmentStatusParentsState();
}

class _AssignmentStatusParentsState extends ConsumerState<AssignmentStatusParents> {


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
                        Container(
                          decoration: BoxDecoration(
                              color: shimmerHighlightColor,
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(color: Colors.black)),
                          child: ListTile(
                            onTap: () {
                              if (stud_data.studentAssignment.path
                                  .endsWith('.jpg') ||
                                  stud_data.studentAssignment.path
                                      .endsWith('.jpeg') ||
                                  stud_data.studentAssignment.path
                                      .endsWith('.png')) {
                                print(
                                    '${Api.basePicUrl}${stud_data.studentAssignment.path}');
                                launchUrlString(
                                    '${Api.basePicUrl}${stud_data.studentAssignment.path}');
                              } else if (stud_data.studentAssignment.path
                                  .endsWith('.doc') ||
                                  stud_data.studentAssignment.path
                                      .endsWith('.docx') ||
                                  stud_data.studentAssignment.path
                                      .endsWith('.pdf')) {
                                print(
                                    'http://docs.google.com/viewer?url=${Api.basePicUrl}${stud_data.studentAssignment.path}');
                                launchUrlString(
                                    'http://docs.google.com/viewer?url=${Api.basePicUrl}${stud_data.studentAssignment.path}');
                              } else {
                                SnackShow.showFailure(
                                    context, 'Submitted in wrong format');
                              }

                              // launchUrl(url);
                            },
                            title: const Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'View Assignment',
                                  style: TextStyle(color: Colors.black),
                                ),
                                Icon(
                                  Icons.arrow_circle_right_sharp,
                                  color: Colors.black,
                                )
                              ],
                            ),
                          ),
                        ),

                        const SizedBox(height: 10,),

                        assignmentStatus.when(
                            data: (statusData){
                              final status = statusData.firstWhereOrNull((element) => element.studentAssignment.id == stud_data.id);

                              if(status == null){
                                return Container(

                                    decoration: BoxDecoration(
                                        color: shimmerHighlightColor,
                                        borderRadius: BorderRadius.circular(10),
                                        border: Border.all(
                                            color: Colors.black
                                        )
                                    ),
                                    child: const ListTile(
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
                                            title: const Text('Status',style: TextStyle(color: Colors.white),),
                                            trailing:Text(status.status,style: const TextStyle(color: Colors.white),)
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
                            error: (err, stack) => Center(child: Text('$err')),
                            loading: () =>
                                SizedBox(
                                    height:100.h,
                                    child: const ShimmerListTile3())
                        ),



                      ],
                    );

                  }
                  else{
                    return Text(
                      'No Submission',style: TextStyle(color: Colors.black,fontSize: 15.sp,fontWeight: FontWeight.bold),
                    );

                  }

                },
                error: (err, stack) => Center(child: Text('$err')),
                loading: () =>
                    SizedBox(
                        height: 100.h,
                        child: const ShimmerListTile3())),
          ),





        ],
      ),
    );
  }
}
