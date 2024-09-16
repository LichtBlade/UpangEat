part of 'stall_bloc.dart';

abstract class StallState extends Equatable {
  const StallState();
}

class StallInitial extends StallState {
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}

class StallLoading extends StallState {
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}

class StallLoaded extends StallState {
  final List<Stall> stalls;

  const StallLoaded(this.stalls);
  @override
  List<Object?> get props => [stalls];
}

class StallError extends StallState {
  final String message;

  const StallError(this.message);

  @override
  List<Object?> get props => [message];
}



