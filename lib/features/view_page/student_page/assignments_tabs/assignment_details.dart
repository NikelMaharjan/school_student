import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:easy_image_viewer/easy_image_viewer.dart';
import 'package:eschool/features/providers/assignment_providers.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:path/path.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../../../../api/api.dart';
import '../../../../authentication/providers/auth_provider.dart';
import '../../../../constants/colors.dart';
import '../../../../constants/snackshow.dart';
import '../../../../utils/commonWidgets.dart';
import '../../../model/assignment_model.dart';
import '../../../providers/image_provider.dart';
import '../../../services/assignment_services.dart';

class AssignmentDetails extends ConsumerStatefulWidget {
  final Assignment assignment;
  final int student_id;

  AssignmentDetails({required this.assignment, required this.student_id});

  @override
  ConsumerState<AssignmentDetails> createState() => _AssignmentDetailsState();
}

class _AssignmentDetailsState extends ConsumerState<AssignmentDetails> {
  File? _file;

  void _pickFile() async {
    final result = await FilePicker.platform.pickFiles();
    if (result == null) {
      return;
    }

    final selectedFile = result.files.single;
    _file = File(selectedFile.path!);
    setState(() {});
  }




  Future<void> _redirect(String website) async {
    final Uri launchUri = Uri(
      scheme: 'https',
      path: website,
    );
    await launchUrl(launchUri,mode: LaunchMode.externalApplication);
  }

  @override
  Widget build(BuildContext context) {
    final auth = ref.watch(authProvider);
    final image = ref.watch(imageProvider);

    print("File is $_file");

    final assigned = ref.watch(assignmentProvider);
    final studentAssignment = ref.watch(studentAssignmentProvider(auth.user.token));
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.w),
      child: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            SizedBox(height: 20,),
            Text('Title',style: TextStyle(color: Colors.black,fontSize: 18.sp,fontWeight: FontWeight.bold),),

            SizedBox(height: 5.h,),
            Text(widget.assignment.title,style: TextStyle(color: Colors.black),),
            SizedBox(height: 10.h,),

            Divider(
              thickness: 1,
              color: Colors.black,
            ),

