import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'seller_center_bloc_event.dart';
part 'seller_center_bloc_state.dart';

class SellerCenterBlocBloc extends Bloc<SellerCenterBlocEvent, SellerCenterBlocState> {
  SellerCenterBlocBloc() : super(SellerCenterBlocInitial()) {
    on<SellerCenterBlocEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
