
import 'package:eschool/constants/snackshow.dart';
import 'package:eschool/features/model/features.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../constants/colors.dart';
import '../../../../utils/commonWidgets.dart';
import '../../../services/student_services.dart';
import '../../sample_pages/report_tabs/reports.dart';
import '../subject_tab/subject_page.dart';

class ReportPage extends ConsumerWidget {
  final int student_id;
  final StudentClass class_data;
  ReportPage({required this.class_data,required this.student_id});

  @override
  Widget build(BuildContext context,ref) {
    print(class_data.className!.id);
    final classSubject= ref.watch(secWiseSubjectProvider(class_data.className!.id));

   // final classSubject= ref.watch(classsSubjectProvider(class_data.className!.id ));


    return Scaffold(
      appBar: AppBar(
        backgroundColor: bgColor,
        title: Text("Subjects", style: TextStyle(color: Colors.white),),
      ),
      backgroundColor: Colors.white,
      body: Column(
        children: [
          SizedBox(height: 10.h,),
          Padding(
            padding: EdgeInsets.only(left: 20.w),
            child: Container(
              // color: Colors.red,
                child: classSubject.when(
                    data: (sub_data){
                      return GridView.builder(
                        itemCount: sub_data.length ,
                        padding: EdgeInsets.zero,
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            childAspectRatio: 2.w / 2.4.h,
                            crossAxisCount: 3,
                            mainAxisSpacing: 5.h,
                            crossAxisSpacing: 5.w),
                        itemBuilder: (context,index){
                          return  CommonWidget(
                            color: Colors.lightBlueAccent,

                            text: sub_data[index].subject.subjectName,
                            label: sub_data[index].subject.subjectName.substring(0,1),
                            onTap: () {
                             Get.to(() => Report(classSubject: sub_data[index],student_id: student_id,));
                            }

                          );
                        },


                      );
                    },
                    error:  (err, stack) => Center(child: Text('$err')),
                    loading: () => GridShimmer()
                )

            ),
          ),
        ],
      ),

        );

  }
}
