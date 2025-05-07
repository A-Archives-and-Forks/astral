import 'dart:io';

import 'package:astral/k/models/all_settings.dart';
import 'package:astral/k/models/room.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:isar/isar.dart';

class AllSettingsCz {
  final Isar _isar;

  AllSettingsCz(this._isar) {
    init();
  }

  Future<void> init() async {
    AllSettings? settings = await _isar.allSettings.get(
      1,
    ); // 1. 使用可变变量 settings
    bool needsSave = false; // 2. 标记是否需要保存

    if (settings == null) {
      // 3. 如果是首次运行 (settings 为 null)
      settings = AllSettings(); // 创建新实例

      // 直接在新实例上设置所有默认值
      settings.playerName = await _getDeviceName(); // 设置默认 playerName
      settings.listenList = [
        // 设置默认 listenList
        "tcp://0.0.0.0:11010",
        "udp://0.0.0.0:11010",
        "tcp://[::]:11010",
        "udp://[::]:11010",
      ];
      needsSave = true; // 标记这个新创建并完全初始化的对象需要保存
    } else {
      // 4. 如果 settings 已存在，检查各个字段是否需要设置默认值
      if (settings.playerName == null) {
        settings.playerName = await _getDeviceName();
        needsSave = true;
      }
      if (settings.listenList == null || settings.listenList!.isEmpty) {
        settings.listenList = [
          "tcp://0.0.0.0:11010",
          "udp://0.0.0.0:11010",
          "tcp://[::]:11010",
          "udp://[::]:11010",
        ];
        needsSave = true;
      }
    }

    // 5. 如果有任何更改或这是新对象，则保存到数据库
    if (needsSave) {
      await _isar.writeTxn(() async {
        // 此处的 settings! 是安全的，因为如果它开始时为 null，则已被赋值
        await _isar.allSettings.put(settings!);
      });
    }
  }

  // getListenList
  Future<List<String>> getListenList() async {
    AllSettings? config = await _isar.allSettings.get(1);
    if (config?.listenList == null) return [];
    return config!.listenList!;
  }

  // 设置监听列表
  Future<void> setListenList(List<String> listenList) async {
    AllSettings? config = await _isar.allSettings.get(1);
    if (config != null) {
      config.listenList = listenList;
      await _isar.writeTxn(() async {
        await _isar.allSettings.put(config);
      });
    }
  }

  // 删除监听列表
  Future<void> deleteListenList(int index) async {
    AllSettings? config = await _isar.allSettings.get(1);
    if (config != null) {
      config.listenList!.removeAt(index);
      await _isar.writeTxn(() async {
        await _isar.allSettings.put(config);
      });
    }
  }

  // 添加监听列表
  Future<void> addListenList(String listen) async {
    AllSettings? config = await _isar.allSettings.get(1);
    if (config != null) {
      config.listenList!.add(listen);
      await _isar.writeTxn(() async {
        await _isar.allSettings.put(config);
      });
    }
  }

  // 修改监听列表
  Future<void> updateListenList(int index, String listen) async {
    AllSettings? config = await _isar.allSettings.get(1);
    if (config != null) {
      config.listenList![index] = listen;
      await _isar.writeTxn(() async {
        await _isar.allSettings.put(config);
      });
    }
  }

  // 设置房间
  Future<void> updateRoom(Room room) async {
    AllSettings? config = await _isar.allSettings.get(1);
    if (config != null) {
      config.room = room.id;
      await _isar.writeTxn(() async {
        await _isar.allSettings.put(config);
      });
    }
  }

  // 获取当前房间ID
  Future<Room?> getRoom() async {
    AllSettings? config = await _isar.allSettings.get(1);
    if (config?.room == null) return null;
    return await _isar.rooms.get(config!.room!);
  }

  // 获取所有设置
  Future<AllSettings?> getAllSettings() async {
    return await _isar.allSettings.get(1);
  }

  // 设定玩家名称
  Future<void> setPlayerName(String name) async {
    AllSettings? config = await _isar.allSettings.get(1);
    if (config != null) {
      config.playerName = name;
      await _isar.writeTxn(() async {
        await _isar.allSettings.put(config);
      });
    }
  }

  // 获取玩家名称
  Future<String> getPlayerName() async {
    AllSettings? config = await _isar.allSettings.get(1);
    if (config?.playerName == null) {
      String deviceName = await _getDeviceName();
      await setPlayerName(deviceName);
      return deviceName;
    }
    return config!.playerName!;
  }
}

// 在同一个文件中添加这个方法
Future<String> _getDeviceName() async {
  try {
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();

    if (Platform.isAndroid) {
      AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
      return androidInfo.model;
    } else if (Platform.isIOS) {
      IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
      return iosInfo.name;
    } else if (Platform.isWindows) {
      WindowsDeviceInfo windowsInfo = await deviceInfo.windowsInfo;
      return windowsInfo.computerName;
    } else if (Platform.isMacOS) {
      MacOsDeviceInfo macOSInfo = await deviceInfo.macOsInfo;
      return macOSInfo.computerName;
    } else if (Platform.isLinux) {
      LinuxDeviceInfo linuxInfo = await deviceInfo.linuxInfo;
      return linuxInfo.name;
    }

    return "Default Player"; // 如果无法获取设备名称，则使用默认名称
  } catch (e) {
    return "Default Player"; // 错误处理，返回默认名称
  }
}
