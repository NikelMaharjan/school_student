import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:shimmer/shimmer.dart';
import '../../../../../../constants/colors.dart';
import '../../../../../../utils/commonWidgets.dart';
import '../../../../../authentication/providers/auth_provider.dart';
import '../../../../../exceptions/internet_exceptions.dart';
import '../../../../services/notice_services.dart';

class SubjectNotices extends ConsumerWidget {
  final int sub_id;
  final String sub_name;
  final int class_sec_id;
  final String token;
  final int teacher_id;
  final int class_sec_sub_id;

  SubjectNotices({required this.sub_id,required this.sub_name,required this.class_sec_id,required this.token,required this.teacher_id,required this.class_sec_sub_id});

  @override
  Widget build(BuildContext context, ref) {
    final auth = ref.watch(authProvider);
    final subNotices = ref.watch(subNoticeList(auth.user.token));






    return ConnectivityChecker(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: subNotices.when(
          data: (subNotices_data){
            final sub_notices = subNotices_data.where((element) => element.subjectName?.id == class_sec_sub_id).toList();

            if(sub_notices.isNotEmpty){
              return ListView.builder(
                  padding: EdgeInsets.zero,
                  shrinkWrap: true,
                  itemCount: sub_notices.length,
                  itemBuilder: (context, index){
                    String createdAtString = sub_notices[index].createdAt.toString();
                    DateTime createdAt = DateTime.parse(createdAtString);


                    return Padding(
                      padding: EdgeInsets.symmetric(
                          vertical: 5.h,
                          horizontal: 20.w),
                      child: NoticeCard(
                          title: sub_notices[index].title,
                          description: sub_notices[index].message,
                          createdAt: '${DateFormat('MMMM dd').format(createdAt)}'),


                    );
                  }
              );

            } else{
              return Center(child: Text('No announcement',style: TextStyle(color: Colors.black),),);
            }


          },
          error: (err, stack) => Center(child: Text('$err')),
          loading: () => NoticeShimmer(),
        )
      ),
    );
  }

}


