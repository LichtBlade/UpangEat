import 'package:equatable/equatable.dart';

class Stall extends Equatable {
  final int stallId;
  final String stallName;
  final int ownerId;
  final String? description;
  final int? contactNumber;
  final String? imageUrl;
  final String? imageBannerUrl;
  final bool isActive;

  const Stall({
    required this.stallId,
    required this.stallName,
    required this.ownerId,
    this.description,
    this.contactNumber,
    this.imageUrl,
    this.imageBannerUrl,
    required this.isActive,
  });

  factory Stall.fromJson(Map<String, dynamic> json){
    return Stall(
      stallId: json['stall_id'],
      stallName: json['stall_name'],
      ownerId: json['owner_id'],
      description: json['description'] ?? "No Desc",
      contactNumber: json['contact_number'] ?? 0,
      imageUrl: json['image_url'] ?? "BossSisigProfile.jpg",
      imageBannerUrl: json['image_banner_url'] ?? "BossSisigBanner.jpg",
      isActive: json['is_active'] == 1,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'stall_id' : stallId,
      'stall_name' : stallName,
      'owner_id' : ownerId,
      'description' : description,
      'contact_number' : contactNumber,
      'image_url' : imageUrl,
      'image_banner_url' : imageBannerUrl,
      'is_active' : isActive ? 1 : 0,
    };
  }


  @override
  List<Object?> get props => [stallId, stallName, ownerId, description, contactNumber, imageUrl, imageBannerUrl, isActive];
}