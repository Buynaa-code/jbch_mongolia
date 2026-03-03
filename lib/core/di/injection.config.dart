// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:connectivity_plus/connectivity_plus.dart' as _i3;
import 'package:flutter_secure_storage/flutter_secure_storage.dart' as _i4;
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;
import 'package:shared_preferences/shared_preferences.dart' as _i50;

import '../../features/auth/data/datasources/auth_remote_data_source.dart'
    as _i9;
import '../../features/auth/data/repositories/auth_repository_impl.dart'
    as _i11;
import '../../features/auth/domain/repositories/auth_repository.dart' as _i10;
import '../../features/auth/domain/usecases/get_current_user_usecase.dart'
    as _i12;
import '../../features/auth/domain/usecases/login_usecase.dart' as _i13;
import '../../features/auth/domain/usecases/logout_usecase.dart' as _i14;
import '../../features/auth/domain/usecases/register_usecase.dart' as _i15;
import '../../features/auth/presentation/cubit/auth_cubit.dart' as _i16;
import '../../features/events/data/datasources/events_remote_data_source.dart'
    as _i17;
import '../../features/events/data/repositories/events_repository_impl.dart'
    as _i19;
import '../../features/events/domain/repositories/events_repository.dart'
    as _i18;
import '../../features/events/domain/usecases/get_events.dart' as _i20;
import '../../features/events/domain/usecases/get_upcoming_events.dart' as _i21;
import '../../features/events/domain/usecases/register_for_event.dart' as _i22;
import '../../features/events/presentation/cubit/events_cubit.dart' as _i23;
import '../../features/home/data/datasources/home_remote_data_source.dart'
    as _i32;
import '../../features/home/data/repositories/home_repository_impl.dart'
    as _i34;
import '../../features/home/domain/repositories/home_repository.dart' as _i33;
import '../../features/home/domain/usecases/get_home_data.dart' as _i35;
import '../../features/home/presentation/cubit/home_cubit.dart' as _i36;
import '../../features/library/data/datasources/library_remote_data_source.dart'
    as _i24;
import '../../features/library/data/repositories/library_repository_impl.dart'
    as _i26;
import '../../features/library/domain/repositories/library_repository.dart'
    as _i25;
import '../../features/library/domain/usecases/get_sermons.dart' as _i27;
import '../../features/library/domain/usecases/get_songs.dart' as _i28;
import '../../features/library/domain/usecases/get_verses.dart' as _i29;
import '../../features/library/domain/usecases/toggle_favorite.dart' as _i30;
import '../../features/library/presentation/cubit/library_cubit.dart' as _i31;
import '../../features/profile/data/datasources/profile_local_data_source.dart'
    as _i40;
import '../../features/profile/data/datasources/profile_remote_data_source.dart'
    as _i41;
import '../../features/profile/data/repositories/profile_repository_impl.dart'
    as _i43;
import '../../features/profile/domain/repositories/profile_repository.dart'
    as _i42;
import '../../features/profile/domain/usecases/get_favorites.dart' as _i44;
import '../../features/profile/domain/usecases/get_profile.dart' as _i45;
import '../../features/profile/domain/usecases/settings_usecases.dart' as _i46;
import '../../features/profile/domain/usecases/update_profile.dart' as _i47;
import '../../features/profile/presentation/cubit/profile_cubit.dart' as _i48;
import '../network/dio_client.dart' as _i6;
import '../network/network_info.dart' as _i5;
import '../network/token_storage.dart' as _i7;
import 'injection.dart' as _i8;

