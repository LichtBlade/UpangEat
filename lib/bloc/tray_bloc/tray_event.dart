part of 'tray_bloc.dart';

sealed class TrayEvent extends Equatable {
  const TrayEvent();

  @override
  List<Object> get props => [];
}

class LoadTray extends TrayEvent {
  final int id;
  const LoadTray(this.id);

  @override
  List<Object> get props => [id];
}
