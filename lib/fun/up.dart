import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'package:astral/k/app_s/aps.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:package_info_plus/package_info_plus.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:path_provider/path_provider.dart';
import 'package:open_file/open_file.dart';

class UpdateChecker {
  /// GitHub 仓库所有者
  final String owner;

  /// GitHub 仓库名称
  final String repo;

  /// 可选：指定检查的分支名称，默认为 'main'
  final String branch;

  UpdateChecker({
    required this.owner,
    required this.repo,
    this.branch = 'main',
  });

/// 检查更新
Future<void> checkForUpdates(BuildContext context, {bool showNoUpdateMessage = true}) async {
  try {
    final releaseInfo = await _fetchLatestRelease(includePrereleases: Aps().beta.value);
    if (releaseInfo == null) {
      _showUpdateDialog(
        context,
        '检查更新失败',
        '无法获取最新版本信息',
        'https://github.com/$owner/$repo/releases',
      );
      return;
    }

    // 获取当前应用版本
    final currentVersion = await _getCurrentVersion();
    debugPrint('当前版本: $currentVersion');
    debugPrint('服务器版本: ${releaseInfo['tag_name']}');
    
    // 比较版本号，如果有新版本则显示更新弹窗
    // 在 checkForUpdates 方法中修改 _showUpdateDialog 调用
    if (_shouldUpdate(currentVersion, releaseInfo['tag_name'])) {
      _showUpdateDialog(
        context,
        releaseInfo['tag_name'],
        releaseInfo['body'] ?? '新版本已发布',
        releaseInfo['html_url'],
        releaseInfo: releaseInfo, // 传递完整的 release 信息
      );
    } else if (showNoUpdateMessage) {
      _showUpdateDialog(
        context,
        '当前已是最新版本',
        '当前版本为: $currentVersion',
        'https://github.com/$owner/$repo/releases',
      );
    }
  } catch (e) {
    _showUpdateDialog(
      context,
      '更新检查失败',
      '检查更新时发生错误: $e',
      'https://github.com/$owner/$repo/releases',
    );
  }
}

  /// 获取最新发布版本信息
  Future<Map<String, dynamic>?> _fetchLatestRelease({bool includePrereleases = false}) async {
    try {
      // 根据 includePrereleases 参数选择不同的 API 端点
      final apiUrl = includePrereleases 
          ? 'https://api.github.com/repos/$owner/$repo/releases'  // 获取所有版本
          : 'https://api.github.com/repos/$owner/$repo/releases/latest';  // 只获取最新稳定版
      
      final response = await http.get(
        Uri.parse(apiUrl),
        headers: {
          'Accept': 'application/vnd.github.v3+json',
          'User-Agent': 'astral',
        },
      );

      if (response.statusCode == 200) {
        if (includePrereleases) {
          // 获取所有版本，返回第一个（最新的，可能是预发布版）
          final List<dynamic> releases = json.decode(response.body);
          if (releases.isEmpty) return null;
          return releases[0];
        } else {
          // 获取最新稳定版
          return json.decode(response.body);
        }
      } else {
        return {
          // 返回错误信息
          'tag_name': '错误 ${response.statusCode}',
          'body': '请求GitHub API失败',
          'html_url': 'https://github.com/$owner/$repo/releases',
        };
      }
    } catch (e) {
      return null;
    }
  }

  /// 获取当前应用版本
  Future<String> _getCurrentVersion() async {
    try {
      return AppInfoUtil.getVersion();
    } catch (e) {
      return "0.0.0"; // 返回默认版本号避免后续比较崩溃
    }
  }

