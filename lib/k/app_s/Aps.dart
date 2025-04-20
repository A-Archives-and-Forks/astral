import 'dart:ui';

import 'package:astral/k/models/room.dart';
import 'package:astral/k/models/room_tags.dart';
import 'package:flutter/material.dart';
import 'package:signals_flutter/signals_flutter.dart';
import 'package:astral/k/database/app_data.dart';
export 'package:signals_flutter/signals_flutter.dart';

/// 全局状态管理类
class Aps {
  //单例模式
  Aps._internal() {
    _initThemeSettings();
    updateNetConfig();
    initRoomTagsSetting();
  }
  static final Aps _instance = Aps._internal();
  factory Aps() => _instance;
  // 初始化房间标签
  Future<void> initRoomTagsSetting() async {
    allRoomTags.value = await AppDatabase().RoomTagsSetting.getAllTags();
  }

  // 初始化主题设置
  Future<void> _initThemeSettings() async {
    final database = AppDatabase();
    themeMode.value = await database.themeSettings.getThemeMode();
    themeColor.value = Color(await database.themeSettings.getThemeColor());
  }

  /// **********************************************************************************************************
  /// 主题颜色
  final Signal<Color> themeColor = signal(Colors.blue);
  // 更新主题颜色
  Future<void> updateThemeColor(Color color) async {
    themeColor.value = color;
    await AppDatabase().themeSettings.updateThemeColor(color.toARGB32());
  }

  /// **********************************************************************************************************
  /// 主题模式
  final Signal<ThemeMode> themeMode = signal(ThemeMode.system); // 初始化为跟随系统
  // 更新主题模式
  Future<void> updateThemeMode(ThemeMode mode) async {
    themeMode.value = mode;
    await AppDatabase().themeSettings.updateThemeMode(mode);
  }

  /// **********************************************************************************************************

  /// 软件名
  final Signal<String> appName = signal('Astro Game'); // 初始化为Astro Game

  /// **********************************************************************************************************

  /// 获取屏幕分割宽度 区分手机和桌面
  final Signal<double> screenSplitWidth = signal(480); // 初始化为480
  //更新屏幕分割宽度
  void updateScreenSplitWidth(double width) {
    screenSplitWidth.value = width;
    // 判断是否为桌面
    isDesktop.value = width > 480;
  }

  /// **********************************************************************************************************

  /// 是否为桌面
  final Signal<bool> isDesktop = signal(false); // 初始化为false
  /// **********************************************************************************************************

  // 添加鼠标悬停状态跟踪
  final Signal<int?> hoveredIndex = signal(null);

  /// **********************************************************************************************************

  // 构建导航项
  final Signal<int> selectedIndex = Signal(0);

  /// **********************************************************************************************************

  /// 网络配置
  final Signal<String> netns = signal(''); // 网络命名空间
  final Signal<String> hostname = signal(''); // 主机名
  final Signal<String> instanceName = signal('default'); // 实例名称
  final Signal<String> ipv4 = signal(''); // IPv4地址
  final Signal<bool> dhcp = signal(false); // DHCP设置
  final Signal<String> networkName = signal(''); // 网络名称
  final Signal<String> networkSecret = signal(''); // 网络密钥
  final Signal<List<String>> listeners = signal([]); // 监听端口列表
  final Signal<List<String>> peer = signal([]); // 对等节点列表
  final Signal<String> defaultProtocol = signal(''); // 默认协议
  final Signal<String> devName = signal(''); // 设备名称
  final Signal<bool> enableEncryption = signal(true); // 加密设置
  final Signal<bool> enableIpv6 = signal(true); // IPv6设置
  final Signal<int> mtu = signal(1360); // MTU值
  final Signal<bool> latencyFirst = signal(false); // 延迟优先设置
  final Signal<bool> enableExitNode = signal(false); // 出口节点设置
  final Signal<bool> noTun = signal(false); // TUN设备禁用设置
  final Signal<bool> useSmoltcp = signal(false); // smoltcp网络栈设置
  final Signal<String> relayNetworkWhitelist = signal(''); // 中继网络白名单
  final Signal<bool> disableP2p = signal(false); // P2P禁用设置
  final Signal<bool> relayAllPeerRpc = signal(false); // 中继所有对等RPC设置
  final Signal<bool> disableUdpHolePunching = signal(false); // UDP打洞禁用设置
  final Signal<bool> multiThread = signal(true); // 多线程设置
  final Signal<int> dataCompressAlgo = signal(0);

