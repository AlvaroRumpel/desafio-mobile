import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../features/error/presentation/page/error_page.dart';
import '../../features/locations/data/data_sources/locations_data_source.dart';
import '../../features/locations/data/data_sources/locations_data_source_impl.dart';
import '../../features/locations/data/repositories/locations_repository_impl.dart';
import '../../features/locations/domain/repositories/locations_repository.dart';
import '../../features/locations/domain/usecases/locations_usecase.dart';
import '../../features/locations/presentation/bloc/locations_cubit.dart';
import '../../features/locations/presentation/page/locations_page.dart';
import '../../features/login/data/data_sources/login_data_source.dart';
import '../../features/login/data/data_sources/login_data_source_impl.dart';
import '../../features/login/data/repositories/login_repository_impl.dart';
import '../../features/login/domain/repositories/login_repository.dart';
import '../../features/login/domain/usecases/login_usecase.dart';
import '../../features/login/presentation/bloc/login_cubit.dart';
import '../../features/login/presentation/page/login_page.dart';
import '../../features/video_view/presentation/page/video_view_page.dart';
import '../shared/dtos/video_dto.dart';

part 'routes_names.dart';

class Routes {
  static MaterialPageRoute generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case LOGIN:
        return _buildRoute(
          settings,
          MultiRepositoryProvider(
            providers: _getLoginProviders(),
            child: BlocProvider(
              create: (ctx) => LoginCubit(usecase: ctx.read<LoginUsecase>()),
              child: const LoginPage(),
            ),
          ),
        );

      case LOCATIONS:
        return _buildRoute(
          settings,
          MultiRepositoryProvider(
            providers: _getLocationsProviders(),
            child: BlocProvider(
              create: (ctx) => LocationsCubit(
                usecase: ctx.read<LocationsUsecase>(),
              ),
              child: const LocationsPage(),
            ),
          ),
        );

      case VIDEO_VIEW:
        if (settings.arguments is VideoDto) {
          final video = settings.arguments as VideoDto;
          return _buildRoute(
            settings,
            VideoViewPage(video: video),
          );
        }

        return _errorRoute('Invalid arguments for VIDEO_VIEW');

      default:
        return _errorRoute('Route not found');
    }
  }

  static MaterialPageRoute _buildRoute(
    RouteSettings settings,
    Widget builder,
  ) {
    return MaterialPageRoute(
      settings: settings,
      builder: (context) => builder,
    );
  }

  static MaterialPageRoute _errorRoute(String message) {
    return MaterialPageRoute(
      builder: (_) => ErrorPage(message: message),
    );
  }

  // Providers for LOGIN route
  static List<RepositoryProvider<dynamic>> _getLoginProviders() {
    return [
      RepositoryProvider<LoginDataSource>(create: (_) => LoginDataSourceImpl()),
      RepositoryProvider<LoginRepository>(
        create: (ctx) =>
            LoginRepositoryImpl(dataSource: ctx.read<LoginDataSource>()),
      ),
      RepositoryProvider<LoginUsecase>(
        create: (ctx) => LoginUsecase(repository: ctx.read<LoginRepository>()),
      ),
    ];
  }

  // Providers for LOCATIONS route
  static List<RepositoryProvider<dynamic>> _getLocationsProviders() {
    return [
      RepositoryProvider<LocationsDataSource>(
        create: (_) => LocationsDataSourceImpl(),
      ),
      RepositoryProvider<LocationsRepository>(
        create: (ctx) => LocationsRepositoryImpl(
          dataSource: ctx.read<LocationsDataSource>(),
        ),
      ),
      RepositoryProvider<LocationsUsecase>(
        create: (ctx) => LocationsUsecase(
          repository: ctx.read<LocationsRepository>(),
        ),
      ),
    ];
  }
}
