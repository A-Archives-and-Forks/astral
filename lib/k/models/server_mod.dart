import 'package:isar/isar.dart';
part 'server_mod.g.dart';

@collection
class ServerMod {
  /// 主键自增
  Id id = Isar.autoIncrement;
  String name = ""; // 服务器名
  String url = ""; // 服务器地址
  // 是否启用
  bool enable = true;
  // tcp 开启
  bool tcp = true;
  // udp 开启
  bool udp = true;
  // ws 开启
  bool ws = false;
  // wss 开启
  bool wss = false;
  // quic 开启
  bool quic = false;
  // wg 开启
  bool wg = false;
  // txt 开启
  bool txt = false;
  // srv 开启
  bool srv = false;
  // http 开启
  bool http = false;
  // https 开启
  bool https = false;

  //构造
  ServerMod({
    this.id = Isar.autoIncrement,
    this.enable = false,
    this.name = "",
    this.url = "",
    this.tcp = true,
    this.udp = true,
    this.ws = false,
    this.wss = false,
    this.quic = false,
    this.wg = false,
    this.txt = false,
    this.srv = false,
    this.http = false,
    this.https = false,
  });
}