  /// 数据压缩算法(0:不压缩)
  final Signal<bool> bindDevice = signal(false);

  /// 是否绑定设备
  final Signal<bool> enableKcpProxy = signal(false);

  /// 是否启用KCP代理
  final Signal<bool> disableKcpInput = signal(false);

  /// 是否禁用KCP输入
  final Signal<bool> disableRelayKcp = signal(false);

  /// 是否禁用中继KCP
  final Signal<bool> proxyForwardBySystem = signal(false);

  // 更新网络配置
  /// 从数据库加载并更新所有网络配置
  Future<void> updateNetConfig() async {
    final database = AppDatabase();
    // 获取基本网络配置
    netns.value = await database.netConfigSetting.getNetns(); // 网络命名空间
    hostname.value = await database.netConfigSetting.getHostname(); // 主机名
    instanceName.value =
        await database.netConfigSetting.getInstanceName(); // 实例名称
    ipv4.value = await database.netConfigSetting.getIpv4(); // IPv4地址
    dhcp.value = await database.netConfigSetting.getDhcp(); // DHCP设置

    // 获取网络连接相关配置
    networkName.value =
        await database.netConfigSetting.getNetworkName(); // 网络名称
    networkSecret.value =
        await database.netConfigSetting.getNetworkSecret(); // 网络密钥
    listeners.value = await database.netConfigSetting.getListeners(); // 监听端口列表
    peer.value = await database.netConfigSetting.getPeer(); // 对等节点列表
    defaultProtocol.value =
        await database.netConfigSetting.getDefaultProtocol(); // 默认协议
    devName.value = await database.netConfigSetting.getDevName(); // 设备名称

    // 获取网络功能开关配置
    enableEncryption.value =
        await database.netConfigSetting.getEnableEncryption(); // 加密设置
    enableIpv6.value =
        await database.netConfigSetting.getEnableIpv6(); // IPv6设置
    mtu.value = await database.netConfigSetting.getMtu(); // MTU值
    latencyFirst.value =
        await database.netConfigSetting.getLatencyFirst(); // 延迟优先
    enableExitNode.value =
        await database.netConfigSetting.getEnableExitNode(); // 出口节点
    noTun.value = await database.netConfigSetting.getNoTun(); // TUN设备禁用
    useSmoltcp.value =
        await database.netConfigSetting.getUseSmoltcp(); // smoltcp网络栈

    // 获取高级网络配置
    relayNetworkWhitelist.value =
        await database.netConfigSetting.getRelayNetworkWhitelist(); // 中继网络白名单
    disableP2p.value = await database.netConfigSetting.getDisableP2p(); // P2P禁用
    relayAllPeerRpc.value =
        await database.netConfigSetting.getRelayAllPeerRpc(); // 中继所有对等RPC
    disableUdpHolePunching.value =
        await database.netConfigSetting.getDisableUdpHolePunching(); // UDP打洞禁用
    multiThread.value =
        await database.netConfigSetting.getMultiThread(); // 多线程设置
  }

  // 更新网络命名空间
  Future<void> updateNetns(String value) async {
    netns.value = value;
    await AppDatabase().netConfigSetting.updateNetns(value);
  }

  // 更新主机名
  Future<void> updateHostname(String value) async {
    hostname.value = value;
    await AppDatabase().netConfigSetting.updateHostname(value);
  }

  // 更新实例名称
  Future<void> updateInstanceName(String value) async {
    instanceName.value = value;
    await AppDatabase().netConfigSetting.updateInstanceName(value);
  }

