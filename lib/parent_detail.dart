

import 'package:eschool/api/api.dart';
import 'package:eschool/authentication/providers/auth_provider.dart';
import 'package:eschool/constants/colors.dart';
import 'package:eschool/features/model/parent_model.dart';
import 'package:eschool/features/services/student_services.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../utils/commonWidgets.dart';

class ParentsProfiles extends ConsumerWidget {


  final ParentDetail parentDetail;

  ParentsProfiles({required this.parentDetail});



  @override
  Widget build(BuildContext context,ref) {
    final auth = ref.watch(authProvider);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: bgColor,
        title: const Text("Profile", style: TextStyle(color: Colors.white),),
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(

          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(vertical: 12.h),
              child: CircleAvatar(
                backgroundImage: NetworkImage('${Api.basePicUrl}${parentDetail.picture}'),
                radius: 50.sp,),
            ),
            Text(
              parentDetail.parentName,
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 20.sp),
            ),

            Divider(
              thickness: 1.h,
              height: 30.h,
              color: Colors.grey,
            ),

            SizedBox(
              height: 10.h,
            ),
            IconTextRow(
                title: 'Current Address',
                text: parentDetail.currentAddress,
                icon: Icons.person
            ),
            SizedBox(
              height: 30.h,
            ),
            IconTextRow(
                title: 'Permanent Address',
                text: parentDetail.permanentAddress,
                icon: Icons.segment_rounded
            ),

            SizedBox(
              height: 30.h,
            ),
            IconTextRow(
                title: 'Mobile',
                text: parentDetail.mobileNo.toString(),
                icon: Icons.timelapse
            ),
            SizedBox(
              height: 30.h,
            ),


            IconTextRow(title: 'Gender', text: parentDetail.gender, icon: Icons.person),

            SizedBox(
              height: 30.h,
            ),




            IconTextRow(
                title: 'Occupation',
                text: parentDetail.occupation,
                icon: Icons.timelapse
            ),
            SizedBox(
              height: 30.h,
            ),



            IconTextRow(
                title: 'Education',
                text: parentDetail.education,
                icon: Icons.timelapse
            ),
            SizedBox(
              height: 30.h,
            ),



            IconTextRow(
                title: 'Nationality',
                text: parentDetail.nationality,
                icon: Icons.timelapse
            ),
            SizedBox(
              height: 30.h,
            ),



            IconTextRow(
                title: 'Martial Status',
                text: parentDetail.maritalStatus,
                icon: Icons.timelapse
            ),
            SizedBox(
              height: 30.h,
            ),



            IconTextRow(
                title: 'Relation',
                text: parentDetail.relationshipToStudent,
                icon: Icons.timelapse
            ),

            SizedBox(
              height: 30.h,
            ),



          ],
        ),
      )
    );
  }
}
