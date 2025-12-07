import '../../domain/repositories/intelligence_repository.dart';

/// Manage Agent Subscription Use Case
///
/// Handles subscribing/unsubscribing to specific AI agents
/// for realtime intelligence updates.
class ManageAgentSubscription {
  final IntelligenceRepository _repository;

  ManageAgentSubscription(this._repository);

  /// Subscribe to a specific agent
  ///
  /// [agentId] - The ID of the agent to subscribe to
  void subscribe(String agentId) {
    _repository.subscribeAgent(agentId);
  }

  /// Unsubscribe from a specific agent
  ///
  /// [agentId] - The ID of the agent to unsubscribe from
  void unsubscribe(String agentId) {
    _repository.unsubscribeAgent(agentId);
  }

  /// Subscribe to multiple agents
  ///
  /// [agentIds] - List of agent IDs to subscribe to
  void subscribeAll(List<String> agentIds) {
    _repository.subscribeAgents(agentIds);
  }
}
