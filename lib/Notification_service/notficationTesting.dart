import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';

import '../Notification_service/NotificationService.dart';

class notficationTesting extends StatelessWidget {
  const notficationTesting({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Row(),
              ElevatedButton.icon(
                onPressed: () {
                  showNotification(
                    title: "Basic Notification",
                    body: "This is a Basic Notification",
                  );
                },
                label: Text("Default Notification"), icon:  SizedBox.shrink(),
              ),
              ElevatedButton.icon(
                onPressed: () {
                  showNotification(
                    title: "Basic Notification",
                    body: "This is a Basic Notification",
                    summary: "This is Basic Summary",
                    notificationLayout: NotificationLayout.Inbox,
                  );
                },
                label: Text("Notification With Summary"), icon:  SizedBox.shrink(),
              ),
              ElevatedButton.icon(
                onPressed: () async {
                  await showNotification(
                    title: "Order Confirmation",
                    body: "🎉 Your order has been successfully placed! 🚀 \n Thank you for connecting with us.",

                    // summary: "Thissss is Basic Summary",
                    notificationLayout: NotificationLayout.BigPicture,

                    bigPicture:
                    "resource://drawable/launcher_icon",
                  );
                },
                label: Text("BigPicture Notification"), icon:  SizedBox.shrink(),
              ),
              ElevatedButton.icon(
                onPressed: () {
                  showNotification(
                    title: "Action noti",
                    body: "This is a Action",
                    payload: {
                      "navigate": "true",
                    },
                    actionButtons: [
                      NotificationActionButton(
                        key: 'demo',
                        label: "Demo Page",
                        actionType: ActionType.SilentAction,
                        color: Colors.deepPurple,
                      )
                    ],
                  );
                },
                label: Text("Action Button Notification"), icon:  SizedBox.shrink(),
              ),
              ElevatedButton.icon(
                onPressed: () {
                  showNotification(
                    title: "Big Text Notification",
                    body: "This is Big Text",
                    notificationLayout: NotificationLayout.BigText,
                  );
                },
                label: Text("BigText Notification"), icon:  SizedBox.shrink(),
              ),
              ElevatedButton.icon(
                onPressed: () {
                  showNotification(
                    title: "Song Downloading",
                    body: "Please wait",
                    notificationLayout: NotificationLayout.ProgressBar,
                  );
                },
                label: Text("ProgressBar Notification"), icon:  SizedBox.shrink(),
              ),
              ElevatedButton.icon(
                onPressed: () {
                  showNotification(
                    title: "Nitish Kumar",
                    body: "Hello What are you doing",
                    notificationLayout: NotificationLayout.Messaging,
                  );
                },
                label: Text("Messaging Notification"), icon:  SizedBox.shrink(),
              ),
              ElevatedButton.icon(
                onPressed: () {
                  showNotification(
                    title: "Nitish Kumar",
                    body: "Hello What are you doing",
                    notificationLayout: NotificationLayout.MessagingGroup,
                  );
                },
                label: Text("Messaging Group Notification"), icon:  SizedBox.shrink(),
              ),
              ElevatedButton.icon(
                onPressed: () {
                  showNotification(
                    title: "New song playing",
                    body: "Arjit ",
                    notificationLayout: NotificationLayout.MediaPlayer,
                  );
                },
                label: Text("MediaPlayer Notification"), icon:  SizedBox.shrink(),
              ),
              ElevatedButton.icon(
                onPressed: () {
                  showNotification(
                    title: "New song playing",
                    body: "Arjit ",
                    notificationLayout: NotificationLayout.MediaPlayer,
                  );
                },
                label: Text("MediaPlayer Notification"), icon:  SizedBox.shrink(),
              ),
            ],
          ),
        ));
  }
}
