import 'package:film_list/domain/hive/hive_item_type.dart';
import 'package:film_list/domain/hive/hive_keys.dart';
import 'package:film_list/ui/app.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(HiveItemTypeAdapter());
  await Hive.openBox<HiveItemType>(HiveKeys.hiveItemTypeKey);

  runApp(const App());
}