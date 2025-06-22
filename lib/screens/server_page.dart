import 'package:astral/fun/show_server_dialog.dart';
import 'package:astral/k/app_s/aps.dart';
import 'package:astral/k/models/server_mod.dart';
import 'package:astral/wid/server_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:isar/isar.dart';
import 'package:astral/wid/server_reorder_sheet.dart';
import 'package:astral/wid/public_servers_dialog.dart'; // 新增公共服务器对话框导入
import 'dart:async'; // 添加Timer导入


class ServerPage extends StatefulWidget {
  const ServerPage({super.key});

  @override
  State<ServerPage> createState() => _ServerPageState();
}

class _ServerPageState extends State<ServerPage> with WidgetsBindingObserver, SingleTickerProviderStateMixin {
  int _getColumnCount(double width) {
    if (width >= 1200) {
      return 4;
    } else if (width >= 900) {
      return 3;
    } else if (width >= 600) {
      return 2;
    }
    return 1;
  }

  final _aps = Aps();
  late TickerProvider _tickerProvider;
  late AnimationController _animationController;
  late Timer _updateTimer;
  bool _isForeground = true;
  bool _isVisible = true;

  @override
  void initState() {
    super.initState();
    
    // 使用mixin提供的vsync实现
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    
    // 初始加载服务器列表
    _loadServers();
    
    // 添加生命周期监听
    WidgetsBinding.instance.addObserver(this);
    
    // 启动初始更新定时器
    _startUpdateTimer();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // 检查页面可见性
    final isVisible = ModalRoute.of(context)?.isCurrent ?? false;
    if (isVisible != _isVisible) {
      _isVisible = isVisible;
      _restartUpdateTimer();
    }
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    // 更新应用前后台状态
    final isForeground = state == AppLifecycleState.resumed;
    if (isForeground != _isForeground) {
      _isForeground = isForeground;
      _restartUpdateTimer();
    }
  }

  void _startUpdateTimer() {
    final interval = _calculateUpdateInterval();
    _updateTimer = Timer.periodic(interval, (timer) async {
      if (mounted && _isVisible && _isForeground) {
        await _aps.getAllServers();
        setState(() {}); // 强制刷新UI
      }
    });
    
    // 立即触发一次更新
    if (mounted && _isVisible && _isForeground) {
      _updateServers();
    }
  }

  void _restartUpdateTimer() {
    if (_updateTimer.isActive) {
      _updateTimer.cancel();
    }
    _startUpdateTimer();
  }

  Duration _calculateUpdateInterval() {
    if (_isForeground && _isVisible) {
      return const Duration(seconds: 5);
    }
    return const Duration(seconds: 30);
  }

