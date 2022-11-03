import 'package:decisionroll/services/socket_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final socketServiceProvider = Provider<SocketService>((ref) {
  final socketService = SocketService();
  socketService.initConnection();
  return socketService;
});
