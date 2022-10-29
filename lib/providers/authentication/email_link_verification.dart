import 'dart:async';
import 'dart:convert';

import 'package:decisionroll/main.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:socket_io_client/socket_io_client.dart' as io;

final emailLoginVerificationProvider = StreamProvider<String>((ref) async* {
  StreamController<String> socketResponse = StreamController<String>();

  ref.onDispose(() {
    // close socketio
    socketResponse.close();
  });
  socket = io.io('http://192.168.125.187:5002/verify-login-email',
      io.OptionBuilder().setTransports(['websocket']).build());
  socket.onConnect((data) {});
  socket.on("loginlinkverification", (response) {
    var responseMap = json.encode(response);

    socketResponse.add(responseMap);
  });

  await for (final value in socketResponse.stream) {
    yield value;
  }
});
