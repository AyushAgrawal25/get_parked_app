import 'package:getparked/Utils/DomainUtils.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class SocketUtils {
  IO.Socket socketIO;

  IO.Socket init(onSocketConnected, onSocketDisconnected) {
    try {
      String socketURL = 'ws://' + HOST_NAME + ':' + HOST_PORT + '/';
      socketIO = IO.io(socketURL, <String, dynamic>{
        'transports': ['websocket'],
        'autoConnect': false,
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
