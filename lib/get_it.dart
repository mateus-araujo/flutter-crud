import 'package:flutter_crud/provider/users.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

void setup() {
  getIt.registerSingleton<Users>(Users());
}
