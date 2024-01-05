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
      appBar: AppBar(
        backgroundColor: bgColor,
        title: const Text("Fees", style: TextStyle(color: Colors.white),),
      ),
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                totalFee.when(
                    data: (data){
                      return ListView.builder(
                        physics: const BouncingScrollPhysics(),
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
                                  date: DateFormat('yyyy-MM-dd').format(data[index].createdAt),
                                  status: data[index].status
                              ),
                            ],
                          );
                          }
                      );
                    },
                  error: (err, stack) => Center(child: Text('$err')),
                  loading: () => const NoticeShimmer(),
                ),


                SizedBox(
                  height: 15.h,
                ),

                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text('History',style: TextStyle(color: Colors.black,fontSize: 18.sp),),
                ),

                Divider(
                  thickness: 1,
                  color: Colors.black,
                  height: 8.h,
                ),

                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: history.when(
                      data: (historyData){
                        final data = historyData.where((element) => element.totalFee.student.id ==student_id).toList();
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
                                          title: const Text('Payment Details',style: TextStyle(color:Colors.black),),
                                          content: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [

                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  const Text('Paid Amount:',style: TextStyle(color: Colors.black),),
                                                  Text('${data[index].paymentAmount}/-',style: const TextStyle(color: Colors.black),),
                                                ],
                                              ),
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  const Text('Paid Date:',style: TextStyle(color: Colors.black),),
                                                  Text(DateFormat('yyyy-MM-dd').format(data[index].paymentDate),style: const TextStyle(color: Colors.black),),
                                                ],
                                              ),
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  const Text('Student Name:',style: TextStyle(color: Colors.black),),
                                                  Text(data[index].totalFee.student.studentName,style: const TextStyle(color: Colors.black),),
                                                ],
                                              ),
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  const Text('Collected by:',style: TextStyle(color: Colors.black),),
                                                  Text(data[index].collectedBy.employeeName,style: const TextStyle(color: Colors.black),),
                                                ],
                                              ),
                                              SizedBox(
                                                height: 15.h,
                                              ),
                                              const Text('Remarks',style: TextStyle(color: Colors.black),),
                                              const Divider(
                                                thickness: 1,
                                                color: Colors.black,
                                              ),
                                              Text(data[index].paymentNote,style: const TextStyle(color: Colors.black),)
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
                                                child: const Text('Confirm',style: TextStyle(color: Colors.white))
                                            ),
                                            TextButton(
                                                style: TextButton.styleFrom(
                                                    backgroundColor: abs_color
                                                ),
                                                onPressed: (){
                                                  SnackShow.showSuccess(context, 'Please contact via email or phone');
                                                },
                                                child: const Text('Dispute',style: TextStyle(color: Colors.white),)
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
                                    Text('${data[index].paymentAmount}/-',style: const TextStyle(color: Colors.black),),
                                    Text(DateFormat('yyyy-MM-dd').format(data[index].paymentDate),style: const TextStyle(color: Colors.black),),
                                  ],
                                ),
                                subtitle: Text(data[index].paymentNote,style: const TextStyle(color: Colors.black),),
                              ),
                            );
                            }
                        );
                      },
                      error: (err,stack)=>  Text(err.toString(),style: TextStyle(color: Colors.black),),
                      loading: ()=>const NoticeShimmer()
                  ),
                )





              ],
            ),
          ),
          Positioned(
            left: 15.w,
            top: 45.h,
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
          ref.invalidate(studentAllFeePaymentProvider(0));
          ref.invalidate(totalFeeProvider(student_id));
        },
        backgroundColor: primary,
        child: const Icon(Icons.refresh,color: Colors.white,),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}
