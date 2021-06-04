import 'package:getparked/Utils/DomainUtils.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class SocketUtils {
  IO.Socket socketIO;

  IO.Socket init(onSocketConnected, onSocketDisconnected) {
    socketIO = IO.io(domainName, <String, dynamic>{
      'transports': ['websocket'],
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
  }
}
