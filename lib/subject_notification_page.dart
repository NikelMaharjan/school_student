

import 'package:connectivity/connectivity.dart';
import 'package:eschool/features/services/notice_services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../../../constants/colors.dart';
import '../../../../../utils/commonWidgets.dart';
import '../../../../authentication/providers/auth_provider.dart';
import '../../../../exceptions/internet_exceptions.dart';

import 'features/services/school_info_services.dart';
import 'features/view_page/student_page/subject_tab/chapters.dart';
import 'features/view_page/student_page/subject_tab/subject_announcements/announcements.dart';


class SubjectNotificationPage extends ConsumerStatefulWidget {

  int id;
  int? selected_index;
  SubjectNotificationPage({required this.id, this.selected_index});





  @override
  ConsumerState<SubjectNotificationPage> createState() => _SubjectNotificationPageState();
}

class _SubjectNotificationPageState extends ConsumerState<SubjectNotificationPage> with TickerProviderStateMixin {




  late TabController _tabController;

  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(initialIndex: widget.selected_index == null ? 0 : 1, vsync: this, length: 2);

  }




  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {



    // print("Subject Id ${widget.subject_id} SubjectName ${widget.subject_name} ClassLevelName ${widget.class_level_name} SecName ${widget.sec_name} ClassSecID ${widget.class_sec_id} Classsecsubid ${widget.class_Sec_Sub_id} ");

    final auth = ref.watch(authProvider);
    final schoolData = ref.watch(schoolInfo(auth.user.token));

    final nikel = ref.watch(subNoticeListNotification(widget.id));



    return DefaultTabController(
      length: 2,
      child: ConnectivityChecker(
        child: Scaffold(
          backgroundColor: Colors.white,
          body: nikel.when(
              data: (data){
                return Column(
                  children: [
                    Container(
                      height: MediaQuery.of(context).size.height * 1.3 / 5,
                      width: double.infinity,
                      decoration: BoxDecoration(
                          color: bgColor,
                          borderRadius:
                          BorderRadius.vertical(bottom: Radius.circular(25))),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [

                          Center(
                            child: Column(
                              children: [
                                Text(
                                  data[0].subjectName!.subject.subjectName,
                                  style: TextStyle(color: Colors.white, fontSize: 25.sp),
                                ),
                                Text(
                                  '${data[0].subjectName!.classSection!.className.classLevel.name} ${data[0].subjectName!.classSection!.sectionName.sectionName}',
                                  style: TextStyle(color: Colors.white, fontSize: 15.sp),
                                ),
                              ],
                            ),
                          ),


                          SizedBox(height: 20.h),
                          TabBar(
                              controller: _tabController,
                              onTap: (index) {
                                setState(() {
                                  _currentIndex = index;
                                });
                              },
                              padding: EdgeInsets.symmetric(
                                  vertical: 15.h, horizontal: 30.w),
                              labelStyle: TextStyle(
                                fontSize: 18.sp,
                              ),
                              unselectedLabelStyle: TextStyle(
                                fontSize: 18.sp,
                              ),
                              isScrollable: false,
                              labelPadding: EdgeInsets.only(left: 15.w, right: 15.w),
                              labelColor: primary,
                              unselectedLabelColor: Colors.white,
                              // indicatorColor: primary,
                              indicator: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10)),
                              tabs: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                  child: Tab(
                                    text: 'Chapters',
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                  child: Tab(text: 'Announcement'),
                                ),
                              ]),
                        ],
                      ),
                    ),
                    Container(
                      height: MediaQuery.of(context).size.height * 4 / 10,
                      // color: Colors.red,
                      child: TabBarView(
                          controller: _tabController,
                          children: [
                            Chapters(
                              subjectName: data[0].subjectName!.subject.subjectName,
                              subject_id: data[0].subjectName!.subject.id,
                              className: data[0].subjectName!.classSection!.className.classLevel.name,
                              section: data[0].subjectName!.classSection!.sectionName.sectionName,
                              class_sec_id: data[0].subjectName!.classSection!.id,
                              class_sec_sub_id: data[0].subjectName!.id,
                            ),
                            SubjectNotices(
                              class_sec_sub_id: data[0].subjectName!.id,
                              sub_id: data[0].subjectName!.subject.id,
                              sub_name: data[0].subjectName!.subject.subjectName,
                              class_sec_id: data[0].subjectName!.classSection!.id,
                              token: auth.user.token,
                              teacher_id: data[0].subjectName!.teacher.id,
                            ),
                          ]
                      ),)
                  ],
                );
              },
              error: (e, s) => Center(child: Text(e.toString()),),
              loading: () => Center(child: CircularProgressIndicator(),)
          ),

        ),
      ),
    );
  }
}
