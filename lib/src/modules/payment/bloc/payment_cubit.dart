import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:hawihub/src/core/utils/constance_manager.dart';
import 'package:hawihub/src/modules/auth/bloc/auth_bloc.dart';
import 'package:hawihub/src/modules/payment/data/services/payment_service.dart';
import 'package:meta/meta.dart';

part 'payment_state.dart';

class PaymentCubit extends Cubit<PaymentState> {
  PaymentCubit() : super(PaymentInitial());
  static PaymentCubit? cubit;

  static PaymentCubit get() {
    cubit ??= PaymentCubit();
    return cubit!;
  }

  final PaymentService _paymentService = PaymentService();

  Future<void> joinToGame(double pendingWallet) async {
    final result = await _paymentService.joinToGame(pendingWallet);
    result.fold(
      (l) {
        emit(JoinToGameErrorState(l));
      },
      (r) {
        emit(JoinToGameSuccessState(r));
      },
    );
  }

  Future<void> addWallet({
    required double totalPrice,
    required BuildContext context,
  }) async {
    await _paymentService
        .addWallet(context: context, totalPrice: totalPrice)
        .then(
      (value) async {
        if (value.isSuccess) {
          emit(AddWalletSuccessState());
          await getBalance(value.paymentId!).then(
            (value) {
              AuthBloc bloc = AuthBloc.get(context);
              bloc.add(GetProfileEvent(ConstantsManager.userId!, "Player"));
            },
          );
        }
      },
    );
  }

  Future<void> getBalance(String key) async {
    final result = await _paymentService.getPaymentStatus(key);
    result.fold(
      (l) {
        emit(GetPaymentStatusErrorState(l));
      },
      (r) {
        emit(GetPaymentStatusSuccessState(r));
      },
    );
  }
}
