import 'dart:async';

import 'package:apartment_app/src/fire_base/fire_base_auth.dart';
import 'package:apartment_app/src/pages/service_object/service_info.dart';


class ServiceBloc {
  StreamController _serviceController = new StreamController.broadcast();

  Stream? get service => _serviceController.stream;

  bool checkStream() {

    _serviceController.sink.add('OK it work????');

    return true;
  }

  Future <bool> checkService(ServiceInfo Info) async{
    if (Info.iconPath == 'assets/images/service_icon/add_icon.png') {
      _serviceController.sink.add('Chua them icon');
      await   _serviceController.sink.done;

    } else if (Info.type == 'Thu phi dua tren') {
      _serviceController.sink.add('Chưa thêm hình thưc thu phí ');
      await   _serviceController.sink.done;

    } else if (Info.name == null || Info.name == '') {
      _serviceController.sink.add('Chưa thêm tên dịch vụ');
      await   _serviceController.sink.done;

    }
    await   _serviceController.sink.done;
    return Future<bool>.value(true);
  }

  void dispose() {
    _serviceController.close();
  }
}
