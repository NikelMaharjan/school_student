import 'package:card_swiper/card_swiper.dart';
import 'package:eschool/api/api.dart';
import 'package:eschool/authentication/providers/auth_provider.dart';
import 'package:eschool/constants/colors.dart';
import 'package:eschool/features/services/bus_services.dart';
import 'package:eschool/features/services/notice_services.dart';
import 'package:eschool/features/services/student_services.dart';
import 'package:eschool/features/view_page/student_page/default_page.dart';
import 'package:eschool/features/view_page/student_page/notification_tabs/notification_page.dart';
import 'package:eschool/features/view_page/student_page/subject_tab/subject_page.dart';
import 'package:eschool/utils/commonWidgets.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:in_app_update/in_app_update.dart';
import 'package:intl/intl.dart';
import '../../../constants/snackshow.dart';
import '../../../testpage.dart';
import '../../services/notification_service.dart';

import '../homepage_parents/location_tracker.dart';
import '../../services/feature_services.dart';
import '../sample_pages/profile_samples/sample_profile.dart';

import 'menu_items/exam/exam_page.dart';
import 'menu_items/notices/notice_page.dart';
import 'menu_items/result/result_page.dart';
import 'menu_items/school_calender.dart';
import 'menu_items/settings_page.dart';

class OverviewPage extends ConsumerStatefulWidget {
  @override
  ConsumerState<OverviewPage> createState() => _OverviewPageState();
}

class _OverviewPageState extends ConsumerState<OverviewPage> {


  AppUpdateInfo? _updateInfo;
  bool _flexibleUpdateAvailable = false;

  int? unseen;
  int? student_id;
  int? class_id;
  int? section_id;
  int? subject_id;

  String notification_token = '';
  final notificationTypes = [ 'Calendar events','Notice', 'Invigillator info', 'Class section', 'Class notice','Assignment', 'Student assignment', 'Student total fee', 'Exam class', 'Admit card', 'Total exam marks'];



