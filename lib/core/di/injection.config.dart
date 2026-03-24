// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:connectivity_plus/connectivity_plus.dart' as _i895;
import 'package:flutter_secure_storage/flutter_secure_storage.dart' as _i558;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;
import 'package:shared_preferences/shared_preferences.dart' as _i460;

import '../../features/auth/data/datasources/auth_remote_data_source.dart'
    as _i107;
import '../../features/auth/data/datasources/supabase_auth_data_source.dart'
    as _i857;
import '../../features/auth/data/repositories/auth_repository_impl.dart'
    as _i153;
import '../../features/auth/domain/repositories/auth_repository.dart' as _i787;
import '../../features/auth/domain/usecases/get_current_user_usecase.dart'
    as _i17;
import '../../features/auth/domain/usecases/login_usecase.dart' as _i188;
import '../../features/auth/domain/usecases/logout_usecase.dart' as _i48;
import '../../features/auth/domain/usecases/register_usecase.dart' as _i941;
import '../../features/auth/presentation/cubit/auth_cubit.dart' as _i117;
import '../../features/events/data/datasources/events_remote_data_source.dart'
    as _i370;
import '../../features/events/data/repositories/events_repository_impl.dart'
    as _i560;
import '../../features/events/domain/repositories/events_repository.dart'
    as _i967;
import '../../features/events/domain/usecases/get_events.dart' as _i286;
import '../../features/events/domain/usecases/get_upcoming_events.dart'
    as _i292;
import '../../features/events/domain/usecases/register_for_event.dart' as _i791;
import '../../features/events/presentation/cubit/events_cubit.dart' as _i496;
import '../../features/home/data/datasources/home_remote_data_source.dart'
    as _i362;
import '../../features/home/data/repositories/home_repository_impl.dart'
    as _i76;
import '../../features/home/domain/repositories/home_repository.dart' as _i0;
import '../../features/home/domain/usecases/get_home_data.dart' as _i453;
import '../../features/home/presentation/cubit/home_cubit.dart' as _i9;
import '../../features/library/data/datasources/library_remote_data_source.dart'
    as _i676;
import '../../features/library/data/repositories/library_repository_impl.dart'
    as _i912;
import '../../features/library/domain/repositories/library_repository.dart'
    as _i810;
import '../../features/library/domain/usecases/get_sermons.dart' as _i1026;
import '../../features/library/domain/usecases/get_songs.dart' as _i990;
import '../../features/library/domain/usecases/get_verses.dart' as _i73;
import '../../features/library/domain/usecases/toggle_favorite.dart' as _i313;
import '../../features/library/presentation/cubit/library_cubit.dart' as _i196;
import '../../features/profile/data/datasources/profile_local_data_source.dart'
    as _i439;
import '../../features/profile/data/datasources/profile_remote_data_source.dart'
    as _i847;
import '../../features/profile/data/repositories/profile_repository_impl.dart'
    as _i334;
import '../../features/profile/domain/repositories/profile_repository.dart'
    as _i894;
