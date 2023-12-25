import 'package:eschool/features/view_page/homepage_parents/overview_parents.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'login_page.dart';
import '../providers/auth_provider.dart';
import '../../features/view_page/student_page/default_page.dart';




class StatusPage extends ConsumerWidget {

  @override
  Widget build(BuildContext context, ref) {
    final auth = ref.watch(authProvider);

    if(auth.user.token.isNotEmpty){

      if(auth.user.userInfo.userType=='Student'){
        return DefaultPage();
      }
      else if(auth.user.userInfo.userType=='Parent'){
        return OverviewParents();

      }
      else{
        return LoginPage();
      }

    }
    else{
      return LoginPage();

    }




  }
}