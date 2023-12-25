



import 'package:eschool/constants/colors.dart';
import 'package:eschool/constants/snackshow.dart';
import 'package:eschool/features/providers/payment_provider.dart';
import 'package:eschool/features/services/fee_services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

import '../../../../model/fee_model.dart';

class FeeDetails extends ConsumerWidget {
  final TotalFee totalFee;
  FeeDetails({required this.totalFee});

  @override
  Widget build(BuildContext context,ref) {

    print(totalFee.id);
    final studentFee = ref.watch(studentFeeProvider(totalFee.id));


    return studentFee.when(
        data: (data){
          final fee_data = data.where((element) => element.studentTotalFee?.id==totalFee.id).toList();
          print(fee_data.length);
          return  Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 5.h,),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: Colors.black
                  )
                ),
                child: ListTile(
                  title: Row(
                    children: [
                      Text('Remaining: ',style: TextStyle(fontSize: 15.sp,fontWeight: FontWeight.bold,color: Colors.black),),
                      Text('${totalFee.remainingFee} /-',style: TextStyle(fontSize: 20.sp,fontWeight: FontWeight.bold,color: Colors.black),),
                    ],
                  ),
                  subtitle: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Status: ${totalFee.status}',style: TextStyle(color: totalFee.status =='Paid'? pre_color:abs_color,fontSize: 12.sp),),
                      Text('Due Date: ${DateFormat('yyyy-MM-dd').format(totalFee.dueDate!)}',style: TextStyle(color: Colors.black,fontSize: 12.sp),),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 10.h,
              ),
              Text('Details:',style: TextStyle(color: Colors.black,fontSize: 18.sp,fontWeight: FontWeight.bold),),
              Divider(
                thickness: 1,

                color: Colors.black,
              ),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.black
                  )
                ),
                padding: EdgeInsets.symmetric(horizontal: 8.w,vertical: 8.h),
                child: Table(

                  children: [
                    TableRow(

                      decoration: UnderlineTabIndicator(
                          borderSide: BorderSide(
                              color: Colors.black
                          )
                      ),
                      children: [
                        TableCell(child: Text('Description', style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black,fontSize: 15.sp))),
                        TableCell(child: Text('Amount', style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black,fontSize: 15.sp))),
                      ],
                    ),
                    for (var i = 0; i < fee_data.length; i++)
                      TableRow(
                        decoration: UnderlineTabIndicator(
                            borderSide: BorderSide(
                                color: Colors.black
                            )
                        ),
                        children: [
                          TableCell(child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(fee_data[i].feeTitle!,style: TextStyle(color: Colors.black,fontSize: 15.sp),),
                              SizedBox(height: 5.h,)
                            ],
                          )),
                          TableCell(child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(fee_data[i].feeAmount!,style: TextStyle(color: Colors.black,fontSize: 15.sp),),
                              SizedBox(height: 5.h,)
                            ],
                          )),
                        ],
                      ),


                    TableRow(
                      decoration: UnderlineTabIndicator(
                          borderSide: BorderSide(
                              color: Colors.black
                          )
                      ),
                      children: [
                        TableCell(child: Text('Total Amount', style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black,fontSize: 15.sp))),
                        TableCell(child: Text('${fee_data.map((e) => double.parse(e.feeAmount!)).reduce((a, b) => a + b)}', style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black,fontSize: 15.sp))),
                      ],
                    ),
                    TableRow(
                      decoration: UnderlineTabIndicator(
                          borderSide: BorderSide(
                              color: Colors.black
                          )
                      ),
                      children: [
                        TableCell(child: Text('Discount Amount', style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black,fontSize: 15.sp))),
                        TableCell(child: Text(totalFee.discountProvided==true?'${totalFee.discount}/-':'-', style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black,fontSize: 15.sp))),
                      ],
                    ),
                    TableRow(

                      children: [
                        TableCell(child: Text('Total Fee', style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black,fontSize: 15.sp))),
                        TableCell(child: Text('${totalFee.totalFee}/-', style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black,fontSize: 15.sp))),
                      ],
                    ),
                  ],
                ),
              ),
              // if(totalFee.status != 'Paid')
              // Center(
              //   child: Padding(
              //     padding: EdgeInsets.symmetric(
              //         vertical: 8.h, horizontal: 8.w),
              //     child: TextButton(
              //       style: TextButton.styleFrom(
              //           backgroundColor: primary,
              //           foregroundColor: Colors.white,
              //           fixedSize: Size.fromWidth(320.w),
              //           shape: RoundedRectangleBorder(
              //               borderRadius:
              //               BorderRadius.circular(10),
              //               side: BorderSide(
              //                 color: Colors.black,
              //               ))),
              //       onPressed: (){
              //
              //         return SnackShow.showSuccess(context, 'Coming Soon...');
              //
              //         // ref.watch(paymentProvider.notifier).addFeePayment(
              //         //     collectedBy: collectedBy,
              //         //     totalFee: totalFee,
              //         //     paymentAmount: paymentAmount,
              //         //     paymentNote: paymentNote,
              //         //     paymentMethod: paymentMethod,
              //         //     paymentDate: paymentDate,
              //         //     token: token
              //         // );
              //
              //       },
              //       child:  Padding(
              //         padding: EdgeInsets.symmetric(
              //             vertical: 5.h, horizontal: 8.w),
              //         child: Text(
              //           'PAY NOW',
              //           style: TextStyle(
              //             fontSize: 18.sp,
              //           ),
              //         ),
              //       ),
              //     ),
              //   ),
              // ),
            ],
          );
        },
        error:  (err, stack) => Center(child: Text('$err')),
        loading: () => Center(child: CircularProgressIndicator())
    );
  }
}
