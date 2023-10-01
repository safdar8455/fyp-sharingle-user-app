class PlacesJson {
  String? place_id;
  String? iconUrl;
  String? name;
  double? latitude;
  double? longitude;
  String? formattedAddress;

  PlacesJson({
    this.place_id,
    this.iconUrl,
    this.name,
    this.latitude,
    this.longitude,
    this.formattedAddress,
  });

  PlacesJson.fromJson(Map<String, dynamic> json) {
    place_id = json['place_id'];
    name = json['name'];
    latitude = json['geometry']['location']['lat'];
    longitude = json['geometry']['location']['lng'];
    formattedAddress = json['formatted_address'];
    iconUrl = json['icon'];
  }
}
