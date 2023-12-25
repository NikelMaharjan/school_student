
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../../authentication/providers/auth_provider.dart';
import '../../../../../constants/colors.dart';
import '../../../../services/exam_services.dart';

class MarkSheet extends ConsumerWidget {
  final String examName;
  final int exam_id;
  final int student_id;
  MarkSheet({required this.exam_id,required this.student_id,required this.examName});

  @override
  Widget build(BuildContext context,ref) {
    final auth = ref.watch(authProvider);
    final subMarks = ref.watch(marksInfo(auth.user.token));
    final totalMarks = ref.watch(totalMarksProvider(exam_id));
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Container(
              height: MediaQuery.of(context).size.height * 0.8/ 5,
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
                      child: Column(
                        children: [

                          Text(examName,style: TextStyle(color: Colors.white,fontSize: 25.sp,),),
                          Text('MarkSheet',
                              style: TextStyle(color: Colors.white, fontSize: 18.sp)),
                        ],
                      ),
                    ),])),

          totalMarks.when(
              data: (data){
                final markSheet = data.firstWhereOrNull((element) => element.student.id==student_id);
                print(markSheet?.id);
                if(markSheet!=null){
                  return subMarks.when(
                      data: (sub_data){
                        final sub_marks = sub_data.where((element) => element.totalMarks.id==markSheet.id).toList();
                        return ListView.builder(
                          physics: BouncingScrollPhysics(),
                          itemCount: sub_marks.length,
                            padding: EdgeInsets.symmetric(horizontal: 15.w),
                            shrinkWrap: true,
                            itemBuilder: (context,index){
                            final double pass_marks = int.parse(sub_marks[index].subject_full_marks )* 0.4;
                            return Card(
                              elevation: 0,
                              color: shimmerHighlightColor,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                                side: BorderSide(
                                  color: Colors.black
                                )
                              ),
                              child: ListTile(
                                title: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(sub_marks[index].classSubject.subject.subjectName,style: TextStyle(color: Colors.black),),
                                    Text(sub_marks[index].obtained_marks,style: TextStyle(color: int.parse(sub_marks[index].obtained_marks)>pass_marks? pre_color:abs_color,fontWeight: FontWeight.bold),),
                                  ],
                                ),
                                subtitle: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text('Pass Marks : ${pass_marks}',style: TextStyle(color: Colors.black,fontSize: 12.sp),),
                                    Text('Full Marks : ${sub_marks[index].subject_full_marks}',style: TextStyle(color: Colors.black,fontSize: 12.sp),),
                                  ],
                                ),
                              ),
                            );
                            }
                        );
                      },
                      error:  (err, stack) => Center(child: Text('$err')),
                      loading: () => Container(child: Center(child: CircularProgressIndicator()))
                  );

                 // return Text('${markSheet.totalMarks}',style: TextStyle(color: Colors.black),);
                }
                else {
                  return Text('Marks hasn\'t been tallied',style: TextStyle(color: Colors.black),);
                }
              },
              error:  (err, stack) => Center(child: Text('$err')),
              loading: () =>  Center(child: CircularProgressIndicator())
          )

        ],
      ),
    );
  }
}
