import 'package:isar/isar.dart';
part 'all_settings.g.dart';

@collection
class AllSettings {
  /// 主键ID，固定为1因为只需要一个实例
  Id id = 1;

  /// 当前启用的房间
  int? room;

  /// 玩家名称
  String? playerName;
}
