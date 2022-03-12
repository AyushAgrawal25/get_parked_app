import 'package:flutter/cupertino.dart';
import 'package:getparked/Utils/DomainUtils.dart';
import 'package:getparked/Utils/SecureStorageUtils.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class SocketUtils {
  IO.Socket socketIO;

  IO.Socket init(
      {@required String authToken,
      Function(IO.Socket) onSocketConnected,
      Function(IO.Socket) onSocketDisconnected}) {
    try {
      print("Connecting to Sockets...");
      // String socketURL = 'ws://' + HOST_NAME + ':' + HOST_PORT + '/';
      String socketURL = 'https://' + HOST_NAME + '/';
      print(socketURL);
      socketIO = IO.io(socketURL, <String, dynamic>{
        'transports': ['websocket'],
        'autoConnect': false,
        'auth': {AUTH_TOKEN: authToken}
      });

      socketIO.connect();
      socketIO.on("connect", (data) {
        print("Connection Successfully Established...");
        onSocketConnected(socketIO);
      });

      socketIO.on("reconnect", (data) {
        print("Socket Connected Again.. Reconnection");
      });

      socketIO.on("disconnect", (data) {
        print("Socket Disconnected Unexpectedly..");
        onSocketDisconnected(socketIO);
      });

      return socketIO;
    } catch (e) {
      print(e);
      return socketIO;
    }
  }
}
