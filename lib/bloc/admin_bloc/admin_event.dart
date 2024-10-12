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