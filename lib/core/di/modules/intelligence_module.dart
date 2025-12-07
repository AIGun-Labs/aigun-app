import 'package:get_it/get_it.dart';

import '../../../features/intelligence/domain/repositories/intelligence_repository.dart';
import '../../../features/intelligence/application/usecases/fetch_event_intelligence.dart';
import '../../../features/intelligence/application/usecases/fetch_intelligence_tokens.dart';
import '../../../features/intelligence/application/usecases/fetch_signal_intelligence.dart';
import '../../../features/intelligence/application/usecases/manage_agent_subscription.dart';
import '../../../features/intelligence/application/usecases/manage_realtime_connection.dart';
import '../../../features/intelligence/application/usecases/subscribe_realtime_intelligence.dart';
import '../../../features/intelligence/infrastructure/repositories/intelligence_repository_impl.dart';
import '../../../features/intelligence/infrastructure/datasources/intelligence_realtime_source.dart';
import '../../../features/intelligence/infrastructure/datasources/intelligence_remote_source.dart';
import '../../../features/intelligence/presentation/cubits/event_list/event_list_cubit.dart';
import '../../../features/intelligence/presentation/cubits/intelligence/intelligence_cubit.dart';
import '../../../features/intelligence/presentation/cubits/signal_list/signal_list_cubit.dart';
import '../../../features/intelligence/presentation/cubits/unread/unread_cubit.dart';
import '../module_repo.dart';

/// Intelligence Module - Dependency Injection Configuration
///
/// This module registers all dependencies for the Intelligence feature
/// following Clean Architecture principles.
class IntelligenceModule implements InjectionModule {
  final GetIt _sl;

  IntelligenceModule(this._sl);

  @override
  Future<void> init() async {
    // =========================================================================
    // Data Sources
    // =========================================================================

    /// Remote source for HTTP API calls
    _sl.registerLazySingleton<IntelligenceRemoteSource>(
      () => IntelligenceRemoteSource(_sl()),
    );

    /// Realtime source for WebSocket connections (using factory constructor)
    _sl.registerLazySingleton<IntelligenceRealtimeSource>(
      () => IntelligenceRealtimeSource.create(),
    );

    // =========================================================================
    // Repositories
    // =========================================================================

    /// Main repository implementing domain interface
    _sl.registerLazySingleton<IntelligenceRepository>(
      () => IntelligenceRepositoryImpl(
        _sl<IntelligenceRemoteSource>(),
        _sl<IntelligenceRealtimeSource>(),
      ),
    );

    // =========================================================================
    // Use Cases
    // =========================================================================

    /// Fetch event-type intelligence
    _sl.registerLazySingleton<FetchEventIntelligence>(
      () => FetchEventIntelligence(_sl<IntelligenceRepository>()),
    );

    /// Fetch signal-type intelligence
    _sl.registerLazySingleton<FetchSignalIntelligence>(
      () => FetchSignalIntelligence(_sl<IntelligenceRepository>()),
    );

    /// Fetch tokens for intelligence items
    _sl.registerLazySingleton<FetchIntelligenceTokens>(
      () => FetchIntelligenceTokens(_sl<IntelligenceRepository>()),
    );

    /// Subscribe to realtime intelligence stream
    _sl.registerLazySingleton<SubscribeRealtimeIntelligence>(
      () => SubscribeRealtimeIntelligence(_sl<IntelligenceRepository>()),
    );

    /// Manage WebSocket connection lifecycle
    _sl.registerLazySingleton<ManageRealtimeConnection>(
      () => ManageRealtimeConnection(_sl<IntelligenceRepository>()),
    );

    /// Manage agent subscriptions
    _sl.registerLazySingleton<ManageAgentSubscription>(
      () => ManageAgentSubscription(_sl<IntelligenceRepository>()),
    );

    // =========================================================================
    // Cubits (Presentation Layer State Management)
    // =========================================================================

    /// Event list cubit - manages event-type intelligence list state
    _sl.registerLazySingleton<EventListCubit>(
      () => EventListCubit(
        fetchEventIntelligence: _sl<FetchEventIntelligence>(),
        fetchIntelligenceTokens: _sl<FetchIntelligenceTokens>(),
      ),
    );

    /// Signal list cubit - manages signal-type intelligence list state
    _sl.registerLazySingleton<SignalListCubit>(
      () => SignalListCubit(
        fetchSignalIntelligence: _sl<FetchSignalIntelligence>(),
        fetchIntelligenceTokens: _sl<FetchIntelligenceTokens>(),
      ),
    );

    /// Unread cubit - manages unread intelligence items state
    _sl.registerLazySingleton<UnreadCubit>(
      () => UnreadCubit(),
    );

    /// Main intelligence cubit - coordinates all sub-cubits
    _sl.registerLazySingleton<IntelligenceCubit>(
      () => IntelligenceCubit(
        manageConnection: _sl<ManageRealtimeConnection>(),
        subscribeRealtime: _sl<SubscribeRealtimeIntelligence>(),
        manageSubscription: _sl<ManageAgentSubscription>(),
        fetchTokens: _sl<FetchIntelligenceTokens>(),
        eventListCubit: _sl<EventListCubit>(),
        signalListCubit: _sl<SignalListCubit>(),
        unreadCubit: _sl<UnreadCubit>(),
      ),
    );
  }
}
