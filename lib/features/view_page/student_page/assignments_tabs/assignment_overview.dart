import 'package:eschool/constants/colors.dart';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


import 'assignments_tabs.dart';

class AssignmentOverview extends StatefulWidget {
  @override
  State<AssignmentOverview> createState() => _AssignmentOverviewState();
}

class _AssignmentOverviewState extends State<AssignmentOverview>
    with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    TabController _tabController = TabController(length: 2, vsync: this);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: bgColor,
        title: const Text("Assignment", style: TextStyle(color: Colors.white),),
      ),
        backgroundColor: Colors.white,
        body: SizedBox(
            // color: Colors.red,
            height: MediaQuery.of(context).size.height * 3.8 / 5,
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 0.h, horizontal: 15.w),
              child: const AssignmentTabs(),
            )));
  }
}
