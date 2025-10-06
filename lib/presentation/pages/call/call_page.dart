import 'package:flutter/material.dart';
import 'package:sip_ua/sip_ua.dart';

class CallPage extends StatefulWidget {
  const CallPage({super.key});

  @override
  State<CallPage> createState() => _UserScreenState();
}

class _UserScreenState extends State<CallPage>
    implements SipUaHelperListener {
  final SIPUAHelper _helper = SIPUAHelper();
  final TextEditingController _usernameController =
  TextEditingController(text: "1245435");

  String _registerStatus = 'Chưa đăng ký';
  String _callStatus = 'Chưa có cuộc gọi';
  final List<String> _logs = [];

  @override
  void initState() {
    super.initState();
    _helper.addSipUaHelperListener(this);
  }

  void _addLog(String message) {
    setState(() {
      _logs.insert(0, '[${DateTime.now().toIso8601String()}] $message');
    });
  }

  void _startUA() {
    _helper.stop();
    UaSettings settings = UaSettings();
    settings.webSocketUrl = 'wss://call.softdreams.vn:8089/ws';
    settings.uri = 'sip:user1@call.softdreams.vn';
    settings.authorizationUser = "user1";
    settings.password = 'Gr0up#User1!!';
    settings.displayName = 'User 1';
    settings.userAgent = 'Flutter SIP Client';
    settings.register = true;
    settings.transportType = TransportType.WS;
    settings.iceServers = [
      {
        'url': 'turns:call.softdreams.vn:5349',
        'username': 'webrtcuser',
        'credential': 'webrtcpp',
      }
    ];

    try {
      _helper.start(settings);
      _addLog('Đã gửi yêu cầu khởi động SIP');
    } catch (e) {
      _addLog('Lỗi SIP: $e');
    }
  }

  void _makeCall(String extension) async {
    final sipUri = 'sip:$extension@call.softdreams.vn';
    await _helper.call(sipUri, voiceOnly: true);
    _addLog('Thực hiện gọi $sipUri');
  }

  void _hangUp() {
    _helper.terminateSessions({});
    _addLog('Đã gửi yêu cầu kết thúc cuộc gọi');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Đăng ký CCCD/SĐT để gọi SIP 9999')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _usernameController,
              decoration: const InputDecoration(
                labelText: 'Nhập CCCD / SĐT (User SIP)',
              ),
              keyboardType: TextInputType.phone,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                if (_usernameController.text.isNotEmpty) {
                  _startUA();
                }
              },
              child: const Text('🚀 Đăng ký SIP'),
            ),
            const SizedBox(height: 20),
            Wrap(
              // mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton(
                  onPressed: () => _makeCall('9999'),
                  child: const Text('📞 Gọi 9999'),
                ),
                ElevatedButton(
                  onPressed: () => _makeCall('1000'),
                  child: const Text('📞 Gọi 1000'),
                ),
                ElevatedButton(
                  onPressed: _hangUp,
                  child: const Text('❌ Kết thúc'),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Text('📲 Đăng ký: $_registerStatus'),
            Text('📞 Cuộc gọi: $_callStatus'),
            const Divider(),
            const Align(
              alignment: Alignment.centerLeft,
              child: Text('📋 Lịch sử:',
                  style: TextStyle(fontWeight: FontWeight.bold)),
            ),
            Expanded(
              child: ListView.builder(
                reverse: true,
                itemCount: _logs.length,
                itemBuilder: (context, index) {
                  return Text(
                    _logs[index],
                    style: const TextStyle(fontSize: 12, color: Colors.black87),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void callStateChanged(Call call, CallState state) {
    setState(() {
      _callStatus = state.state.toString();
    });
    _addLog('Trạng thái cuộc gọi: ${state.state}');
    debugPrint('📞 Call State: ${state.state}');
  }

  @override
  void registrationStateChanged(RegistrationState state) {
    setState(() {
      _registerStatus = state.state.toString();
    });
    _addLog('Trạng thái đăng ký SIP: ${state.state}');
    debugPrint('📲 Registration: ${state.state}');
  }

  @override
  void transportStateChanged(TransportState state) {
    _addLog('Kết nối: ${state.state}');
    debugPrint('🌐 Transport: ${state.state}');
  }

  @override
  void onNewMessage(SIPMessageRequest msg) {}

  @override
  void onNewNotify(Notify ntf) {}

  @override
  void onNewReinvite(ReInvite event) {}
}
