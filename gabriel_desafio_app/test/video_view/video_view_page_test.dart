import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gabriel_desafio_app/core/shared/dtos/video_dto.dart';
import 'package:gabriel_desafio_app/features/video_view/presentation/page/video_view_page.dart';
import 'package:mocktail/mocktail.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';
import 'package:video_player/video_player.dart';
// ignore: depend_on_referenced_packages
import 'package:video_player_platform_interface/video_player_platform_interface.dart';

// Mock classes
class MockVideoPlayerController extends Mock implements VideoPlayerController {}

class MockChewieController extends Mock implements ChewieController {}

class FakeVideoPlayerPlatform extends Fake
    with MockPlatformInterfaceMixin
    implements VideoPlayerPlatform {
  @override
  Future<void> init() async {}

  @override
  Future<int> create(DataSource dataSource) async {
    return 1;
  }

  @override
  Future<void> dispose(int textureId) async {}

  @override
  Future<void> play(int textureId) async {}

  @override
  Stream<VideoEvent> videoEventsFor(int textureId) {
    return const Stream<VideoEvent>.empty();
  }
}

void main() {
  late MockVideoPlayerController mockVideoPlayerController;
  late MockChewieController mockChewieController;
  late FakeVideoPlayerPlatform fakeVideoPlayerPlatform;
  final videoDto = VideoDto(
    uri: 'https://example.com/video.mp4',
    title: 'Test Video',
    subtitle: 'Test Subtitle',
  );

  setUpAll(() {
    registerFallbackValue(
      const VideoPlayerValue(
        isInitialized: true,
        duration: Duration(seconds: 60),
        size: Size(1920, 1080),
      ),
    );

    fakeVideoPlayerPlatform = FakeVideoPlayerPlatform();
    VideoPlayerPlatform.instance = fakeVideoPlayerPlatform;
  });

  setUp(() {
    mockVideoPlayerController = MockVideoPlayerController();
    mockChewieController = MockChewieController();

    when(() => mockVideoPlayerController.initialize())
        .thenAnswer((_) async => {});

    when(() => mockVideoPlayerController.value).thenReturn(
      const VideoPlayerValue(
        isInitialized: true,
        duration: Duration(seconds: 60),
        size: Size(1920, 1080),
      ),
    );

    when(() => mockChewieController.isPlaying).thenReturn(true);
    when(() => mockChewieController.aspectRatio).thenReturn(16 / 9);
  });

  Widget createWidgetUnderTest() {
    return MaterialApp(
      home: VideoViewPage(video: videoDto),
    );
  }

  group('VideoViewPage', () {
    testWidgets('should display video title and subtitle correctly',
        (WidgetTester tester) async {
      // Act
      await tester.pumpWidget(createWidgetUnderTest());

      // Assert
      expect(find.text('Test Video'), findsOneWidget);
      expect(find.text('Test Subtitle'), findsOneWidget);
    });

    testWidgets(
        'should display CircularProgressIndicator when video is not initialized',
        (WidgetTester tester) async {
      // Arrange
      when(() => mockVideoPlayerController.value).thenReturn(
        const VideoPlayerValue.uninitialized(),
      );

      // Act
      await tester.pumpWidget(createWidgetUnderTest());

      // Assert
      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });

    testWidgets('should pop from the navigator when back button is pressed',
        (WidgetTester tester) async {
      // Act
      await tester.pumpWidget(createWidgetUnderTest());
      await tester.tap(find.byIcon(Icons.arrow_back_ios_rounded));
      await tester.pumpAndSettle();

      // Assert
      expect(find.byType(VideoViewPage), findsNothing);
    });
  });
}

class FakeVideoPlayer extends VideoPlayerValue {
  const FakeVideoPlayer.uninitialized() : super.uninitialized();
}
