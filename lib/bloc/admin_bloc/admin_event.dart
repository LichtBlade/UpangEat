abstract class AdminEvent {}

class CreateStallEvent extends AdminEvent {
  final String stallName;
  final String? description;
  final String ownerId;
  final String contactNo;

  CreateStallEvent({
    required this.stallName,
    this.description,
    required this.ownerId,
    required this.contactNo,
  });
}

class UpdateStallEvent extends AdminEvent {
  final int id;
  final String stallname;
  final String? description;

  UpdateStallEvent(
      {required this.id, required this.stallname, required this.description});
}

class DeleteStallEvent extends AdminEvent {
  final int id;

  DeleteStallEvent({required this.id});
}
