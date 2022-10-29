import 'dart:async';

import 'package:decisionroll/main.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:socket_io_client/socket_io_client.dart' as io;

final fetchDecisionsProvider = StreamProvider<String>((ref) async* {
  StreamController<String> socketResponse = StreamController<String>();

  ref.onDispose(() {
    // close socketio
    socketResponse.close();
  });
  socket = io.io('https://decisionrollbackend.herokuapp.com/decisions',
      io.OptionBuilder().setTransports(['websocket']).build());
  socket.onConnect((data) {
    socket.emit('decisions', {'decisions': 'Requesting Decisions'});
  });
  socket.on("decisions", (decisions) {
    socketResponse.add(decisions);
  });

  await for (final value in socketResponse.stream) {
    yield value;
  }
});
