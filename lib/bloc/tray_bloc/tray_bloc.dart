import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:upang_eat/models/food_model.dart';
import 'package:upang_eat/models/stall_model.dart';
import 'package:upang_eat/models/tray_model.dart';

import '../../repositories/tray_repository.dart';
import '../../repositories/tray_repository_impl.dart';
import '../../user_data.dart';

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
            userId: globalUserData!.userId,
            itemId: event.foodItemId,
            quantity: event.quantity);
        final stall = await _trayRepository.addToTray(newTray);
        emit(TrayAdded(stall));
      } on StallConflictException catch (e) {
        print("eyo");
        emit(TrayStallConflict(e.trayIdsToDelete));
      }catch (error) {
        print("error: $error");
        emit(TrayError(error.toString()));

      }
    });

    on<DeleteTray>((event, emit) async {
      emit(TrayLoading());
      try{
        await _trayRepository.deleteTray(event.id);
        emit(TrayItemRemoved(event.id));
      } catch (error) {
        emit(TrayError(error.toString()));
      }
    });

    on<DeleteTrayIds>((event, emit) async {
      emit(TrayLoading());
      try{
        await _trayRepository.deleteListOfTrays(event.id);

        emit(TrayItemsRemoved());


      } catch (error) {
        emit(TrayError(error.toString()));
      }
    });

    on<StallConflictDeleteTrayIds>((event, emit) async {
      emit(TrayLoading());
      try{
        await _trayRepository.deleteListOfTrays(event.id);
        emit(TrayItemsRemoved());

        final newTray = TrayModel(
            trayId: 0,
            userId: globalUserData!.userId,
            itemId: event.foodItemId,
            quantity: event.quantity);
        final stall = await _trayRepository.addToTray(newTray);
        emit(TrayAdded(stall));
      } catch (error) {
        emit(TrayError(error.toString()));
      }
    });



    on<UpdateTray>((event, emit) async {
      emit(TrayLoading());
      try{
        await _trayRepository.updateTray(event.tray,event.id);

        // Re-fetch the updated tray items
        final updatedTrayItems = await _trayRepository.fetchTrayByUserId(event.userId);
        emit(TrayLoaded(updatedTrayItems));



      } catch (error) {
        emit(TrayError(error.toString()));
      }
    });


  }
}
