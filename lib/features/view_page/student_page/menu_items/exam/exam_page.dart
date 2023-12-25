


import 'dart:convert';

import 'package:eschool/constants/colors.dart';
import 'package:eschool/features/view_page/student_page/menu_items/exam/exam_sample.dart';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';



class ExamPage extends ConsumerStatefulWidget {


  final int class_id;

  ExamPage({required this.class_id});

  @override
  ConsumerState<ExamPage> createState() => _ExamPageState();
}

class _ExamPageState extends ConsumerState<ExamPage> with TickerProviderStateMixin{



  @override
  Widget build(BuildContext context) {

    TabController _tabController = TabController(length: 7, vsync: this);
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(

        children: [
      Container(
      height: MediaQuery.of(context).size.height * 1/ 5,
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
            child: Text('Exam Routine',
                style: TextStyle(color: Colors.white, fontSize: 25.sp)),
          ),])),
          SizedBox(height: 5.h,),

          Container(
              height: 50.h,
              // width: 280.h,
              child: TabBar(

                  controller: _tabController,
                  isScrollable: true,
                  labelPadding: EdgeInsets.only(left: 15.w, right: 15.w),
                  labelColor: Colors.white,
                  unselectedLabelColor: primary,
                  indicator: BoxDecoration(
                      color: primary,
                      borderRadius: BorderRadius.circular(10)
                  ),
                  tabs: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Tab(text: 'MON',),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Tab(text: 'TUE'),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Tab(text: 'WED'),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Tab(text: 'THU'),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Tab(text: 'FRI'),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Tab(text: 'SAT'),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Tab(text: 'SUN'),
                    ),

                  ]
              )
          ),

          SizedBox(
            height: 10.h,
          ),


          Container(
            width: 350.w,
            // color: Colors.red,
            height: MediaQuery.of(context).size.height *3.7/6,
            child: TabBarView(
                controller: _tabController,
                children:[
                  Exams(class_id: widget.class_id,day: 'Monday',),
                  Exams(class_id: widget.class_id,day: 'Tuesday',),
                  Exams(class_id: widget.class_id,day: 'Wednesday',),
                  Exams(class_id: widget.class_id,day: 'Thursday',),
                  Exams(class_id: widget.class_id,day: 'Friday',),
                  Exams(class_id: widget.class_id,day: 'Saturday',),
                  Exams(class_id: widget.class_id,day: 'Sunday',),


                ]
            ),
          ),

        ],
      ),
    );
  }
}