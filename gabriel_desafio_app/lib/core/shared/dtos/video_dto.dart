import '../../../features/locations/domain/entities/location.dart';

class VideoDto {
  final String uri;
  final String title;
  final String subtitle;

  VideoDto({
    required this.uri,
    required this.title,
    required this.subtitle,
  });

  factory VideoDto.fromLocation(Location location) {
    return VideoDto(
      uri: location.uri,
      title: location.videoInfo.title,
      subtitle: location.videoInfo.subtitle,
    );
  }
}
