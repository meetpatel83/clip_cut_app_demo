import 'dart:ui';

class PetModel {
  final String id;
  final String petName;
  final String petGender;
  final String imageUrl;
  final String matingDate;
  final String breedingPartner;
  final String pregnancy;
  final Color bgColor;

  PetModel( {
    required this.petName,
    required this.petGender,
    required this.matingDate,
    required this.breedingPartner,
    required this.pregnancy,
    required this.id,
    required this.imageUrl,
    required this.bgColor
  });
}
