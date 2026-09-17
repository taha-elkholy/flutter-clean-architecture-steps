import 'package:flutter_clean_architecture_steps/core/di/service_locator.config.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

final GetIt getIt = GetIt.instance;

/// Called once, before `runApp`.
@InjectableInit()
void setupServiceLocator() => getIt.init();
