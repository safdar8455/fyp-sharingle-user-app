class SaveLocationModel {
  final String placeId;
  final String placeName;
  final String? addPlaceName;
  final String? addPlaceDetails;
  final String placeAddress;
  final String latitude;
  final String longitude;

  SaveLocationModel({
    required this.placeId,
    required this.placeName,
    this.addPlaceName,
    this.addPlaceDetails,
    required this.placeAddress,
    required this.latitude,
    required this.longitude,
  });
}
