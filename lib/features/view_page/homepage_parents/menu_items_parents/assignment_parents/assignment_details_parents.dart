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

import '../../../../../api/api.dart';
import '../../../../../authentication/providers/auth_provider.dart';
import '../../../../../constants/colors.dart';
import '../../../../../constants/snackshow.dart';
import '../../../../../utils/commonWidgets.dart';
import '../../../../model/assignment_model.dart';
import '../../../../providers/image_provider.dart';
import '../../../../services/assignment_services.dart';

class AssignmentDetailsParents extends ConsumerStatefulWidget {
  final Assignment assignment;
  final int student_id;

  AssignmentDetailsParents({required this.assignment, required this.student_id});

  @override
  ConsumerState<AssignmentDetailsParents> createState() => _AssignmentDetailsParentsState();
}

class _AssignmentDetailsParentsState extends ConsumerState<AssignmentDetailsParents> {
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

    final assigned = ref.watch(assignmentProvider);
    final studentAssignment =
    ref.watch(studentAssignmentProvider(auth.user.token));
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.w),
      child: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
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

          ],
        ),
      ),
    );
  }
}
