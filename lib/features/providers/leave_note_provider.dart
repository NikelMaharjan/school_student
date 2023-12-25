





import 'dart:io';

import 'package:eschool/features/services/student_leave_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

import '../model/crud_state.dart';
import '../services/assignment_services.dart';

final leaveNoteProvider = StateNotifierProvider<StudentLeaveNotifier, CrudState>((ref) => StudentLeaveNotifier(CrudState.empty()));



class StudentLeaveNotifier extends StateNotifier<CrudState>{
  StudentLeaveNotifier(super.state);




  Future<void> delNote({
    required int id,
    required String token,
  }) async {
    state = state.copyWith(isLoad: true, errorMessage: '', isSuccess: false);
    final response = await StudentLeaveService(token).delLeaveNote(id: id);

    response.fold((l) {
      state = state.copyWith(isLoad: false, errorMessage: l, isSuccess: false);
    }, (r) {
      state = state.copyWith(
          isLoad: false, errorMessage: '', isSuccess: true);
    });
  }


  Future<void> addNote({
    required String reason,
    required int student,
    required bool longLeave,
    required String token,
    required String startDate,
    String? endDate

  }) async {
    state = state.copyWith(isLoad: true, errorMessage: '', isSuccess: false);
    final response = await StudentLeaveService(token).addNote(
        reason: reason,
        student: student,
        longLeave: longLeave,
        startDate: startDate,
        endDate: endDate ?? null
    );
    response.fold((l) {
      state = state.copyWith(isLoad: false, errorMessage: l, isSuccess: false);
    }, (r) {
      state = state.copyWith(
          isLoad: false, errorMessage: '', isSuccess: true);

    });
  }




}