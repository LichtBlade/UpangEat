abstract class AdminEvent {}

class CreateStallEvent extends AdminEvent {
  final String stallName;
  final int ownerId;
  final int contactNumber;
  final String description;
  final bool isActive;

  CreateStallEvent({
    required this.stallName,
    required this.ownerId,
    required this.contactNumber,
    required this.description,
    required this.isActive,
  });
}

class UpdateStallEvent extends AdminEvent {
  final int stallId;
  final String stallName;
  final int ownerId;
  final int contactNumber;
  final String description;
  final bool isActive;

  UpdateStallEvent({
    required this.stallId,
    required this.stallName,
    required this.ownerId,
    required this.contactNumber,
    required this.description,
    required this.isActive,
  });
}

class DeleteStallEvent extends AdminEvent {
  final int stallId;

  DeleteStallEvent({required this.stallId});
}