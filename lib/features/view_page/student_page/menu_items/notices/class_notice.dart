


import 'package:eschool/authentication/providers/auth_provider.dart';
import 'package:eschool/features/services/notice_services.dart';
import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../utils/commonWidgets.dart';

class ClassNotice extends ConsumerWidget {
  final int class_sec_id;
  const ClassNotice({super.key, required this.class_sec_id});

  @override
  Widget build(BuildContext context,ref) {
    final auth = ref.watch(authProvider);
    final noticeData = ref.watch(classNoticeProvider(class_sec_id));

    return Container(
      height: MediaQuery.of(context).size.height * 4 / 5,
      // color: Colors.red,
      child: noticeData.when(
        data: (data) {
          final allNotice = data.where((element) => element.notice.forAllClass == false).toList();

          return ListView.builder(
              padding: EdgeInsets.symmetric(horizontal: 15.w),
              physics: const BouncingScrollPhysics(),
              shrinkWrap: true,
              itemCount: allNotice.length,
              itemBuilder: (context, index) {
                return NoticeCard(
                    title: allNotice[index].notice.title,
                    description: allNotice[index].notice.description,
                    createdAt: allNotice[index].createdAt);
              });
        },
        error: (err, stack) => Center(child: Text('$err',style: const TextStyle(color: Colors.black),)),
        loading: () => const NoticeShimmer(),
      ),
    );
  }
}
