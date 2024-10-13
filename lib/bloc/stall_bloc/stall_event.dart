part of 'stall_bloc.dart';

abstract class StallEvent extends Equatable {
  const StallEvent();

  @override
  List<Object?> get props => [];
}

class LoadStalls extends StallEvent {}

class LoadSingleStall extends StallEvent {
  final int id;

  const LoadSingleStall(this.id);

  @override
  List<Object?> get props => [id];
}

class CreateStall extends StallEvent {
  final Stall stall;

  const CreateStall(this.stall);

  @override
  List<Object?> get props => [stall];
}
