import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:upang_eat/models/food_model.dart';
import 'package:upang_eat/models/tray_model.dart';

import '../../repositories/tray_repository.dart';

part 'tray_event.dart';
part 'tray_state.dart';

class TrayBloc extends Bloc<TrayEvent, TrayState> {
  final TrayRepository _trayRepository;
  TrayBloc(this._trayRepository) : super(TrayLoading()) {
    on<LoadTray>((event, emit) async {
      emit(TrayLoading());
      try{
        final trays = await _trayRepository.fetchTrayByUserId(event.id);
        emit(TrayLoaded(trays));
      } catch (error) {
        emit(TrayError(error.toString()));

      }
    });

    on<CreateTray>((event, emit) async {
      emit(TrayLoading());
      try{

        final newTray = TrayModel(
            trayId: 0,
            userId: 1, // TODO change to logged in user ID
            itemId: event.foodItemId,
            quantity: event.quantity);
        await _trayRepository.addToTray(newTray);
      } catch (error) {
        emit(TrayError(error.toString()));

      }
    });

    on<DeleteTray>((event, emit) async {
      emit(TrayLoading());
      try{
        await _trayRepository.deleteTray(event.id);
        // emit(TrayItemRemoved(event.id));

        // // Add a delay of 1 second
        // await Future.delayed(const Duration(seconds: 1));
        //
        // // Refresh the tray items
        // final updatedTrayItems = await _trayRepository.fetchTrayByUserId(1); // TODO: Replace with actual user ID
        // emit(TrayLoaded(updatedTrayItems));
      } catch (error) {
        emit(TrayError(error.toString()));
      }
    });

    on<UpdateTray>((event, emit) async {
      emit(TrayLoading());
      try{
        await _trayRepository.updateTray(event.tray,event.id);

      } catch (error) {
        emit(TrayError(error.toString()));
      }
    });


  }
}
