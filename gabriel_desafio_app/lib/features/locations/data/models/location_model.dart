import 'dart:convert';

class LocationModel {
  final String uri;
  final String fileName;
  final VideoInfoModel videoInfo;
  final LocationInfoModel locationInfo;

  LocationModel({
    required this.uri,
    required this.fileName,
    required this.videoInfo,
    required this.locationInfo,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'uri': uri,
      'fileName': fileName,
      'videoInfo': videoInfo.toMap(),
      'locationInfo': locationInfo.toMap(),
    };
  }

  factory LocationModel.fromMap(Map<String, dynamic> map) {
    return LocationModel(
      uri: map['uri'] as String,
      fileName: map['fileName'] as String,
      videoInfo:
          VideoInfoModel.fromMap(map['videoInfo'] as Map<String, dynamic>),
      locationInfo: LocationInfoModel.fromMap(
        map['locationInfo'] as Map<String, dynamic>,
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory LocationModel.fromJson(String source) =>
      LocationModel.fromMap(json.decode(source) as Map<String, dynamic>);
}

class VideoInfoModel {
  final String title;
  final String subtitle;
  final String description;

  VideoInfoModel({
    required this.title,
    required this.subtitle,
    required this.description,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'title': title,
      'subtitle': subtitle,
      'description': description,
    };
  }

  factory VideoInfoModel.fromMap(Map<String, dynamic> map) {
    return VideoInfoModel(
      title: map['title'] as String,
      subtitle: map['subtitle'] as String,
      description: map['description'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory VideoInfoModel.fromJson(String source) =>
      VideoInfoModel.fromMap(json.decode(source) as Map<String, dynamic>);
}

class LocationInfoModel {
  final String id;
  final String name;
  final AddressModel address;

  LocationInfoModel({
    required this.id,
    required this.name,
    required this.address,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'address': address.toMap(),
    };
  }

  factory LocationInfoModel.fromMap(Map<String, dynamic> map) {
    return LocationInfoModel(
      id: map['id'] as String,
      name: map['name'] as String,
      address: AddressModel.fromMap(map['address'] as Map<String, dynamic>),
    );
  }

  String toJson() => json.encode(toMap());

  factory LocationInfoModel.fromJson(String source) =>
      LocationInfoModel.fromMap(json.decode(source) as Map<String, dynamic>);
}

class AddressModel {
  final String city;
  final String state;
  final String address;
  final String latitude;
  final String longitude;

  AddressModel({
    required this.city,
    required this.state,
    required this.address,
    required this.latitude,
    required this.longitude,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'city': city,
      'state': state,
      'address': address,
      'latitude': latitude,
      'longitude': longitude,
    };
  }

  factory AddressModel.fromMap(Map<String, dynamic> map) {
    return AddressModel(
      city: map['city'] as String,
      state: map['state'] as String,
      address: map['address'] as String,
      latitude: map['latitude'] as String,
      longitude: map['longitude'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory AddressModel.fromJson(String source) =>
      AddressModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
