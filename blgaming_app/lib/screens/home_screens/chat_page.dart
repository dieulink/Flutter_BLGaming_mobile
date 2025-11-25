import 'dart:convert';
import 'package:blgaming_app/screens/home_screens/widgets/app_bar_chatbot.dart';
import 'package:blgaming_app/services/chat_service.dart';
import 'package:blgaming_app/ui_value.dart';
import 'package:flutter/material.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final ChatService _chatService = ChatService();

  final List<_ChatMessage> _messages = [];
  final TextEditingController _controller = TextEditingController();
  final ScrollController _scrollCtrl = ScrollController();

  bool _isTyping = false; // AI đang gõ
  bool _isUserTyping = false; // User đang gõ → đổi border

  /// Thêm tin nhắn vào list
  void _addMessage(String text, bool isUser) {
    setState(() {
      _messages.add(_ChatMessage(text: text, isUser: isUser));
    });
    _scrollToBottom();
  }

  /// Xử lý gửi tin nhắn
  Future<void> _handleSend() async {
    final msg = _controller.text.trim();
    if (msg.isEmpty) return;

    _addMessage(msg, true);
    _controller.clear();

    setState(() {
      _isTyping = true;
      _isUserTyping = false;
    });

    try {
      final reply = await _chatService.sendMessage(msg);

      /// Parse JSON { "result": "..." }
      if (reply.trim().startsWith("{")) {
        try {
          final jsonData = jsonDecode(reply);
          final content = jsonData["result"] ?? reply;
          _addMessage(content, false);
        } catch (_) {
          _addMessage(reply, false);
        }
      } else {
        _addMessage(reply, false);
      }
    } catch (e) {
      _addMessage("⚠ Lỗi API: $e", false);
    }

    setState(() => _isTyping = false);
  }

  /// Auto scroll xuống cuối danh sách tin nhắn
  void _scrollToBottom() {
    Future.delayed(const Duration(milliseconds: 200), () {
      if (_scrollCtrl.hasClients) {
        _scrollCtrl.animateTo(
          _scrollCtrl.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBarChatbot(),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              controller: _scrollCtrl,
              padding: const EdgeInsets.all(12),
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                final msg = _messages[index];
                return Align(
                  alignment: msg.isUser
                      ? Alignment.centerRight
                      : Alignment.centerLeft,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      if (!msg.isUser)
                        Padding(
                          padding: const EdgeInsets.only(right: 8),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(50),
                            child: Image.asset(
                              'assets/imgs/linhvat2.png',
                              width: 32,
                              height: 32,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),

                      Flexible(
                        child: Container(
                          width: getWidth(context) * 0.7,
                          padding: const EdgeInsets.all(12),
                          margin: const EdgeInsets.symmetric(vertical: 6),
                          decoration: BoxDecoration(
                            color: msg.isUser
                                ? mainColor
                                : const Color.fromARGB(255, 48, 48, 48),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            msg.text,
                            style: const TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),

          if (_isTyping)
            const Padding(padding: EdgeInsets.all(8), child: TypingIndicator()),

          _buildInputBar(),
        ],
      ),
    );
  }

  Widget _buildInputBar() {
    return SafeArea(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
        color: Colors.black,
        child: Row(
          children: [
            Expanded(
              child: TextField(
                controller: _controller,
                style: const TextStyle(color: Colors.white),
                onChanged: (value) {
                  setState(() => _isUserTyping = value.isNotEmpty);
                },
                decoration: InputDecoration(
                  hintText: "Nhập tin nhắn...",
                  hintStyle: const TextStyle(color: Colors.white54),

                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: _isUserTyping ? mainColor : Colors.grey.shade700,
                      width: 1.5,
                    ),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: mainColor, width: 2),
                    borderRadius: BorderRadius.circular(12),
                  ),

                  filled: true,
                  fillColor: Colors.grey.shade900,
                ),
              ),
            ),

            IconButton(
              onPressed: _handleSend,
              icon: const Icon(Icons.send, color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}

class _ChatMessage {
  final String text;
  final bool isUser;

  _ChatMessage({required this.text, required this.isUser});
}

class TypingIndicator extends StatefulWidget {
  const TypingIndicator({super.key});

  @override
  State<TypingIndicator> createState() => _TypingIndicatorState();
}

class _TypingIndicatorState extends State<TypingIndicator>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (_, __) {
        int dot = ((_controller.value * 3) % 3).floor();
        return Container(
          // // color: const Color.fromARGB(255, 48, 48, 48),
          // alignment: Alignment.centerLeft,
          // width: 55,
          // padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          // decoration: BoxDecoration(
          //   color: const Color.fromARGB(255, 48, 48, 48),
          //   borderRadius: BorderRadius.circular(20),
          // ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: List.generate(3, (i) {
              return Opacity(
                opacity: i == dot ? 1 : 0.3,
                child: const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 2),
                  child: Text(
                    "●",
                    style: TextStyle(color: Colors.white, fontSize: 12),
                  ),
                ),
              );
            }),
          ),
        );
      },
    );
  }
}