  /// 比较版本号，判断是否需要更新
  bool _shouldUpdate(String currentVersion, String latestVersion) {
    // 统一去除v前缀
    final current = currentVersion.replaceAll(RegExp(r'^v'), '');
    final latest = latestVersion.replaceAll(RegExp(r'^v'), '');

    // 分离主版本和预发布标签
    final currentParts = current.split('-');
    final latestParts = latest.split('-');

    // 比较主版本部分
    final currentMain = _parseVersionParts(currentParts[0]);
    final latestMain = _parseVersionParts(latestParts[0]);

    for (int i = 0; i < 3; i++) {
      final curr = i < currentMain.length ? currentMain[i] : 0;
      final lat = i < latestMain.length ? latestMain[i] : 0;

      if (lat > curr) return true;
      if (lat < curr) return false;
    }

    // 主版本相同，比较预发布标签
    if (currentParts.length == 1) return latestParts.length > 1; // 当前是正式版
    if (latestParts.length == 1) return true; // 最新是正式版

    return _comparePreRelease(currentParts[1], latestParts[1]) < 0;
  }

  List<int> _parseVersionParts(String version) {
    return version.split('.').map((s) => int.tryParse(s) ?? 0).toList();
  }

  int _comparePreRelease(String a, String b) {
    final aParts = a.split('.');
    final bParts = b.split('.');

    for (int i = 0; i < max(aParts.length, bParts.length); i++) {
      final aVal = i < aParts.length ? aParts[i] : '';
      final bVal = i < bParts.length ? bParts[i] : '';

      // 优先比较数字
      final aNum = int.tryParse(aVal);
      final bNum = int.tryParse(bVal);

      if (aNum != null && bNum != null) {
        if (aNum != bNum) return aNum.compareTo(bNum);
      } else {
        final cmp = aVal.compareTo(bVal);
        if (cmp != 0) return cmp;
      }
    }
    return 0;
  }

  /// 显示更新弹窗
  void _showUpdateDialog(
    BuildContext context,
    String version,
    String releaseNotes,
    String downloadUrl, {
    Map<String, dynamic>? releaseInfo,
  }) {
    final isLatestVersion = version.contains("当前已是最新版本");

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => _UpdateDialog(
        version: version,
        releaseNotes: releaseNotes,
        downloadUrl: downloadUrl,
        isLatestVersion: isLatestVersion,
        releaseInfo: releaseInfo,
        onDownload: releaseInfo != null ? () => _handleDownload(context, releaseInfo) : null,
      ),
    );
  }

  /// 处理下载逻辑
  Future<void> _handleDownload(BuildContext context, Map<String, dynamic> releaseInfo) async {
    final downloadUrl = _getDownloadUrl(releaseInfo);
    if (downloadUrl == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('当前平台不支持自动下载，请手动下载')),
      );
      return;
    }

    final fileName = _getPlatformFileName();
    
    // 显示下载进度对话框
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => _DownloadProgressDialog(
        onDownload: (onProgress) => _downloadFile(downloadUrl, fileName, onProgress),
        fileName: fileName,
      ),
    );
  }

  /// 根据平台获取对应的下载文件名
  String _getPlatformFileName() {
    if (Platform.isAndroid) {
      return 'app-release-arm64-v8a.apk';
    } else if (Platform.isWindows) {
      return 'Astralsetup.exe';
    } else {
      // 其他平台暂不支持直接下载
      return '';
    }
  }

  /// 从release信息中获取对应平台的下载链接
  String? _getDownloadUrl(Map<String, dynamic> releaseInfo) {
    final fileName = _getPlatformFileName();
    if (fileName.isEmpty) return null;

    final assets = releaseInfo['assets'] as List<dynamic>?;
    if (assets == null) return null;

    for (final asset in assets) {
      if (asset['name'] == fileName) {
        return asset['browser_download_url'];
      }
    }
    return null;
  }

  /// 下载文件并显示进度
  Future<String?> _downloadFile(String url, String fileName, Function(double) onProgress) async {
    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode != 200) return null;

      final bytes = response.bodyBytes;
      final dir = await getTemporaryDirectory();
      final file = File('${dir.path}/$fileName');

      // 模拟下载进度（实际项目中应该使用流式下载）
      await file.writeAsBytes(bytes);
      onProgress(1.0); // 下载完成

      return file.path;
    } catch (e) {
      return null;
    }
  }

}

class AppInfoUtil {
  static PackageInfo? _packageInfo;

  /// 初始化应用信息
  static Future<void> init() async {
    _packageInfo = await PackageInfo.fromPlatform();
  }

