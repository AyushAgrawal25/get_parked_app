class GooglePlaceData {
  final int id;
  final String name;
  final String address;
  final double latitude;
  final double longitude;

  GooglePlaceData({
    this.id,
    this.name,
    this.address,
    this.latitude,
    this.longitude,
  });

  GooglePlaceData copyWith(
      {int id,
      String name,
      String address,
      double latitude,
      double longitude}) {
    return GooglePlaceData(
        id: id ?? this.id,
        name: name ?? this.name,
        address: address ?? this.address,
        longitude: longitude ?? this.longitude,
        latitude: latitude ?? this.latitude);
  }
}
