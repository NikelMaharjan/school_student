



import 'package:eschool/constants/colors.dart';
import 'package:eschool/constants/snackshow.dart';
import 'package:eschool/features/model/fee_model.dart';
import 'package:eschool/features/services/fee_services.dart';
import 'package:eschool/utils/commonWidgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

class FeeHistory extends ConsumerWidget {
  final TotalFee totalFee;
  FeeHistory({required this.totalFee});

  @override
  Widget build(BuildContext context,ref) {
    final history = ref.watch(studentFeePaymentProvider(totalFee.id));
    return history.when(
        data: (data){
          return ListView.builder(
            itemCount: data.length,
              shrinkWrap: true,
              padding: EdgeInsets.symmetric(horizontal: 8.w),
              itemBuilder: (context,index){
              return FeeCard2(
                  paymentAmount: '${data[index].paymentAmount}',
                  date: '${DateFormat('yyyy-MM-dd').format(data[index].paymentDate)}',
                  note: '${data[index].paymentNote}',
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
                                    Text(totalFee.student.studentName,style: TextStyle(color: Colors.black),),
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
              );
              }
          );
        },
        error: (err,stack)=>Center(child: Text('NO PAYMENT HISTORY',style: TextStyle(color: Colors.black),)),
        loading: ()=>ShimmerListTile()
    );
  }
}
