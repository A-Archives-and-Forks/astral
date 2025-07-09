import 'package:astral/k/app_s/aps.dart';
import 'package:astral/src/rust/api/simple.dart';
import 'package:astral/wid/all_user_card.dart';
import 'package:astral/wid/mini_user_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:astral/wid/room_settings_sheet.dart';

class UserPage extends StatefulWidget {
  const UserPage({super.key});

  @override
  State<UserPage> createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    // 使用 Riverpod 监听节点数据
    return Scaffold(
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () => RoomSettingsSheet.show(context),
      //   child: const Icon(Icons.bar_chart),
      //   tooltip: '房间设置',
      // ),
      body: Builder(
        builder: (context) {
          final netStatus = Aps().netStatus.watch(context);
          if (!Aps().isConnecting.watch(context)) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.cloud_off_rounded,
                    size: 48,
                    color: colorScheme.primary,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    '无数据',
                    style: TextStyle(
                      color: colorScheme.primary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            );
          } else if (netStatus == null || netStatus.nodes.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.people_outline,
                    size: 64,
                    color: colorScheme.primary.withOpacity(0.6),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    '房间内暂无成员',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: colorScheme.primary,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '当前没有其他玩家连接到房间',
                    style: TextStyle(
                      color: colorScheme.onSurface.withOpacity(0.7),
                    ),
                  ),
                ],
              ),
            );
          } else {
            // 获取排序选项
            // final sortOption = Aps().sortOption.watch(context);
            // 获取排序顺序
            // final sortOrder = Aps().sortOrder.watch(context);
            // 获取原始节点列表
            var nodes = Aps().netStatus.watch(context)!.nodes;
            nodes.sort((a, b) {
              return a.latencyMs.compareTo(b.latencyMs);
            });
            // // 根据排序选项对节点进行排序
            // if (sortOption == 1) {
            //   // 按延迟排序
            //   nodes.sort((a, b) {
            //     int comparison = a.latencyMs.compareTo(b.latencyMs);
            //     return sortOrder == 0 ? comparison : -comparison;
            //   });
            // } else if (sortOption == 2) {
            //   // 按用户名长度排序
            //   nodes.sort((a, b) {
            //     int comparison = a.hostname.length.compareTo(b.hostname.length);
            //     return sortOrder == 0 ? comparison : -comparison;
            //   });
            // }
            // 如果sortOption为0，则不排序

            // 根据显示模式过滤节点
            List<KVNodeInfo> filteredNodes = nodes;
            // 仅显示用户（排除服务器）
            filteredNodes =
                nodes
                    .where((node) => !node.hostname.startsWith('PublicServer_'))
                    .toList();

            // 根据搜索查询过滤节点
            if (_searchQuery.isNotEmpty) {
              filteredNodes =
                  filteredNodes
                      .where(
                        (node) => node.hostname.toLowerCase().contains(
                          _searchQuery.toLowerCase(),
                        ),
                      )
                      .toList();
            }

            // 返回一个可滚动的视图
            return Column(
              children: [
                // 搜索框
                Container(
                  padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
                  child: TextField(
                    controller: _searchController,
                    decoration: InputDecoration(
                      hintText: '搜索玩家名称...',
                      prefixIcon: const Icon(Icons.search),
                      suffixIcon:
                          _searchQuery.isNotEmpty
                              ? IconButton(
                                icon: const Icon(Icons.clear),
                                onPressed: () {
                                  _searchController.clear();
                                  setState(() {
                                    _searchQuery = '';
                                  });
                                },
                              )
                              : null,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(
                          color: colorScheme.outline.withOpacity(0.5),
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(
                          color: colorScheme.outline.withOpacity(0.5),
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(
                          color: colorScheme.primary,
                          width: 2,
                        ),
                      ),
                      filled: true,
                      fillColor: colorScheme.surface,
                    ),
                    onChanged: (value) {
                      setState(() {
                        _searchQuery = value;
                      });
                    },
                  ),
                ),
                // 显示搜索结果数量
                if (_searchQuery.isNotEmpty)
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 4,
                    ),
                    alignment: Alignment.centerLeft,
                    child: Text(
                      '找到 ${filteredNodes.length} 个玩家',
                      style: TextStyle(
                        color: colorScheme.onSurface.withOpacity(0.7),
                        fontSize: 12,
                      ),
                    ),
                  ),
                // 玩家列表
                Expanded(
                  child:
                      filteredNodes.isEmpty && _searchQuery.isNotEmpty
                          ? Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.search_off,
                                  size: 64,
                                  color: colorScheme.primary.withOpacity(0.6),
                                ),
                                const SizedBox(height: 16),
                                Text(
                                  '未找到匹配的玩家',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: colorScheme.primary,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  '尝试使用不同的搜索关键词',
                                  style: TextStyle(
                                    color: colorScheme.onSurface.withOpacity(
                                      0.7,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          )
                          : CustomScrollView(
                            // 始终允许滚动,即使内容不足一屏
                            physics: const AlwaysScrollableScrollPhysics(),
                            slivers: [
                              // 为网格添加内边距
                              SliverPadding(
                                padding: const EdgeInsets.fromLTRB(
                                  12,
                                  0,
                                  12,
                                  0,
                                ),
                                // 使用瀑布流网格布局
                                sliver: SliverMasonryGrid(
                                  // 配置网格布局参数
                                  gridDelegate:
                                      SliverSimpleGridDelegateWithFixedCrossAxisCount(
                                        // 根据屏幕宽度动态计算列数
                                        crossAxisCount: _getColumnCount(
                                          MediaQuery.of(context).size.width,
                                        ),
                                      ),
                                  // 设置网格项之间的间距
                                  mainAxisSpacing: 8.0,
                                  crossAxisSpacing: 8.0,
                                  // 配置子项构建器
                                  delegate: SliverChildBuilderDelegate(
                                    (context, index) {
                                      // 获取当前索引对应的玩家数据
                                      final player = filteredNodes[index];
                                      // 根据简单列表模式选项返回不同的卡片组件
                                      return MiniUserCard(
                                        player: player,
                                        colorScheme: colorScheme,
                                        localIPv4: Aps().ipv4.watch(context),
                                      );
                                    },
                                    // 设置子项数量为过滤后的节点数量
                                    childCount: filteredNodes.length,
                                  ),
                                ),
                              ),
                            ],
                          ),
                ),
              ],
            );
          }
        },
      ),
    );
  }

  // 根据宽度计算列数
  int _getColumnCount(double width) {
    if (width >= 1200) {
      return 3;
    } else if (width >= 900) {
      return 2;
    }
    return 1; // 窄屏使用单列
  }
}

