







import 'package:eschool/authentication/providers/auth_provider.dart';
import 'package:eschool/features/services/notice_services.dart';
import 'package:eschool/features/view_page/student_page/menu_items/notices/class_notice.dart';
import 'package:eschool/features/view_page/student_page/menu_items/notices/school_notices_tab.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../../constants/colors.dart';
import '../../../../../exceptions/internet_exceptions.dart';

class NoticeBoard extends ConsumerStatefulWidget {
  final int class_sec_id;
  NoticeBoard({required this.class_sec_id});

  @override
  ConsumerState<NoticeBoard> createState() => _NoticeBoard();
}

class _NoticeBoard extends ConsumerState<NoticeBoard> with TickerProviderStateMixin{
  @override
  Widget build(BuildContext context) {
    final auth = ref.watch(authProvider);

    TabController _tabController = TabController(length: 2, vsync: this);
    return ConnectivityChecker(
      child: Scaffold(
        backgroundColor: Colors.white,
        body:
        Column(
          children: [
            Container(
                height: MediaQuery.of(context).size.height * 1.4 / 5,
                width: double.infinity,
                decoration: BoxDecoration(
                    color: bgColor,
                    borderRadius:
                    BorderRadius.vertical(bottom: Radius.circular(25))),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 20.h,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                          onPressed: () {
                            Get.back();
                          },
                          icon: Icon(
                            Icons.arrow_back,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),

                    Center(
                      child: Text('Notices',
                          style: TextStyle(color: Colors.white, fontSize: 25.sp)),
                    ),




                    SizedBox(
                      height: 10.h,
                    ),
                    TabBar(
                        controller: _tabController,
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
                              text: 'School Notice',
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8.0),
                            child: Tab(
                                text: 'Class Notice'
                            ),
                          ),
                        ])
                  ],
                )),
            Container(
              // color: Colors.red,
                height: MediaQuery.of(context).size.height * 3.6 / 5,
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 0.h, horizontal: 15.w),
                  child: TabBarView(
                    // physics: NeverScrollableScrollPhysics(),

                    controller: _tabController,
                    children: [
                      SchoolNotice(),
                      ClassNotice(class_sec_id: widget.class_sec_id)
                    ],
                    //MyClass(id: class_id, school_id: school_id, class_teacher: class_teacher, teacher_subject: teacher_subject, classSub_id: classSub_id,)
                  ),
                )),
          ],
        ),

        floatingActionButton: FloatingActionButton(
          onPressed: (){
            ref.refresh(noticeList(auth.user.token));
          },
          child: Icon(Icons.refresh,color: Colors.white,),
          backgroundColor: primary,
        ),

      ),
    );
  }
}