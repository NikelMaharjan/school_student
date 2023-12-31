
import 'package:eschool/authentication/providers/auth_provider.dart';
import 'package:eschool/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../utils/commonWidgets.dart';
import '../../../services/student_services.dart';

  class ParentsProfile extends ConsumerWidget {
    final int student_id;
    const ParentsProfile({super.key, required this.student_id});
  @override
  Widget build(BuildContext context,ref) {

    final auth = ref.watch(authProvider);
    final infoData = ref.watch(studentList(auth.user.token));
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Container(
            width: double.infinity,
            height: MediaQuery.of(context).size.height*1/5,
            decoration: const BoxDecoration(
                borderRadius: BorderRadius.vertical(
                  bottom: Radius.circular(40),
                ),
                color: Color(0xff205578)),
            child: Row(
              children : [
                IconButton(
                  onPressed: (){},
                  icon: const Icon(Icons.chevron_left),
                ),
                Expanded(
                  child: Center(
                    child: Text('Parents Profile',
                        style: TextStyle(fontSize: 25.sp, color: Colors.white)),
                  ),
                ),
                SizedBox(width: 50.w,)

              ]
            ),
          ),

          Container(
            height: MediaQuery.of(context).size.height*3.8/5,
            child:

                infoData.when(
                    data: (data){
                      final info = data.firstWhere((element) => element.id == student_id);
                      return ListView(
                        physics: const BouncingScrollPhysics(),
                        shrinkWrap: true,
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: 10.h, horizontal: 8.h),
                            child: Stack(
                              children: [
                                Column(
                                  children: [
                                    SizedBox(
                                      height: 25.h,
                                    ),
                                    Card(
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                          BorderRadius.circular(20)),
                                      // elevation:5,
                                      color: shimmerContentColor,
                                      child: ListTile(
                                        title: Column(
                                          crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                          children: [
                                            SizedBox(
                                              height: 50.h,
                                            ),
                                            Divider(
                                              thickness: 1.h,
                                              height: 8.h,
                                              color: Colors.grey,
                                            ),
                                            SizedBox(
                                              height: 10.h,
                                            ),
                                            Text('Mother\'s Name:',
                                                style: TextStyle(
                                                    color: Colors.grey,
                                                    fontSize: 15.sp)),
                                            SizedBox(
                                              height: 5.h,
                                            ),
                                            Text(info.motherName,
                                                style: const TextStyle(
                                                    color: Colors.black,
                                                    fontWeight: FontWeight.bold)),
                                            SizedBox(
                                              height: 20.h,
                                            ),
                                            Text('Date Of Birth',
                                                style: TextStyle(
                                                    color: Colors.grey,
                                                    fontSize: 15.sp)),
                                            SizedBox(
                                              height: 5.h,
                                            ),
                                            const Text('1995-01-01',
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontWeight: FontWeight.bold)),
                                            SizedBox(
                                              height: 20.h,
                                            ),
                                            Text('E-mail',
                                                style: TextStyle(
                                                    color: Colors.grey,
                                                    fontSize: 15.sp)),
                                            SizedBox(
                                              height: 5.h,
                                            ),
                                            const Text('jane@gmail.com',
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontWeight: FontWeight.bold)),
                                            SizedBox(
                                              height: 20.h,
                                            ),
                                            Text('Occupation',
                                                style: TextStyle(
                                                    color: Colors.grey,
                                                    fontSize: 15.sp)),
                                            SizedBox(
                                              height: 5.h,
                                            ),
                                            const Text('Business',
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontWeight: FontWeight.bold)),
                                            SizedBox(
                                              height: 20.h,
                                            ),
                                            Text('Phone Number',
                                                style: TextStyle(
                                                    color: Colors.grey,
                                                    fontSize: 15.sp)),
                                            SizedBox(
                                              height: 5.h,
                                            ),
                                            Text('${info.motherPhoneNumber}',
                                                style: const TextStyle(
                                                    color: Colors.black,
                                                    fontWeight: FontWeight.bold)),
                                            SizedBox(
                                              height: 20.h,
                                            ),
                                            Text('Address',
                                                style: TextStyle(
                                                    color: Colors.grey,
                                                    fontSize: 15.sp)),
                                            SizedBox(
                                              height: 5.h,
                                            ),
                                            const Text('-',
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontWeight: FontWeight.bold)),
                                            SizedBox(
                                              height: 20.h,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Align(
                                  alignment: Alignment.topCenter,
                                  child: CircleAvatar(
                                    backgroundColor: Colors.white,
                                    radius: 40.sp,
                                    child: CircleAvatar(
                                      backgroundColor: Colors.grey,
                                      radius: 35.sp,
                                      child: Icon(
                                        Icons.person,
                                        color: Colors.black,
                                        size: 40.sp,
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                          Container(
                            // color: Colors.red,
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical: 10.h, horizontal: 8.h),
                              child: Stack(
                                children: [
                                  Column(
                                    children: [
                                      SizedBox(
                                        height: 25.h,
                                      ),
                                      Card(
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                            BorderRadius.circular(20)),
                                        // elevation:5,
                                        color: shimmerContentColor,
                                        child: ListTile(
                                          title: Column(
                                            crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                            children: [
                                              SizedBox(
                                                height: 50.h,
                                              ),
                                              Divider(
                                                thickness: 1.h,
                                                height: 8.h,
                                                color: Colors.grey,
                                              ),
                                              SizedBox(
                                                height: 10.h,
                                              ),
                                              Text('Father\'s Name:',
                                                  style: TextStyle(
                                                      color: Colors.grey,
                                                      fontSize: 15.sp)),
                                              SizedBox(
                                                height: 5.h,
                                              ),
                                              Text(info.fatherName,
                                                  style: const TextStyle(
                                                      color: Colors.black,
                                                      fontWeight: FontWeight.bold)),
                                              SizedBox(
                                                height: 20.h,
                                              ),
                                              Text('Date Of Birth',
                                                  style: TextStyle(
                                                      color: Colors.grey,
                                                      fontSize: 15.sp)),
                                              SizedBox(
                                                height: 5.h,
                                              ),
                                              const Text('1995-12-12',
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontWeight: FontWeight.bold)),
                                              SizedBox(
                                                height: 20.h,
                                              ),
                                              Text('E-mail',
                                                  style: TextStyle(
                                                      color: Colors.grey,
                                                      fontSize: 15.sp)),
                                              SizedBox(
                                                height: 5.h,
                                              ),
                                              const Text('john@gmail.com',
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontWeight: FontWeight.bold)),
                                              SizedBox(
                                                height: 20.h,
                                              ),
                                              Text('Occupation',
                                                  style: TextStyle(
                                                      color: Colors.grey,
                                                      fontSize: 15.sp)),
                                              SizedBox(
                                                height: 5.h,
                                              ),
                                              const Text('Business',
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontWeight: FontWeight.bold)),
                                              SizedBox(
                                                height: 20.h,
                                              ),
                                              Text('Phone Number',
                                                  style: TextStyle(
                                                      color: Colors.grey,
                                                      fontSize: 15.sp)),
                                              SizedBox(
                                                height: 5.h,
                                              ),
                                              Text('${info.fatherPhoneNumber}',
                                                  style: const TextStyle(
                                                      color: Colors.black,
                                                      fontWeight: FontWeight.bold)),
                                              SizedBox(
                                                height: 20.h,
                                              ),
                                              Text('Address',
                                                  style: TextStyle(
                                                      color: Colors.grey,
                                                      fontSize: 15.sp)),
                                              SizedBox(
                                                height: 5.h,
                                              ),
                                              const Text('-',
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontWeight: FontWeight.bold)),
                                              SizedBox(
                                                height: 20.h,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Align(
                                    alignment: Alignment.topCenter,
                                    child: CircleAvatar(
                                      backgroundColor: Colors.white,
                                      radius: 40.sp,
                                      child: CircleAvatar(
                                        backgroundColor: Colors.grey,
                                        radius: 35.sp,
                                        child: Icon(
                                          Icons.person,
                                          color: Colors.black,
                                          size: 40.sp,
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 100.h,
                          )
                        ],
                      );
                    },
                  error: (err, stack) => Center(child: Text('$err')),
                  loading: () => const NoticeShimmer(),
                )


          ),
        ],
      ),
    );
  }
}
