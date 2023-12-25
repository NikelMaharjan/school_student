import 'package:eschool/constants/colors.dart';
import 'package:eschool/features/services/fee_services.dart';
import 'package:eschool/features/view_page/homepage_parents/menu_items_parents/fee_page/fee_tab.dart';
import 'package:eschool/utils/commonWidgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../../../../authentication/providers/auth_provider.dart';
import '../../../../../constants/snackshow.dart';


class FeePage extends ConsumerWidget {
  final int student_id;
  FeePage({required this.student_id});
  @override
  Widget build(BuildContext context,ref) {
    final auth = ref.watch(authProvider);
    final totalFee = ref.watch(totalFeeProvider(student_id));
    final history = ref.watch(studentAllFeePaymentProvider(0));
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 150.h,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: primary,
                      borderRadius:
                      BorderRadius.vertical(bottom: Radius.circular(20))),
                  child: Center(
                      child: Text(
                        'Fees',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 30.sp,
                        ),
                      )),
                ),

                totalFee.when(
                    data: (data){
                      return ListView.builder(
                        physics: BouncingScrollPhysics(),
                        itemCount: data.length,
                          padding: EdgeInsets.symmetric(horizontal: 15.w),
                          shrinkWrap: true,
                          itemBuilder: (context,index){
                          return Column(
                            children: [
                              FeeCard(
                                onTap: ()=>Get.to(()=>FeeTabs(totalFee: data[index])),
                                  totalFee: data[index].totalFee,
                                  remainingFee: data[index].remainingFee,
                                  date: '${DateFormat('yyyy-MM-dd').format(data[index].createdAt)}',
                                  status: data[index].status
                              ),
                            ],
                          );
                          }
                      );
                    },
                  error: (err, stack) => Center(child: Text('$err')),
                  loading: () => NoticeShimmer(),
                ),


                SizedBox(
                  height: 15.h,
                ),

                Text('History',style: TextStyle(color: Colors.black,fontSize: 18.sp),),

                Divider(
                  thickness: 1,
                  color: Colors.black,
                  height: 8.h,
                ),

                history.when(
                    data: (history_data){
                      print(student_id);
                      final data = history_data.where((element) => element.totalFee.student.id==student_id).toList();
                      return ListView.builder(
                        itemCount: data.length,
                          shrinkWrap: true,
                          padding: EdgeInsets.symmetric(vertical: 5.h),
                          itemBuilder: (context,index){
                          return Container(
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.black
                              )
                            ),
                            child: ListTile(
                              onTap: ()async{
                                showDialog(
                                    context: context,
                                    builder: (context){
                                      return AlertDialog(
                                        backgroundColor: Colors.white,
                                        title: Text('Payment Details',style: TextStyle(color:Colors.black),),
                                        content: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [

                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                Text('Paid Amount:',style: TextStyle(color: Colors.black),),
                                                Text('${data[index].paymentAmount}/-',style: TextStyle(color: Colors.black),),
                                              ],
                                            ),
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                Text('Paid Date:',style: TextStyle(color: Colors.black),),
                                                Text('${DateFormat('yyyy-MM-dd').format(data[index].paymentDate)}',style: TextStyle(color: Colors.black),),
                                              ],
                                            ),
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                Text('Student Name:',style: TextStyle(color: Colors.black),),
                                                Text(data[index].totalFee.student.studentName,style: TextStyle(color: Colors.black),),
                                              ],
                                            ),
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                Text('Collected by:',style: TextStyle(color: Colors.black),),
                                                Text('${data[index].collectedBy.employeeName}',style: TextStyle(color: Colors.black),),
                                              ],
                                            ),
                                            SizedBox(
                                              height: 15.h,
                                            ),
                                            Text('Remarks',style: TextStyle(color: Colors.black),),
                                            Divider(
                                              thickness: 1,
                                              color: Colors.black,
                                            ),
                                            Text(data[index].paymentNote,style: TextStyle(color: Colors.black),)
                                          ],
                                        ),
                                        actions: [
                                          TextButton(
                                              style: TextButton.styleFrom(
                                                  backgroundColor: primary
                                              ),
                                              onPressed: (){
                                                Navigator.pop(context);
                                              },
                                              child: Text('Confirm',style: TextStyle(color: Colors.white))
                                          ),
                                          TextButton(
                                              style: TextButton.styleFrom(
                                                  backgroundColor: abs_color
                                              ),
                                              onPressed: (){
                                                SnackShow.showSuccess(context, 'Please contact via email or phone');
                                              },
                                              child: Text('Dispute',style: TextStyle(color: Colors.white),)
                                          ),

                                        ],
                                        actionsAlignment: MainAxisAlignment.spaceAround,
                                      );
                                    }
                                );
                              },
                              title: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text('${data[index].paymentAmount}/-',style: TextStyle(color: Colors.black),),
                                  Text('${DateFormat('yyyy-MM-dd').format(data[index].paymentDate)}',style: TextStyle(color: Colors.black),),
                                ],
                              ),
                              subtitle: Text(data[index].paymentNote,style: TextStyle(color: Colors.black),),
                            ),
                          );
                          }
                      );
                    },
                    error: (err,stack)=> Text('No payment history',style: TextStyle(color: Colors.black),),
                    loading: ()=>NoticeShimmer()
                )





              ],
            ),
          ),
          Positioned(
            left: 15.w,
            top: 40.h,
            child: IconButton(
                onPressed: () {
                  Get.back();
                },
                icon: Icon(Icons.arrow_back, color: Colors.white, size: 25.sp)),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          ref.refresh(studentAllFeePaymentProvider(0));
          ref.refresh(totalFeeProvider(student_id));
        },
        backgroundColor: primary,
        child: Icon(Icons.refresh,color: Colors.white,),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}
