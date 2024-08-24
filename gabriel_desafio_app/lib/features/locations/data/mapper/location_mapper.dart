import '../../domain/entities/location.dart';
import '../models/location_model.dart';

class LocationMapper {
  static LocationModel toModel(Location location) {
    return LocationModel(
      uri: location.uri,
      fileName: location.fileName,
      videoInfo: VideoInfoMapper.toModel(location.videoInfo),
      locationInfo: LocationInfoMapper.toModel(location.locationInfo),
    );
  }

  static Location toEntity(LocationModel model) {
    return Location(
      uri: model.uri,
      fileName: model.fileName,
      videoInfo: VideoInfoMapper.toEntity(model.videoInfo),
      locationInfo: LocationInfoMapper.toEntity(model.locationInfo),
    );
  }
}

class VideoInfoMapper {
  static VideoInfoModel toModel(VideoInfo videoInfo) {
    return VideoInfoModel(
      title: videoInfo.title,
      subtitle: videoInfo.subtitle,
      description: videoInfo.description,
    );
  }

  static VideoInfo toEntity(VideoInfoModel model) {
    return VideoInfo(
      title: model.title,
      subtitle: model.subtitle,
      description: model.description,
    );
  }
}

class LocationInfoMapper {
  static LocationInfoModel toModel(LocationInfo locationInfo) {
    return LocationInfoModel(
      id: locationInfo.id,
      name: locationInfo.name,
      address: AddressMapper.toModel(locationInfo.address),
    );
  }

  static LocationInfo toEntity(LocationInfoModel model) {
    return LocationInfo(
      id: model.id,
      name: model.name,
      address: AddressMapper.toEntity(model.address),
    );
  }
}

class AddressMapper {
  static AddressModel toModel(Address address) {
    return AddressModel(
      city: address.city,
      state: address.state,
      address: address.address,
      latitude: address.latitude,
      longitude: address.longitude,
    );
  }

  static Address toEntity(AddressModel model) {
    return Address(
      city: model.city,
      state: model.state,
      address: model.address,
      latitude: model.latitude,
      longitude: model.longitude,
    );
  }
}
