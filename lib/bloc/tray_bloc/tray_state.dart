part of 'tray_bloc.dart';

sealed class TrayState extends Equatable {
  const TrayState();
}

final class TrayInitial extends TrayState {
  @override
  List<Object> get props => [];
}
