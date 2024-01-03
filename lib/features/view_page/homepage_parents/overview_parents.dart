import 'package:card_swiper/card_swiper.dart';
import 'package:eschool/constants/colors.dart';
import 'package:eschool/features/services/parent_services.dart';
import 'package:eschool/features/view_page/homepage_parents/student_overview.dart';
import 'package:eschool/features/view_page/homepage_parents/settings_parents.dart';
import 'package:eschool/features/view_page/student_page/menu_items/notices/school_notices_tab.dart';
import 'package:eschool/features/view_page/student_page/menu_items/parent_profile.dart';
import 'package:eschool/parent_detail.dart';
import 'package:eschool/parent_notice.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:in_app_update/in_app_update.dart';
import 'package:intl/intl.dart';
import '../../../api/api.dart';
import '../../../authentication/login_pages/login_page.dart';
import '../../../authentication/providers/auth_provider.dart';
import '../../../constants/snackshow.dart';
import '../../../exceptions/internet_exceptions.dart';
import '../../services/notification_service.dart';
import '../../../utils/commonWidgets.dart';
import '../../services/notice_services.dart';

class OverviewParents extends ConsumerStatefulWidget {
  const OverviewParents({super.key});

  @override
  ConsumerState<OverviewParents> createState() => _OverviewParentsState();
}

class _OverviewParentsState extends ConsumerState<OverviewParents> {

  AppUpdateInfo? _updateInfo;
  bool _flexibleUpdateAvailable = false;



  @override
  void initState() {
    super.initState();
   // checkForUpdate();

    // 1. This method call when app in terminated state and you get a notification
    // when you click on notification app open from terminated state and you can get notification data in this method

    FirebaseMessaging.instance.getInitialMessage().then(
          (message) {
        //print("FirebaseMessaging.instance.getInitialMessage");
        if (message != null) {
         // print("New Notification");
          // if (message.data['_id'] != null) {
          //   Navigator.of(context).push(
          //     MaterialPageRoute(
          //       builder: (context) => DemoScreen(
          //         id: message.data['_id'],
          //       ),
          //     ),
          //   );
          // }
          LocalNotificationService.createanddisplaynotification(message);
        }
      },
    );

    // 2. This method only call when App in foreground it mean app must be opened
    FirebaseMessaging.onMessage.listen(
          (message) {
      //  print("FirebaseMessaging.onMessage.listen");
        if (message.notification != null) {
          // print(message.notification!.title);
          // print(message.notification!.body);
          // print("message.data11 ${message.data}");
          LocalNotificationService.createanddisplaynotification(message);

        }
      },
    );

    // 3. This method only call when App in background and not terminated(not closed)
    FirebaseMessaging.onMessageOpenedApp.listen(
          (message) {
   //     print("FirebaseMessaging.onMessageOpenedApp.listen");
        if (message.notification != null) {
     //     print(message.notification!.title);
       //   print(message.notification!.body);
       //   print("message.data22 ${message.data['_id']}");
          LocalNotificationService.createanddisplaynotification(message);
        }
      },
    );

    getToken();
  }



