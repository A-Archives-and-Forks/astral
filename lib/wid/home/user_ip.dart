import 'package:astral/k/app_s/aps.dart';
import 'package:astral/wid/home_box.dart';
import 'package:astral/wid/canvas_jump.dart';
import 'package:astral/k/models/room.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';

class UserIpBox extends StatefulWidget {
  const UserIpBox({super.key});

  @override
  State<UserIpBox> createState() => _UserIpBoxState();
}

class _UserIpBoxState extends State<UserIpBox> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _virtualIPController = TextEditingController();
  final TextEditingController _roomController = TextEditingController();

  final FocusNode _usernameControllerFocusNode = FocusNode();
  final FocusNode _virtualIPFocusNode = FocusNode();

  final Aps _aps = Aps();
  bool _isValidIP = true;

  bool _isValidIPv4(String ip) {
    // 检查是否包含子网掩码格式
    final parts = ip.split('/');
    if (parts.length > 2) return false;

    // 验证IP地址部分
    final ipPart = parts[0];
    if (ipPart.isEmpty) return false;

    // 优化IP地址验证逻辑
    final octets = ipPart.split('.');
    if (octets.length != 4) return false;

    for (final octet in octets) {
      try {
        final value = int.parse(octet);
        if (value < 0 || value > 255) return false;
      } catch (e) {
        return false;
      }
    }

    // 如果包含子网掩码，验证子网掩码部分
    if (parts.length == 2) {
      final maskPart = parts[1];
      if (maskPart.isEmpty) return false;

      try {
        final mask = int.parse(maskPart);
        if (mask < 0 || mask > 32) return false;
      } catch (e) {
        return false;
      }
    }

    return true;
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // 初始化时同步一次状态
      effect(() {
        // 只在控件没有焦点时才更新，避免与用户输入冲突
        if (!_usernameControllerFocusNode.hasFocus) {
          _usernameController.text = _aps.PlayerName.value; // 监听玩家名变化
        }
        if (!_virtualIPFocusNode.hasFocus) {
          final newIP = _aps.ipv4.value;
          _virtualIPController.text = newIP; // 监听IP地址变化
          // 同时更新验证状态
          setState(() {
            _isValidIP = _isValidIPv4(newIP);
          });
        }
        // 房间选择器不是文本输入框，可以直接更新
        _roomController.text = _aps.selectroom.value?.name ?? ''; // 监听房间选择变化
      });

      // 初始化验证状态
      setState(() {
        _isValidIP = _isValidIPv4(_virtualIPController.text);
      });
    });
  }

  @override
  void dispose() {
    // 清理监听器
    _usernameController.dispose();
    _virtualIPController.dispose();
    _usernameControllerFocusNode.dispose();
    _virtualIPFocusNode.dispose();
    _roomController.dispose();
    super.dispose();
  }

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
              Icon(Icons.network_check, color: colorScheme.primary, size: 22),
              const SizedBox(width: 8),
              const Text(
                '网络状态',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400),
              ),
              const Spacer(),
              // 添加状态指示器
              Container(
                margin: const EdgeInsets.only(right: 4), 
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: _getStatusColor(
                    Aps().Connec_state.watch(context),
                    colorScheme,
                  ),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  _getStatusText(Aps().Connec_state.watch(context)),
                  style: TextStyle(
                    color: colorScheme.onPrimary,
                    fontSize: 12,
                    fontWeight: FontWeight.w300,
                  ),
                ),
              ),
            ],
          ),

          if (Aps().ipv4.watch(context).isNotEmpty) ...[
            const SizedBox(height: 6),
            Wrap(
              spacing: 8,
              children: [
                Icon(Icons.public, size: 20, color: colorScheme.primary),
                const Text(
                  '虚拟IP: ',
                  style: TextStyle(fontWeight: FontWeight.w700),
                ),
                Text(
                  Aps().ipv4.watch(context),
                  style: TextStyle(color: colorScheme.secondary),
                ),
              ],
            ),
          ],
          const SizedBox(height: 16),
          TextField(
            controller: _usernameController,
            focusNode: _usernameControllerFocusNode,
            enabled:
                (Aps().Connec_state.watch(context) != CoState.idle)
                    ? false
                    : true,
            onChanged: (value) {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                _aps.updatePlayerName(value);
              });
            },
            decoration: InputDecoration(
              labelText: '玩家昵称',
              hintText: '输入喜欢的名字',
              border: const OutlineInputBorder(),
              prefixIcon: Icon(Icons.person, color: colorScheme.primary),
              floatingLabelBehavior: FloatingLabelBehavior.always,
              contentPadding: const EdgeInsets.symmetric(
                vertical: 12,
                horizontal: 12,
              ),
            ),
          ),

          // InkWell(
          //   onTap:
          //       Aps().Connec_state.watch(context) != CoState.connected
          //           ? () => CanvasJump.show(
          //             context,
          //             rooms: _aps.rooms.watch(context).cast<Room>(),
          //             onSelect: (Room room) {
          //               _aps.setRoom(room);
          //             },
          //           )
          //           : null,
          //   child: InputDecorator(
          //     decoration: InputDecoration(
          //       labelText: '选择房间',
          //       contentPadding: const EdgeInsets.symmetric(
          //         vertical: 12,
          //         horizontal: 12,
          //       ),
          //       floatingLabelBehavior: FloatingLabelBehavior.always,
          //       enabled: Aps().Connec_state.watch(context) == CoState.idle,
          //       border: const OutlineInputBorder(),
          //       prefixIcon: Icon(Icons.apartment, color: colorScheme.primary),
          //       suffixIcon: Icon(Icons.menu, color: colorScheme.primary),
          //     ),
          //     child: IgnorePointer(
          //       ignoring:
          //           Aps().Connec_state.watch(context) == CoState.connected,
          //       child: Text(
          //         Aps().selectroom.watch(context)?.name ?? '请选择房间',
          //         style: TextStyle(
          //           color:
          //               Aps().Connec_state.watch(context) != CoState.connected
          //                   ? Theme.of(context).textTheme.bodyLarge?.color
          //                   : Theme.of(context).disabledColor,
          //         ),
          //       ),
          //     ),
          //   ),
          // ),

          // const SizedBox(height: 9),

          // SizedBox(
          //   height: 60,
          //   child: Row(
          //     children: [
          //       Expanded(
          //         child: TextField(
          //           controller: _virtualIPController,
          //           focusNode: _virtualIPFocusNode,
          //           enabled:
          //               !_aps.dhcp.watch(context) &&
          //               (Aps().Connec_state.watch(context) == CoState.idle),
          //           onChanged: (value) {
          //             if (!_aps.dhcp.watch(context)) {
          //               // 实时更新IPv4值并立即验证
          //               _aps.updateIpv4(value);
          //               setState(() {
          //                 _isValidIP = _isValidIPv4(value);
          //               });
          //             }
          //           },
          //           decoration: InputDecoration(
          //             labelText: '虚拟网IP',
          //             // 添加提示文本
          //             hintText: '不明白的话自动即可',
          //             border: const OutlineInputBorder(),
          //             prefixIcon: Icon(Icons.lan, color: colorScheme.primary),
          //             floatingLabelBehavior: FloatingLabelBehavior.always,
          //             contentPadding: const EdgeInsets.symmetric(
          //               vertical: 12,
          //               horizontal: 12,
          //             ),
          //             errorText:
          //                 (!_aps.dhcp.watch(context) && !_isValidIP)
          //                     ? '请输入有效的IPv4地址'
          //                     : null,
          //           ),
          //         ),
          //       ),
          //       const SizedBox(width: 8),
          //       Column(
          //         mainAxisAlignment: MainAxisAlignment.center,
          //         children: [
          //           Switch(
          //             value: _aps.dhcp.watch(context),
          //             onChanged: (value) {
          //               if (Aps().Connec_state.watch(context) == CoState.idle) {
          //                 _aps.updateDhcp(value);
          //               }
          //             },
          //           ),
          //           Text(
          //             _aps.dhcp.watch(context) ? "自动" : "手动",
          //             style: const TextStyle(fontSize: 12),
          //           ),
          //         ],
          //       ),
          //     ],
          //   ),
          // ),

          // if (_aps.dhcp.watch(context))
          //   const Padding(
          //     padding: EdgeInsets.only(top: 8.0),
          //     child: Text('系统将自动分配虚拟网IP', style: TextStyle(fontSize: 12)),
          //   )
          // else
          //   const SizedBox(height: 12),
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
