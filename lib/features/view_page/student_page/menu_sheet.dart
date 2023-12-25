import 'package:eschool/api/api.dart';
import 'package:eschool/features/services/notice_services.dart';
import 'package:eschool/features/services/student_services.dart';
import 'package:eschool/authentication/providers/auth_provider.dart';
import 'package:eschool/constants/colors.dart';
import 'package:eschool/features/view_page/student_page/menu_items/attendance/attendance_page.dart';
import 'package:eschool/features/view_page/student_page/menu_items/exam/exam_page.dart';
import 'package:eschool/features/view_page/student_page/menu_items/school_calender.dart';
import 'package:eschool/features/view_page/student_page/menu_items/parent_profile.dart';
import 'package:eschool/features/view_page/student_page/menu_items/notices/notice_page.dart';
import 'package:eschool/features/view_page/student_page/menu_items/report_page.dart';
import 'package:eschool/features/view_page/student_page/menu_items/result/result_page.dart';
import 'package:eschool/authentication/login_pages/parent_login.dart';
import 'package:eschool/authentication/login_pages/student_page.dart';
import 'package:eschool/features/view_page/sample_pages/profile_samples/sample_profile.dart';
import 'package:eschool/utils/commonWidgets.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:icon_decoration/icon_decoration.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../services/feature_services.dart';
import 'menu_items/settings_page.dart';
import 'menu_items/result/result_page.dart';
import 'menu_items/timetable/timetable_page.dart';

class MenuPage extends ConsumerStatefulWidget {

  @override
  ConsumerState<MenuPage> createState() => _MenuPageState();
}

class _MenuPageState extends ConsumerState<MenuPage> {

  double boxX= 0;
  double boxY= 10;



  @override
  void initState() {
    super.initState();
    // Rebuild the screen after 3s which will process the animation from green to blue
    Future.delayed(Duration(milliseconds: 100)).then((value) => setState(() {
      boxX = 0;
      boxY = 1;
    }));

  }


  @override
  Widget build(BuildContext context) {

    final auth = ref.watch(authProvider);
    final noticeData = ref.watch(noticeList(auth.user.token));
    final infoData = ref.watch(studentList(auth.user.token));
    final studentClass = ref.watch(studentClassInfo(auth.user.token));

    return Container(
      padding: EdgeInsets.only(top: 8.h),
      // height: MediaQuery.of(context).size.height * 0.7,
      width: 392.w,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(40))
      ),
      child: studentClass.when(
          data: (classData){
            final class_data = classData.firstWhere((element) => element.currentLevel==true);
            return Column(
              // mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal:20.w,vertical: 5.h),
                  child: Row(
                    children: [

                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: CircleAvatar(
                          backgroundImage: NetworkImage('${Api.basePicUrl}${class_data.student.studentPhoto}'),
                          radius: 30.sp,
                        ),
                      ),


                      Padding(
                        padding: EdgeInsets.symmetric(horizontal:8.w),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(class_data.student.studentName,style:TextStyle(fontSize: 20.sp,color: Colors.black,),),
                            Text('Class : ${class_data.className!.className.classLevel.name} ${class_data.className!.sectionName.sectionName} | Roll No : ${class_data.rollNo}',style:TextStyle(fontSize: 15.sp,color: Colors.grey),),
                            Text('Section : ${class_data.className!.sectionName.sectionName} ${class_data.className!.sectionName.sectionName} ',style:TextStyle(fontSize: 15.sp,color: Colors.grey),)
                          ],
                        ),
                      ),
                      // IconButton(
                      //     onPressed: (){
                      //       Get.to(()=>StudentProfile(student_id: info.id,className:class_data.className!.className.classLevel.name! ,rollNo: class_data.rollNo,));
                      //     },
                      //     icon: Icon(Icons.arrow_forward_ios,color: Colors.black,size: 30.sp,)
                      // )
                    ],
                  ),
                ),
                Divider(
                  thickness: 1.h,
                  color: Colors.grey.withOpacity(0.7),
                  height: 25.h,
                  indent: 20.w,
                  endIndent: 20.w,
                ),



                GridView(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,

                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      childAspectRatio: (MediaQuery.of(context).size.width) /
                          (MediaQuery.of(context).size.height / 2.2),
                    ),
                    children: [
                      GridTileButton(
                        title: 'Attendance',
                        imagePath: 'assets/icons/attendance 1 copy.svg',
                        onTap: (){
                          Get.to(()=>Attendance(student_id: class_data.student.id,));
                        },
                      ),
                      GridTileButton(
                        title: 'Timetable',
                        imagePath: 'assets/icons/time table copy.svg',
                        onTap: (){
                          Get.to(()=>TimeTable(className: class_data.className!.className.classLevel.name,section: class_data.className!.sectionName.sectionName,class_sec_id: class_data.className!.id,));
                        },
                      ),
                      GridTileButton(
                        title: 'Notice Board',
                        imagePath: 'assets/icons/notice copy.svg',
                        onTap: (){
                          Get.to(()=>NoticeBoard(class_sec_id: class_data.className!.id,));
                        },
                      ),
                      GridTileButton(
                        title: 'Exam',
                        imagePath: 'assets/icons/exam copy.svg',
                        onTap: (){
                          Get.to(()=>ExamPage(class_id: class_data.className!.className.id,));
                        },
                      ),

                      GridTileButton(
                        title: 'Result',
                        imagePath: 'assets/icons/result copy.svg',
                        onTap: (){
                          Get.to(()=>ExamResults(class_id: class_data.className!.className.id,student_id: class_data.student.id,));
                        },
                      ),
                      GridTileButton(
                        title: 'Report',
                        imagePath: 'assets/icons/report copy.svg',
                        onTap: (){
                          Get.to(()=>ReportPage(class_data: class_data,student_id:class_data.student.id ,));
                        },
                      ),
                      //
                      // GridTileButton(
                      //   title: 'Parents',
                      //   imagePath: 'assets/icons/parents copy.svg',
                      //   onTap: (){
                      // //    Get.to(()=>ParentsProfile(student_id: info.id));
                      //   },
                      // ),

                      GridTileButton(
                        title: 'Calender',
                        imagePath: 'assets/icons/holiday.svg',
                        onTap: (){
                          Get.to(()=>Calender());
                        },
                      ),

                      GridTileButton(
                        title: 'Settings',
                        imagePath: 'assets/icons/settings copy.svg',
                        onTap: (){
                          Get.to(()=>Settings());
                        },
                      ),



                    ]),




              ],
            );

          },
          error: (err, stack) => Center(child: Text('$err')),
          loading: () => Center(child: CircularShimmer())),








    );



  }
}
