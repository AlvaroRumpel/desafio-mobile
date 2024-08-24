import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gabriel_desafio_app/features/locations/domain/entities/location.dart';
import 'package:gabriel_desafio_app/features/locations/presentation/bloc/locations_cubit.dart';
import 'package:gabriel_desafio_app/features/locations/presentation/page/locations_page.dart';
import 'package:mocktail/mocktail.dart';

class MockLocationsCubit extends MockCubit<LocationsState>
    implements LocationsCubit {}

void main() {
  late MockLocationsCubit mockLocationsCubit;

  setUp(() {
    mockLocationsCubit = MockLocationsCubit();
  });

  Widget createWidgetUnderTest() {
    return MaterialApp(
      home: BlocProvider<LocationsCubit>(
        create: (context) => mockLocationsCubit,
        child: const LocationsPage(),
      ),
    );
  }

  group('LocationsPage', () {
    testWidgets('should show CircularProgressIndicator when state is loading',
        (WidgetTester tester) async {
      // Arrange
      when(() => mockLocationsCubit.state).thenReturn(LocationsLoading());

      // Act
      await tester.pumpWidget(createWidgetUnderTest());

      // Assert
      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });

    testWidgets('should display a list of locations when state is success',
        (WidgetTester tester) async {
      // Arrange
      final location1 = Location(
        uri: 'uri',
        fileName: 'fileName',
        videoInfo: VideoInfo(title: '', subtitle: '', description: ''),
        locationInfo: LocationInfo(
          id: '',
          name: 'Location 1',
          address: Address(
            city: '',
            state: '',
            address: '',
            latitude: '',
            longitude: '',
          ),
        ),
      );
      final location2 = Location(
        uri: 'uri',
        fileName: 'fileName',
        videoInfo: VideoInfo(title: '', subtitle: '', description: ''),
        locationInfo: LocationInfo(
          id: '',
          name: 'Location 2',
          address: Address(
            city: '',
            state: '',
            address: '',
            latitude: '',
            longitude: '',
          ),
        ),
      );
      final mockLocations = [location1, location2];
      when(() => mockLocationsCubit.state)
          .thenReturn(LocationsSuccess(locations: mockLocations));

      // Act
      await tester.pumpWidget(createWidgetUnderTest());

      // Assert
      expect(find.byType(ListTile), findsNWidgets(2));
      expect(find.text('Location 1'), findsOneWidget);
      expect(find.text('Location 2'), findsOneWidget);
    });

    testWidgets('should display an error message when state is error',
        (WidgetTester tester) async {
      // Arrange
      const errorMessage = 'An error occurred';
      when(() => mockLocationsCubit.state)
          .thenReturn(const LocationsError(message: errorMessage));

      // Act
      await tester.pumpWidget(createWidgetUnderTest());

      // Assert
      expect(find.text(errorMessage), findsOneWidget);
    });

    testWidgets('should call fetchLocationList when refresh button is tapped',
        (WidgetTester tester) async {
      // Arrange
      when(() => mockLocationsCubit.state).thenReturn(LocationsLoading());
      when(() => mockLocationsCubit.fetchLocationList())
          .thenAnswer((_) async => {});
      // Act
      await tester.pumpWidget(createWidgetUnderTest());
      await tester.tap(find.byIcon(Icons.refresh_rounded));

      // Assert
      verify(() => mockLocationsCubit.fetchLocationList()).called(1);
    });
  });

  group('LocationsState', () {
    final mockLocations = [
      Location(
        uri: 'uri',
        fileName: 'fileName',
        videoInfo: VideoInfo(title: '', subtitle: '', description: ''),
        locationInfo: LocationInfo(
          id: '',
          name: 'Location 1',
          address: Address(
            city: '',
            state: '',
            address: '',
            latitude: '',
            longitude: '',
          ),
        ),
      ),
      Location(
        uri: 'uri',
        fileName: 'fileName',
        videoInfo: VideoInfo(title: '', subtitle: '', description: ''),
        locationInfo: LocationInfo(
          id: '',
          name: 'Location 2',
          address: Address(
            city: '',
            state: '',
            address: '',
            latitude: '',
            longitude: '',
          ),
        ),
      ),
    ];

    const String mockErrorMessage = 'Error occurred';

    test('LocationsInitial should be a subclass of LocationsState', () {
      expect(LocationsInitial(), isA<LocationsState>());
    });

    test('LocationsLoading should be a subclass of LocationsState', () {
      expect(LocationsLoading(), isA<LocationsState>());
    });

    test('LocationsSuccess should contain a list of locations', () {
      final successState = LocationsSuccess(locations: mockLocations);
      expect(successState.locations, mockLocations);
    });

    test('LocationsError should contain an error message', () {
      const errorState = LocationsError(message: mockErrorMessage);
      expect(errorState.message, mockErrorMessage);
    });

    test('LocationsSuccess should return the correct props', () {
      final successState = LocationsSuccess(locations: mockLocations);
      expect(successState.props, [mockLocations]);
    });

    test('LocationsError should return the correct props', () {
      const errorState = LocationsError(message: mockErrorMessage);
      expect(errorState.props, [mockErrorMessage]);
    });

    group('when method', () {
      test('should execute initial callback when LocationsInitial', () {
        final state = LocationsInitial();
        final result = state.when(
          initial: () => 'Initial',
          loading: () => 'Loading',
          success: (_) => 'Success',
          error: (_) => 'Error',
        );
        expect(result, 'Initial');
      });

      test('should execute loading callback when LocationsLoading', () {
        final state = LocationsLoading();
        final result = state.when(
          initial: () => 'Initial',
          loading: () => 'Loading',
          success: (_) => 'Success',
          error: (_) => 'Error',
        );
        expect(result, 'Loading');
      });

      test('should execute success callback when LocationsSuccess', () {
        final state = LocationsSuccess(locations: mockLocations);
        final result = state.when(
          initial: () => 'Initial',
          loading: () => 'Loading',
          success: (locations) => locations,
          error: (_) => 'Error',
        );
        expect(result, mockLocations);
      });

      test('should execute error callback when LocationsError', () {
        const state = LocationsError(message: mockErrorMessage);
        final result = state.when(
          initial: () => 'Initial',
          loading: () => 'Loading',
          success: (_) => 'Success',
          error: (message) => message,
        );
        expect(result, mockErrorMessage);
      });
    });

    group('maybeWhen method', () {
      test('should execute success callback when LocationsSuccess', () {
        final state = LocationsSuccess(locations: mockLocations);
        final result = state.maybeWhen(
          success: (locations) => locations,
          orElse: () => 'orElse',
        );
        expect(result, mockLocations);
      });

      test('should execute orElse callback when state is LocationsInitial', () {
        final state = LocationsInitial();
        final result = state.maybeWhen(
          success: (locations) => 'Success',
          orElse: () => 'orElse',
        );
        expect(result, 'orElse');
      });
    });

    group('whenOrNull method', () {
      test('should execute success callback when LocationsSuccess', () {
        final state = LocationsSuccess(locations: mockLocations);
        final result = state.whenOrNull(
          success: (locations) => locations,
        );
        expect(result, mockLocations);
      });

      test('should return null when state is LocationsInitial', () {
        final state = LocationsInitial();
        final result = state.whenOrNull(
          success: (locations) => 'Success',
        );
        expect(result, isNull);
      });
    });
  });
}
