part of 'tray_bloc.dart';

sealed class TrayState extends Equatable {
  const TrayState();
  @override
  List<Object> get props => [];
}

final class TrayLoading extends TrayState {}

final class TrayItemRemoved extends TrayState {
  final int id;
  const TrayItemRemoved(this.id);

  @override
  List<Object> get props => [id];
}

final class TrayLoaded extends TrayState {
  final List<TrayModel> trays;
  const TrayLoaded(this.trays);

  @override
  List<Object> get props => [trays];
}

final class TrayError extends TrayState {
  final String message;

  const TrayError(this.message);

  @override
  List<Object> get props => [message];
}
