



import 'package:eschool/authentication/providers/auth_provider.dart';
import 'package:eschool/constants/colors.dart';
import 'package:eschool/utils/commonWidgets.dart';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


import '../../../services/feature_services.dart';
import '../../../services/student_services.dart';
import 'assignments.dart';

class AssignmentTabs extends ConsumerStatefulWidget {
  const  AssignmentTabs({super.key});

  @override
  ConsumerState<AssignmentTabs> createState() => _AssignmentTabsState();
}

class _AssignmentTabsState extends ConsumerState<AssignmentTabs> with TickerProviderStateMixin{


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
    final studentClass = ref.watch(studentClassInfo(auth.user.token));

    return studentClass.when(
        data: (classData){
          final class_data = classData.firstWhere((element) => element.currentLevel==true);
        //  final classSubject= ref.watch(secWiseSubjectProvider(class_data.className!.id));


          final classSubject= ref.watch(classsSubjectProvider(class_data.className!.id ));

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
                          return Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20.0),
                            child: Tab(
                              text: item.subject.subject_name,
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                  ],
                  body: TabBarView(
                    controller: _tabController,
                    children:  List<Widget>.generate(data.length, (index) => Assignments(
                      subject: data[index].id,
                      student_id: class_data.student.id,
                      className: class_data.className!.className.classLevel.name,
                      section: class_data.className!.sectionName.sectionName,),
                    ),
                  ),
                );

              },
              error:  (err, stack) => Center(child: Text('$err')),
              loading: () => const Center(child: ShimmerListTile2())
          );



          },
        error:  (err, stack) => Center(child: Text('$err')),
        loading: () => const Center(child: ShimmerListTile2())
    );



  }
}