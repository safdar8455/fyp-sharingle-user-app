class NearbySearchResult {
  String? placeId;
  String? iconUrl;
  String? name;
  double? latitude;
  double? longitude;
  String? vicinity;

  NearbySearchResult({
    this.placeId,
    this.iconUrl,
    this.name,
    this.latitude,
    this.longitude,
    this.vicinity,
  });

  NearbySearchResult.fromJson(Map<String, dynamic> json) {
    placeId = json['place_id'];
    name = json['name'];
    latitude = json['geometry']['location']['lat'];
    longitude = json['geometry']['location']['lng'];
    vicinity = json['vicinity'];
    iconUrl = json['icon'];
  }
}
