import 'package:getparked/StateManagement/Models/VehicleData.dart';

class VehicleTypeData {
  VehicleType type;
  int id;
  String name;
  double length;
  double breadth;
  double height;

  VehicleTypeData(
      {this.type, this.id, this.name, this.length, this.breadth, this.height});
}