  Future<void> _updateServers() async {
    await _aps.getAllServers();
    if (mounted) {
      setState(() {}); // 强制刷新UI
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    _updateTimer.cancel();
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  Future<void> _loadServers() async {
    await _aps.getAllServers();
  }

  @override
  Widget build(BuildContext context) {
    // 监听连接状态
    final isConnected = _aps.Connec_state.watch(context);
    // 获取服务器列表并添加自动监听
    final servers = _aps.servers.watch(context);
    
    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          final columnCount = _getColumnCount(constraints.maxWidth);
          
          // 强制创建新的列表实例以触发更新
          final List<ServerMod> displayServers = List.from(servers);
          
          // 添加唯一标识符确保布局强制重建
          final layoutKey = ValueKey('layout_${columnCount}_${servers.length}');
          
          return CustomScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            slivers: [
              // 如果服务器列表为空，显示提示信息
              if (servers.isEmpty)
                SliverFillRemaining(
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.dns_outlined,
                          size: 80,
                          color: Theme.of(context).colorScheme.outline,
                        ),
                        const SizedBox(height: 24),
                        Text(
                          '暂无服务器',
                          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                            color: Theme.of(context).colorScheme.onSurfaceVariant,
                          ),
                        ),
                        const SizedBox(height: 12),
                        Text(
                          '点击右下角星球按钮添加公共服务器',
                          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: Theme.of(context).colorScheme.outline,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          '或点击加号按钮手动添加服务器',
                          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: Theme.of(context).colorScheme.outline,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                )
              else if (columnCount == 1)
                SliverPadding(
                  key: ValueKey('list_layout_${columnCount}_${servers.hashCode}'),
                  padding: const EdgeInsets.all(14),
                  sliver: SliverList.separated(
                    itemCount: displayServers.length,
                    itemBuilder: (context, index) {
                      final server = displayServers[index];
                      return ServerCard(
                        key: ValueKey(server.id),
                        server: server,
                        onEdit: () {
                          showEditServerDialog(context, server: server);
                        },
                        onDelete: () {
                          _showDeleteConfirmDialog(server);
                        },
                      );
                    },
                    separatorBuilder: (context, index) => const SizedBox(height: 12),
                  ),
                )
              else
                SliverPadding(
                  key: ValueKey('grid_layout_${columnCount}_${servers.hashCode}'),
                  padding: const EdgeInsets.all(14),
                  sliver: SliverMasonryGrid.count(
                    crossAxisCount: columnCount,
                    mainAxisSpacing: 12,
                    crossAxisSpacing: 12,
                    childCount: displayServers.length,
                    itemBuilder: (context, index) {
                      final server = displayServers[index];
                      return ServerCard(
                        server: server,
                        onEdit: () {
                          showEditServerDialog(context, server: server);
                        },
                        onDelete: () {
                          _showDeleteConfirmDialog(server);
                        },
                      );
                    },
                  ),
                ),
              // 添加底部安全区域，防止内容被遮挡
              SliverToBoxAdapter(
                child: SizedBox(
                  height: MediaQuery.of(context).padding.bottom + 20,
                ),
              ),
            ],
          );
        },
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            heroTag: 'server_sort',
            onPressed: () async {
              final currentServers = _aps.servers.value;
              final reorderedServers = await ServerReorderSheet.show(context, currentServers);
              if (reorderedServers != null && mounted) {
                await _aps.reorderServers(reorderedServers);
                // 使用更可靠的状态更新方式
                setState(() {
                  // 使用展开运算符确保生成新列表实例
                  _aps.servers.value = [...reorderedServers];
                });
              }
            },
            child: const Icon(Icons.sort),
          ),
          const SizedBox(width: 16),
          FloatingActionButton(
            heroTag: 'public_servers_dialog',
            onPressed: () => _showPublicServersDialog(),
            child: const Icon(Icons.public),
          ),
          const SizedBox(width: 16),
          FloatingActionButton(
            heroTag: '添加服务器',
            onPressed: () => showAddServerDialog(context),
            child: const Icon(Icons.add),
          ),
        ],
      ),
    );
  }

  // 显示公共服务器列表对话框
  void _showPublicServersDialog() {
    PublicServersDialog.show(context, _addPublicServer);
  }

  // 添加公共服务器
  void _addPublicServer(String name, String url) {
    final server = ServerMod(
      id: Isar.autoIncrement,
      enable: false,
      name: name,
      url: url,
      tcp: true,
      udp: false,
      ws: false,
      wss: false,
      quic: false,
      wg: false,
      txt: false,
      srv: false,
      http: false,
      https: false,
    );

    _aps.addServer(server);
    // 强制触发服务器列表更新
    _aps.servers.value = [..._aps.servers.value];
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('已添加服务器: $name')),
    );
  }

  // 显示删除确认对话框
  void _showDeleteConfirmDialog(ServerMod server) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('删除服务器'),
        content: Text('确定要删除服务器 "${server.name}" 吗？此操作不可撤销。'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('取消'),
          ),
          TextButton(
            onPressed: () {
              _aps.deleteServer(server);
              Navigator.of(context).pop();
            },
            style: TextButton.styleFrom(foregroundColor: Colors.red),
            child: const Text('删除'),
          ),
        ],
      ),
    );
  }
}
