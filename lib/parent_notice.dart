




import 'package:eschool/constants/colors.dart';
import 'package:eschool/features/services/notice_services.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../authentication/providers/auth_provider.dart';
import '../../../../../utils/commonWidgets.dart';

class ParentNotice extends ConsumerWidget {
  const ParentNotice({super.key});


  @override
  Widget build(BuildContext context,ref) {
    final auth = ref.watch(authProvider);
    final noticeData = ref.watch(noticeList(auth.user.token));
    return Scaffold(
      appBar: AppBar(
        backgroundColor: bgColor,
        title: const Text("Notice", style: TextStyle(color: Colors.white),),

      ),
      body: SizedBox(
        height: MediaQuery.of(context).size.height * 4 / 5,
        // color: Colors.red,
        child: noticeData.when(
          data: (data) {
            final allNotice = data
                .where((element) => element.forAllClass == true)
                .toList();
            return ListView.builder(
                padding: EdgeInsets.symmetric(horizontal: 15.w),
                physics: const BouncingScrollPhysics(),
                shrinkWrap: true,
                itemCount: allNotice.length,
                itemBuilder: (context, index) {
                  return NoticeCard(
                      title: allNotice[index].title,
                      description: allNotice[index].description,
                      createdAt: allNotice[index].createdAt);
                });
          },
          error: (err, stack) => Center(child: Text('$err')),
          loading: () => const NoticeShimmer(),
        ),
      ),
    );
  }
}