            Text('Description',style: TextStyle(color: Colors.black,fontSize: 18.sp,fontWeight: FontWeight.bold),),
            SizedBox(height: 5.h,),
            Text(widget.assignment.description,style: TextStyle(color: Colors.black),),
            SizedBox(height: 10.h,),
            Divider(
              thickness: 1,
              color: Colors.black,
            ),
            widget.assignment.link != null ? Column(
              children: [
                ListTile(
                  onTap: (){
                    _redirect(widget.assignment.link!);
                  },
                  contentPadding: EdgeInsets.zero,
                  title: Text('Link',style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),),
                  subtitle: Text(widget.assignment.link!,style: TextStyle(color: bgColor, fontStyle: FontStyle.italic, decoration: TextDecoration.underline),),
                ),
                Divider(
                  thickness: 1,
                  color: Colors.black,
                ),
              ],
            ):SizedBox(),
            SizedBox(height: 5.h,),
            widget.assignment.imageFile != null ? Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Image',style: TextStyle(color: Colors.black,fontSize: 18.sp,fontWeight: FontWeight.bold),),
                InkWell(
                  onTap: () {
                    showImageViewer(context, CachedNetworkImageProvider('${Api.basePicUrl}${widget.assignment.imageFile}'),
                        swipeDismissible: false);
                  },
                  child: Text(widget.assignment.imageFile!, style: TextStyle(color: bgColor, fontStyle: FontStyle.italic, decoration: TextDecoration.underline),),
                ),
              ],
            ):SizedBox(),
            SizedBox(height: 10.h,),

            Divider(
              thickness: 1,
              color: Colors.black,
            ),
            widget.assignment.hasDeadline==true? Column(
              crossAxisAlignment: CrossAxisAlignment.start,

              children: [
                Text('Deadline',style: TextStyle(color: Colors.black,fontSize: 18.sp,fontWeight: FontWeight.bold),),

                Text('${DateFormat('MMMM dd').format(DateTime.parse(widget.assignment.deadline!))}',style: TextStyle(color: Colors.black,fontSize: 16.sp),),


                Divider(
                  thickness: 1,
                  color: Colors.black,
                ),



              ],
            ): Text(''),

         // DottedBorder(
         //      borderType: BorderType.RRect,
         //      radius: Radius.circular(10),
         //      dashPattern: [5, 5],
         //      color: primary,
         //      strokeWidth: 1,
         //      child: InkWell(
         //          onTap: () async {
         //            _pickFile();
         //            // ref.read(imageProvider.notifier).pickAnImage();
         //          },
         //          child: Container(
         //            height: MediaQuery.of(context).size.height * 0.08,
         //            width: MediaQuery.of(context).size.width * 0.9,
         //            decoration: BoxDecoration(
         //              borderRadius: BorderRadius.circular(10),
         //            ),
         //            child: Row(
         //              mainAxisAlignment: MainAxisAlignment.center,
         //              children: [
         //                CircleAvatar(
         //                  radius: 20.sp,
         //                  backgroundColor: primary,
         //                  child: Icon(
         //                    Icons.add,
         //                    color: Colors.white,
         //                  ),
         //                ),
         //                SizedBox(
         //                  width: 10.w,
         //                ),
         //                Text(
         //                  'Add Assignment',
         //                  style: TextStyle(
         //                      color: Colors.black, fontSize: 15.sp),
         //                )
         //              ],
         //            ),
         //          )),
         //    ),


            SizedBox(height: 10,),




            studentAssignment.when(
                data: (data) {
                  final stud_data = data.firstWhereOrNull((element) => element.assignment.id == widget.assignment.id && element.student.id == widget.student_id);

                  print(widget.assignment.id);
                  print(widget.student_id);


                  if (stud_data != null) {
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
                            onLongPress: () {
                              showDialog(
                                  context: context,
                                  builder: (context) {
                                    return AlertDialog(
                                      content: Text('Delete Assignment?'),
                                      actions: [
                                        TextButton(
                                            onPressed: () async {
                                              ref
                                                  .read(assignmentProvider
                                                  .notifier)
                                                  .delStudentAssignment(
                                                  id: stud_data.id,
                                                  token: auth.user.token)
                                                  .then((value) => ref.refresh(
                                                  studentAssignmentProvider(
                                                      auth.user.token)))
                                                  .then((value) =>
                                                  Navigator.pop(context));
                                            },
                                            child: Text('Yes')),
                                        TextButton(
                                            onPressed: () {
                                              Navigator.pop(context);
                                            },
                                            child: Text('No')),
                                      ],
                                    );
                                  });
                            },
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
                                    '${Api.basePicUrl}${stud_data.studentAssignment.path}',mode: LaunchMode.externalApplication);
                              } else if (stud_data.studentAssignment.path
                                  .endsWith('.doc') ||
                                  stud_data.studentAssignment.path
                                      .endsWith('.docx') ||
                                  stud_data.studentAssignment.path
                                      .endsWith('.pdf')) {
                                print(
                                    'http://docs.google.com/viewer?url=${Api.basePicUrl}${stud_data.studentAssignment.path}');
                                launchUrlString(
                                    'http://docs.google.com/viewer?url=${Api.basePicUrl}${stud_data.studentAssignment.path}',mode: LaunchMode.externalApplication);
                              } else {
                                SnackShow.showFailure(
                                    context, 'Submitted in wrong format');
                              }

                              // launchUrl(url);
                            },
                            title: Row(
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
                      ],
                    );
                  }




                  if (_file == null) {
                    return   DottedBorder(
                      borderType: BorderType.RRect,
                      radius: Radius.circular(10),
                      dashPattern: [5, 5],
                      color: primary,
                      strokeWidth: 1,
                      child: InkWell(
                          onTap: () async {
                            _pickFile();
                            // ref.read(imageProvider.notifier).pickAnImage();
                          },
                          child: Container(
                            height: MediaQuery.of(context).size.height * 0.08,
                            width: MediaQuery.of(context).size.width * 0.9,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                CircleAvatar(
                                  radius: 20.sp,
                                  backgroundColor: primary,
                                  child: Icon(
                                    Icons.add,
                                    color: Colors.white,
                                  ),
                                ),
                                SizedBox(
                                  width: 10.w,
                                ),
                                Text(
                                  'Add Assignment',
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 15.sp),
                                )
                              ],
                            ),
                          )),
                    );

                  } else {
                    return Container(
                        width: 300.w,
                        child: Center(
                            child: Text(
                          'Selected: ${basename(_file!.path)}',
                          style: TextStyle(color: Colors.black),
                        )));
                  }
                },
                error: (err, stack) => Center(child: Text('$err')),
                loading: () => Container(height: 100.h, child: ShimmerListTile3())),
            if (_file != null)
              Center(
                child: TextButton(
                    style: TextButton.styleFrom(
                        backgroundColor: primary,
                        foregroundColor: Colors.white,
                        fixedSize: Size.fromWidth(320.w),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                            side: BorderSide(
                              color: Colors.black,
                            ))),
                    onPressed: () {
                      if (_file!.path.endsWith('.jpg') ||
                          _file!.path.endsWith('.jpeg') ||
                          _file!.path.endsWith('.png') ||
                          _file!.path.endsWith('.pdf') ||
                          _file!.path.endsWith('.doc')) {
                        ref
                            .read(assignmentProvider.notifier).addStudentAssignment(
                                student: widget.student_id,
                                assignment: widget.assignment.id,
                                token: auth.user.token,
                                student_assignment: _file!)
                            .then((value) => SnackShow.showSuccess(
                                context, 'Assignment Submitted'))
                            .then((value) => ref.refresh(
                                studentAssignmentProvider(auth.user.token)))
                            .then((value) => SnackShow.showSuccess(
                                context, 'Assignment added'))
                            .then((value) {
                          _file = null;
                          setState(() {});
                        });
                      } else {
                        SnackShow.showFailure(
                            context, 'Trying to submit in wrong format');
                      }
                    },
                    child: assigned.isLoad
                        ? CircularProgressIndicator()
                        : Text('Submit')),
              )
          ],
        ),
      ),
    );
  }
}
