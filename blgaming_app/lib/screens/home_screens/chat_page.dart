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

  bool _isTyping = false;
  bool _isUserTyping = false;

  void _addMessage(String text, bool isUser, {bool isTypewriter = false}) {
    setState(() {
      _messages.add(_ChatMessage(
        text: text,
        isUser: isUser,
        isTypewriterEffect: isTypewriter, // truyền trạng thái vào
      ));
    });
    _scrollToBottom();
  }

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

      String content;
      if (reply.trim().startsWith("{")) {
        try {
          final jsonData = jsonDecode(reply);
          content = jsonData["result"] ?? reply;
        } catch (_) {
          content = reply;
        }
      } else {
        content = reply;
      }

      _addMessage(content, false, isTypewriter: true);
    } catch (e) {
      _addMessage("⚠ Lỗi API: $e", false);
    }

    setState(() => _isTyping = false);
  }

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
                  alignment:
                      msg.isUser ? Alignment.centerRight : Alignment.centerLeft,
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
                                ? mainColor2
                                : const Color.fromARGB(255, 48, 48, 48),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: msg.isTypewriterEffect
                              ? TypewriterText(text: msg.text)
                              : Text(
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
  final bool isTypewriterEffect;

  _ChatMessage(
      {required this.text,
      required this.isUser,
      this.isTypewriterEffect = false});
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
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: List.generate(3, (i) {
              return Opacity(
                opacity: i == dot ? 1 : 0.3,
                child: const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 2),
                  child: Text(
                    "●",
                    style: TextStyle(color: Colors.white, fontSize: 15),
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

class TypewriterText extends StatefulWidget {
  final String text;

  const TypewriterText({super.key, required this.text});

  @override
  State<TypewriterText> createState() => _TypewriterTextState();
}

class _TypewriterTextState extends State<TypewriterText> {
  String _displayedText = "";
  int _currentIndex = 0;

  static const Duration _typingSpeed = Duration(milliseconds: 20);

  @override
  void initState() {
    super.initState();
    _startTypingAnimation();
  }

  @override
  void didUpdateWidget(covariant TypewriterText oldWidget) {
    if (oldWidget.text != widget.text) {
      _displayedText = "";
      _currentIndex = 0;
      _startTypingAnimation();
    }
    super.didUpdateWidget(oldWidget);
  }

  void _startTypingAnimation() async {
    for (int i = 0; i < widget.text.length; i++) {
      await Future.delayed(_typingSpeed);
      if (mounted) {
        setState(() {
          _displayedText = widget.text.substring(0, i + 1);
          _currentIndex = i + 1;
        });
      } else {
        break;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      _displayedText,
      style: const TextStyle(color: Colors.white),
    );
  }
}
