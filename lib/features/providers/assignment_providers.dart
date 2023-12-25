





import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

import '../model/crud_state.dart';
import '../services/assignment_services.dart';

final assignmentProvider = StateNotifierProvider<AssignmentNotifier, CrudState>((ref) => AssignmentNotifier(CrudState.empty()));



class AssignmentNotifier extends StateNotifier<CrudState>{
  AssignmentNotifier(super.state);




  Future<void> delStudentAssignment({
    required int id,
   required String token,
  }) async {
    state = state.copyWith(isLoad: true, errorMessage: '', isSuccess: false);
    final response = await StudentAssignmentService(token).delStudentAssignment(id: id);

    response.fold((l) {
      state = state.copyWith(isLoad: false, errorMessage: l, isSuccess: false);
    }, (r) {
      state = state.copyWith(
          isLoad: false, errorMessage: '', isSuccess: true);
    });
  }


  Future<void> addStudentAssignment({
    required File student_assignment,
    required int student,
    required int assignment,
    required String token

  }) async {
    state = state.copyWith(isLoad: true, errorMessage: '', isSuccess: false);
    final response = await StudentAssignmentService(token).addStudentAssignment(
        assignment: assignment,
        student: student,
        student_assignment: student_assignment
    );
    response.fold((l) {
      state = state.copyWith(isLoad: false, errorMessage: l, isSuccess: false);
    }, (r) {
      state = state.copyWith(
          isLoad: false, errorMessage: '', isSuccess: true);

    });
  }




}