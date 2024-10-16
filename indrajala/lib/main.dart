import 'package:flutter/material.dart';
import 'package:indrajala/core/dependency_injection/service_locator.dart';
import 'package:indrajala/myapp.dart';

void main() async {
  
  WidgetsFlutterBinding.ensureInitialized();
  await init();

  runApp(const MyApp());
}
