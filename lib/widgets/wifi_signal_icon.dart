import 'package:flutter/material.dart';

class WiFiSignalIcon extends StatelessWidget {
  final int rssi;
  final secure;
  final Color? color;
  final double? size;

  WiFiSignalIcon({this.rssi = 0, this.secure = true, this.color, this.size});

  IconData getWiFiIcon(rssi, secure) {
    if (rssi > -30) {
      return secure
          ? Icons.signal_wifi_4_bar_lock_outlined
          : Icons.signal_wifi_4_bar_outlined;
    }
    if (rssi > -67) {
      return secure
          ? Icons.signal_wifi_4_bar_lock_outlined
          : Icons.signal_wifi_4_bar_outlined;
    }
    if (rssi > -80) {
      return secure
          ? Icons.signal_wifi_4_bar_lock_outlined
          : Icons.signal_wifi_4_bar_outlined;
    }
    return secure
          ? Icons.signal_wifi_4_bar_lock_outlined
          : Icons.signal_wifi_4_bar_outlined;
  }

  @override
  Widget build(BuildContext context) {
    return Icon(getWiFiIcon(rssi, secure), color: color, size: size);
  }
}
