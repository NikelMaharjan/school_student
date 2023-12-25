







import 'package:eschool/features/services/notification_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../model/crud_state.dart';
import '../services/notification_service.dart';

final notificationUpdater = StateNotifierProvider<NotificationNotifier, CrudState>((ref) => NotificationNotifier(CrudState.empty()));



class NotificationNotifier extends StateNotifier<CrudState>{
  NotificationNotifier(super.state);




  Future<void> updateSeen({
    required int id,
    required String token,
  }) async {
    state = state.copyWith(isLoad: true, errorMessage: '', isSuccess: false);
    final response = await NotificationService(token).updateNotification(id: id);

    response.fold((l) {
      state = state.copyWith(isLoad: false, errorMessage: l, isSuccess: false);
    }, (r) {
      state = state.copyWith(
          isLoad: false, errorMessage: '', isSuccess: true);
    });
  }






}