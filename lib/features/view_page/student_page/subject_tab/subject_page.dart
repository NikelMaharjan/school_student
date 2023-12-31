import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../../../constants/colors.dart';
import '../../../../../utils/commonWidgets.dart';
import '../../../../authentication/providers/auth_provider.dart';
import '../../../../exceptions/internet_exceptions.dart';
import '../../../model/class_model.dart';
import '../../../services/notice_services.dart';
import '../../../services/school_info_services.dart';
import 'subject_announcements/announcements.dart';
import 'chapters.dart';

class Subjects extends ConsumerStatefulWidget {
  final int subject_id;
  final String subject_name;
  final String class_level_name;
  final String sec_name;
  final int class_sec_id;
  final int teacher_id;
  final int class_Sec_Sub_id;



  Subjects({required this.sec_name,required this.class_level_name,required this.class_sec_id,required this.subject_name,required this.subject_id,required this.teacher_id,required this.class_Sec_Sub_id});

  @override
  ConsumerState<Subjects> createState() =>
      _SubjectsState(
          subject_id: subject_id,
          class_sec_id: class_sec_id,
          subject_name: subject_name,
          sec_name: sec_name,
          class_level_name: class_level_name,
          teacher_id: teacher_id,
          class_Sec_Sub_id:class_Sec_Sub_id,


      );
}

class _SubjectsState extends ConsumerState<Subjects> with TickerProviderStateMixin {
  final int subject_id;
  final String class_level_name;
  final String sec_name;
  final int class_sec_id;
  final String subject_name;
  final int teacher_id;
  final int class_Sec_Sub_id;





  _SubjectsState(
      {
        required this.sec_name,
        required this.class_level_name,
        required this.subject_name,
        required this.subject_id,
        required this.class_sec_id,
        required this.teacher_id,
        required this.class_Sec_Sub_id,

      });

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



    print("Subject Id ${widget.subject_id} SubjectName ${widget.subject_name} ClassLevelName ${widget.class_level_name} SecName ${widget.sec_name} ClassSecID ${widget.class_sec_id} Classsecsubid ${widget.class_Sec_Sub_id} ");

    final auth = ref.watch(authProvider);
    final schoolData = ref.watch(schoolInfo(auth.user.token));



    return DefaultTabController(
      length: 2,
      child: ConnectivityChecker(
        child: Scaffold(
            backgroundColor: Colors.white,
            body:Column(
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
                      // Row(
                      //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //   children: [
                      //     IconButton(
                      //       onPressed: () {
                      //         Get.back();
                      //       },
                      //       icon: Icon(
                      //         Icons.arrow_back,
                      //         color: Colors.white,
                      //       ),
                      //     ),
                      //     IconButton(
                      //       onPressed: () async {
                      //         await ref.refresh(schoolInfo(auth.user.token));
                      //         await ref.refresh(subNoticeList(auth.user.token));
                      //         print('refreshed');
                      //       },
                      //       icon: Icon(
                      //         Icons.refresh,
                      //         color: Colors.white,
                      //       ),
                      //     ),
                      //   ],
                      // ),

                      Center(
                        child: Column(
                          children: [
                            Text(
                              subject_name,
                              style: TextStyle(color: Colors.white, fontSize: 25.sp),
                            ),
                            Text(
                              '${class_level_name} ${sec_name}',
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
                        Chapters(subjectName: subject_name,subject_id: subject_id,className: class_level_name,section: sec_name,class_sec_id: class_sec_id,class_sec_sub_id: class_Sec_Sub_id,),
                        SubjectNotices(class_sec_sub_id:class_Sec_Sub_id,sub_id: subject_id, sub_name: subject_name, class_sec_id: class_sec_id, token: auth.user.token,teacher_id: teacher_id,),
                      ]
                  ),)
              ],
            ),

        ),
      ),
    );
  }
}
