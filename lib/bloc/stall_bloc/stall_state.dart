part of 'stall_bloc.dart';

sealed class StallState extends Equatable {
  const StallState();

  @override
  List<Object> get props => [];
}


class StallLoading extends StallState {}

class StallLoaded extends StallState {
  final List<Stall> stalls;

  const StallLoaded(this.stalls);
  @override
  List<Object> get props => [stalls];
}

class SingleStallLoaded extends StallState {
  final Stall stall;

  const SingleStallLoaded(this.stall);
  @override
  List<Object> get props => [stall];
}

class StallError extends StallState {
  final String message;

  const StallError(this.message);

  @override
  List<Object> get props => [message];
}



