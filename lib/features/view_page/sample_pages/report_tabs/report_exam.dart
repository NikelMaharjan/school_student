import 'package:eschool/constants/colors.dart';
import 'package:eschool/utils/commonWidgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../model/class_model.dart';
import '../../../services/exam_services.dart';

class ReportExam extends ConsumerWidget {

  final int student_id;
  final ClassSubject classSubject;
  ReportExam({required this.classSubject,required this.student_id});

  @override
  Widget build(BuildContext context,ref) {
    final subMarks = ref.watch(subExamMarksProvider(classSubject.id));
    // List<double> exam = [2, 0];
    // int total_marks = 50;
    // int obtained_marks = 40;
    //
    // Map<String, double> dataMap = {
    //   "attempted": exam[0],
    //   "missed": exam[1],
    // };
    return SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      child: subMarks.when(
          data: (sub_data){
            final data = sub_data.where((element) => element.totalMarks.student.id==student_id).toList();
            final passed_data = data.where((element) => double.parse(element.obtained_marks) > double.parse(element.subject_full_marks)*0.4).toList();
            final failed_data = data.where((element) => double.parse(element.obtained_marks) < double.parse(element.subject_full_marks)*0.4).toList();
            print(passed_data.length);
            List<double> total = [passed_data.length.toDouble(),failed_data.length.toDouble()];
            Map<String, double> dataMap = {
              "Passed": total[0],
              "Failed": total[1],
            };

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                    'Total Exams  ${total.reduce((a, b) => a + b).round()}',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 20.sp,
                        fontWeight: FontWeight.bold)),
                Container(
                  width: 365.w,
                  height: 150.h,
                  child: Card(
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                        side: BorderSide(
                            color: Colors.grey.withOpacity(0.3))),
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8.w),
                      child: Row(
                        children: [
                          PieChart(
                            colorList: [pre_color, abs_color],
                            chartValuesOptions: ChartValuesOptions(
                              showChartValues: false,
                            ),
                            legendOptions:
                            LegendOptions(showLegends: false),
                            chartRadius: 90.sp,
                            ringStrokeWidth: 8.w,
                            chartType: ChartType.ring,
                            dataMap: dataMap,
                          ),
                          SizedBox(
                            width: 20.w,
                          ),
                          Column(
                            mainAxisAlignment:
                            MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment:
                            CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Container(
                                    height: 20,
                                    width: 20,
                                    decoration: BoxDecoration(
                                        color: pre_color,
                                        borderRadius:
                                        BorderRadius.circular(
                                            100)),
                                  ),
                                  SizedBox(
                                    width: 10.w,
                                  ),
                                  Text(
                                      'Passed: ${total[0].round()}',
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 20.sp)),
                                ],
                              ),
                              Row(
                                children: [
                                  Container(
                                    height: 20,
                                    width: 20,
                                    decoration: BoxDecoration(
                                        color: abs_color,
                                        borderRadius:
                                        BorderRadius.circular(
                                            100)),
                                  ),
                                  SizedBox(
                                    width: 10.w,
                                  ),
                                  Text('Failed: ${total[1].round()}',
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 20.sp)),
                                ],
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 30.h,
                ),
                ListView.builder(
                  itemCount: data.length,
                    shrinkWrap: true,
                    padding: EdgeInsets.zero,
                    itemBuilder: (context,index){
                    final double pass_marks = double.parse(data[index].subject_full_marks) * 0.4;
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
                            Text(data[index].totalMarks.exam.name,style: TextStyle(color: Colors.black),),
                            Text(data[index].obtained_marks,style: TextStyle(color: int.parse(data[index].obtained_marks)>pass_marks? pre_color:abs_color,fontWeight: FontWeight.bold),),
                          ],
                        ),
                        subtitle: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Pass Marks : ${pass_marks.round()}',style: TextStyle(color: Colors.black,fontSize: 12.sp),),
                            Text('Full Marks : ${data[index].subject_full_marks}',style: TextStyle(color: Colors.black,fontSize: 12.sp),),
                          ],
                        ),
                      ),
                    );
                    }

                ),
              ],
            );
          },
          error: (err,stack)=>Text('$err'),
          loading: ()=>NoticeShimmer()
      )
    );
  }
}
