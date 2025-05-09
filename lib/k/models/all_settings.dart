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

  /// 监听列表
  List<String>? listenList;

  /// 自定义vpn网段
  List<String> customVpn = [];

  ///用户列表简约模式
  bool userListSimple = false;

  /// 关闭最小化到托盘
  bool closeMinimize = true;

  /// 开机自启
  bool startup = false;

  /// 启动后最小化
  bool startupMinimize = false;

  /// 启动后自动连接
  bool startupAutoConnect = false;
}