  // 更新IPv4地址
  Future<void> updateIpv4(String value) async {
    ipv4.value = value;
    await AppDatabase().netConfigSetting.updateIpv4(value);
  }

  // 更新DHCP设置
  Future<void> updateDhcp(bool value) async {
    dhcp.value = value;
    await AppDatabase().netConfigSetting.updateDhcp(value);
  }

  // 更新网络名称
  Future<void> updateNetworkName(String value) async {
    networkName.value = value;
    await AppDatabase().netConfigSetting.updateNetworkName(value);
  }

  // 更新网络密钥
  Future<void> updateNetworkSecret(String value) async {
    networkSecret.value = value;
    await AppDatabase().netConfigSetting.updateNetworkSecret(value);
  }

  // 更新监听端口列表
  Future<void> updateListeners(List<String> value) async {
    listeners.value = value;
    await AppDatabase().netConfigSetting.updateListeners(value);
  }

  // 更新对等节点列表
  Future<void> updatePeer(List<String> value) async {
    peer.value = value;
    await AppDatabase().netConfigSetting.updatePeer(value);
  }

  // 更新默认协议
  Future<void> updateDefaultProtocol(String value) async {
    defaultProtocol.value = value;
    await AppDatabase().netConfigSetting.updateDefaultProtocol(value);
  }

  // 更新设备名称
  Future<void> updateDevName(String value) async {
    devName.value = value;
    await AppDatabase().netConfigSetting.updateDevName(value);
  }

  /// 更新加密设置 会顺便更新mtu
  /// 如果开启加密则mtu为1360 否则为1380
  Future<void> updateEnableEncryption(bool value) async {
    enableEncryption.value = value;
    if (value) {
      //设置mtu为1360
      updateMtu(1360);
    } else {
      //设置mtu为1380
      updateMtu(1380);
    }
    await AppDatabase().netConfigSetting.updateEnableEncryption(value);
  }

  // 更新IPv6设置
  Future<void> updateEnableIpv6(bool value) async {
    enableIpv6.value = value;
    await AppDatabase().netConfigSetting.updateEnableIpv6(value);
  }

  // 更新MTU值
  Future<void> updateMtu(int value) async {
    mtu.value = value;
    await AppDatabase().netConfigSetting.updateMtu(value);
  }

  // 更新延迟优先设置
  Future<void> updateLatencyFirst(bool value) async {
    latencyFirst.value = value;
    await AppDatabase().netConfigSetting.updateLatencyFirst(value);
  }

  // 更新出口节点设置
  Future<void> updateEnableExitNode(bool value) async {
    enableExitNode.value = value;
    await AppDatabase().netConfigSetting.updateEnableExitNode(value);
  }

  // 更新TUN设备禁用设置
  Future<void> updateNoTun(bool value) async {
    noTun.value = value;
    await AppDatabase().netConfigSetting.updateNoTun(value);
  }

  // 更新smoltcp网络栈设置
  Future<void> updateUseSmoltcp(bool value) async {
    useSmoltcp.value = value;
    await AppDatabase().netConfigSetting.updateUseSmoltcp(value);
  }

  // 更新中继网络白名单
  Future<void> updateRelayNetworkWhitelist(String value) async {
    relayNetworkWhitelist.value = value;
    await AppDatabase().netConfigSetting.updateRelayNetworkWhitelist(value);
  }

  // 更新P2P禁用设置
  Future<void> updateDisableP2p(bool value) async {
    disableP2p.value = value;
    await AppDatabase().netConfigSetting.updateDisableP2p(value);
  }

  // 更新中继所有对等RPC设置
  Future<void> updateRelayAllPeerRpc(bool value) async {
    relayAllPeerRpc.value = value;
    await AppDatabase().netConfigSetting.updateRelayAllPeerRpc(value);
  }

  // 更新UDP打洞禁用设置
  Future<void> updateDisableUdpHolePunching(bool value) async {
    disableUdpHolePunching.value = value;
    await AppDatabase().netConfigSetting.updateDisableUdpHolePunching(value);
  }

