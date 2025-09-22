import 'package:flutter/material.dart';
import 'package:sip_ua/sip_ua.dart';

class AgentSipPage extends StatefulWidget {
  const AgentSipPage({super.key});

  @override
  State<AgentSipPage> createState() => _AgentSipPageState();
}

class _AgentSipPageState extends State<AgentSipPage>
    implements SipUaHelperListener {
  final SIPUAHelper _helper = SIPUAHelper();
  String connectionStatus = 'Disconnected';
  String registerStatus = 'None';
  Call? _currentCall;
  final List<String> _logs = [];

  @override
  void initState() {
    super.initState();
    _helper.addSipUaHelperListener(this);
    _startSIP();
  }

  void _addLog(String message) {
    setState(() {
      _logs.insert(0, '[${DateTime.now().toIso8601String()}] $message');
    });
  }

  void _startSIP() {
    UaSettings settings = UaSettings();
    settings.uri = 'sip:agent0001@call.softdreams.vn';
    settings.authorizationUser = 'agent0001';
    settings.password = 'Ag3nt#0001!!';
    settings.webSocketUrl = 'wss://call.softdreams.vn:8089/ws';
    settings.webSocketSettings.allowBadCertificate = true;
    settings.transportType = TransportType.WS;
    settings.register = true;
    settings.userAgent = 'MyFlutterAgent';
    settings.iceServers = [
      {
        'url': 'turns:call.softdreams.vn:5349',
        'username': 'webrtcuser',
        'credential': 'webrtcpp',
      }
    ];
    _helper.start(settings);
    _addLog('Đã gửi yêu cầu khởi động Agent SIP');
  }

  void _register() {
    _helper.register();
    _addLog('Gửi lại đăng ký SIP');
  }

  void _answer() {
    _currentCall?.answer(_helper.buildCallOptions());
    _addLog('Bắt máy cuộc gọi');
  }

  void _reject() {
    _currentCall?.hangup();
    _addLog('Từ chối cuộc gọi');
  }

  void _hangup() {
    _currentCall?.hangup();
    _addLog('Kết thúc cuộc gọi');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('WebRTC Agent SIP')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Trạng thái kết nối: $connectionStatus'),
            Text('Trạng thái đăng ký: $registerStatus'),
            const SizedBox(height: 20),
            Wrap(
              // mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton(
                    onPressed: _register, child: const Text('Đăng ký SIP')),
                ElevatedButton(
                    onPressed: _answer, child: const Text('Bắt máy')),
                ElevatedButton(
                    onPressed: _reject, child: const Text('Từ chối')),
                ElevatedButton(
                    onPressed: _hangup, child: const Text('Kết thúc')),
              ],
            ),
            const Divider(),
            const Text(
              '📋 Lịch sử:',
              style: TextStyle(fontWeight: FontWeight.bold),
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
    _addLog('Trạng thái cuộc gọi: ${state.state}');
    setState(() {
      if (state.state == CallStateEnum.ENDED ||
          state.state == CallStateEnum.FAILED ||
          state.state == CallStateEnum.NONE) {
        _currentCall = null;
      } else {
        _currentCall = call;
      }
    });
  }

  @override
  void registrationStateChanged(RegistrationState state) {
    setState(() {
      registerStatus = state.state.toString();
    });
    _addLog('Trạng thái đăng ký SIP: ${state.state}');
    if (state.state == RegistrationStateEnum.REGISTERED) {
      _showDialog('UA đã đăng ký SIP thành công!');
    }
  }

  @override
  void transportStateChanged(TransportState state) {
    setState(() {
      connectionStatus = state.state.toString();
    });
    _addLog('Trạng thái kết nối: ${state.state}');
  }

  @override
  void onNewMessage(SIPMessageRequest msg) {
    _addLog('New message: ${msg.message}');
  }

  @override
  void onNewNotify(Notify ntf) {
    _addLog('New notify: $ntf');
  }

  @override
  void onNewReinvite(ReInvite event) {
    _addLog('New reinvite: $event');
  }

  void _showDialog(String message) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Thông báo'),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK'),
          )
        ],
      ),
    );
  }
}
