part of 'payment_cubit.dart';

@immutable
sealed class PaymentState {}

final class PaymentInitial extends PaymentState {}

final class AddWalletSuccessState extends PaymentState {}

final class JoinToGameErrorState extends PaymentState {
  final String error;

  JoinToGameErrorState(this.error);
}

final class JoinToGameSuccessState extends PaymentState {
  final String message;

  JoinToGameSuccessState(this.message);
}

final class GetPaymentStatusErrorState extends PaymentState {
  final String error;

  GetPaymentStatusErrorState(this.error);
}

final class GetPaymentStatusSuccessState extends PaymentState {
  final double dueDeposit;

  GetPaymentStatusSuccessState(this.dueDeposit);
}
