import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/routes/routes.dart';
import '../../../../core/shared/dtos/video_dto.dart';
import '../../../../core/theme/custom_theme.dart';
import '../../../../core/utils/mixins/mixin.dart';
import '../bloc/locations_cubit.dart';

class LocationsPage extends StatelessWidget with MessageMixin {
  const LocationsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Locais'),
        actions: [
          IconButton(
            onPressed: context.read<LocationsCubit>().fetchLocationList,
            icon: const Icon(Icons.refresh_rounded),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        child: BlocConsumer<LocationsCubit, LocationsState>(
          listenWhen: (previous, current) => current is LocationsError,
          listener: (context, state) {
            state.whenOrNull(error: (message) => showError(context, message));
          },
          builder: (context, state) {
            return state.maybeWhen(
              success: (locations) => CustomScrollView(
                slivers: [
                  SliverList.separated(
                    itemCount: locations.length,
                    itemBuilder: (context, index) {
                      final loc = locations[index];
                      return ListTile(
                        onTap: () {
                          Navigator.pushNamed(
                            context,
                            VIDEO_VIEW,
                            arguments: VideoDto.fromLocation(loc),
                          );
                        },
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4),
                        ),
                        contentPadding: const EdgeInsets.all(4),
                        dense: true,
                        trailing: const Column(
                          children: [
                            Icon(
                              Icons.arrow_forward_ios,
                              size: 16,
                              color: ThemeColors.secondary,
                            ),
                          ],
                        ),
                        title: Text(
                          loc.locationInfo.name,
                          style:
                              Theme.of(context).textTheme.bodyLarge?.copyWith(
                                    color: ThemeColors.primary,
                                    fontWeight: FontWeight.bold,
                                  ),
                        ),
                        subtitle: Text(
                          loc.locationInfo.address.address,
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                      );
                    },
                    separatorBuilder: (_, __) => const Divider(height: 16),
                  ),
                ],
              ),
              error: (message) => Center(
                child: Text(
                  message,
                  textAlign: TextAlign.center,
                ),
              ),
              orElse: () => const Center(
                child: CircularProgressIndicator(),
              ),
            );
          },
        ),
      ),
    );
  }
}
