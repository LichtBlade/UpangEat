import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:upang_eat/user_data.dart';

import '../bloc/notification_bloc/notification_bloc.dart';

class Notifications extends StatefulWidget {
  const Notifications({super.key});

  @override
  State<Notifications> createState() => _NotificationsState();
}

class _NotificationsState extends State<Notifications> {
  @override
  void initState() {
    context.read<NotificationBloc>().add(FetchNotification(globalUserData!.userId));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Notifications"),
      ),
      body: BlocBuilder<NotificationBloc, NotificationState>(
        builder: (context, state) {
          if (state is NotificationLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is NotificationLoaded) {
            final notifications = state.notifications;
            return ListView.builder(
                itemCount: notifications.length,
                itemBuilder: (context, index) {
                  final notification = notifications[index];
                  if (notification.status == "unread") {
                    context.read<NotificationBloc>().add(UpdateNotificationStatus(notification.notificationId, globalUserData!.userId));
                  }
                  return _NotificationCard(
                    message: notification.message!,
                    date: notification.notificationDate!,
                  );
                });
          } else if (state is NotificationError) {
            return Text("Error: ${state.message}");
          } else {
            return const Text("Unexpected State");
          }
        },
      ),
    );
  }
}

class _NotificationCard extends StatelessWidget {
  final String message;
  final DateTime? date;
  const _NotificationCard({super.key, required this.message, required this.date});

  String timeAgo(DateTime? dateTime) {
    final now = DateTime.now();
    final diff = now.difference(dateTime!);

    if (diff.inMinutes < 60) {
      return "${diff.inMinutes} min${diff.inMinutes == 1 ? '' : 's'} ago";
    } else if (diff.inHours < 24) {
      return "${diff.inHours} hour${diff.inHours == 1 ? '' : 's'} ago";
    } else if (diff.inDays == 1) {
      return "yesterday";
    } else if (diff.inDays < 7) {
      return "${diff.inDays} day${diff.inDays == 1 ? '' : 's'} ago";
    } else if (diff.inDays < 30) {
      return "${(diff.inDays / 7).floor()} week${(diff.inDays / 7).floor() > 1 ? 's' : ''} ago";
    } else {
      return "more than a month ago";
    }
  }

  @override
  Widget build(BuildContext context) {
    List<TextSpan> textSpans = [];
    final words = message.split(" ");
    for (var word in words) {
      if (word.contains("ready")) {
        // If the word matches the keyword, color it green
        textSpans.add(TextSpan(
          text: "$word ",
          style: const TextStyle(color: Colors.green, fontWeight: FontWeight.w700), // Green color
        ));
      } else if (word.contains("accepted")) {
        // If the word matches the keyword, color it green
        textSpans.add(TextSpan(
          text: "$word ",
          style: const TextStyle(color: Colors.blue, fontWeight: FontWeight.w700), // Green color
        ));
      } else if (word.contains("cancelled")) {
        // If the word matches the keyword, color it green
        textSpans.add(TextSpan(
          text: "$word ",
          style: const TextStyle(color: Colors.red, fontWeight: FontWeight.w700), // Green color
        ));
      } else {
        // Default styling for other words
        textSpans.add(TextSpan(
          text: "$word ",
          style: const TextStyle(color: Colors.black), // Default color
        ));
      }
    }

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
      elevation: 0.1,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        height: 70,
        width: double.infinity,
        child: Row(
          children: [
            Expanded(
              child: RichText(
                text: TextSpan(
                  children: textSpans,
                ),
              ),
            ),
            Text(
              timeAgo(date),
              style: const TextStyle(fontWeight: FontWeight.w400, fontSize: 12),
            )
          ],
        ),
      ),
    );
  }
}
