import 'package:film_list/domain/hive/hive_item_type.dart';
import 'package:film_list/domain/hive/hive_keys.dart';
import 'package:hive/hive.dart';

class HiveBoxes{
  static Box<HiveItemType> hiveItemType = Hive.box<HiveItemType>(HiveKeys.hiveItemTypeKey);
}