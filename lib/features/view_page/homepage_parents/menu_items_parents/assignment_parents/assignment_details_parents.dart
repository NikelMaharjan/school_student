import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
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
    final Uri launchUri = Uri(
      scheme: 'https',
      path: website,
    );
    await launchUrl(launchUri);
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
            SizedBox(
              height: 20.h,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                    width: MediaQuery.of(context).size.width * 1 / 2,
                    child: Text(
                      widget.assignment.title,
                      style: TextStyle(color: Colors.black, fontSize: 20.sp),
                    )),
              ],
            ),
            Divider(
              thickness: 1,
              color: Colors.black,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Description',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 18.sp,
                      fontWeight: FontWeight.bold),
                ),
                Text(
                  DateFormat('MMMM dd')
                      .format(DateTime.parse(widget.assignment.createdAt)),
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 15.sp,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 5.h,
            ),
            Text(
              widget.assignment.description,
              style: TextStyle(color: Colors.black),
            ),
            SizedBox(
              height: 5.h,
            ),
            widget.assignment.link != null
                ? ListTile(
              onTap: () {
                _redirect(widget.assignment.link!);
              },
              contentPadding: EdgeInsets.zero,
              title: Text(
                'Link',
                style: TextStyle(
                    color: Colors.black, fontWeight: FontWeight.bold),
              ),
              subtitle: Text(
                widget.assignment.link!,
                style: TextStyle(color: Colors.black),
              ),
            )
                : SizedBox(),
            SizedBox(
              height: 5.h,
            ),
            widget.assignment.imageFile != null
                ? Container(
                height: 200.h,
                width: double.infinity,
                child: Image.network(
                  '${Api.basePicUrl}${widget.assignment.imageFile}',
                  fit: BoxFit.contain,
                ))
                : SizedBox(),
            Divider(
              thickness: 1,
              color: Colors.black,
            ),
            widget.assignment.hasDeadline == true
                ? Text(
              'Deadline: ${DateFormat('MMMM dd').format(DateTime.parse(widget.assignment.deadline!))}',
              style: TextStyle(color: Colors.black, fontSize: 20.sp),
            )
                : Text(''),
            SizedBox(
              height: 10.h,
            ),
          ],
        ),
      ),
    );
  }
}
