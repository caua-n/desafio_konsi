class CoordinatesModel {
  double latitude;
  double longitude;

  CoordinatesModel({
    required this.latitude,
    required this.longitude,
  });

  factory CoordinatesModel.empty() {
    return CoordinatesModel(latitude: 0.0, longitude: 0.0);
  }

  void setLatitude(double newLatitude) {
    latitude = newLatitude;
  }

  void setLongitude(double newLongitude) {
    longitude = newLongitude;
  }
}
