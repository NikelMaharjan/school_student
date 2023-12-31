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

  const AssignmentDetails({super.key, required this.assignment, required this.student_id});

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

    final Uri url = Uri.parse(website);
    if (await canLaunchUrl(url)) {
      await launchUrl(url, mode: LaunchMode.externalApplication);
    } else {
      throw "Could not launch $url";
    }

  }

  @override
  Widget build(BuildContext context) {
    final auth = ref.watch(authProvider);
    final image = ref.watch(imageProvider);

    //print("File is $_file");

    final assigned = ref.watch(assignmentProvider);
    final studentAssignment = ref.watch(studentAssignmentProvider(auth.user.token));
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(

        children: [


          DataTable(
            // datatable widget
            columns: [
              // column to set the name
              const DataColumn(label: Text('Title'),),
              DataColumn(label: Text(widget.assignment.title),),
            ],

            rows: [
              // row to set the values
              DataRow(
                  cells: [
                const DataCell(Text('Description')),
                DataCell(InkWell(

                  onTap: (){
                    showDialog (
                      context: context,
                      barrierDismissible: true,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          shape: const RoundedRectangleBorder(borderRadius:
                          BorderRadius.all(Radius.circular(10))),
                          title: const Text('Description!'),
                          content: Text(widget.assignment.description),
                          actions: [

                            TextButton(
                              child: const Text('OK',),
                              onPressed: () {

                                Navigator.of(context).pop();


                              },
                            ),
                          ],
                        );
                      },
                    );
                  },

                    child: SizedBox(
                      width: 180.w,
                      child: Text(widget.assignment.description, style: TextStyle(
                          color: bgColor,
                          decoration: TextDecoration.underline,
                          fontStyle: FontStyle.italic,
                          overflow: TextOverflow.ellipsis

                      ),
                      ),
                    ),
                )),
                  ]
              ),


              DataRow(
                  cells: [
                    const DataCell(Text('Link')),
                    DataCell(widget.assignment.link != null ? InkWell(
                      onTap: (){
                        _redirect(widget.assignment.link!);

                      },
                        child: SizedBox(
                          width: 180.w,
                          child: Text(widget.assignment.link!, style: TextStyle(
                              fontStyle: FontStyle.italic,
                              color: bgColor,
                              overflow: TextOverflow.ellipsis,

                              decoration: TextDecoration.underline
                          ),),
                        )) : const Text("")),
                  ]
              ),


              DataRow(
                  cells: [
                    const DataCell(Text('Reference')),
                    DataCell(widget.assignment.imageFile != null ? InkWell(
                        onTap: (){
                          showImageViewer(context, CachedNetworkImageProvider('${Api.basePicUrl}${widget.assignment.imageFile}'),
                              swipeDismissible: false);
                        },
                        child: SizedBox(
                          width: 180.w,
                            child: Text(widget.assignment.imageFile!, style: TextStyle(
                                fontStyle: FontStyle.italic,
                                color: bgColor,
                                overflow: TextOverflow.ellipsis,
                                decoration: TextDecoration.underline),))) : const Text("")),
                  ]
              ),

              DataRow(
                  cells: [
                    const DataCell(Text('Deadline')),
                    DataCell(widget.assignment.hasDeadline == true ? Text(DateFormat('MMMM dd').format(DateTime.parse(widget.assignment.deadline!))) : const Text("")),
                  ]
              ),

            ],
          ),

          // SizedBox(height: 20,),
          // Text('Title',style: TextStyle(color: Colors.black,fontSize: 18.sp,fontWeight: FontWeight.bold),),
          //
          // SizedBox(height: 5.h,),
          // Text(widget.assignment.title,style: TextStyle(color: Colors.black),),
          // SizedBox(height: 10.h,),
          //
          // Divider(
          //   thickness: 1,
          //   color: Colors.black,
          // ),
          //
          // Text('Description',style: TextStyle(color: Colors.black,fontSize: 18.sp,fontWeight: FontWeight.bold),),
          // SizedBox(height: 5.h,),
          // Text(widget.assignment.description,style: TextStyle(color: Colors.black),),
          // SizedBox(height: 10.h,),
          // Divider(
          //   thickness: 1,
          //   color: Colors.black,
          // ),
          // widget.assignment.link != null ? Column(
          //   children: [
          //     ListTile(
          //       onTap: (){
          //         _redirect(widget.assignment.link!);
          //       },
          //       contentPadding: EdgeInsets.zero,
          //       title: Text('Link',style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),),
          //       subtitle: Text(widget.assignment.link!,style: TextStyle(color: bgColor, fontStyle: FontStyle.italic, decoration: TextDecoration.underline),),
          //     ),
          //     Divider(
          //       thickness: 1,
          //       color: Colors.black,
          //     ),
          //   ],
          // ):SizedBox(),
          // SizedBox(height: 5.h,),
          // widget.assignment.imageFile != null ? Column(
          //   crossAxisAlignment: CrossAxisAlignment.start,
          //   children: [
          //     Text('Reference Image',style: TextStyle(color: Colors.black,fontSize: 18.sp,fontWeight: FontWeight.bold),),
          //     InkWell(
          //       onTap: () {
          //         showImageViewer(context, CachedNetworkImageProvider('${Api.basePicUrl}${widget.assignment.imageFile}'),
          //             swipeDismissible: false);
          //       },
          //       child: Text(widget.assignment.imageFile!, style: TextStyle(color: bgColor, fontStyle: FontStyle.italic, decoration: TextDecoration.underline),),
          //     ),
          //   ],
          // ):SizedBox(),
          // SizedBox(height: 10.h,),
          //
          // Divider(
          //   thickness: 1,
          //   color: Colors.black,
          // ),
          // widget.assignment.hasDeadline==true? Column(
          //   crossAxisAlignment: CrossAxisAlignment.start,
          //
          //   children: [
          //     Text('Deadline',style: TextStyle(color: Colors.black,fontSize: 18.sp,fontWeight: FontWeight.bold),),
          //
          //     Text('${DateFormat('MMMM dd').format(DateTime.parse(widget.assignment.deadline!))}',style: TextStyle(color: Colors.black,fontSize: 16.sp),),
          //
          //
          //     Divider(
          //       thickness: 1,
          //       color: Colors.black,
          //     ),
          //
          //
          //
          //   ],
          // ): Text(''),

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


          const SizedBox(height: 40,),




          studentAssignment.when(
              data: (data) {
                final studData = data.firstWhereOrNull((element) => element.assignment.id == widget.assignment.id && element.student.id == widget.student_id);

               // print(widget.assignment.id);
               // print(widget.student_id);


                if (studData != null) {
                  final url = Uri.parse('${Api.basePicUrl}${studData.studentAssignment.path}');

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
                                    content: const Text('Delete Assignment?'),
                                    actions: [
                                      TextButton(
                                          onPressed: () async {
                                            ref.read(assignmentProvider.notifier).delStudentAssignment(
                                                id: studData.id,
                                                token: auth.user.token)
                                                .then((value) => ref.refresh(studentAssignmentProvider(auth.user.token)))
                                                .then((value) => Navigator.pop(context));
                                          },
                                          child: const Text('Yes')),
                                      TextButton(
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                          child: const Text('No')),
                                    ],
                                  );
                                });
                          },
                          onTap: () {
                            if (studData.studentAssignment.path
                                .endsWith('.jpg') ||
                                studData.studentAssignment.path
                                    .endsWith('.jpeg') ||
                                studData.studentAssignment.path
                                    .endsWith('.png')) {
                              print(
                                  '${Api.basePicUrl}${studData.studentAssignment.path}');
                              launchUrlString(
                                  '${Api.basePicUrl}${studData.studentAssignment.path}',mode: LaunchMode.externalApplication);
                            } else if (studData.studentAssignment.path
                                .endsWith('.doc') ||
                                studData.studentAssignment.path
                                    .endsWith('.docx') ||
                                studData.studentAssignment.path
                                    .endsWith('.pdf')) {
                          //    print('http://docs.google.com/viewer?url=${Api.basePicUrl}${studData.studentAssignment.path}');
                              launchUrlString(
                                  'http://docs.google.com/viewer?url=${Api.basePicUrl}${studData.studentAssignment.path}',mode: LaunchMode.externalApplication);
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
                    ],
                  );
                }




                if (_file == null) {
                  return   DottedBorder(
                    borderType: BorderType.RRect,
                    radius: const Radius.circular(10),
                    dashPattern: const [5, 5],
                    color: primary,
                    strokeWidth: 1,
                    child: InkWell(
                        onTap: () async {
                          _pickFile();
                          // ref.read(imageProvider.notifier).pickAnImage();
                        },
                        child: Container(
                          height: MediaQuery.of(context).size.height * 0.06,
                          width: MediaQuery.of(context).size.width * 0.9,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              CircleAvatar(
                                radius: 12.sp,
                                backgroundColor: primary,
                                child: const Icon(
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
                  return SizedBox(
                      width: 300.w,
                      child: Center(child: Text(
                        'Selected: ${basename(_file!.path)}',
                        style: const TextStyle(color: Colors.black),
                      )));
                }
              },
              error: (err, stack) => Center(child: Text('$err')),
              loading: () => SizedBox(height: 100.h, child: const ShimmerListTile3())),
          if (_file != null)
            Center(
              child: TextButton(
                  style: TextButton.styleFrom(
                      backgroundColor: primary,
                      foregroundColor: Colors.white,
                      fixedSize: Size.fromWidth(320.w),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                          side: const BorderSide(
                            color: Colors.black,
                          ))),
                  onPressed: () {
                    if (_file!.path.endsWith('.jpg') || _file!.path.endsWith('.jpeg') || _file!.path.endsWith('.png') || _file!.path.endsWith('.pdf') || _file!.path.endsWith('.doc')) {
                      ref.read(assignmentProvider.notifier).addStudentAssignment(
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
                  child: assigned.isLoad ? const CircularProgressIndicator() : const Text('Submit')),
            )
        ],
      ),
    );
  }
}