// 新建 StatefulWidget 来管理列表项的悬停状态
class PlayerListItem extends StatefulWidget {
  final KVNodeInfo player;
  final ColorScheme colorScheme;
  final String? localIPv4; // 需要传入本地 IP
  // 将辅助函数作为参数传递，或者定义为顶层/静态函数
  final Color Function(double) getLatencyColor;
  final IconData Function(String) getConnectionIcon;
  final String Function(int, String, String?) mapConnectionType;
  final Widget Function(KVNodeInfo, ColorScheme, Color, IconData, String?)
  buildDesktopPlayerListItem; // 传递构建函数

  const PlayerListItem({
    required Key key,
    required this.player,
    required this.colorScheme,
    required this.localIPv4,
    required this.getLatencyColor,
    required this.getConnectionIcon,
    required this.mapConnectionType,
    required this.buildDesktopPlayerListItem,
  }) : super(key: key);

  @override
  State<PlayerListItem> createState() => _PlayerListItemState();
}

class _PlayerListItemState extends State<PlayerListItem> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    // 从 widget 属性获取数据和函数
    final player = widget.player;
    final colorScheme = widget.colorScheme;
    final localIPv4 = widget.localIPv4;

    // 调用传递进来的辅助函数
    final latencyColor = widget.getLatencyColor(player.latencyMs);
    final connectionType = widget.mapConnectionType(
      player.cost,
      player.ipv4,
      localIPv4,
    );
    final connectionIcon = widget.getConnectionIcon(connectionType);

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
          side: BorderSide(
            color: _isHovered ? colorScheme.primary : Colors.transparent,
            width: 1,
          ),
        ),
        child: InkWell(
          onTap: () {
            // 如果需要 onTap 功能，在这里实现
          },
          splashColor: colorScheme.primary.withOpacity(0.3),
          highlightColor: colorScheme.primary.withOpacity(0.1),
          borderRadius: BorderRadius.circular(8),
          child: Container(
            padding: const EdgeInsets.all(12),
            width: double.infinity,
            // 调用传递进来的桌面布局构建函数
            child: widget.buildDesktopPlayerListItem(
              player,
              colorScheme,
              latencyColor,
              connectionIcon,
              localIPv4, // 可能需要传递 localIPv4 给 desktop builder
            ),
          ),
        ),
      ),
    );
  }
}
