import 'package:flutter/material.dart';
import 'package:astral/k/app_s/aps.dart';
import 'package:astral/screens/user_list_page.dart';
import 'package:astral/k/models/user_node.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:convert'; // 用于base64编码
import 'package:photo_view/photo_view.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final TextEditingController _messageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  final List<ChatMessage> _messages = [];
  final _aps = Aps();

  @override
  void initState() {
    super.initState();
    // 添加一些示例消息
    _messages.addAll([
      ChatMessage(
        id: '1',
        content: '欢迎使用去中心化聊天功能！',
        sender: 'System',
        timestamp: DateTime.now().subtract(const Duration(minutes: 5)),
        isOwn: false,
      ),
    ]);

    // 设置消息接收回调
    _aps.nodeDiscoveryService.setMessageCallback((
      String senderId,
      String messageId,
      String message,
    ) {
      _onMessageReceived(senderId, message);
    });
  }

  @override
  @override
  void dispose() {
    _messageController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _sendMessage() {
    final content = _messageController.text.trim();
    if (content.isEmpty) return;

    final message = ChatMessage(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      content: content,
      sender: '我',
      timestamp: DateTime.now(),
      isOwn: true,
      type: MessageType.text,
    );

    setState(() {
      _messages.add(message);
    });
    Future.microtask(_scrollToBottom);
    _messageController.clear();
    _scrollToBottom();

    // 向所有在线用户发送消息
    _broadcastMessage(content);
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        // 增加一个小延迟确保内容完全渲染
        Future.delayed(const Duration(milliseconds: 50), () {
          if (_scrollController.hasClients) {
            _scrollController.animateTo(
              _scrollController.position.maxScrollExtent,
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeOut,
            );
          }
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final isDesktop = _aps.isDesktop.watch(context);
    final currentRoom = _aps.selectroom.watch(context);

    // 检查当前房间是否为保护类型
    if (currentRoom == null || !currentRoom.encrypted) {
      return Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.lock_outline,
                size: 64,
                color: colorScheme.onSurface.withOpacity(0.3),
              ),
              const SizedBox(height: 16),
              Text(
                '此房间非保护房间',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  color: colorScheme.onSurface.withOpacity(0.6),
                ),
              ),
              const SizedBox(height: 8),
              Text(
                '聊天功能仅在保护房间中可用',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: colorScheme.onSurface.withOpacity(0.4),
                ),
              ),
            ],
          ),
        ),
      );
    }

    return Scaffold(
      body: Column(
        children: [
          // 聊天头部
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: colorScheme.surface,
              border: Border(
                bottom: BorderSide(color: colorScheme.outline.withOpacity(0.2)),
              ),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.chat_bubble_outline,
                  color: colorScheme.primary,
                  size: 24,
                ),
                const SizedBox(width: 12),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '大厅',
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      '在线用户: ${_getOnlineUserCount()}',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: colorScheme.onSurface.withOpacity(0.6),
                      ),
                    ),
                  ],
                ),
                const Spacer(),
                IconButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const UserListPage(),
                      ),
                    );
                  },
                  icon: Icon(
                    Icons.people_outlined,
                    color: colorScheme.onSurface.withOpacity(0.7),
                  ),
                  tooltip: '用户列表',
                ),
              ],
            ),
          ),
          // 消息列表
          Expanded(
            child:
                _messages.isEmpty
                    ? _buildEmptyState(colorScheme)
                    : ListView.builder(
                      controller: _scrollController,
                      padding: const EdgeInsets.all(16),
                      itemCount: _messages.length,
                      itemBuilder: (context, index) {
                        return _buildMessageBubble(
                          _messages[index],
                          colorScheme,
                        );
                      },
                    ),
          ),
          // 消息输入区域
          _buildMessageInput(colorScheme, isDesktop),
        ],
      ),
    );
  }

  Widget _buildEmptyState(ColorScheme colorScheme) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.chat_bubble_outline,
            size: 64,
            color: colorScheme.onSurface.withOpacity(0.3),
          ),
          const SizedBox(height: 16),
          Text(
            '还没有消息',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              color: colorScheme.onSurface.withOpacity(0.6),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            '开始一段新的对话吧！',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: colorScheme.onSurface.withOpacity(0.4),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMessageBubble(ChatMessage message, ColorScheme colorScheme) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        mainAxisAlignment:
            message.isOwn ? MainAxisAlignment.end : MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.end,

        children: [
          if (!message.isOwn) ...[
            CircleAvatar(
              radius: 16,
              backgroundColor: colorScheme.primary.withOpacity(0.1),
              child: Text(
                message.sender[0].toUpperCase(),
                style: TextStyle(
                  color: colorScheme.primary,
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(width: 8),
          ],
          Flexible(
            child: Container(
              constraints: BoxConstraints(
                maxWidth: MediaQuery.of(context).size.width * 0.7,
              ),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              decoration: BoxDecoration(
                color:
                    message.isOwn
                        ? colorScheme.primary
                        : colorScheme.surfaceVariant,
                borderRadius: BorderRadius.circular(18).copyWith(
                  bottomLeft:
                      message.isOwn
                          ? const Radius.circular(18)
                          : const Radius.circular(4),
                  bottomRight:
                      message.isOwn
                          ? const Radius.circular(4)
                          : const Radius.circular(18),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (!message.isOwn)
                    Padding(
                      padding: const EdgeInsets.only(bottom: 4),
                      child: Text(
                        message.sender,
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: colorScheme.primary,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  message.type == MessageType.text
                      ? Text(
                        message.content,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color:
                              message.isOwn
                                  ? colorScheme.onPrimary
                                  : colorScheme.onSurfaceVariant,
                        ),
                      )
                      : GestureDetector(
                        onTap:
                            () => _showImagePreview(context, message.content),
                        child: Stack(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: Image.memory(
                                base64Decode(message.content),
                                width: 200,
                                fit: BoxFit.cover,
                              ),
                            ),
                            // 放大图标提示
                            Positioned(
                              top: 8,
                              right: 8,
                              child: Container(
                                padding: const EdgeInsets.all(4),
                                decoration: BoxDecoration(
                                  color: Colors.black54,
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: const Icon(
                                  Icons.zoom_in,
                                  color: Colors.white,
                                  size: 16,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                  const SizedBox(height: 4),
                  Text(
                    _formatTime(message.timestamp),
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color:
                          message.isOwn
                              ? colorScheme.onPrimary.withOpacity(0.7)
                              : colorScheme.onSurfaceVariant.withOpacity(0.7),
                      fontSize: 10,
                    ),
                  ),
                ],
              ),
            ),
          ),
          if (message.isOwn) ...[
            const SizedBox(width: 8),
            CircleAvatar(
              radius: 16,
              backgroundColor: colorScheme.primary.withOpacity(0.1),
              child: Text(
                message.sender[0].toUpperCase(),
                style: TextStyle(
                  color: colorScheme.primary,
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildMessageInput(ColorScheme colorScheme, bool isDesktop) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: colorScheme.surface,
        border: Border(
          top: BorderSide(color: colorScheme.outline.withOpacity(0.2)),
        ),
      ),
      child: Row(
        children: [
          IconButton(
            icon: Icon(Icons.image, color: colorScheme.onSurfaceVariant),
            onPressed: _sendImage,
            tooltip: '发送图片',
          ),
          const SizedBox(width: 8),
          Expanded(
            child: TextField(
              controller: _messageController,
              decoration: InputDecoration(
                hintText: '输入消息...',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(24),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor: colorScheme.surfaceVariant,
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 12,
                ),
              ),
              maxLines: null,
              textInputAction:
                  isDesktop ? TextInputAction.newline : TextInputAction.send,
              onSubmitted: (value) {
                if (value.trim().isNotEmpty) {
                  _sendMessage();
                }
              },
            ),
          ),
          const SizedBox(width: 8),
          FloatingActionButton.small(
            onPressed: _sendMessage,
            backgroundColor: colorScheme.primary,
            heroTag: "chat_send",
            child: Icon(Icons.send, color: colorScheme.onPrimary),
          ),
        ],
      ),
    );
  }

  String _formatTime(DateTime timestamp) {
    final now = DateTime.now();
    final difference = now.difference(timestamp);

    if (difference.inDays > 0) {
      return '${difference.inDays}天前';
    } else if (difference.inHours > 0) {
      return '${difference.inHours}小时前';
    } else if (difference.inMinutes > 0) {
      return '${difference.inMinutes}分钟前';
    } else {
      return '刚刚';
    }
  }

  void _showImagePreview(BuildContext context, String base64Image) {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: Colors.transparent,
          child: GestureDetector(
            onTap: () => Navigator.of(context).pop(),
            child: Container(
              width: double.infinity,
              height: double.infinity,
              color: Colors.transparent,
              child: Center(
                child: Container(
                  constraints: BoxConstraints(
                    maxWidth: MediaQuery.of(context).size.width * 0.9,
                    maxHeight: MediaQuery.of(context).size.height * 0.8,
                  ),
                  child: PhotoView(
                    backgroundDecoration: const BoxDecoration(
                      color: Colors.transparent,
                    ),
                    imageProvider: MemoryImage(base64Decode(base64Image)),
                    minScale: PhotoViewComputedScale.contained,
                    maxScale: PhotoViewComputedScale.covered * 2.0,
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  int _getOnlineUserCount() {
    return _aps.allUsersNode.value.length;
  }

  void _broadcastMessage(String content) async {
    // 向所有在线用户发送消息
    for (final user in _aps.allUsersNode.value) {
      if (user.userId != _aps.nodeDiscoveryService.currentUser?.userId) {
        try {
          await _aps.nodeDiscoveryService.sendMessageToUser(
            user.userId,
            content,
          );
        } catch (e) {
          print('发送消息给 ${user.userName} 失败: $e');
        }
      }
    }
  }

  void _onMessageReceived(String senderId, String message) {
    // 打印所有在线用户信息
    print('当前在线用户列表:');
    for (var user in _aps.allUsersNode.value) {
      print(
        '用户ID: ${user.userId}, 用户名: ${user.userName}, IP: ${user.ipAddress}',
      );
    }

    // 查找发送者信息并打印详细信息
    final sender = _aps.allUsersNode.value.firstWhere(
      (user) => user.userId == senderId,
      orElse: () {
        print('未找到ID为 $senderId 的用户，使用默认用户信息');
        return UserNode(
          userId: senderId,
          userName: '未知用户',
          ipAddress: '',
          messagePort: 0,
          statusMessage: '',
          tags: [],
        );
      },
    );

    // 打印找到的发送者详细信息
    print('发送者详细信息:');
    print('用户ID: ${sender.userId}');
    print('用户名: ${sender.userName}');
    print('IP地址: ${sender.ipAddress}');
    print('消息端口: ${sender.messagePort}');
    print('状态消息: ${sender.statusMessage}');
    print('标签: ${sender.tags.join(", ")}');

    final chatMessage = ChatMessage(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      content:
          message.startsWith('image_base64:')
              ? message.substring('image_base64:'.length)
              : message,
      sender: sender.userName,
      timestamp: DateTime.now(),
      isOwn: false,
      type:
          message.startsWith('image_base64:')
              ? MessageType.image
              : MessageType.text,
    );

    setState(() {
      _messages.add(chatMessage);
    });

    if (message.startsWith('image_base64:')) {
      Future.delayed(const Duration(milliseconds: 100), () {
        _scrollToBottom();
      });
    } else {
      _scrollToBottom();
    }
  }

  Future<void> _sendImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      // 在这里处理图片发送逻辑
      final messageId = DateTime.now().millisecondsSinceEpoch.toString();
      final imageBytes = await image.readAsBytes();
      final base64Image = base64Encode(imageBytes);
      final imageMessageContent = 'image_base64:$base64Image';

      // 发送Base64编码的图片数据
      final onlineUsers = await _aps.nodeDiscoveryService.getOnlineUsers();
      print('准备发送图片给 ${onlineUsers.length} 个在线用户:');
      for (var user in onlineUsers) {
        print('- ${user.userName} (${user.userId})');
      }

      final currentUser = _aps.nodeDiscoveryService.currentUser;
      if (currentUser == null) {
        print('警告: 当前用户信息未设置，发送的图片消息可能没有发送者信息。');
      } else {
        print('当前用户: ${currentUser.userName} (${currentUser.userId})');
      }

      for (var user in onlineUsers) {
        if (user.userId != currentUser?.userId) {
          try {
            print('尝试发送图片给: ${user.userName} (${user.userId})');
            bool success = await _aps.nodeDiscoveryService.sendMessageToUser(
              user.userId,
              imageMessageContent,
            );
            if (success) {
              print('图片成功发送给: ${user.userName}');
            } else {
              print('图片发送失败给: ${user.userName}');
            }
          } catch (e) {
            print('发送图片给 ${user.userName} 时发生错误: $e');
          }
        }
      }

      // 更新本地消息列表时，也使用去除前缀的纯Base64数据
      final localChatMessage = ChatMessage(
        id: messageId,
        content: base64Image, // 存储纯Base64编码的图片数据
        sender: '我',
        timestamp: DateTime.now(),
        isOwn: true,
        type: MessageType.image,
        imageUrl: null,
      );

      setState(() {
        _messages.add(localChatMessage);
      });
      // 只在图片渲染完成后滚动一次，避免多次滚动导致跳动
      Future.delayed(const Duration(milliseconds: 100), () {
        _scrollToBottom();
      });
    }
  }
}

enum MessageType { text, image }

class ChatMessage {
  final String id;
  final String content;
  final String sender;
  final DateTime timestamp;
  final bool isOwn;
  final MessageType type;
  final String? imageUrl;

  ChatMessage({
    required this.id,
    required this.content,
    required this.sender,
    required this.timestamp,
    required this.isOwn,
    this.type = MessageType.text,
    this.imageUrl,
  });
}
