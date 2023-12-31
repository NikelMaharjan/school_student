


import 'dart:convert';

import 'package:eschool/constants/colors.dart';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';

import '../../../sample_pages/routine_samples.dart';
import 'class_routine.dart';

class TimeTable extends StatefulWidget {

  final String className;
  final String section;
  final int class_sec_id;

  const TimeTable({super.key, required this.section,required this.className,required this.class_sec_id});

  @override
  State<TimeTable> createState() => _TimeTableState();
}

class _TimeTableState extends State<TimeTable> with TickerProviderStateMixin{



  @override
  Widget build(BuildContext context) {
    TabController tabController = TabController(length: 7, vsync: this);
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(

        children: [
          Container(
            width: double.infinity,
            height: 150.h,
            decoration: const BoxDecoration(
                borderRadius: BorderRadius.vertical(bottom: Radius.circular(40),),
                color: Color(0xff205578)
            ),

          ),
          Center(
            child: Column(
              children: [
                Container(
                  width: double.infinity,
                  height: MediaQuery.of(context).size.height *1/6,
                  decoration: const BoxDecoration(
                      borderRadius: BorderRadius.vertical(bottom: Radius.circular(40),),
                      color: Color(0xff205578)
                  ),
                  child:  Center(
                    child: Text('Time Table',style : TextStyle(fontSize: 20.sp,color: Colors.white)),
                  ),

                ),

                Padding(
                  padding: EdgeInsets.only(bottom: 15.h),
                  child: SizedBox(

                    width: 350.w,
                    height: 60.h,
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)
                      ),
                      color: Colors.white,
                      elevation: 3,
                      child: Center(
                          child: Text('Class ${widget.className}-${widget.section}',style: TextStyle(fontSize: 20.sp,color: Colors.black),)
                      ),

                    ),
                  ),
                ),

                SizedBox(
                    height: 50.h,
                    // width: 280.h,
                    child: TabBar(

                        controller: tabController,
                        isScrollable: true,
                        labelPadding: EdgeInsets.only(left: 15.w, right: 15.w),
                        labelColor: Colors.white,
                        unselectedLabelColor: primary,
                        indicator: BoxDecoration(
                            color: primary,
                            borderRadius: BorderRadius.circular(10)
                        ),
                        tabs: const [
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 12.0),
                            child: Tab(text: 'MON',),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 12.0),
                            child: Tab(text: 'TUE'),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 12.0),
                            child: Tab(text: 'WED'),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 12.0),
                            child: Tab(text: 'THU'),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 12.0),
                            child: Tab(text: 'FRI'),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 12.0),
                            child: Tab(text: 'SAT'),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 12.0),
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
                  height: MediaQuery.of(context).size.height *3.7/6,
                  child: TabBarView(
                      controller: tabController,
                      children:[
                        ClassRoutine(class_section_id: widget.class_sec_id,day: 'Monday',),
                        ClassRoutine(class_section_id: widget.class_sec_id,day: 'Tuesday',),
                        ClassRoutine(class_section_id: widget.class_sec_id,day: 'Wednesday',),
                        ClassRoutine(class_section_id: widget.class_sec_id,day: 'Thursday',),
                        ClassRoutine(class_section_id: widget.class_sec_id,day: 'Friday',),
                        ClassRoutine(class_section_id: widget.class_sec_id,day: 'Saturday',),
                        ClassRoutine(class_section_id: widget.class_sec_id,day: 'Sunday',),

                      ]
                  ),
                )





              ],
            ),
          ),
          Positioned(
            left: 15.w,
            top:40.h,
            child: IconButton(
                onPressed: (){
                  Get.back();
                },
                icon: Icon(Icons.arrow_back,color:Colors.white,size:25.sp)
            ),
          ),
        ],
      ),
    );
  }
}