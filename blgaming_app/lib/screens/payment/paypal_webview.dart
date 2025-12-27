import 'dart:convert';
import 'package:blgaming_app/services/paypal_service.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class PaypalWebViewPage extends StatefulWidget {
  final String approvalUrl;

  const PaypalWebViewPage({
    super.key,
    required this.approvalUrl,
  });

  @override
  State<PaypalWebViewPage> createState() => _PaypalWebViewPageState();
}

class _PaypalWebViewPageState extends State<PaypalWebViewPage> {
  late final WebViewController _controller;
  bool _handled = false;

  static const cancelUrl = 'http://localhost:5173/cancel';
  static const successUrl = 'http://localhost:5173/paypal/payment';

  @override
  void initState() {
    super.initState();

    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onNavigationRequest: _handleNavigation,
        ),
      )
      ..loadRequest(Uri.parse(widget.approvalUrl));
  }

  NavigationDecision _handleNavigation(NavigationRequest request) {
    final url = request.url;
    debugPrint('PayPal redirect: $url');
    final uri = Uri.parse(url);

    if (_handled) return NavigationDecision.prevent;
    if (uri.path == '/paypal/payment') {
      final payerId = uri.queryParameters['PayerID'] ?? '';
      final paymentId = uri.queryParameters['paymentId'] ?? '';
      PaypalService.handlePaymentSuccess(
          payerId: payerId, paymentId: paymentId);
      _showSuccess();
      Navigator.of(context).pushNamedAndRemoveUntil(
        'home',
        (route) => false,
      );

      return NavigationDecision.prevent;
    }

    if (url.startsWith(cancelUrl)) {
      _handled = true;
      _showCancel();
      Navigator.pop(context, false);
      return NavigationDecision.prevent;
    }

    return NavigationDecision.navigate;
  }

  void _showSuccess() {
    Future.delayed(const Duration(milliseconds: 300), () {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Row(
            children: const [
              Icon(Icons.check_circle, color: Colors.white),
              SizedBox(width: 12),
              Text('Thanh toán thành công'),
            ],
          ),
          backgroundColor: Colors.green,
          behavior: SnackBarBehavior.floating,
        ),
      );
    });
  }

  void _showCancel() {
    Future.delayed(const Duration(milliseconds: 300), () {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Row(
            children: const [
              Icon(Icons.check_circle, color: Colors.black),
              SizedBox(width: 12),
              Text('Đã hủy giao dịch'),
            ],
          ),
          backgroundColor: Colors.yellow,
          behavior: SnackBarBehavior.floating,
        ),
      );
    });
  }

  void _showError(String message) {
    Navigator.pop(context);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Thanh toán PayPal'),
      ),
      body: WebViewWidget(controller: _controller),
    );
  }
}
