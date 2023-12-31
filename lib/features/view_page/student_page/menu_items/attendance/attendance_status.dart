


import 'package:eschool/constants/snackshow.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';


import '../../../../../constants/colors.dart';
import '../../../../../utils/commonWidgets.dart';
import '../../../../services/attendance_services.dart';

class AttendanceStatus extends ConsumerWidget {

  final int student_id;
  const AttendanceStatus({super.key, required this.student_id});

  @override
  Widget build(BuildContext context,ref) {

    final attendStatus = ref.watch(studentAttendanceProvider(student_id));
    final attendNote = ref.watch(studentLeaveNoteProvider(student_id));


    return Scaffold(
      appBar: AppBar(
        backgroundColor: bgColor,
        title: const Text("Status", style: TextStyle(color: Colors.white),),
      ),
      backgroundColor: Colors.white,
      body: Column(
        children: [
          SizedBox(
            // color: Colors.red,
            height: MediaQuery.of(context).size.height*4.2/5,
            child:  attendStatus.when(
              data: (data){
                return  data.isEmpty ? const Center(
                  child: Text("Nothing at the moment"),

                ) : ListView.builder(
                    padding: EdgeInsets.zero,
                    physics: const BouncingScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: data.length,
                    itemBuilder: (context, index) {

                      return Card(
                        color: Colors.white,
                        shape: Border.all(
                            color: Colors.black
                        ),
                        child: ListTile(
                          onTap: ()async{
                            if(data[index].status=='Present'){
                              SnackShow.showSuccess(context, 'You were present');
                            }
                            else{
                              await showDialog(
                                  context: context,
                                  builder: (context){
                                   return attendNote.when(
                                        data: (noteData){
                                          final leaveNote = noteData.firstWhereOrNull((element) => element.startDate == data[index].attendance.date);
                                          if(leaveNote!=null){

                                            return AlertDialog(
                                              backgroundColor: Colors.white,
                                              title: Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  Text('Absent Note',style: TextStyle(color: Colors.black,fontSize: 12.sp),),
                                                  Text(data[index].attendance.date,style: TextStyle(color: Colors.black,fontSize: 12.sp),),
                                                ],
                                              ),
                                              content:Text(leaveNote.reason!,style: const TextStyle(color: Colors.black),),

                                            );
                                          }
                                          else{
                                            return AlertDialog(
                                              backgroundColor: Colors.white,
                                              title: Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  Text('Absent Note',style: TextStyle(color: Colors.black,fontSize: 12.sp),),
                                                  Text(data[index].attendance.date,style: TextStyle(color: Colors.black,fontSize: 12.sp),),
                                                ],
                                              ),
                                              content:const Text('No reason given',style: TextStyle(color: Colors.black),),

                                            );
                                          }

                                        },
                                     error: (err, stack) {
                                       return AlertDialog(
                                         backgroundColor: Colors.white,
                                         title: Row(
                                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                           children: [
                                             Text('Absent Note',style: TextStyle(color: Colors.black,fontSize: 12.sp),),
                                             Text(data[index].attendance.date,style: TextStyle(color: Colors.black,fontSize: 12.sp),),
                                           ],
                                         ),
                                         content:const Text('No reason given',style: TextStyle(color: Colors.black),),

                                       );
                                     },
                                     loading: () {
                                          return const AlertDialog(
                                            content: Center(child: CircularProgressIndicator(),),
                                          );
                                     },
                                    );

                                  }
                              );
                            }
                          },
                          title: Text(data[index].attendance.date,style: const TextStyle(color: Colors.black),),
                          trailing: CircleAvatar(
                            radius: 10.sp,
                            backgroundColor: data[index].status == 'Present' ? pre_color: abs_color,
                          ),
                        ),
                      );
                    }
                );


              },
              error: (err, stack) => Center(child: Text('$err')),
              loading: () => const NoticeShimmer(),
            )



          )
        ],
      ),
    );
  }
}
