



import 'package:eschool/features/view_page/student_page/menu_items/result/result_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../../constants/colors.dart';
import '../../../../../utils/commonWidgets.dart';
import '../../../../services/exam_services.dart';


class ExamResults extends ConsumerWidget {
  final int class_id;
  final int student_id;
  ExamResults({required this.class_id,required this.student_id});

  @override
  Widget build(BuildContext context,ref) {

    final examClass = ref.watch(examClassProvider(class_id));

    return Scaffold(
      appBar: AppBar(
        backgroundColor: bgColor,
        title: Text("RESULTS", style: TextStyle(color: Colors.white),),
      ),
      backgroundColor: Colors.white,
      body: Column(
        children: [
          examClass.when(
              data: (data){
                return ListView.builder(
                  itemCount: data.length,
                    padding: EdgeInsets.symmetric(horizontal: 8.w),
                    shrinkWrap: true,
                    itemBuilder: (context,index){
                    return ExamCard(
                      onTap: ()=>Get.to(()=>MarkSheet(exam_id: data[index].exam.id,student_id:student_id ,examName: data[index].exam.name,)),
                        title: data[index].exam.name,
                        date: '${data[index].exam.examStartDate} to ${data[index].exam.examEndDate}'
                    );

                    }
                );
              },
            error: (err, stack) => Expanded(child: Center(child: Text('$err'))),
            loading: () => NoticeShimmer(),
          )
        ],
      )
    );
  }
}