  // 更新多线程设置
  Future<void> updateMultiThread(bool value) async {
    multiThread.value = value;
    await AppDatabase().netConfigSetting.updateMultiThread(value);
  }

  // 更新数据压缩算法
  Future<void> updateDataCompressAlgo(int value) async {
    dataCompressAlgo.value = value;
    await AppDatabase().netConfigSetting.updateDataCompressAlgo(value);
  }

  // 更新是否绑定设备
  Future<void> updateBindDevice(bool value) async {
    bindDevice.value = value;
    await AppDatabase().netConfigSetting.updateBindDevice(value);
  }

  // 更新是否启用KCP代理
  Future<void> updateEnableKcpProxy(bool value) async {
    enableKcpProxy.value = value;
    await AppDatabase().netConfigSetting.updateEnableKcpProxy(value);
  }

  // 更新是否禁用KCP输入
  Future<void> updateDisableKcpInput(bool value) async {
    disableKcpInput.value = value;
    await AppDatabase().netConfigSetting.updateDisableKcpInput(value);
  }

  // 更新是否禁用中继KCP
  Future<void> updateDisableRelayKcp(bool value) async {
    disableRelayKcp.value = value;
    await AppDatabase().netConfigSetting.updateDisableRelayKcp(value);
  }

  // 更新是否使用系统代理转发
  Future<void> updateProxyForwardBySystem(bool value) async {
    proxyForwardBySystem.value = value;
    await AppDatabase().netConfigSetting.updateProxyForwardBySystem(value);
  }

  /// 房间标签
  final Signal<List<RoomTags>> allRoomTags = signal([]);

  /// 添加标签
  Future<void> addTag(String tagName) async {
    await AppDatabase().RoomTagsSetting.addTag(tagName);
    allRoomTags.value = await AppDatabase().RoomTagsSetting.getAllTags();
  }

  /// 设置标签选中状态
  Future<void> setTagSelected(String tagName, bool isSelected) async {
    await AppDatabase().RoomTagsSetting.setTagSelected(tagName, isSelected);
    allRoomTags.value = await AppDatabase().RoomTagsSetting.getAllTags();
  }

  /// 清除所有标签的选中状态
  Future<void> clearAllTagSelections() async {
    await AppDatabase().RoomTagsSetting.clearAllTagSelections();
    allRoomTags.value = await AppDatabase().RoomTagsSetting.getAllTags();
  }

  /// 删除标签
  Future<void> deleteTag(String tagName) async {
    await AppDatabase().RoomTagsSetting.deleteTag(tagName);
    allRoomTags.value = await AppDatabase().RoomTagsSetting.getAllTags();
  }

  /// 获取所有标签
  Future<List<RoomTags>> getAllTags() async {
    final tagsList = await AppDatabase().RoomTagsSetting.getAllTags();
    allRoomTags.value = tagsList; // 更新 Signal
    return tagsList;
  }

  /// 房间列表
  final Signal<List<Room>> rooms = signal([]);

  /// 添加房间
  Future<void> addRoom(Room room) async {
    await AppDatabase().RoomSetting.addRoom(room);
    rooms.value = await AppDatabase().RoomSetting.getAllRooms();
  }

  /// 删除房间
  Future<void> deleteRoom(int id) async {
    await AppDatabase().RoomSetting.deleteRoom(id);
    rooms.value = await AppDatabase().RoomSetting.getAllRooms();
  }

  /// 根据ID获取房间
  Future<Room?> getRoomById(int id) async {
    return await AppDatabase().RoomSetting.getRoomById(id);
  }

  /// 获取所有房间
  Future<List<Room>> getAllRooms() async {
    final roomsList = await AppDatabase().RoomSetting.getAllRooms();
    rooms.value = roomsList; // 更新 Signal
    return roomsList;
  }

  /// 更新房间
  Future<int> updateRoom(Room room) async {
    rooms.value = await AppDatabase().RoomSetting.getAllRooms();
    return await AppDatabase().RoomSetting.updateRoom(room);
  }
}
