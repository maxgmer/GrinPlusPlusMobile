import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:grin_plus_plus/colors.dart';

typedef bool NotificationListener(Notification notification);
class NotificationsRepository {
  static final List<Notification> _pendingNotifications = [];
  static NotificationListener _listener;
  static bool _initialized = false;
  static bool _enabled = true;

  List<Notification> get pendingNotifications => _pendingNotifications;

  static void showNotification(Notification notification) {
    _pendingNotifications.add(notification);
  }

  static void subscribe(NotificationListener notificationListener) {
    if (notificationListener != null) {
      _init();
      _listener = notificationListener;
    }
  }

  static void _init() {
    if (!_initialized) {
      Future.doWhile(() async {
        if (_pendingNotifications.length != 0 &&
            _listener != null &&
            _listener(_pendingNotifications[0])) {
          _pendingNotifications.removeAt(0);
        }
        return Future.delayed(
          Duration(milliseconds: 200), () =>_enabled,
        );
      });
    }
  }

  static void disable() {
    _enabled = false;
  }
}

enum NotificationType {success, failure}
class Notification extends Equatable {
  final String title;
  final String message;
  final NotificationType notificationType;

  Notification({
    this.title,
    this.message,
    this.notificationType,
  });

  @override
  List<Object> get props => [title, message, notificationType];

  Widget get icon {
    switch (notificationType) {
      case NotificationType.success:
        return const Icon(
          Icons.done,
          color: Colors.black,
        );
      case NotificationType.failure:
        return const Icon(
          Icons.error_outline,
          color: Colors.black,
        );
    }
    return null;
  }

  Color get color {
    switch (notificationType) {
      case NotificationType.success: return kColorGreen;
      case NotificationType.failure: return kColorErrorRed;
    }
    return null;
  }

  TextStyle get titleStyle {
    switch (notificationType) {
      case NotificationType.success:
        return TextStyle(
          fontSize: 16,
          color: Colors.black,
        );
      case NotificationType.failure:
        return TextStyle(
          fontSize: 16,
          color: Colors.black,
        );
    }
    return null;
  }

  get messageStyle {
    switch (notificationType) {
      case NotificationType.success:
        return TextStyle(
          fontSize: 14,
          color: Colors.black,
        );
      case NotificationType.failure:
        return TextStyle(
          fontSize: 14,
          color: Colors.black,
        );
    }
    return null;
  }
}