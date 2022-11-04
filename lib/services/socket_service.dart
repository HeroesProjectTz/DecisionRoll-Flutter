import 'dart:developer';

import 'package:decisionroll/utilities/constants.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class SocketService {
  IO.Socket socket = IO.io(
      // im using adb so i need to use my wifi ip
      socketServiceUrl,
      IO.OptionBuilder()
          .setTransports(['websocket']) // for Flutter or Dart VM
          .disableAutoConnect() // disable auto-connection
          // .setExtraHeaders({'foo': 'bar'}) // optional
          .build());

  initConnection() {
    socket.connect();
    socket.on('connection', (_) {
      log('connect ${_.toString()}');
    });
    log('Trying Connection');
    socket.onConnect((_) {
      log('connect');
    });

    socket.onerror((_) {
      log('Error Is ${_.toString()}');
    });
  }

  sessionActivated(String uid, String email, String fullname) {
    socket.emit('userSessionActivated',
        {"uid": uid, "email": email, "fullname": fullname});
  }
}
