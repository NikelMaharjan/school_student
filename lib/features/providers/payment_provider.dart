






import 'package:eschool/features/services/fee_services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../model/crud_state.dart';

final paymentProvider = StateNotifierProvider<PaymentNotifier, CrudState>((ref) => PaymentNotifier(CrudState.empty()));



class PaymentNotifier extends StateNotifier<CrudState>{
  PaymentNotifier(super.state);




  Future<void> addFeePayment({
    required int collectedBy,
    required int totalFee,
    required String paymentAmount,
    required String paymentNote,
    required String paymentMethod,
    required String paymentDate,
    required String token,


  }) async {
    state = state.copyWith(isLoad: true, errorMessage: '', isSuccess: false);
    final response = await FeePaymentService(token).feePayment(
        collectedBy: collectedBy,
        totalFee: totalFee,
        paymentAmount: paymentAmount,
        paymentNote: paymentNote,
        paymentMethod: paymentMethod,
        paymentDate: paymentDate
    );
    response.fold((l) {
      state = state.copyWith(isLoad: false, errorMessage: l, isSuccess: false);
    }, (r) {
      state = state.copyWith(
          isLoad: false, errorMessage: '', isSuccess: true);

    });
  }




}