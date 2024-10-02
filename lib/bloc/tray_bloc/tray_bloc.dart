import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'tray_event.dart';
part 'tray_state.dart';

class TrayBloc extends Bloc<TrayEvent, TrayState> {
  TrayBloc() : super(TrayInitial()) {
    on<TrayEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
