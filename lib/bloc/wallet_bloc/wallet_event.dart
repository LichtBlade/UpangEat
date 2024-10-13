part of 'wallet_bloc.dart';

sealed class WalletEvent extends Equatable {
  const WalletEvent();

  @override
  List<Object> get props => [];
}

class LoadEthBalance extends WalletEvent{
  final double amount;
  final String accountId;
  const LoadEthBalance(this.amount, this.accountId);

  @override
  List<Object> get props => [amount, accountId];
}
