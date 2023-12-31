







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

   int? selected_index;

  NoticeBoard({super.key, required this.class_sec_id, this.selected_index});


  @override
  ConsumerState<NoticeBoard> createState() => _NoticeBoard();
}

class _NoticeBoard extends ConsumerState<NoticeBoard> with TickerProviderStateMixin{
  @override
  Widget build(BuildContext context) {
    final auth = ref.watch(authProvider);

    TabController tabController = TabController(initialIndex: widget.selected_index == null ? 0 :1, length: 2, vsync: this);
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
                    const BorderRadius.vertical(bottom: Radius.circular(25))),
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
                          icon: const Icon(
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
                        controller: tabController,
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
                        tabs: const [
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 8.0),
                            child: Tab(
                              text: 'School Notice',
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 8.0),
                            child: Tab(
                                text: 'Class Notice'
                            ),
                          ),
                        ])
                  ],
                )),
            SizedBox(
              // color: Colors.red,
                height: MediaQuery.of(context).size.height * 3.6 / 5,
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 0.h, horizontal: 15.w),
                  child: TabBarView(
                    // physics: NeverScrollableScrollPhysics(),

                    controller: tabController,
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
            ref.invalidate(noticeList(auth.user.token));
          },
          backgroundColor: primary,
          child: const Icon(Icons.refresh,color: Colors.white,),
        ),

      ),
    );
  }
}