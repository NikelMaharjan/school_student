import 'package:eschool/api/api.dart';
import 'package:eschool/authentication/providers/auth_provider.dart';
import 'package:eschool/constants/colors.dart';
import 'package:eschool/features/services/student_services.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../utils/commonWidgets.dart';

class StudentProfile extends ConsumerWidget {
  final int student_id;
  final String className;
  final int rollNo;
  StudentProfile({required this.student_id,required this.rollNo,required this.className});

  @override
  Widget build(BuildContext context,ref) {
    final auth = ref.watch(authProvider);
    final infoData = ref.watch(studentList(auth.user.token));

    return Scaffold(
      appBar: AppBar(
        backgroundColor: bgColor,
        title: Text("Profile", style: TextStyle(color: Colors.white),),
      ),
      backgroundColor: Colors.white,
      body: infoData.when(
          data: (data){
           final info = data.firstWhere((element) => element.id == student_id);
           return   SingleChildScrollView(
             physics: BouncingScrollPhysics(),
             child: Column(

               mainAxisSize: MainAxisSize.min,
               children: [
                 Padding(
                   padding: EdgeInsets.symmetric(vertical: 12.h),
                   child: CircleAvatar(
                     backgroundImage: NetworkImage('${Api.basePicUrl}${info.studentPhoto}'),
                       radius: 50.sp,),
                 ),
                 Text(
                   info.studentName,
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
                     title: 'Class',
                     text: className,
                     icon: Icons.person
                 ),
                 SizedBox(
                   height: 30.h,
                 ),
                 IconTextRow(
                     title: 'Roll no.',
                     text: '${rollNo}',
                     icon: Icons.segment_rounded
                 ),

                 SizedBox(
                   height: 30.h,
                 ),
                 IconTextRow(
                     title: 'Date of Birth',
                     text: info.dateOfBirthEng,
                     icon: Icons.timelapse
                 ),
                 SizedBox(
                   height: 30.h,
                 ),
                 IconTextRow(
                     title: 'Residential Address',
                     text: info.residentalAddress,
                     icon: Icons.gps_fixed
                 ),

                 SizedBox(
                   height: 30.h,
                 ),

                 IconTextRow(title: 'Gender', text: info.gender, icon: info.gender == "male"? Icons.male : Icons.female),

                 SizedBox(
                   height: 30.h,
                 ),
                 IconTextRow(title: 'Mobile no.', text: '${info.mobileNumber}', icon: Icons.phone),
                 SizedBox(
                   height: 30.h,
                 ),
                 IconTextRow(title: 'Email', text: info.email, icon: Icons.email),
                 SizedBox(
                   height: 55.h,
                 ),
               ],
             ),
           );
          },
          error: (err, stack) => Center(child: Text('$err')),
          loading: () => Center(child: ShimmerListTile())
      ),
    );
  }
}
