import 'package:eschool/constants/colors.dart';
import 'package:eschool/features/view_page/student_page/menu_items/attendance/attendance_status.dart';
import 'package:eschool/features/view_page/student_page/menu_items/attendance/leave_note.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../../../services/attendance_services.dart';

class Attendance extends ConsumerStatefulWidget {

  final int student_id;
  const Attendance({super.key, required this.student_id});

  @override
  ConsumerState<Attendance> createState() => _AttendanceState();
}

class _AttendanceState extends ConsumerState<Attendance> {
  Map<String, List> mySelectedEvents = {};

  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDate;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _selectedDate = _focusedDay;
  }

  List _attendance(DateTime dateTime) {
    if (mySelectedEvents[DateFormat('yyyy-MM-dd').format(dateTime)] != null) {
      return mySelectedEvents[DateFormat('yyyy-MM-dd').format(dateTime)]!;
    } else {
      return [];
    }
  }

  _showDialogEvent() async {
    await showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Center(child: Text('Attendance')),
          content: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            mainAxisSize: MainAxisSize.min,
            children: [
              TextButton(
                  style:
                  TextButton.styleFrom(backgroundColor: Colors.green),
                  onPressed: () {
                    setState(() {
                      mySelectedEvents[DateFormat('yyyy-MM-dd')
                          .format(_selectedDate!)] = [
                        {'present': true}
                      ];
                    });
                    Navigator.pop(context);
                  },
                  child: const Text('Present',
                      style: TextStyle(color: Colors.white))),
              TextButton(
                  style: TextButton.styleFrom(backgroundColor: Colors.red),
                  onPressed: () {
                    setState(() {
                      mySelectedEvents[DateFormat('yyyy-MM-dd')
                          .format(_selectedDate!)] = [];
                    });
                    Navigator.pop(context);
                  },
                  child: const Text(
                    'Absent',
                    style: TextStyle(color: Colors.white),
                  )),
            ],
          ),
        ));
  }

  @override
  Widget build(BuildContext context) {

    final attendanceStatus = ref.watch(studentAttendanceProvider(widget.student_id));



    // return attendanceStatus.when(
    //   data: (data){
    //     return Scaffold(
    //       backgroundColor: Colors.white,
    //       body: Stack(
    //         children: [
    //           Container(
    //             width: double.infinity,
    //             height: 170.h,
    //             decoration: BoxDecoration(
    //                 borderRadius: BorderRadius.vertical(
    //                   bottom: Radius.circular(40),
    //                 ),
    //                 color: Color(0xff205578)),
    //           ),
    //           Container(
    //             width: double.infinity,
    //             child: SingleChildScrollView(
    //               child: Column(
    //                 crossAxisAlignment: CrossAxisAlignment.center,
    //                 children: [
    //                   SizedBox(height: 60.h),
    //                   Text('Attendance',
    //                       style: TextStyle(fontSize: 20.sp, color: Colors.white)),
    //                   SizedBox(height: 30.h),
    //                   Container(
    //                     // color:Colors.red,
    //                       width: 350.w,
    //                       height: 430.h,
    //                       child: Stack(children: [
    //                         Positioned(
    //                           top: 5.h,
    //                           child: Column(
    //                             children: [
    //                               Container(
    //                                 // color: Colors.white,
    //                                 child: Center(
    //                                   child: Card(
    //                                     color: Colors.white,
    //                                     elevation: 5,
    //                                     shape: RoundedRectangleBorder(
    //                                         borderRadius:
    //                                         BorderRadius.circular(20)),
    //                                     child: SizedBox(
    //                                       width: 340.w,
    //                                       height: 60.h,
    //                                     ),
    //                                   ),
    //                                 ),
    //                               ),
    //                               Container(
    //                                 // color: Colors.white,
    //                                 child: Center(
    //                                   child: Card(
    //                                     color: Colors.white,
    //                                     elevation: 5,
    //                                     shape: RoundedRectangleBorder(
    //                                         borderRadius:
    //                                         BorderRadius.circular(20)),
    //                                     child: SizedBox(
    //                                       width: 340.w,
    //                                       height: 330.h,
    //                                     ),
    //                                   ),
    //                                 ),
    //                               )
    //                             ],
    //                           ),
    //                         ),
    //                         TableCalendar(
    //                           daysOfWeekHeight: 20.h,
    //                           // shouldFillViewport: true,
    //                           rowHeight: 50.h,
    //                           eventLoader: _attendance,
    //                           onDaySelected: (selectedDay, focusedDay) {
    //                             if (!isSameDay(_selectedDate, selectedDay)) {
    //                               // Call `setState()` when updating the selected day
    //                               setState(() {
    //                                 _selectedDate = selectedDay;
    //                                 _focusedDay = focusedDay;
    //                               });
    //                             }
    //                           },
    //                           selectedDayPredicate: (day) {
    //                             return isSameDay(_selectedDate, day);
    //                           },
    //                           onPageChanged: (focusedDay) {
    //                             _focusedDay = focusedDay;
    //                           },
    //                           daysOfWeekStyle: DaysOfWeekStyle(
    //                               weekdayStyle: TextStyle(
    //                                   color: Colors.blueAccent, fontSize: 15.sp),
    //                               weekendStyle: TextStyle(
    //                                   color: Colors.blueAccent, fontSize: 15.sp)),
    //                           focusedDay: _focusedDay,
    //                           firstDay: DateTime.utc(2021, 01, 01),
    //                           lastDay: DateTime.utc(2024, 12, 12),
    //                           headerStyle: HeaderStyle(
    //                               formatButtonVisible: false,
    //                               headerMargin: EdgeInsets.only(
    //                                   left: 10.w,
    //                                   right: 10.w,
    //                                   top: 10.h,
    //                                   bottom: 20.h),
    //                               titleCentered: true,
    //                               titleTextStyle: TextStyle(
    //                                   fontWeight: FontWeight.bold,
    //                                   color: Colors.black),
    //                               leftChevronIcon: Icon(
    //                                 Icons.arrow_back_ios,
    //                                 color: Colors.black,
    //                               ),
    //                               rightChevronIcon: Icon(
    //                                 Icons.arrow_forward_ios,
    //                                 color: Colors.black,
    //                               )),
    //
    //                           calendarStyle: CalendarStyle(
    //                             defaultTextStyle: TextStyle(color: Colors.black),
    //                             markerSize: 25.sp,
    //                             markerDecoration: BoxDecoration(
    //                                 borderRadius: BorderRadius.circular(100),
    //                                 color: Colors.green.withOpacity(0.7)),
    //                             markersAutoAligned: false,
    //                             markersAlignment: Alignment.center,
    //                             // cellMargin: EdgeInsets.all(10),
    //
    //                             outsideDaysVisible: false,
    //                             // tablePadding: EdgeInsets.symmetric(horizontal:10),
    //                           ),
    //                         ),
    //                       ])),
    //
    //                   attendanceStatus.when(
    //                     data: (data){
    //                       int presentCount = 0;
    //                       int absentCount = 0;
    //
    //                       for(int i=0; i<data.length; i++) {
    //                         if(data[i].status == 'Present') {
    //                           presentCount++;
    //                         } else if(data[i].status == 'Absent') {
    //                           absentCount++;
    //                         }
    //                       }
    //
    //                       return  Container(
    //                           width: 350.w,
    //                           height: 180.h,
    //                           child: Row(
    //                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //                               children: [
    //                                 InkWell(
    //                                   onTap: ()=> Get.to(()=>AttendanceStatus(student_id: widget.student_id)),
    //                                   child: Container(
    //                                       decoration: BoxDecoration(
    //                                         borderRadius: BorderRadius.circular(10),
    //                                       ),
    //                                       width: 170.w,
    //                                       height: 170.h,
    //                                       child: Card(
    //                                         color: pre_color,
    //                                         elevation: 5,
    //                                         shadowColor: pre_color,
    //                                         child: Column(
    //                                           mainAxisAlignment:
    //                                           MainAxisAlignment.spaceEvenly,
    //                                           children: [
    //                                             Text('Total Present',
    //                                                 style: TextStyle(
    //                                                     color: Colors.white,
    //                                                     fontSize: 20.sp,
    //                                                     fontWeight: FontWeight.bold)),
    //                                             CircleAvatar(
    //                                               backgroundColor: Colors.white,
    //                                               radius: 30.sp,
    //                                               child: Text('$presentCount'),
    //                                             )
    //                                           ],
    //                                         ),
    //                                       )),
    //                                 ),
    //                                 InkWell(
    //                                   onTap: ()=> Get.to(()=>AttendanceStatus(student_id: widget.student_id)),
    //                                   child: Container(
    //                                       decoration: BoxDecoration(
    //                                         borderRadius: BorderRadius.circular(10),
    //                                       ),
    //                                       width: 170.w,
    //                                       height: 170.h,
    //                                       child: Card(
    //                                         color: abs_color,
    //                                         elevation: 5,
    //                                         shadowColor: abs_color,
    //                                         child: Column(
    //                                           mainAxisAlignment:
    //                                           MainAxisAlignment.spaceEvenly,
    //                                           children: [
    //                                             Text('Total Absent',
    //                                                 style: TextStyle(
    //                                                     color: Colors.white,
    //                                                     fontSize: 20.sp,
    //                                                     fontWeight: FontWeight.bold)),
    //                                             CircleAvatar(
    //                                               backgroundColor: Colors.white,
    //                                               radius: 30.sp,
    //                                               child: Text('$absentCount'),
    //                                             )
    //                                           ],
    //                                         ),
    //                                       )),
    //                                 ),
    //                               ]));
    //                     },
    //                     error: (err, stack) => Center(child: Text('$err')),
    //                     loading: () => Center(child: CircularProgressIndicator(),),
    //                   ),
    //
    //                   SizedBox(height: 10.h,),
    //
    //                   TextButton(
    //                     style: TextButton.styleFrom(
    //                         backgroundColor: primary,
    //                         foregroundColor: Colors.white,
    //                         fixedSize: Size.fromWidth(320.w),
    //                         shape: RoundedRectangleBorder(
    //                             borderRadius:
    //                             BorderRadius.circular(10),
    //                             side: BorderSide(
    //                               color: Colors.black,
    //                             ))),
    //                     onPressed: () {
    //
    //                       Get.to(()=>AddNote(student_id: widget.student_id));
    //
    //                     },
    //                     child: Padding(
    //                       padding: EdgeInsets.symmetric(
    //                           vertical: 5.h, horizontal: 8.w),
    //                       child: Text(
    //                         'Leave a absent note',
    //                         style: TextStyle(
    //                           fontSize: 15.sp,
    //                         ),
    //                       ),
    //                     ),
    //                   ),
    //
    //                 ],
    //               ),
    //             ),
    //           ),
    //           Positioned(
    //             left: 15.w,
    //             top: 40.h,
    //             child: IconButton(
    //                 onPressed: () {
    //                   Get.back();
    //                 },
    //                 icon: Icon(Icons.arrow_back, color: Colors.white, size: 25.sp)),
    //           ),
    //         ],
    //       ),
    //     );
    //   },
    //   error: (err, stack) => Container(color: Colors.white,child: Center(child: Text('No Attendance Data',style: TextStyle(color: Colors.black,fontSize: 18.sp),),),),
    //   loading: () => Container(color:Colors.white,child: Center(child: CircularProgressIndicator(),)),
    // );

    return Scaffold(
      backgroundColor: Colors.white,
      body: attendanceStatus.when(
          data: (data){
            return Stack(
              children: [
                Container(
                  width: double.infinity,
                  height: 170.h,
                  decoration: const BoxDecoration(
                      borderRadius: BorderRadius.vertical(
                        bottom: Radius.circular(40),
                      ),
                      color: Color(0xff205578)),
                ),
                Container(
                  width: double.infinity,
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(height: 60.h),
                        Text('Attendance',
                            style: TextStyle(fontSize: 20.sp, color: Colors.white)),
                        SizedBox(height: 30.h),
                        Container(
                          // color:Colors.red,
                            width: 350.w,
                            height: 430.h,
                            child: Stack(children: [
                              Positioned(
                                top: 5.h,
                                child: Column(
                                  children: [
                                    Container(
                                      // color: Colors.white,
                                      child: Center(
                                        child: Card(
                                          color: Colors.white,
                                          elevation: 5,
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                              BorderRadius.circular(20)),
                                          child: SizedBox(
                                            width: 340.w,
                                            height: 60.h,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      // color: Colors.white,
                                      child: Center(
                                        child: Card(
                                          color: Colors.white,
                                          elevation: 5,
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                              BorderRadius.circular(20)),
                                          child: SizedBox(
                                            width: 340.w,
                                            height: 330.h,
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              TableCalendar(
                                daysOfWeekHeight: 20.h,
                                // shouldFillViewport: true,
                                rowHeight: 50.h,
                                eventLoader: _attendance,
                                onDaySelected: (selectedDay, focusedDay) {
                                  if (!isSameDay(_selectedDate, selectedDay)) {
                                    // Call `setState()` when updating the selected day
                                    setState(() {
                                      _selectedDate = selectedDay;
                                      _focusedDay = focusedDay;
                                    });
                                  }
                                },
                                selectedDayPredicate: (day) {
                                  return isSameDay(_selectedDate, day);
                                },
                                onPageChanged: (focusedDay) {
                                  _focusedDay = focusedDay;
                                },
                                daysOfWeekStyle: DaysOfWeekStyle(
                                    weekdayStyle: TextStyle(
                                        color: Colors.blueAccent, fontSize: 15.sp),
                                    weekendStyle: TextStyle(
                                        color: Colors.blueAccent, fontSize: 15.sp)),
                                focusedDay: _focusedDay,
                                firstDay: DateTime.utc(2021, 01, 01),
                                lastDay: DateTime.utc(2024, 12, 12),
                                headerStyle: HeaderStyle(
                                    formatButtonVisible: false,
                                    headerMargin: EdgeInsets.only(
                                        left: 10.w,
                                        right: 10.w,
                                        top: 10.h,
                                        bottom: 20.h),
                                    titleCentered: true,
                                    titleTextStyle: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black),
                                    leftChevronIcon: const Icon(
                                      Icons.arrow_back_ios,
                                      color: Colors.black,
                                    ),
                                    rightChevronIcon: const Icon(
                                      Icons.arrow_forward_ios,
                                      color: Colors.black,
                                    )),

                                calendarStyle: CalendarStyle(
                                  defaultTextStyle: const TextStyle(color: Colors.black),
                                  markerSize: 25.sp,
                                  markerDecoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(100),
                                      color: Colors.green.withOpacity(0.7)),
                                  markersAutoAligned: false,
                                  markersAlignment: Alignment.center,
                                  // cellMargin: EdgeInsets.all(10),

                                  outsideDaysVisible: false,
                                  // tablePadding: EdgeInsets.symmetric(horizontal:10),
                                ),
                              ),
                            ])),

                        attendanceStatus.when(
                          data: (data){
                            int presentCount = 0;
                            int absentCount = 0;

                            for(int i=0; i<data.length; i++) {
                              if(data[i].status == 'Present') {
                                presentCount++;
                              } else if(data[i].status == 'Absent') {
                                absentCount++;
                              }
                            }

                            return  Container(
                                width: 350.w,
                                height: 120.h,
                                child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      InkWell(
                                        onTap: ()=> Get.to(()=>AttendanceStatus(student_id: widget.student_id)),
                                        child: Container(
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(10),
                                            ),
                                            width: 170.w,
                                            child: Card(
                                              color: pre_color,
                                              elevation: 5,
                                              shadowColor: pre_color,
                                              child: Column(
                                                mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                                children: [
                                                  Text('Total Present',
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 20.sp,
                                                          fontWeight: FontWeight.bold)),
                                                  CircleAvatar(
                                                    backgroundColor: Colors.white,
                                                    radius: 20.sp,
                                                    child: Text('$presentCount'),
                                                  )
                                                ],
                                              ),
                                            )),
                                      ),
                                      InkWell(
                                        onTap: ()=> Get.to(()=>AttendanceStatus(student_id: widget.student_id)),
                                        child: Container(
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(10),
                                            ),
                                            width: 170.w,
                                            height: 170.h,
                                            child: Card(
                                              color: abs_color,
                                              elevation: 5,
                                              shadowColor: abs_color,
                                              child: Column(
                                                mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                                children: [
                                                  Text('Total Absent',
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 20.sp,
                                                          fontWeight: FontWeight.bold)),
                                                  CircleAvatar(
                                                    backgroundColor: Colors.white,
                                                    radius: 20.sp,
                                                    child: Text('$absentCount'),
                                                  )
                                                ],
                                              ),
                                            )),
                                      ),
                                    ]));
                          },
                          error: (err, stack) => Center(child: Text('$err')),
                          loading: () => const Center(child: CircularProgressIndicator(),),
                        ),

                        SizedBox(height: 10.h,),

                        TextButton(
                          style: TextButton.styleFrom(
                              backgroundColor: primary,
                              foregroundColor: Colors.white,
                              fixedSize: Size.fromWidth(320.w),
                              shape: RoundedRectangleBorder(
                                  borderRadius:
                                  BorderRadius.circular(10),
                                  side: const BorderSide(
                                    color: Colors.black,
                                  ))),
                          onPressed: () {

                            Get.to(()=>AddNote(student_id: widget.student_id));

                          },
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: 5.h, horizontal: 8.w),
                            child: Text(
                              'Leave a absent note',
                              style: TextStyle(
                                fontSize: 15.sp,
                              ),
                            ),
                          ),
                        ),

                      ],
                    ),
                  ),
                ),
                Positioned(
                  left: 15.w,
                  top: 45.h,
                  child: IconButton(
                      onPressed: () {
                        Get.back();
                      },
                      icon: Icon(Icons.arrow_back, color: Colors.white, size: 25.sp)),
                ),
              ],
            );
          },
         error: (err, stack) => Container(color: Colors.white,child: Center(child: Text('No Attendance Data',style: TextStyle(color: Colors.black,fontSize: 18.sp),),),),
         loading: () => Container(color:Colors.white,child: const Center(child: CircularProgressIndicator(),)),
      ),
    );


  



  }
}
