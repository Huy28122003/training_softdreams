import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class ChatbotPage extends StatefulWidget {
  const ChatbotPage({super.key});

  @override
  State<ChatbotPage> createState() => _ChatbotPageState();
}

class _ChatbotPageState extends State<ChatbotPage> {
  InAppWebViewController? _controller;
  String messageFromBot = "";
  bool _initSent = false;

  final Map<String, dynamic> initData = {
    "name": "chat-bot:init",
    "data": {
      "userId": "12312",
      "chatBotName": "EasyPos Support",
      "language": "vi",
      "appName": "EasyPOS",
      "accessToken": "",
      "userDetails": {
        "comId": 1001,
        "companyName": "  ABC",
        "address": ", Đà Nẵng",
        "taxCode": "12312312",
        "username": "fasdfs",
        "fullName": "adfadf sadf sadfs df",
        "phoneNumber": "21312312312",
        "email": "a.dfsdf@example.com",
      },
      "agentId": "agent_epos",
    }
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Chatbot")),
      body: Column(
        children: [
          Expanded(
            child: InAppWebView(
              initialUrlRequest: URLRequest(
                url: WebUri("https://echatbot.easypos.vn/iframe/chat-bot"),
              ),
              initialSettings: InAppWebViewSettings(
                javaScriptEnabled: true,
              ),
              onWebViewCreated: (controller) {
                _controller = controller;

                _controller?.addJavaScriptHandler(
                  handlerName: "flutterHandler",
                  callback: (args) {
                    print("fsdfsdfsd $args");
                    setState(() {
                      messageFromBot =
                          args.isNotEmpty ? args[0].toString() : "";
                    });
                    return "Flutter đã nhận: $messageFromBot";
                  },
                );
              },
              onLoadStop: (controller, url) async {
                if (!_initSent) {
                  _initSent = true;

                  // gắn listener
                  await controller.evaluateJavascript(source: """
                    window.addEventListener("message", function(event) {
                      if (window.flutter_inappwebview) {
                        window.flutter_inappwebview.callHandler("flutterHandler", event.data);
                      }
                    });
                  """);
                  // gửi initData
                  final jsonString = jsonEncode(initData);
                  await controller.evaluateJavascript(
                    source: "window.postMessage($jsonString, '*');",
                  );
                }
              },
            ),
          ),
          Container(
            padding: const EdgeInsets.all(8),
            color: Colors.red,
            width: double.infinity,
            child: Text("Message từ Bot: $messageFromBot"),
          )
        ],
      ),
    );
  }
}
