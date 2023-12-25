


import 'dart:convert';

import 'package:eschool/authentication/providers/auth_provider.dart';
import 'package:eschool/constants/colors.dart';
import 'package:eschool/features/services/parent_services.dart';
import 'package:eschool/features/view_page/homepage_parents/menu_items_parents/assignment_parents/assignment_items.dart';
import 'package:eschool/utils/commonWidgets.dart';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';


import '../../../../services/student_services.dart';
  class AssignmentTabsParents extends ConsumerStatefulWidget {
  final int student_id;
  AssignmentTabsParents({required this.student_id});

  @override
    ConsumerState<AssignmentTabsParents> createState() => _AssignmentTabsState();
}

  class _AssignmentTabsState extends ConsumerState<AssignmentTabsParents> with TickerProviderStateMixin{


  late ScrollController _scrollController;
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _tabController = TabController(length: 0, vsync: this);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    final auth = ref.watch(authProvider);
    final studentClass = ref.watch(studentClassListProvider(widget.student_id));

    return studentClass.when(
        data: (classData){
          final class_data = classData.firstWhere((element) => element.currentLevel==true);
          final classSubject= ref.watch(secWiseSubjectProvider(class_data.className!.id));
          return classSubject.when(
              data: (data) {
                _tabController = TabController(length: data.length, vsync: this);
                return NestedScrollView(

                  floatHeaderSlivers: false,
                  controller: _scrollController,
                  headerSliverBuilder: (context, bool) => [
                    SliverAppBar(
                      automaticallyImplyLeading: false,

                      backgroundColor: Colors.white,
                      // pinned: true,
                      primary: false,
                      centerTitle: false,
                      titleSpacing: 0.w,

                      title: TabBar(
                        padding: EdgeInsets.only(top: 10.h),

                        labelStyle: TextStyle(fontSize: 15.sp),
                        controller: _tabController,
                        isScrollable: true,
                        labelPadding: EdgeInsets.only(left: 20.w, right: 20.w),
                        labelColor: Colors.white,
                        unselectedLabelColor: Colors.black,
                        // indicatorColor: primary,
                        indicator: BoxDecoration(
                            color: primary,
                            borderRadius: BorderRadius.circular(10)
                        ),
                        tabs: data.map((item) {
                          return Tab(
                            text: item.subject.subjectName,
                          );
                        }).toList(),
                      ),
                    ),
                  ],
                  body: TabBarView(
                    controller: _tabController,
                    children:  List<Widget>.generate(
                      data.length,
                          (index) => AssignmentItems(subject: data[index].id, student_id: class_data.student.id,className: class_data.className!.className.classLevel.name!,section: class_data.className!.sectionName.sectionName,),
                    ),
                  ),);

              },
              error:  (err, stack) => Center(child: Text('$err')),
              loading: () => Container(child: Center(child: ShimmerListTile2()))
          );



        },
        error:  (err, stack) => Center(child: Text('$err')),
        loading: () => Container(child: Center(child: ShimmerListTile2()))
    );



  }
}