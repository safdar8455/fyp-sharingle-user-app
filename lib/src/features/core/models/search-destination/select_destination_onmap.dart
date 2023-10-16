class SelectDestinationOnMap {
  String? placeId;
  String? placeName;
  String? placeAddress;
  double? latitude;
  double? longitude;

  SelectDestinationOnMap({
    this.placeId,
    this.placeName,
    this.placeAddress,
    this.latitude,
    this.longitude,
  });

  // Add proper JSON parsing to handle missing keys gracefully
  factory SelectDestinationOnMap.fromJson(Map<String, dynamic> json) {
    return SelectDestinationOnMap(
      placeId: json['place_id'] ?? '',
      placeName: json['address_components'][0]["long_name"] ?? '',
      placeAddress: json['formatted_address'] ?? '',
      latitude: json['geometry']['location']['lat'] ?? 0.0,
      longitude: json['geometry']['location']['lng'] ?? 0.0,
    );
  }
}