import '../../features/profile/domain/usecases/get_favorites.dart' as _i543;
import '../../features/profile/domain/usecases/get_profile.dart' as _i72;
import '../../features/profile/domain/usecases/settings_usecases.dart' as _i501;
import '../../features/profile/domain/usecases/update_profile.dart' as _i78;
import '../../features/profile/presentation/cubit/profile_cubit.dart' as _i36;
import '../network/dio_client.dart' as _i667;
import '../network/network_info.dart' as _i932;
import '../network/supabase_service.dart' as _i658;
import '../network/token_storage.dart' as _i964;
import 'injection.dart' as _i464;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  Future<_i174.GetIt> init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) async {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    final registerModule = _$RegisterModule();
    await gh.factoryAsync<_i460.SharedPreferences>(
      () => registerModule.sharedPreferences,
      preResolve: true,
    );
    gh.lazySingleton<_i558.FlutterSecureStorage>(
      () => registerModule.secureStorage,
    );
    gh.lazySingleton<_i895.Connectivity>(() => registerModule.connectivity);
    gh.lazySingleton<_i658.SupabaseService>(() => _i658.SupabaseService());
    gh.lazySingleton<_i439.ProfileLocalDataSource>(
      () => _i439.ProfileLocalDataSourceImpl(gh<_i460.SharedPreferences>()),
    );
    gh.lazySingleton<_i107.AuthRemoteDataSource>(
      () => _i857.SupabaseAuthRemoteDataSource(gh<_i658.SupabaseService>()),
    );
    gh.lazySingleton<_i964.TokenStorage>(
      () => _i964.TokenStorage(gh<_i558.FlutterSecureStorage>()),
    );
    gh.lazySingleton<_i667.DioClient>(
      () => _i667.DioClient(gh<_i964.TokenStorage>()),
    );
    gh.lazySingleton<_i370.EventsRemoteDataSource>(
      () => _i370.EventsRemoteDataSourceImpl(gh<_i667.DioClient>()),
    );
    gh.lazySingleton<_i676.LibraryRemoteDataSource>(
      () => _i676.LibraryRemoteDataSourceImpl(gh<_i667.DioClient>()),
    );
    gh.lazySingleton<_i847.ProfileRemoteDataSource>(
      () => _i847.ProfileRemoteDataSourceImpl(gh<_i667.DioClient>()),
    );
    gh.lazySingleton<_i362.HomeRemoteDataSource>(
      () => _i362.HomeRemoteDataSourceImpl(gh<_i667.DioClient>()),
    );
    gh.lazySingleton<_i932.NetworkInfo>(
      () => _i932.NetworkInfoImpl(gh<_i895.Connectivity>()),
    );
    gh.lazySingleton<_i810.LibraryRepository>(
      () => _i912.LibraryRepositoryImpl(
        gh<_i676.LibraryRemoteDataSource>(),
        gh<_i932.NetworkInfo>(),
      ),
    );
    gh.lazySingleton<_i1026.GetSermonsUseCase>(
      () => _i1026.GetSermonsUseCase(gh<_i810.LibraryRepository>()),
    );
    gh.lazySingleton<_i1026.GetRecentSermonsUseCase>(
      () => _i1026.GetRecentSermonsUseCase(gh<_i810.LibraryRepository>()),
    );
    gh.lazySingleton<_i990.GetSongsUseCase>(
      () => _i990.GetSongsUseCase(gh<_i810.LibraryRepository>()),
    );
    gh.lazySingleton<_i73.GetVersesUseCase>(
      () => _i73.GetVersesUseCase(gh<_i810.LibraryRepository>()),
    );
    gh.lazySingleton<_i73.GetVerseOfWeekUseCase>(
      () => _i73.GetVerseOfWeekUseCase(gh<_i810.LibraryRepository>()),
    );
    gh.lazySingleton<_i313.ToggleSongFavoriteUseCase>(
      () => _i313.ToggleSongFavoriteUseCase(gh<_i810.LibraryRepository>()),
    );
    gh.lazySingleton<_i313.ToggleVerseFavoriteUseCase>(
      () => _i313.ToggleVerseFavoriteUseCase(gh<_i810.LibraryRepository>()),
    );
    gh.lazySingleton<_i313.ToggleSermonFavoriteUseCase>(
      () => _i313.ToggleSermonFavoriteUseCase(gh<_i810.LibraryRepository>()),
    );
    gh.lazySingleton<_i894.ProfileRepository>(
      () => _i334.ProfileRepositoryImpl(
        gh<_i847.ProfileRemoteDataSource>(),
        gh<_i439.ProfileLocalDataSource>(),
        gh<_i932.NetworkInfo>(),
        gh<_i964.TokenStorage>(),
      ),
    );
    gh.lazySingleton<_i543.GetFavoriteSongsUseCase>(
      () => _i543.GetFavoriteSongsUseCase(gh<_i894.ProfileRepository>()),
    );
    gh.lazySingleton<_i543.GetFavoriteVersesUseCase>(
      () => _i543.GetFavoriteVersesUseCase(gh<_i894.ProfileRepository>()),
    );
    gh.lazySingleton<_i72.GetProfileUseCase>(
      () => _i72.GetProfileUseCase(gh<_i894.ProfileRepository>()),
    );
    gh.lazySingleton<_i501.GetThemeModeUseCase>(
      () => _i501.GetThemeModeUseCase(gh<_i894.ProfileRepository>()),
    );
    gh.lazySingleton<_i501.SetThemeModeUseCase>(
      () => _i501.SetThemeModeUseCase(gh<_i894.ProfileRepository>()),
    );
    gh.lazySingleton<_i501.GetNotificationsEnabledUseCase>(
      () => _i501.GetNotificationsEnabledUseCase(gh<_i894.ProfileRepository>()),
    );
    gh.lazySingleton<_i501.SetNotificationsEnabledUseCase>(
      () => _i501.SetNotificationsEnabledUseCase(gh<_i894.ProfileRepository>()),
    );
    gh.lazySingleton<_i501.LogoutUseCase>(
      () => _i501.LogoutUseCase(gh<_i894.ProfileRepository>()),
    );
    gh.lazySingleton<_i78.UpdateProfileUseCase>(
      () => _i78.UpdateProfileUseCase(gh<_i894.ProfileRepository>()),
    );
    gh.lazySingleton<_i787.AuthRepository>(
      () => _i153.AuthRepositoryImpl(
        gh<_i107.AuthRemoteDataSource>(),
        gh<_i932.NetworkInfo>(),
        gh<_i658.SupabaseService>(),
      ),
    );
    gh.lazySingleton<_i967.EventsRepository>(
      () => _i560.EventsRepositoryImpl(
        gh<_i370.EventsRemoteDataSource>(),
        gh<_i932.NetworkInfo>(),
      ),
    );
    gh.factory<_i36.ProfileCubit>(
      () => _i36.ProfileCubit(
        gh<_i72.GetProfileUseCase>(),
        gh<_i543.GetFavoriteSongsUseCase>(),
        gh<_i543.GetFavoriteVersesUseCase>(),
        gh<_i501.GetThemeModeUseCase>(),
        gh<_i501.SetThemeModeUseCase>(),
        gh<_i501.GetNotificationsEnabledUseCase>(),
        gh<_i501.SetNotificationsEnabledUseCase>(),
        gh<_i501.LogoutUseCase>(),
      ),
    );
    gh.lazySingleton<_i17.GetCurrentUserUseCase>(
      () => _i17.GetCurrentUserUseCase(gh<_i787.AuthRepository>()),
    );
    gh.lazySingleton<_i188.LoginUseCase>(
      () => _i188.LoginUseCase(gh<_i787.AuthRepository>()),
    );
    gh.lazySingleton<_i48.LogoutUseCase>(
      () => _i48.LogoutUseCase(gh<_i787.AuthRepository>()),
    );
    gh.lazySingleton<_i941.RegisterUseCase>(
      () => _i941.RegisterUseCase(gh<_i787.AuthRepository>()),
    );
    gh.lazySingleton<_i0.HomeRepository>(
      () => _i76.HomeRepositoryImpl(
        gh<_i362.HomeRemoteDataSource>(),
        gh<_i932.NetworkInfo>(),
      ),
    );
    gh.factory<_i196.LibraryCubit>(
      () => _i196.LibraryCubit(
        gh<_i990.GetSongsUseCase>(),
        gh<_i73.GetVersesUseCase>(),
        gh<_i1026.GetSermonsUseCase>(),
        gh<_i313.ToggleSongFavoriteUseCase>(),
        gh<_i313.ToggleVerseFavoriteUseCase>(),
        gh<_i313.ToggleSermonFavoriteUseCase>(),
      ),
    );
    gh.lazySingleton<_i286.GetEventsUseCase>(
      () => _i286.GetEventsUseCase(gh<_i967.EventsRepository>()),
    );
    gh.lazySingleton<_i292.GetUpcomingEventsUseCase>(
      () => _i292.GetUpcomingEventsUseCase(gh<_i967.EventsRepository>()),
    );
    gh.lazySingleton<_i791.RegisterForEventUseCase>(
      () => _i791.RegisterForEventUseCase(gh<_i967.EventsRepository>()),
    );
    gh.factory<_i117.AuthCubit>(
      () => _i117.AuthCubit(
        gh<_i188.LoginUseCase>(),
        gh<_i941.RegisterUseCase>(),
        gh<_i48.LogoutUseCase>(),
        gh<_i17.GetCurrentUserUseCase>(),
        gh<_i787.AuthRepository>(),
        gh<_i658.SupabaseService>(),
      ),
    );
    gh.lazySingleton<_i453.GetUpcomingSeminarsUseCase>(
      () => _i453.GetUpcomingSeminarsUseCase(gh<_i0.HomeRepository>()),
    );
    gh.lazySingleton<_i453.GetWeeklyProgramUseCase>(
      () => _i453.GetWeeklyProgramUseCase(gh<_i0.HomeRepository>()),
    );
    gh.lazySingleton<_i453.GetMemoryVerseUseCase>(
      () => _i453.GetMemoryVerseUseCase(gh<_i0.HomeRepository>()),
    );
    gh.lazySingleton<_i453.GetFeaturedSongsUseCase>(
      () => _i453.GetFeaturedSongsUseCase(gh<_i0.HomeRepository>()),
    );
    gh.lazySingleton<_i453.GetSundaySchedulesUseCase>(
      () => _i453.GetSundaySchedulesUseCase(gh<_i0.HomeRepository>()),
    );
    gh.lazySingleton<_i453.GetAnnouncementsUseCase>(
      () => _i453.GetAnnouncementsUseCase(gh<_i0.HomeRepository>()),
    );
    gh.factory<_i496.EventsCubit>(
      () => _i496.EventsCubit(
        gh<_i286.GetEventsUseCase>(),
        gh<_i292.GetUpcomingEventsUseCase>(),
        gh<_i791.RegisterForEventUseCase>(),
      ),
    );
    gh.factory<_i9.HomeCubit>(
      () => _i9.HomeCubit(
        gh<_i453.GetUpcomingSeminarsUseCase>(),
        gh<_i453.GetWeeklyProgramUseCase>(),
        gh<_i453.GetMemoryVerseUseCase>(),
        gh<_i453.GetFeaturedSongsUseCase>(),
        gh<_i453.GetSundaySchedulesUseCase>(),
        gh<_i453.GetAnnouncementsUseCase>(),
      ),
    );
    return this;
  }
}

class _$RegisterModule extends _i464.RegisterModule {}