  // @override
  // void initState() {
  //   super.initState();
  //   checkForUpdate();
  //   setState(() {
  //     unseen = 0;
  //   });
  //
  //   FirebaseMessaging.instance.getInitialMessage().then(
  //         (message) {
  //       print("FirebaseMessaging.instance.getInitialMessage");
  //       if (message != null) {
  //         print("New Notification");
  //         if (message.data['id'] != null) {
  //
  //             if(message.data['notification_type']==notificationTypes[0]){
  //               Get.to(()=>NotificationPage(notification_token: notification_token, class_sec_id: class_id!, student_id: student_id!));
  //             }
  //             else if(message.data['notification_type']==notificationTypes[1]||message.data['notification_type']==notificationTypes[4]){
  //               Get.to(()=>NotificationPage(notification_token: notification_token, class_sec_id: class_id!, student_id: student_id!));
  //             }
  //             else if(message.data['notification_type']==notificationTypes[5]){
  //               Get.to(()=>NotificationPage(notification_token: notification_token, class_sec_id: class_id!, student_id: student_id!));
  //             }
  //             else if(message.data['notification_type']==notificationTypes[8]){
  //               Get.to(()=>NotificationPage(notification_token: notification_token, class_sec_id: class_id!, student_id: student_id!));
  //             }
  //             else if(message.data['notification_type']==notificationTypes[10]){
  //               Get.to(()=>NotificationPage(notification_token: notification_token, class_sec_id: class_id!, student_id: student_id!));
  //             }
  //             else{
  //               Get.to(NotificationPage(notification_token: notification_token, class_sec_id: class_id!, student_id: student_id!));
  //             }
  //
  //
  //         }
  //         LocalNotificationService.createanddisplaynotification(message);
  //       }
  //     },
  //   );
  //
  //   // 2. This method only call when App in foreground it mean app must be opened
  //   FirebaseMessaging.onMessage.listen(
  //         (message) {
  //       print("FirebaseMessaging.onMessage.listen");
  //       if (message.notification != null) {
  //         print(message.notification!.title);
  //         print(message.notification!.body);
  //         print("message.data11 ${message.data}");
  //         LocalNotificationService.createanddisplaynotification(message);
  //         // if(message.data['notification_type']==notificationTypes[0]){
  //         //   Get.to(()=>NotificationPage(notification_token: notification_token, class_sec_id: class_id!, student_id: student_id!));
  //         // }
  //         // else if(message.data['notification_type']==notificationTypes[1]||message.data['notification_type']==notificationTypes[4]){
  //         //   Get.to(()=>NotificationPage(notification_token: notification_token, class_sec_id: class_id!, student_id: student_id!));
  //         // }
  //         // else if(message.data['notification_type']==notificationTypes[5]){
  //         //   Get.to(()=>NotificationPage(notification_token: notification_token, class_sec_id: class_id!, student_id: student_id!));
  //         // }
  //         // else if(message.data['notification_type']==notificationTypes[8]){
  //         //   Get.to(()=>NotificationPage(notification_token: notification_token, class_sec_id: class_id!, student_id: student_id!));
  //         // }
  //         // else if(message.data['notification_type']==notificationTypes[10]){
  //         //   Get.to(()=>NotificationPage(notification_token: notification_token, class_sec_id: class_id!, student_id: student_id!));
  //         // }
  //         // else{
  //         //   Get.to(NotificationPage(notification_token: notification_token, class_sec_id: class_id!, student_id: student_id!));
  //         // }
  //
  //       }
  //     },
  //   );
  //
  //   // 3. This method only call when App in background and not terminated(not closed)
  //   FirebaseMessaging.onMessageOpenedApp.listen(
  //         (message) {
  //       print("FirebaseMessaging.onMessageOpenedApp.listen");
  //       if (message.notification != null) {
  //         print(message.notification!.title);
  //         print(message.notification!.body);
  //         print("message.data22 ${message.data['_id']}");
  //         LocalNotificationService.createanddisplaynotification(message);
  //         if(message.data['notification_type']==notificationTypes[0]){
  //           Get.to(()=>NotificationPage(notification_token: notification_token, class_sec_id: class_id!, student_id: student_id!));
  //         }
  //         else if(message.data['notification_type']==notificationTypes[1]||message.data['notification_type']==notificationTypes[4]){
  //           Get.to(()=>NotificationPage(notification_token: notification_token, class_sec_id: class_id!, student_id: student_id!));
  //         }
  //         else if(message.data['notification_type']==notificationTypes[5]){
  //           Get.to(()=>NotificationPage(notification_token: notification_token, class_sec_id: class_id!, student_id: student_id!));
  //         }
  //         else if(message.data['notification_type']==notificationTypes[8]){
  //           Get.to(()=>NotificationPage(notification_token: notification_token, class_sec_id: class_id!, student_id: student_id!));
  //         }
  //         else if(message.data['notification_type']==notificationTypes[10]){
  //           Get.to(()=>NotificationPage(notification_token: notification_token, class_sec_id: class_id!, student_id: student_id!));
  //         }
  //         else{
  //           Get.to(NotificationPage(notification_token: notification_token, class_sec_id: class_id!, student_id: student_id!));
  //         }
  //       }
  //     },
  //   );
  //
  //   getToken();
  //
  // }


  Future<void> getToken()async{
    final response = await FirebaseMessaging.instance.getToken();
    setState(() {
      notification_token= response.toString();
    });
    // print('notification token : $response');
  }

  Future<void> checkForUpdate() async {
    InAppUpdate.checkForUpdate().then((info) {
      setState(() {
        _updateInfo = info;
      });
      if(_updateInfo?.updateAvailability ==
          UpdateAvailability.updateAvailable){
        updateDialog();
      }
      else{
        SnackShow.showSuccess(context, 'App is up to date');
      }
    }).catchError((e) {
      SnackShow.showFailure(context, 'App is up to date');
    });
  }

  void updateDialog() async {
    InAppUpdate.startFlexibleUpdate().then((_) {
      setState(() {
        _flexibleUpdateAvailable = true;
      });
    }).catchError((e) {
      SnackShow.showFailure(context, '${e.toString()}');
    });
  }


