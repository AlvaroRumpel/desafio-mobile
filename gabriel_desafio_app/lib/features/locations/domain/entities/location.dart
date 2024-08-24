class Location {
  final String uri;
  final String fileName;
  final VideoInfo videoInfo;
  final LocationInfo locationInfo;

  Location({
    required this.uri,
    required this.fileName,
    required this.videoInfo,
    required this.locationInfo,
  });
}

class VideoInfo {
  final String title;
  final String subtitle;
  final String description;

  VideoInfo({
    required this.title,
    required this.subtitle,
    required this.description,
  });
}

class LocationInfo {
  final String id;
  final String name;
  final Address address;

  LocationInfo({
    required this.id,
    required this.name,
    required this.address,
  });
}

class Address {
  final String city;
  final String state;
  final String address;
  final String latitude;
  final String longitude;

  Address({
    required this.city,
    required this.state,
    required this.address,
    required this.latitude,
    required this.longitude,
  });
}
