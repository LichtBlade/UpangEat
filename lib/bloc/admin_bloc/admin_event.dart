abstract class AdminEvent {}

class CreateStallEvent extends AdminEvent {
  final String stallName;
  final String? description;

  CreateStallEvent({required this.stallName, this.description});
}