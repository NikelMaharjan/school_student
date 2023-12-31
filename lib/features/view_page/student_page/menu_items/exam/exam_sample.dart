import 'package:eschool/authentication/providers/auth_provider.dart';
import 'package:eschool/utils/commonWidgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

import '../../../../services/exam_services.dart';

class Exams extends ConsumerWidget {

  final int class_id;
  final String day;
  Exams({super.key, required this.class_id,required this.day});

  @override
  Widget build(BuildContext context,ref) {



    final auth = ref.watch(authProvider);
    final subject = ref.watch(subjectInfo(auth.user.token));


    final examRoutine = ref.watch(classWiseExamProvider(class_id));



    return subject.when(
      data: (subject_data){
        return examRoutine.when(
          data: (data){
            final routineInfo = data.where((element) => element.day == day).toList();


            return ListView.builder(
              shrinkWrap: true,
              padding: EdgeInsets.zero,
              itemCount: routineInfo.length,
              physics: const BouncingScrollPhysics(),
              itemBuilder: (context, index) {
                final subjectName = subject_data.firstWhere((element) => element.id == routineInfo[index].subject.id);
                // Define the date format to show only the hour and minute
                final timeFormat = DateFormat('hh:mm');

                return CommonCard(
                  time:
                  routineInfo.map((e) => '${timeFormat.format(DateFormat('HH:mm').parse(e.startTime))}-${timeFormat.format(DateFormat('HH:mm').parse(e.endTime))}').join(', '),
                  className: routineInfo.map((e) => e.date).join(', '),
                  subjectName:
                  subjectName.subjectName,
                );
              },
            );







          },
          error: (err, stack) => Center(child: Text('$err')),
          loading: () => const NoticeShimmer(),
        );
      },
      error: (err, stack) => Center(child: Text('$err')),
      loading: () => const NoticeShimmer(),
    );




    //
    // return examRoutine.when(
    //   data: (data){
    //     final routineInfo = data.where((element) => element.day == day).toList();
    //
    //
    //     return ListView.builder(
    //       shrinkWrap: true,
    //       padding: EdgeInsets.zero,
    //       itemCount: routineInfo.length,
    //       physics: BouncingScrollPhysics(),
    //       itemBuilder: (context, index) {
    //      //   final subjectName = subject_data.firstWhere((element) => element.id == routineInfo[index].subject.id);
    //         // Define the date format to show only the hour and minute
    //         final timeFormat = DateFormat('hh:mm');
    //
    //         return CommonCard(
    //           time:
    //           "${routineInfo.map((e) => '${timeFormat.format(DateFormat('HH:mm').parse(e.startTime))}-${timeFormat.format(DateFormat('HH:mm').parse(e.endTime))}').join(', ')}",
    //           className: '${routineInfo.map((e) => e.date).join(', ')}',
    //           subjectName: "Nikel",
    //         );
    //       },
    //     );
    //
    //
    //
    //
    //
    //
    //
    //   },
    //   error: (err, stack) => Center(child: Text('$err')),
    //   loading: () => NoticeShimmer(),
    // );
    //




  }
}
