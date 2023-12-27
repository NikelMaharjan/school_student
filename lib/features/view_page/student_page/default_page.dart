
import 'package:eschool/exceptions/internet_exceptions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:eschool/constants/colors.dart';
import 'package:icon_decoration/icon_decoration.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import '../../services/notification_service.dart';
import 'assignments_tabs/assignment_overview.dart';
import 'menu_sheet.dart';
import 'overview_page.dart';

class DefaultPage extends StatefulWidget {

  @override
  State<DefaultPage> createState() => _DefaultPageState();
}

class _DefaultPageState extends State<DefaultPage> with TickerProviderStateMixin{

  int _index = 0;
  double boxX= 0;
  double boxY= 2;

  final List<Widget>  _pages = [
    OverviewPage(),
    AssignmentOverview(),
    MenuPage()
  ];

  @override
  void initState() {
    super.initState();
    // Rebuild the screen after 3s which will process the animation from green to blue
    Future.delayed(Duration(milliseconds: 300)).then((value) => setState(() {
      boxX = 0;
      boxY = 0.9;
    }));

  }






  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: ()=> _onBackPressed(context).then((value) => value?? false),
      child: ConnectivityChecker(
        child: Scaffold(
          backgroundColor: Colors.white,
          body: Stack(
            children: [

              _pages.elementAt(_index),

              AnimatedContainer(
                alignment: Alignment(boxX, boxY),
                curve: Curves.bounceIn,
                duration: Duration(milliseconds:500),
                child: Card(
                  elevation: 5,
                  color: Colors.white,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: SizedBox(
                      width: 350.w,
                      height: 70.h,
                      child: Theme(
                        data: Theme.of(context).copyWith(
                            canvasColor: Colors.white
                        ),
                        child: BottomNavigationBar(

                            backgroundColor: Colors.white,
                            selectedItemColor: pre_color,
                            unselectedItemColor: Colors.grey,
                            showSelectedLabels: true,
                            showUnselectedLabels: true,
                            onTap:(int index){
                              if(index == 2) {
                                showModalBottomSheet<void>(
                                  isScrollControlled: true,
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(40)
                                    ),
                                    backgroundColor: Colors.red,

                                    context: context,
                                    builder: (BuildContext context) {
                                      return SizedBox(

                                          height: MediaQuery.of(context).copyWith().size.height * 0.7 ,
                                          child: MenuPage()
                                      );
                                    });
                              }
                              else{
                                setState(() {
                                  _index=index;
                                });
                              }
                            },
                            currentIndex: _index,
                            items:[

                              BottomNavigationBarItem(icon: DecoratedIcon(
                                icon: Icon(EvaIcons.home,size: 27.sp,),
                                decoration: IconDecoration(border: IconBorder(
                                    width: 0.1.w
                                )),
                              ),label:'Home'),
                              BottomNavigationBarItem(
                                icon: DecoratedIcon(
                                icon: Icon(EvaIcons.book,size: 27.sp,),
                                decoration: IconDecoration(border: IconBorder(
                                    width: 1.w
                                )),),label:'Subjects',),
                              BottomNavigationBarItem(icon: DecoratedIcon(
                                icon: Icon(EvaIcons.menu,size: 27.sp,),
                                decoration: IconDecoration(border: IconBorder(
                                    width: 1.w
                                )),),label:'Menu'),
                            ]

                        ),
                      ),
                    ),
                  ),
                ) ,
              ),


            ],
          ),
        ),
      ),
    );
  }
}

Future<bool> _onBackPressed(BuildContext context) async {

  return (await showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        backgroundColor: Colors.white,

        title: Center(child: Text('Do you want to logout?',style: TextStyle(color: Colors.black),)),
        actionsAlignment: MainAxisAlignment.center,
        actions: <Widget>[
          new TextButton(
            style: TextButton.styleFrom(
                backgroundColor: primary,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)
                )
            ),
            child: Text("Yes"),
            onPressed: () => Navigator.of(context).pop(true),
          ),
          new TextButton(
            style: TextButton.styleFrom(
                backgroundColor: Colors.white,
                foregroundColor: Colors.black,
                shape: RoundedRectangleBorder(
                    side:BorderSide(
                        color: Colors.grey
                    ),
                    borderRadius: BorderRadius.circular(10)
                )
            ),
            child: Text("No"),
            onPressed: () => Navigator.pop(context),
          ),

        ],
      );
    },




  )) ?? false ;

}