extension GetItInjectableX on _i1.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  Future<_i1.GetIt> init({
    String? environment,
    _i2.EnvironmentFilter? environmentFilter,
  }) async {
    final gh = _i2.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    final registerModule = _$RegisterModule();

    // Third-party dependencies
    gh.lazySingleton<_i3.Connectivity>(() => registerModule.connectivity);
    gh.lazySingleton<_i4.FlutterSecureStorage>(
        () => registerModule.secureStorage);

    // SharedPreferences - async registration
    final sharedPreferences = await _i50.SharedPreferences.getInstance();
    gh.lazySingleton<_i50.SharedPreferences>(() => sharedPreferences);

    // Core - Network
    gh.lazySingleton<_i5.NetworkInfo>(
        () => _i5.NetworkInfoImpl(gh<_i3.Connectivity>()));
    gh.lazySingleton<_i7.TokenStorage>(
        () => _i7.TokenStorage(gh<_i4.FlutterSecureStorage>()));
    gh.lazySingleton<_i6.DioClient>(
        () => _i6.DioClient(gh<_i7.TokenStorage>()));

    // Auth - Data Sources
    gh.lazySingleton<_i9.AuthRemoteDataSource>(() =>
        _i9.AuthRemoteDataSourceImpl(
            gh<_i6.DioClient>(), gh<_i7.TokenStorage>()));

    // Auth - Repositories
    gh.lazySingleton<_i10.AuthRepository>(() => _i11.AuthRepositoryImpl(
          gh<_i9.AuthRemoteDataSource>(),
          gh<_i5.NetworkInfo>(),
          gh<_i7.TokenStorage>(),
        ));

    // Auth - Use Cases
    gh.lazySingleton<_i12.GetCurrentUserUseCase>(
        () => _i12.GetCurrentUserUseCase(gh<_i10.AuthRepository>()));
    gh.lazySingleton<_i13.LoginUseCase>(
        () => _i13.LoginUseCase(gh<_i10.AuthRepository>()));
    gh.lazySingleton<_i14.LogoutUseCase>(
        () => _i14.LogoutUseCase(gh<_i10.AuthRepository>()));
    gh.lazySingleton<_i15.RegisterUseCase>(
        () => _i15.RegisterUseCase(gh<_i10.AuthRepository>()));

    // Auth - Cubit
    gh.factory<_i16.AuthCubit>(() => _i16.AuthCubit(
          gh<_i13.LoginUseCase>(),
          gh<_i15.RegisterUseCase>(),
          gh<_i14.LogoutUseCase>(),
          gh<_i12.GetCurrentUserUseCase>(),
          gh<_i10.AuthRepository>(),
        ));

    // Events - Data Sources
    gh.lazySingleton<_i17.EventsRemoteDataSource>(
        () => _i17.EventsRemoteDataSourceImpl(gh<_i6.DioClient>()));

    // Events - Repositories
    gh.lazySingleton<_i18.EventsRepository>(() => _i19.EventsRepositoryImpl(
          gh<_i17.EventsRemoteDataSource>(),
          gh<_i5.NetworkInfo>(),
        ));

    // Events - Use Cases
    gh.lazySingleton<_i20.GetEventsUseCase>(
        () => _i20.GetEventsUseCase(gh<_i18.EventsRepository>()));
    gh.lazySingleton<_i21.GetUpcomingEventsUseCase>(
        () => _i21.GetUpcomingEventsUseCase(gh<_i18.EventsRepository>()));
    gh.lazySingleton<_i22.RegisterForEventUseCase>(
        () => _i22.RegisterForEventUseCase(gh<_i18.EventsRepository>()));

    // Events - Cubit
    gh.factory<_i23.EventsCubit>(() => _i23.EventsCubit(
          gh<_i20.GetEventsUseCase>(),
          gh<_i21.GetUpcomingEventsUseCase>(),
          gh<_i22.RegisterForEventUseCase>(),
        ));

    // Library - Data Sources
    gh.lazySingleton<_i24.LibraryRemoteDataSource>(
        () => _i24.LibraryRemoteDataSourceImpl(gh<_i6.DioClient>()));

    // Library - Repositories
    gh.lazySingleton<_i25.LibraryRepository>(() => _i26.LibraryRepositoryImpl(
          gh<_i24.LibraryRemoteDataSource>(),
          gh<_i5.NetworkInfo>(),
        ));

    // Library - Use Cases
    gh.lazySingleton<_i27.GetSermonsUseCase>(
        () => _i27.GetSermonsUseCase(gh<_i25.LibraryRepository>()));
    gh.lazySingleton<_i27.GetRecentSermonsUseCase>(
        () => _i27.GetRecentSermonsUseCase(gh<_i25.LibraryRepository>()));
    gh.lazySingleton<_i28.GetSongsUseCase>(
        () => _i28.GetSongsUseCase(gh<_i25.LibraryRepository>()));
    gh.lazySingleton<_i29.GetVersesUseCase>(
        () => _i29.GetVersesUseCase(gh<_i25.LibraryRepository>()));
    gh.lazySingleton<_i29.GetVerseOfWeekUseCase>(
        () => _i29.GetVerseOfWeekUseCase(gh<_i25.LibraryRepository>()));
    gh.lazySingleton<_i30.ToggleSongFavoriteUseCase>(
        () => _i30.ToggleSongFavoriteUseCase(gh<_i25.LibraryRepository>()));
    gh.lazySingleton<_i30.ToggleVerseFavoriteUseCase>(
        () => _i30.ToggleVerseFavoriteUseCase(gh<_i25.LibraryRepository>()));
    gh.lazySingleton<_i30.ToggleSermonFavoriteUseCase>(
        () => _i30.ToggleSermonFavoriteUseCase(gh<_i25.LibraryRepository>()));

    // Library - Cubit
    gh.factory<_i31.LibraryCubit>(() => _i31.LibraryCubit(
          gh<_i28.GetSongsUseCase>(),
          gh<_i29.GetVersesUseCase>(),
          gh<_i27.GetSermonsUseCase>(),
          gh<_i30.ToggleSongFavoriteUseCase>(),
          gh<_i30.ToggleVerseFavoriteUseCase>(),
          gh<_i30.ToggleSermonFavoriteUseCase>(),
        ));

    // Home - Data Sources
    gh.lazySingleton<_i32.HomeRemoteDataSource>(
        () => _i32.HomeRemoteDataSourceImpl(gh<_i6.DioClient>()));

    // Home - Repositories
    gh.lazySingleton<_i33.HomeRepository>(() => _i34.HomeRepositoryImpl(
          gh<_i32.HomeRemoteDataSource>(),
          gh<_i5.NetworkInfo>(),
        ));

    // Home - Use Cases
    gh.lazySingleton<_i35.GetUpcomingSeminarsUseCase>(
        () => _i35.GetUpcomingSeminarsUseCase(gh<_i33.HomeRepository>()));
    gh.lazySingleton<_i35.GetWeeklyProgramUseCase>(
        () => _i35.GetWeeklyProgramUseCase(gh<_i33.HomeRepository>()));
    gh.lazySingleton<_i35.GetMemoryVerseUseCase>(
        () => _i35.GetMemoryVerseUseCase(gh<_i33.HomeRepository>()));
    gh.lazySingleton<_i35.GetFeaturedSongsUseCase>(
        () => _i35.GetFeaturedSongsUseCase(gh<_i33.HomeRepository>()));

    // Home - Cubit
    gh.factory<_i36.HomeCubit>(() => _i36.HomeCubit(
          gh<_i35.GetUpcomingSeminarsUseCase>(),
          gh<_i35.GetWeeklyProgramUseCase>(),
          gh<_i35.GetMemoryVerseUseCase>(),
          gh<_i35.GetFeaturedSongsUseCase>(),
        ));

    // Profile - Data Sources
    gh.lazySingleton<_i40.ProfileLocalDataSource>(
        () => _i40.ProfileLocalDataSourceImpl(gh<_i50.SharedPreferences>()));
    gh.lazySingleton<_i41.ProfileRemoteDataSource>(
        () => _i41.ProfileRemoteDataSourceImpl(gh<_i6.DioClient>()));

    // Profile - Repositories
    gh.lazySingleton<_i42.ProfileRepository>(() => _i43.ProfileRepositoryImpl(
          gh<_i41.ProfileRemoteDataSource>(),
          gh<_i40.ProfileLocalDataSource>(),
          gh<_i5.NetworkInfo>(),
          gh<_i7.TokenStorage>(),
        ));

    // Profile - Use Cases
    gh.lazySingleton<_i44.GetFavoriteSongsUseCase>(
        () => _i44.GetFavoriteSongsUseCase(gh<_i42.ProfileRepository>()));
    gh.lazySingleton<_i44.GetFavoriteVersesUseCase>(
        () => _i44.GetFavoriteVersesUseCase(gh<_i42.ProfileRepository>()));
    gh.lazySingleton<_i45.GetProfileUseCase>(
        () => _i45.GetProfileUseCase(gh<_i42.ProfileRepository>()));
    gh.lazySingleton<_i46.GetThemeModeUseCase>(
        () => _i46.GetThemeModeUseCase(gh<_i42.ProfileRepository>()));
    gh.lazySingleton<_i46.SetThemeModeUseCase>(
        () => _i46.SetThemeModeUseCase(gh<_i42.ProfileRepository>()));
    gh.lazySingleton<_i46.GetNotificationsEnabledUseCase>(
        () => _i46.GetNotificationsEnabledUseCase(gh<_i42.ProfileRepository>()));
    gh.lazySingleton<_i46.SetNotificationsEnabledUseCase>(
        () => _i46.SetNotificationsEnabledUseCase(gh<_i42.ProfileRepository>()));
    gh.lazySingleton<_i46.LogoutUseCase>(
        () => _i46.LogoutUseCase(gh<_i42.ProfileRepository>()));
    gh.lazySingleton<_i47.UpdateProfileUseCase>(
        () => _i47.UpdateProfileUseCase(gh<_i42.ProfileRepository>()));

    // Profile - Cubit
    gh.factory<_i48.ProfileCubit>(() => _i48.ProfileCubit(
          gh<_i45.GetProfileUseCase>(),
          gh<_i44.GetFavoriteSongsUseCase>(),
          gh<_i44.GetFavoriteVersesUseCase>(),
          gh<_i46.GetThemeModeUseCase>(),
          gh<_i46.SetThemeModeUseCase>(),
          gh<_i46.GetNotificationsEnabledUseCase>(),
          gh<_i46.SetNotificationsEnabledUseCase>(),
          gh<_i46.LogoutUseCase>(),
        ));

    return this;
  }
}

class _$RegisterModule extends _i8.RegisterModule {}