  /// 获取应用版本号 (例如: 1.0.0)
  static String getVersion() {
    return _packageInfo?.version ?? '';
  }

  /// 获取应用构建号 (例如: 1)
  static String getBuildNumber() {
    return _packageInfo?.buildNumber ?? '';
  }

  /// 获取完整版本号 (例如: 1.0.0+1)
  static String getFullVersion() {
    final version = getVersion();
    final buildNumber = getBuildNumber();
    return '$version+$buildNumber';
  }

  /// 获取应用名称
  static String getAppName() {
    return _packageInfo?.appName ?? '';
  }

  /// 获取包名
  static String getPackageName() {
    return _packageInfo?.packageName ?? '';
  }
}

/// 更新对话框组件
class _UpdateDialog extends StatelessWidget {
  final String version;
  final String releaseNotes;
  final String downloadUrl;
  final bool isLatestVersion;
  final Map<String, dynamic>? releaseInfo;
  final VoidCallback? onDownload;

  const _UpdateDialog({
    required this.version,
    required this.releaseNotes,
    required this.downloadUrl,
    required this.isLatestVersion,
    this.releaseInfo,
    this.onDownload,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(isLatestVersion ? version : '发现新版本: $version'),
      content: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            if (!isLatestVersion) const Text('更新内容:'),
            if (!isLatestVersion) const SizedBox(height: 8),
            Text(releaseNotes, style: const TextStyle(fontSize: 14)),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('稍后再说'),
        ),
        if (!isLatestVersion && onDownload != null)
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop();
              onDownload!();
            },
            child: const Text('立即更新'),
          ),
        if (!isLatestVersion && onDownload == null)
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop();
              _launchUrl(downloadUrl);
            },
            child: const Text('手动下载'),
          ),
        if (isLatestVersion)
          ElevatedButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('确定'),
          ),
      ],
    );
  }

  Future<void> _launchUrl(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }
}

/// 下载进度对话框组件
class _DownloadProgressDialog extends StatefulWidget {
  final Future<String?> Function(Function(double) onProgress) onDownload;
  final String fileName;

  const _DownloadProgressDialog({
    required this.onDownload,
    required this.fileName,
  });

  @override
  State<_DownloadProgressDialog> createState() => _DownloadProgressDialogState();
}

class _DownloadProgressDialogState extends State<_DownloadProgressDialog> {
  double _progress = 0.0;
  bool _isDownloading = true;
  String? _filePath;
  String? _error;

  @override
  void initState() {
    super.initState();
    _startDownload();
  }

  Future<void> _startDownload() async {
    try {
      final filePath = await widget.onDownload((progress) {
        if (mounted) {
          setState(() {
            _progress = progress;
          });
        }
      });

      if (mounted) {
        setState(() {
          _isDownloading = false;
          _filePath = filePath;
          if (filePath == null) {
            _error = '下载失败';
          }
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _isDownloading = false;
          _error = '下载失败: $e';
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(_isDownloading ? '正在下载更新' : (_error != null ? '下载失败' : '下载完成')),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (_isDownloading) ...[
            LinearProgressIndicator(value: _progress),
            const SizedBox(height: 16),
            Text('下载进度: ${(_progress * 100).toStringAsFixed(1)}%'),
          ] else if (_error != null) ...[
            Text(_error!),
          ] else ...[
            const Icon(Icons.check_circle, color: Colors.green, size: 48),
            const SizedBox(height: 16),
            Text('文件已下载到: ${widget.fileName}'),
            const SizedBox(height: 8),
            const Text('是否立即安装？'),
          ],
        ],
      ),
      actions: [
        if (!_isDownloading) ...[
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('取消'),
          ),
          if (_filePath != null)
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
                _installFile(_filePath!);
              },
              child: const Text('立即安装'),
            ),
          if (_error != null)
            ElevatedButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('确定'),
            ),
        ],
      ],
    );
  }

  Future<void> _installFile(String filePath) async {
    try {
      await OpenFile.open(filePath);
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('无法打开安装文件: $e')),
        );
      }
    }
  }
}
