import 'package:connectivity/connectivity.dart';
import 'package:eschool/assignment_status_notification.dart';
import 'package:eschool/features/model/notice.dart';
import 'package:eschool/features/view_page/student_page/assignments_tabs/assignment_details.dart';
import 'package:eschool/features/view_page/student_page/assignments_tabs/assignment_overview.dart';
import 'package:eschool/features/view_page/student_page/assignments_tabs/assignment_page.dart';
import 'package:eschool/features/view_page/student_page/menu_items/exam/exam_page.dart';
import 'package:eschool/features/view_page/student_page/menu_items/notices/class_notice.dart';
import 'package:eschool/features/view_page/student_page/menu_items/notices/notice_page.dart';
import 'package:eschool/features/view_page/student_page/menu_items/result/result_page.dart';
import 'package:eschool/features/view_page/student_page/subject_tab/subject_announcements/announcements.dart';
import 'package:eschool/features/view_page/student_page/subject_tab/subject_page.dart';
import 'package:eschool/subject_notification_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../../../constants/colors.dart';
import '../../../../../../utils/commonWidgets.dart';
import '../../../../../authentication/providers/auth_provider.dart';
import '../../../../../exceptions/internet_exceptions.dart';
import '../../../services/notice_services.dart';
import '../../../services/school_info_services.dart';
import '../../../providers/notification_provider.dart';
import 'package:eschool/features/services/notification_service.dart';

import '../menu_items/school_calender.dart';







class NotificationPage extends ConsumerStatefulWidget {


  final int class_sec_id;
  final int student_id;
  final String notification_token;
  const NotificationPage({super.key, required this.notification_token,required this.class_sec_id,required this.student_id});


  @override
  ConsumerState<NotificationPage> createState() =>
      _ClassNoticeBoardState();
}

class _ClassNoticeBoardState extends ConsumerState<NotificationPage>
    with TickerProviderStateMixin {

  final notificationTypes = [
    'Calendar events',
    'Notice',
    'Invigillator info',
    'Class section',
    'Class notice',
    'Assignment',
    'Student assignment',
    'Student total fee',
    'Exam class',
    'Admit card',
    'Total exam marks',
    'Subject notice'
    'Assignment status'
  ];



  late TabController _tabController;

  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: 2);

  }




  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final auth = ref.watch(authProvider);
    print('notification page : ${widget.notification_token}');
    final notificationData = ref.watch(notificationProvider2(widget.notification_token));

    return ConnectivityChecker(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: bgColor,
          title: const Text("Notification", style: TextStyle(color: Colors.white),),
        ),
        backgroundColor: Colors.white,
        body:SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                notificationData.when(

                  data: (data) {

                    data.sort((a, b) => b.id.compareTo(a.id));
                    return ListView.builder(
                        padding: EdgeInsets.symmetric(horizontal: 15.w),
                        physics: const BouncingScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: data.length,
                        itemBuilder: (context, index) {
                          final types=data[index].notificationType;
                          return NotificationCard(
                            title: data[index].title,
                            description: data[index].body,
                            color: data[index].seen == true? Colors.white : Colors.red.withOpacity(0.2),
                            onTap: (){


                              ref.read(notificationUpdater.notifier).updateSeen(
                                id: data[index].id,
                                token: auth.user.token,
                              ).then((value) => ref.refresh(notificationProvider2(widget.notification_token)))
                                  .then((value) => print('Successful'));


                              if(types==notificationTypes[0]){
                                Get.to(()=>Calender());
                              }
                              else if(types==notificationTypes[1]){
                                Get.to(()=>NoticeBoard(class_sec_id: widget.class_sec_id));
                              }

                              else if(types==notificationTypes[4]){
                                Get.to(()=>NoticeBoard(class_sec_id: widget.class_sec_id, selected_index: 1,));
                              }
                              else if(types==notificationTypes[5]){
                                Get.to(()=>AssignmentOverview());
                              }
                              else if(types==notificationTypes[8]){
                                Get.to(()=>ExamPage(class_id: widget.class_sec_id));
                              }
                              else if(types==notificationTypes[10]){
                                Get.to(()=>ExamResults(class_id: widget.class_sec_id,student_id:widget.student_id ,));
                              }

                              else if(types=="Subject notice"){
                                Get.to(()=>SubjectNotificationPage(id: data[index].objectId, selected_index: 1,),);
                              }

                              else if(types=="Assignment status"){


                                Get.to(()=> AssignmentStatusNotification(id: data[index].objectId, selected_index: 1,),);
                              }





                              else{
                                return;
                              }




                            },
                          );
                        });
                  },
                  error: (err, stack) => Center(child: Text('$err',style: const TextStyle(color: Colors.black),)),
                  loading: () => const NoticeShimmer(),
                ),
              ],
            ),
          ),
        ),

        floatingActionButton: FloatingActionButton.small(
          backgroundColor: bgColor,
            child: const Icon(Icons.refresh, color: Colors.white,),
            onPressed: (){
            ref.invalidate(notificationProvider2(widget.notification_token));

        }),

      ),
    );
  }
}