  @override
  Widget build(BuildContext context) {
    final auth = ref.watch(authProvider);
    final noticeData = ref.watch(noticeList(auth.user.token));
    final infoData = ref.watch(studentList(auth.user.token));
    final studentClass = ref.watch(studentClassInfo(auth.user.token));
    final notificationData = ref.watch(notificationProvider2(notification_token));
    //print('notification token: $notification_token');


    notificationData.when(
        data: (data) {
          final unseenNotifications = data.where((notification) => notification.seen == false);
          final totalUnseenCount = unseenNotifications.length;
          //print('Total number of unseen notifications: $totalUnseenCount');
          setState(() {
            unseen = totalUnseenCount;
          });
        },
        error: (error, stackTrace) {
      //    print('$error');
        },
        loading: () {
          return;
        }
    );






    // print(auth.user.token);
    return Scaffold(

      backgroundColor: Colors.white,
      body: studentClass.when(
          data: (classData){
            final class_data = classData.firstWhere((element) => element.currentLevel==true);
            setState(() {
              section_id = class_data.className!.id;
              subject_id = class_data.id;
              class_id = class_data.className!.className.classLevel.id;
              student_id = class_data.student!.id;
            });


           // print("section id is $section_id");
           //  print("class id is $class_id");
           //  print("student id is $student_id");





//            final classSubject= ref.watch(secWiseSubjectProvider(class_data.className!.sectionName.id));
            final classSubject= ref.watch(classsSubjectProvider(class_data.className!.id ));
            return SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  Container(
                    height: 220.h,
                    width: double.infinity,
                    decoration: BoxDecoration(
                        color: bgColor,
                        borderRadius: BorderRadius.vertical(bottom: Radius.circular(25))),
                    child: Center(
                      child: Padding(
                        padding: EdgeInsets.only(left: 25.w, top: 70.h,right: 15.w),
                        child: infoData.when(
                            data: (data){
                              final info = data.firstWhere((element) => element.email == auth.user.userInfo.email);
                              print('info id : ${info.id}');
                              final tracker = ref.watch(studentBusProvider(info.id));
                              return  Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: InkWell(
                                      onTap: () => Get.to(() => StudentProfile(student_id: info.id,className:class_data.className!.className.classLevel.name ,rollNo:class_data.rollNo ,)),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          Padding(
                                            padding:
                                            EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.h),
                                            child: CircleAvatar(
                                              backgroundImage: NetworkImage('${Api.basePicUrl}${info.studentPhoto}'),
                                              radius: 30.sp,),
                                          ),
                                          Padding(
                                            padding:
                                            EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.h),
                                            child: Column(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  info.studentName,
                                                  style:
                                                  TextStyle(fontSize: 25.sp, color: Colors.white),
                                                ),
                                                Text(
                                                  'Class : ${class_data.className!.className.classLevel.name }',
                                                  style:
                                                  TextStyle(fontSize: 15.sp, color: Colors.white),
                                                ),

                                                Text(
                                                  '${class_data.className!.sectionName.sectionName} | Roll No : ${class_data.rollNo}',
                                                  style:
                                                  TextStyle(fontSize: 15.sp, color: Colors.white),
                                                ),
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),


                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                        height: 30,
                                        width: 30,
                                        // color: Colors.yellow,
                                        child: Center(
                                          child: Stack(
                                              children: [
                                                InkWell(
                                                    onTap: (){

                                                      Get.to(()=>NotificationPage(notification_token: notification_token,class_sec_id: class_data.className!.id,student_id: class_data.student.id,));
                                                    },
                                                    child: Icon(Icons.notifications, size: 25.sp, color: Colors.white)
                                                ),
                                                if(unseen != 0)
                                                  Positioned(
                                                      top: 0,
                                                      right: 0,
                                                      child: Container(
                                                        width: 14.w,
                                                        height: 14.h,
                                                        decoration: BoxDecoration(
                                                          color: Colors.red,
                                                          shape: BoxShape.circle,
                                                        ),
                                                        child: Center(
                                                          child: Text(
                                                            '',
                                                            // '${unseen}',
                                                            style: TextStyle(
                                                              color: Colors.white,
                                                              fontSize: 10.sp,
                                                              fontWeight: FontWeight.bold,
                                                            ),
                                                          ),
                                                        ),))

                                              ]),
                                        ),
                                      ),

                                      tracker.when(
                                          data:(bus_data){
                                            final busTracker = ref.watch(locationProvider(bus_data.first.busRoute.bus.id));
                                            return busTracker.when(
                                                data: (bus_id){
                                                  return   IconButton(
                                                      onPressed: (){
                                                        // Get.to(()=>TrackerPage());
                                                        Get.to(()=>BusLocationPage(id: bus_id.first.bus,));
                                                      },
                                                      icon: Icon(Icons.pin_drop));
                                                },
                                                loading: ()=>Icon(Icons.pin_drop),
                                                error: (err,stack) => Icon(Icons.error,color: Colors.red)
                                            );
                                          },
                                          loading: ()=>Icon(Icons.pin_drop),
                                          error: (err,stack) {
                                            return IconButton(
                                                onPressed: (){
                                                  SnackShow.showFailure(context, 'No bus assigned.');
                                                },
                                                icon: Icon(Icons.pin_drop, color: Colors.white,));
                                          }
                                      ),
                                    ],
                                  ),
                                ],
                              );
                            },
                            error: (err, stack) => Center(child: Text('$err')),
                            loading: () => Center(child: CircularShimmer())),
                      ),
                    ),
                  ),

                  SizedBox(
                    height: 20 ,
                  ),



                  // Container(
                  //     width: double.infinity,
                  //     height: 210.h,
                  //     // color: Colors.blue,
                  //     child: noticeData.when(
                  //       data: (data){
                  //         final notice_data = data.where((element) => element.forAllClass == true).toList();
                  //         return Swiper(
                  //           pagination: SwiperPagination(
                  //             alignment: Alignment.bottomCenter,
                  //           ),
                  //           autoplay: true,
                  //           // autoplayDelay: 2,
                  //           autoplayDisableOnInteraction: true,
                  //           itemCount: notice_data.length,
                  //           loop: notice_data.length == 1 ? false : true,
                  //           viewportFraction: 1,
                  //           scale: 0.9,
                  //           itemBuilder: (context, index) {
                  //             return Center(
                  //               child: InkWell(
                  //                 onTap: (){
                  //                   showDialog(
                  //                       context: context,
                  //                       builder: (context){
                  //                         return AlertDialog(
                  //                           backgroundColor: Colors.white,
                  //                           title: Text(
                  //                             notice_data[index].title,
                  //                             style: TextStyle(
                  //                               color: Colors.black,
                  //                               fontWeight: FontWeight.bold,
                  //                             ),),
                  //                           content: Container(
                  //                             child:Column(
                  //                               mainAxisSize: MainAxisSize.min,
                  //                               children: [
                  //                                 Align(
                  //                                   alignment: Alignment.topLeft,
                  //                                   child: Text(
                  //                                     notice_data[index].description,
                  //                                     style: TextStyle(color: Colors.black),
                  //                                     maxLines: null,
                  //                                   ),
                  //                                 ),
                  //                                 SizedBox(height: 5.h,),
                  //                                 if(notice_data[index].image!=null)
                  //                                   Container(
                  //                                     height: MediaQuery.of(context).size.height*0.2,
                  //                                     child: Image.network('${Api.basePicUrl}${notice_data[index].image}',fit: BoxFit.contain,),
                  //                                   )
                  //                               ],
                  //                             ),
                  //                           ),
                  //                           actions: [
                  //                             Padding(
                  //                               padding: EdgeInsets.only(left: 15.w),
                  //                               child: Text(
                  //                                 notice_data[index].createdAt,
                  //                                 style: TextStyle(fontSize: 12.sp, color: Colors.black),
                  //                               ),
                  //                             )
                  //                           ],
                  //                           actionsAlignment: MainAxisAlignment.start,
                  //                         );
                  //                       }
                  //                   );
                  //                 },
                  //                 child: Card(
                  //                   elevation: 5,
                  //                   shape: RoundedRectangleBorder(
                  //                       borderRadius: BorderRadius.circular(20)),
                  //                   color: Colors.white,
                  //                   child: SizedBox(
                  //                     width: 350.w,
                  //                     height: 150.h,
                  //                     child: Stack(children: [
                  //                       notice_data[index].image != null ?
                  //                       Container(
                  //                           width: 350.w,
                  //                           height: 150.h,
                  //
                  //                           child: ClipRRect(
                  //                               borderRadius: BorderRadius.circular(20),
                  //                               child: Image.network('${Api.basePicUrl}${notice_data[index].image}',fit: BoxFit.fitWidth,))) : Container(),
                  //
                  //                       Center(child: Text(notice_data[index].title,style: TextStyle(color: Colors.black),))]),
                  //                   ),
                  //                 ),
                  //               ),
                  //             );
                  //           },
                  //         );
                  //       },
                  //       error: (err, stack) => Center(child: Text('$err')),
                  //       loading: () => CardShimmer(),
                  //     )
                  // ),


                  SizedBox(
                    height: 10.h,
                  ),

                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 30.w, vertical: 8.h),
                    child: Text('My Subjects',
                        style: TextStyle(fontSize: 24.sp, color: Colors.black)),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 20.w),
                    child: Container(
                      // color: Colors.red,
                        child: classSubject.when(
                            data: (sub_data){
                              return GridView.builder(
                                itemCount: sub_data.length ,
                                padding: EdgeInsets.zero,
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                    childAspectRatio: 2.w / 2.4.h,
                                    crossAxisCount: 3,
                                    mainAxisSpacing: 5.h,
                                    crossAxisSpacing: 5.w),
                                itemBuilder: (context,index){
                                  return  CommonWidget(
                                    color: Colors.lightBlueAccent,

                                    label: sub_data[index].subject.subject_name.substring(0, 1).toUpperCase(),



                                    text: sub_data[index].subject.subject_name,

                                    onTap: () => Get.to(() => Subjects(
                                        sec_name: class_data.className!.sectionName.sectionName,
                                        class_level_name: class_data.className!.className.classLevel.name,
                                        class_sec_id: class_data.className!.id,
                                        subject_name: sub_data[index].subject.subject_name,
                                        subject_id: sub_data[index].subject.id,
                                        teacher_id: 1,
                                        class_Sec_Sub_id: sub_data[index].id
                                    )),
                                  );
                                },


                              );
                            },
                            error:  (err, stack) => Center(child: Text('$err')),
                            loading: () => GridShimmer()
                        )

                        ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 30.w,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Latest Notices',
                            style: TextStyle(fontSize: 20.sp, color: Colors.black)),
                        InkWell(
                            onTap: () => Get.to(() => NoticeBoard(class_sec_id: class_data.className!.id,)),
                            child: Text('view all >',
                                style: TextStyle(
                                    fontSize: 15.sp, color: Colors.grey))),
                      ],
                    ),
                  ),
                  Center(
                    child: Container(
                      width: 360.w,
                      // height: 500.h,
                      child: noticeData.when(
                        data: (data) {
                          final allNotice = data.where((element) => element.forAllClass == true).toList();
                          return ListView.builder(
                              padding: EdgeInsets.zero,
                              physics: NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: allNotice.length,
                              itemBuilder: (context, index) {
                                return NoticeCard3(
                                    title: allNotice[index].title,
                                    image: allNotice[index].image!=null?'${Api.basePicUrl}${allNotice[index].image}':null,
                                    description: allNotice[index].description,
                                    createdAt: '${DateFormat('MMMM dd').format(DateTime.parse(allNotice[index].createdAt))}');
                              });
                        },
                        error: (err, stack) => Center(child: Text('$err')),
                        loading: () => NoticeShimmer(),
                      ),
                    ),
                  ),
                  SizedBox(height: 150.h,)
                ],
              ),
            );

          },
          error: (err, stack) => Center(child: Text('$err')),
          loading: () => Center(child: CircularProgressIndicator()
          )
      ),




    );
  }
}
