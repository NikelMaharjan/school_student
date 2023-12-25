
import 'package:eschool/utils/commonWidgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

import '../../../../../authentication/providers/auth_provider.dart';
import '../../../../services/routine_service.dart';



class ClassRoutine extends ConsumerWidget {

  final int class_section_id;
  final String day;
  ClassRoutine({required this.class_section_id,required this.day});

  @override
  Widget build(BuildContext context,ref) {

    final auth = ref.watch(authProvider);
    final routine = ref.watch(classRoutineProvider(class_section_id));


    return routine.when(
      data: (data){
        final routineInfo = data.where((element) => element.day==day).toList();
        return routineInfo.isEmpty ? Center(child: Text("No Time Table at the moment"),) : ListView.builder(
          shrinkWrap: true,
          padding: EdgeInsets.zero,
          itemCount: routineInfo.length,
          physics: BouncingScrollPhysics(),
          itemBuilder: (context, index) {




            // Define the date format to show only the hour and minute
            final timeFormat = DateFormat('hh:mm');


            return CustomCardWidget(
                subjectName:  '${routineInfo[index].classSubject.subject.subjectName}' ,
                time: "${timeFormat.format(DateFormat('HH:mm').parse(routineInfo[index].startTime))}-${timeFormat.format(DateFormat('HH:mm').parse(routineInfo[index].endTime))}",
            );

          },
        );







      },
      error: (err, stack) => Center(child: Text('$err')),
      loading: () => NoticeShimmer(),
    );
  }
}