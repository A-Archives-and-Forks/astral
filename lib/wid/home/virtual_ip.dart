import 'dart:io';
import 'package:astral/k/app_s/aps.dart';
import 'package:astral/wid/home_box.dart';
import 'package:flutter/material.dart';

// 添加模拟数据模型
class NetworkNode {
  final String id;
  final String name;
  final bool isServer;
  final List<NetworkConnection> connections;

  NetworkNode({
    required this.id,
    required this.name,
    this.isServer = false,
    this.connections = const [],
  });
}

class NetworkConnection {
  final String targetId;
  final int latency; // 毫秒

  NetworkConnection({required this.targetId, required this.latency});
}

class VirtualIpBox extends StatelessWidget {
  const VirtualIpBox({super.key});

  @override
  Widget build(BuildContext context) {
    var colorScheme = Theme.of(context).colorScheme;
    return HomeBox(
      widthSpan: 2,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.tab, color: colorScheme.primary, size: 22),
              const SizedBox(width: 8),
              const Text(
                '游戏介绍',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400),
              ),
            ],
          ),
          SizedBox(
            height: 350,
          )
        ],
      ),
    );
  }
}

// 获取状态颜色
Color _getStatusColor(CoState state, ColorScheme colorScheme) {
  switch (state) {
    case CoState.idle:
      return Colors.grey;
    case CoState.connecting:
      return Colors.orange;
    case CoState.connected:
      return Colors.green;
  }
}

// 获取状态文本
String _getStatusText(CoState state) {
  switch (state) {
    case CoState.idle:
      return '未连接';
    case CoState.connecting:
      return '连接中';
    case CoState.connected:
      return '已连接';
  }
}
