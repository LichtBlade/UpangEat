import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:upang_eat/models/stall_model.dart';
import 'package:upang_eat/repositories/stall_repository.dart';

part 'stall_event.dart';
part 'stall_state.dart';

class StallBloc extends Bloc<StallEvent, StallState> {
  final StallRepository _stallRepository;

  StallBloc(this._stallRepository) : super(StallLoading()) {
    on<LoadStalls>((event, emit) async {
      emit(StallLoading());
      try{
        final stalls = await _stallRepository.fetchStalls();
        emit (StallLoaded(stalls));
      } catch (e){
        emit (StallError(e.toString()));
      }
    });

    on<LoadSingleStall>((event, emit) async {
      emit(StallLoading());
      try{
        final stall = await _stallRepository.fetchStallById(event.id);
        emit (SingleStallLoaded(stall));
      } catch (e){
        emit (StallError(e.toString()));
      }
    });
  }
}