  Future<void> getToken()async{
    final response = await FirebaseMessaging.instance.getToken();
  //  print(response);
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
      SnackShow.showFailure(context, e.toString());
    });
  }

  void updateDialog() async {
    InAppUpdate.startFlexibleUpdate().then((_) {
      setState(() {
        _flexibleUpdateAvailable = true;
      });
    }).catchError((e) {
      SnackShow.showFailure(context, e.toString());
    });
  }




  @override
  Widget build(BuildContext context) {

    final auth = ref.watch(authProvider);
    final noticeData = ref.watch(noticeList(auth.user.token));
    final infoData = ref.watch(parentList(auth.user.token));
    final studentList = ref.watch(parentStudentList(auth.user.token));

    return ConnectivityChecker(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Stack(children: [
          SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 150.h,
                ),
                // Container(
                //     width: double.infinity,
                //     height: 210.h,
                //     // color: Colors.blue,
                //     child: noticeData.when(
                //       data: (data){
                //         final notice_data = data.where((element) => element.forAllClass == true).toList();
                //         return Swiper(
                //           pagination: const SwiperPagination(
                //             alignment: Alignment.bottomCenter,
                //           ),
                //           autoplay: true,
                //           // autoplayDelay: 2,
                //           autoplayDisableOnInteraction: true,
                //           itemCount: notice_data.length,
                //           loop: true,
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
                //                             style: const TextStyle(
                //                               color: Colors.black,
                //                               fontWeight: FontWeight.bold,
                //                             ),),
                //                           content: Column(
                //                             mainAxisSize: MainAxisSize.min,
                //                             children: [
                //                               Align(
                //                                 alignment: Alignment.topLeft,
                //                                 child: Text(
                //                                   notice_data[index].description,
                //                                   style: const TextStyle(color: Colors.black),
                //                                   maxLines: null,
                //                                 ),
                //                               ),
                //                               SizedBox(height: 5.h,),
                //                               if(notice_data[index].image!=null)
                //                                 Container(
                //                                   height: MediaQuery.of(context).size.height*0.2,
                //                                   child: Image.network('${Api.basePicUrl}${notice_data[index].image}',fit: BoxFit.contain,),
                //                                 )
                //                             ],
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
                //                       Center(child: Text(notice_data[index].title,style: const TextStyle(color: Colors.black),))]),
                //                   ),
                //                 ),
                //               ),
                //             );
                //           },
                //         );
                //       },
                //       error: (err, stack) => Center(child: Text('$err')),
                //       loading: () => const CardShimmer(),
                //     )
                // ),
                SizedBox(
                  height: 40.h,
                ),
                Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 30.w, vertical: 8.h),
                  child: Text('My Children',
                      style: TextStyle(
                          fontSize: 18.sp,
                          fontWeight: FontWeight.bold,
                          color: Colors.black)),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 30.w),
                  child: studentList.when(
                    data: (data){
                      return GridView.builder(
                        itemCount: data.length,
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            childAspectRatio: 2.w / 2.h,
                            crossAxisCount: 2,
                            mainAxisSpacing: 5.h,
                            crossAxisSpacing: 1/2),
                        itemBuilder: (context,index){
                          return Stack(
                            children: [
                              GridTile(
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(20),
                                  child: InkWell(
                                    onTap: () => Get.to(() => StudentOverview(student_id: data[index].student.id,)),
                                    child: Container(

                                        height: 150.h,
                                        width: 150.w,
                                        color: primary,
                                        child: Column(
                                          mainAxisAlignment:
                                          MainAxisAlignment.center,
                                          children: [
                                            data[index].student.studentPhoto!=null?
                                            CircleAvatar(
                                              radius: 25.sp,
                                              backgroundImage: NetworkImage('${Api.basePicUrl}${data[index].student.studentPhoto}'),
                                            ):
                                            CircleAvatar(
                                              radius: 25.sp,
                                              backgroundColor: Colors.black,
                                            ),
                                            Padding(
                                              padding: EdgeInsets.only(top: 8.h),
                                              child: Text(
                                                data[index].student.studentName,
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 15.sp),
                                              ),
                                            ),
                                          ],
                                        )),
                                  ),
                                ),
                              ),
                              Align(
                                alignment: const Alignment(-0.15, 0.96),
                                child: Card(
                                  elevation: 3,
                                  color: Colors.white,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(100),
                                  ),
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(
                                        vertical: 5.h, horizontal: 5.w),
                                    child: Icon(
                                      Icons.arrow_forward_ios,
                                      color: Colors.black,
                                      size: 20.sp,
                                    ),
                                  ),
                                ),
                              )
                            ],
                          );
                        },

                      );
                    },
                    error: (err, stack) => Center(child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 20.0),
                      child: Text('$err'),
                    )),
                    loading: () => const GridShimmer(),
                  ),
                ),

                SizedBox(height: 40,),
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 30.w,
                    vertical: 10,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Latest Notices',
                          style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold, color: Colors.black)),
                      InkWell(
                          onTap: () => Get.to(() => const ParentNotice()),
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
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: allNotice.isEmpty ? allNotice.length : 1,
                            itemBuilder: (context, index) {
                              return NoticeCard3(
                                  title: allNotice[index].title,
                                  image: allNotice[index].image!=null?'${Api.basePicUrl}${allNotice[index].image}':null,
                                  description: allNotice[index].description,
                                  createdAt: DateFormat('MMMM dd').format(DateTime.parse(allNotice[index].createdAt)));
                            });
                      },
                      error: (err, stack) => Center(child: Text('$err')),
                      loading: () => const NoticeShimmer(),
                    ),
                  ),
                ),
                SizedBox(height: 150.h,)
              ],
            ),
          ),
          Container(
            height: 170.h,
            width: double.infinity,
            decoration: BoxDecoration(
                color: bgColor,
                borderRadius: const BorderRadius.vertical(bottom: Radius.circular(25))),
            child: Center(
              child: Padding(
                padding: EdgeInsets.only(left: 25.w, top: 70.h,right: 15.w),
                child: infoData.when(
                    data: (data){
                      final info = data.firstWhere((element) => element.email == auth.user.userInfo.email);
                      return  InkWell(
                        onTap: (){
                          Get.to(() => ParentsProfiles(parentDetail: info));
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Padding(
                              padding:
                              EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.h),
                              child: CircleAvatar(
                                backgroundImage: NetworkImage('${Api.basePicUrl}${info.picture}'),
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
                                    info.parentName,
                                    style:
                                    TextStyle(fontSize: 25.sp, color: Colors.white),
                                  ),
                                  Text(
                                    info.relationshipToStudent,
                                    style:
                                    TextStyle(fontSize: 15.sp, color: Colors.white),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      );
                    },
                    error: (err, stack) => Center(child: Text('$err')),
                    loading: () => const Center(child: CircularShimmer())),
              ),
            ),
          ),
          // Positioned(
          //   right: 10.w,
          //   top: 40.h,
          //   child: IconButton(
          //       onPressed: () {
          //         Get.to(() => const SettingParents());
          //       },
          //       icon: Icon(Icons.more_vert_rounded,
          //           color: Colors.white, size: 25.sp)),
          // ),
        ]),
      ),
    );
  }
}

Future<bool> _onBackPressed(BuildContext context,ref) async {

  final auth = ref.watch(authProvider);
  return (await showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: Colors.white,
            title: const Center(
                child: Text(
              'Do you want to logout?',
              style: TextStyle(color: Colors.black),
            )),
            actionsAlignment: MainAxisAlignment.center,
            actions: <Widget>[
              TextButton(
                style: TextButton.styleFrom(
                    backgroundColor: primary,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10))),
                child: const Text("Yes"),
                onPressed: ()  async {
                  await ref.read(authProvider.notifier).userLogout(auth.user!.token);
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => LoginPage()),
                        (route) => false,
                  );


                },
              ),
              TextButton(
                style: TextButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: Colors.black,
                    shape: RoundedRectangleBorder(
                        side: const BorderSide(color: Colors.grey),
                        borderRadius: BorderRadius.circular(10))),
                child: const Text("No"),
                onPressed: () => Navigator.pop(context),
              ),
            ],
          );
        },
      )) ??
      false;
}
