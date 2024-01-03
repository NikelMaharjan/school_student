import 'package:eschool/constants/colors.dart';
import 'package:eschool/features/model/fee_model.dart';
import 'package:eschool/features/view_page/homepage_parents/menu_items_parents/fee_page/fee_details.dart';
import 'package:eschool/features/view_page/homepage_parents/menu_items_parents/fee_page/fee_history.dart';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';



class FeeTabs extends StatefulWidget {
  final TotalFee totalFee;
  FeeTabs({required this.totalFee});
  @override
  State<FeeTabs> createState() => _FeeTabsState();
}

class _FeeTabsState extends State<FeeTabs>
    with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    TabController _tabController = TabController(length: 2, vsync: this);
    return Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          children: [
            Container(
                height: MediaQuery.of(context).size.height * 1.2 / 5,
                width: double.infinity,
                decoration: BoxDecoration(
                    color: bgColor,
                    borderRadius:
                    const BorderRadius.vertical(bottom: Radius.circular(25))),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 20.h,
                    ),
                    Text('Fees',
                        style: TextStyle(color: Colors.white, fontSize: 25.sp)),
                    SizedBox(
                      height: 10.h,
                    ),
                    TabBar(
                        controller: _tabController,
                        padding: EdgeInsets.symmetric(
                            vertical: 15.h, horizontal: 30.w),
                        labelStyle: TextStyle(
                          fontSize: 18.sp,
                        ),
                        unselectedLabelStyle: TextStyle(
                          fontSize: 18.sp,
                        ),
                        isScrollable: false,
                        labelPadding: EdgeInsets.only(left: 15.w, right: 15.w),
                        labelColor: primary,
                        unselectedLabelColor: Colors.white,
                        // indicatorColor: primary,
                        indicator: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10)),
                        tabs: const [
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 8.0),
                            child: Tab(
                              text: 'Details',
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 8.0),
                            child: Tab(text: 'History'),
                          ),
                        ])
                  ],
                )),
            Container(
              // color: Colors.red,
                height: MediaQuery.of(context).size.height * 3.8 / 5,
                child: Padding(
                  padding:
                  EdgeInsets.symmetric(vertical: 0.h, horizontal: 15.w),
                  child: TabBarView(
                    // physics: NeverScrollableScrollPhysics(),

                    controller: _tabController,
                    children: [
                      FeeDetails(totalFee: widget.totalFee),
                      FeeHistory(totalFee: widget.totalFee),
                    ],
                  ),
                )),
          ],
        ));
  }
}
