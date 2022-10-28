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
  socket.onConnect((data) {
    // socket.emit('decisions', {'email': 'he'});
  });
  socket.on("loginlinkverification", (response) {
    final validMap = json.decode(json.encode(response)) as Map<String, dynamic>;

    // print(validMap);

    socketResponse.add(validMap.toString());
  });

  await for (final value in socketResponse.stream) {
    print(value);
    yield value;
  }
});
