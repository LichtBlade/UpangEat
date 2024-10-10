abstract class AdminState {}

class AdminInitial extends AdminState {}

class AdminLoading extends AdminState {}

class AdminSuccess extends AdminState {}

class AdminFailure extends AdminState {
  final String error;

  AdminFailure(this.error);
}