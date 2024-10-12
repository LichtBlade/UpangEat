import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:upang_eat/repositories/admin_repository_impl.dart';
import 'package:upang_eat/bloc/admin_bloc/admin_event.dart';
import 'package:upang_eat/bloc/admin_bloc/admin_state.dart';

class AdminBloc extends Bloc<AdminEvent, AdminState> {
  final AdminRepositoryImpl adminRepository;

  AdminBloc(this.adminRepository) : super(AdminInitial()) {
    on<CreateStallEvent>(_onCreateStall);
  }

  Future<void> _onCreateStall(
    CreateStallEvent event,
    Emitter<AdminState> emit,
  ) async {
    emit(AdminLoading());
    try {
      await adminRepository.createStall(
        stallName: event.stallName,
        description: event.description,
        ownerId: event.ownerId, 
        contactNo: event.contactNo, 
      );
      emit(AdminSuccess());
    } catch (e) {
      emit(AdminFailure(e.toString()));
    }
  }
}
