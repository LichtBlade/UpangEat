part of 'wallet_bloc.dart';

sealed class WalletState extends Equatable {
  const WalletState();
  @override
  List<Object> get props => [];
}

final class WalletLoading extends WalletState {}

final class WalletBalanceLoaded extends WalletState {
  final double ethBalance;
  const WalletBalanceLoaded(this.ethBalance);

  @override
  List<Object> get props => [ethBalance];
}

final class WalletError extends WalletState {
  final String message;
  const WalletError(this.message);

  @override
  List<Object> get props => [message];
}
