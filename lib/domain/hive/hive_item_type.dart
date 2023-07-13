import 'package:hive/hive.dart';

part 'hive_item_type.g.dart';

@HiveType(typeId: 0)
class HiveItemType{

  @HiveField(0)
  int index;

  @HiveField(1)
  bool isWatched;

  @HiveField(2)
  String title;

  @HiveField(3)
  int rate;

  @HiveField(4)
  DateTime createTime;

  @HiveField(5)
  DateTime watchedTime;

  HiveItemType({
    required this.index,
    required this.isWatched,
    required this.title,
    required this.rate,
    required this.createTime,
    required this.watchedTime,
  });
}