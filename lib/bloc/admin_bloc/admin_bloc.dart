import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:upang_eat/bloc/admin_bloc/admin_event.dart';
import 'package:upang_eat/bloc/admin_bloc/admin_state.dart';
import 'package:upang_eat/repositories/stall_repository_impl.dart';

class AdminBloc extends Bloc<AdminEvent, AdminState> {
  final StallRepositoryImpl stallRepository;

  AdminBloc(this.stallRepository) : super(AdminInitial()) {
    on<CreateStallEvent>(_onCreateStall);
    on<UpdateStallEvent>(_onUpdateStall);
    on<DeleteStallEvent>(_onDeleteStall);
  }

  void _onCreateStall(CreateStallEvent event, Emitter<AdminState> emit) async {
    emit(AdminLoading());

    try {
      await stallRepository.createStall(
        stallName: event.stallName,
        ownerId: event.ownerId,
        contactNumber: event.contactNumber,
        description: event.description,
        isActive: event.isActive,
      );
      emit(AdminSuccess());
    } catch (error) {
      emit(AdminFailure(error.toString()));
    }
  }

  void _onUpdateStall(UpdateStallEvent event, Emitter<AdminState> emit) async {
    emit(AdminLoading());

    try {
      await stallRepository.updateStall(
        stallId: event.stallId,
        stallName: event.stallName,
        ownerId: event.ownerId,
        contactNumber: event.contactNumber,
        description: event.description,
        isActive: event.isActive,
      );
      emit(AdminSuccess());
    } catch (error) {
      emit(AdminFailure(error.toString()));
    }
  }

  void _onDeleteStall(DeleteStallEvent event, Emitter<AdminState> emit) async {
    emit(AdminLoading());

    try {
      await stallRepository.deleteStall(event.stallId);
      emit(AdminSuccess());
    } catch (error) {
      emit(AdminFailure(error.toString()));
    }
  }
}
