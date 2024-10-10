part of 'seller_center_bloc_bloc.dart';

sealed class SellerCenterBlocState extends Equatable {
  const SellerCenterBlocState();
  
  @override
  List<Object> get props => [];
}

final class SellerCenterBlocInitial extends SellerCenterBlocState {}
