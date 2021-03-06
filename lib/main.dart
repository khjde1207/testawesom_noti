import 'package:awesome_notifications/android_foreground_service.dart';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';

void main() async {
  // AwesomeNotifications().actionStream.listen((receivedNotification) {
  //   print("actionStream ${receivedNotification}");
  //   if (receivedNotification.buttonKeyPressed == "exit") {
  //     AwesomeNotifications().cancelSchedule(receivedNotification.id!);
  //     AwesomeNotifications().cancel(receivedNotification.id!);
  //   }
  // });
  // AwesomeNotifications().displayedStream.listen((receivedNotification) async {
  //   print("displayedStream ${receivedNotification}");
  //   var disDate =
  //       DateTime.parse(receivedNotification.createdDate! + "Z").toLocal();
  //   var now = DateTime.now();
  //   print(now.difference(disDate).inSeconds);
  //   if (now.difference(disDate).inSeconds > 30) {
  //     AwesomeNotifications().createNotification(
  //         content: NotificationContent(
  //           id: 10,
  //           channelKey: 'test1',
  //           title: "${DateTime.now().toIso8601String()}",
  //           body: "${DateTime.now().toIso8601String()}",
  //           showWhen: true,
  //           createdLifeCycle: NotificationLifeCycle.Background,
  //           notificationLayout: NotificationLayout.BigText,
  //           displayOnBackground: true,
  //           displayOnForeground: true,
  //         ),
  //         actionButtons: [
  //           NotificationActionButton(
  //               key: 'exit',
  //               label: 'exit',
  //               autoDismissable: false,
  //               // autoCancel: false,
  //               buttonType: ActionButtonType.KeepOnTop),
  //           NotificationActionButton(
  //               key: 'reload',
  //               label: 'reload',
  //               // autoCancel: false,
  //               buttonType: ActionButtonType.KeepOnTop),
  //         ]);
  //   }
  // });
  // AwesomeNotifications().dismissedStream.listen((receivedNotification) {
  //   print("dismissedStream ");
  // });
  // AwesomeNotifications().createdStream.listen((receivedNotification) {
  //   print("createdStream ");
  // });
  await AwesomeNotifications().initialize('resource://drawable/ic_launcher', [
    NotificationChannel(
      channelKey: 'test1',
      channelName: 'test1',
      channelDescription: 'testtest1111',
      defaultColor: Color(0xFF9D50DD),
      ledColor: Colors.white,
      playSound: false,
      importance: NotificationImportance.Low,
      enableVibration: false,
    )
  ]);
  AwesomeNotifications().setListeners(
    onActionReceivedMethod: Test.onActionReceivedMethod,
    onNotificationCreatedMethod: Test.onNotificationCreatedMethod,
    onNotificationDisplayedMethod: Test.onNotificationDisplayedMethod,
    onDismissActionReceivedMethod: Test.onDismissActionReceivedMethod,
  );

  runApp(const MyApp());
}

class Test {
  static Future<void> onActionReceivedMethod(ReceivedAction n) async {
    // print("onActionReceivedMethod ${n}");
    if (n.actionKey == "exit") {
      AwesomeNotifications().cancelSchedule(n.id!);
      AwesomeNotifications().cancel(n.id!);
    }
  }

  static Future<void> onNotificationCreatedMethod(
      ReceivedNotification n) async {
    // print("onNotificationCreatedMethod ${n}");
  }

  static Future<void> onNotificationDisplayedMethod(
      ReceivedNotification receivedNotification) async {
    // print("onNotificationDisplayedMethod ${receivedNotification}");
    var disDate =
        DateTime.parse(receivedNotification.createdDate! + "Z").toLocal();
    var now = DateTime.now();
    print(now.difference(disDate).inSeconds);
    if (now.difference(disDate).inSeconds > 30) {
      await AwesomeNotifications()
          .initialize('resource://drawable/ic_launcher', [
        NotificationChannel(
          channelKey: 'test1',
          channelName: 'test1',
          channelDescription: 'testtest1111',
          defaultColor: Color(0xFF9D50DD),
          ledColor: Colors.white,
          playSound: false,
          importance: NotificationImportance.Low,
          enableVibration: false,
        )
      ]);
      AwesomeNotifications().createNotification(
          content: NotificationContent(
            id: 10,
            channelKey: 'test1',
            title: "${DateTime.now().toIso8601String()}",
            body: "${DateTime.now().toIso8601String()}",
            showWhen: true,
            createdLifeCycle: NotificationLifeCycle.Background,
            notificationLayout: NotificationLayout.BigText,
            displayOnBackground: true,
            displayOnForeground: true,
          ),
          schedule: NotificationInterval(
              interval: 60,
              repeats: true,
              allowWhileIdle: true,
              timeZone:
                  await AwesomeNotifications().getLocalTimeZoneIdentifier()),
          actionButtons: [
            NotificationActionButton(
              key: 'exit',
              label: 'exit',
              autoDismissible: false,
              // autoDismissable: false,
              // autoCancel: false,
              notificationActionType: NotificationActionType.KeepOnTopAction,
            ),
            NotificationActionButton(
                key: 'reload',
                label: 'reload',
                autoDismissible: false,
                notificationActionType: NotificationActionType.KeepOnTopAction
                // notificationActionType: NotificationActionType.
                // autoCancel: false,
                // buttonType: ActionButtonType.KeepOnTop
                ),
          ]);
    }
  }

  static Future<void> onDismissActionReceivedMethod(
      ReceivedNotification n) async {
    // print("onDismissActionReceivedMethod ${n}");
  }
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() async {
    print("_incrementCounter");

    // AndroidForegroundService.s(
    await AwesomeNotifications().createNotification(
        content: NotificationContent(
          id: 10,
          channelKey: 'test1',
          title: "sadadsadsad",
          body: "teasdsadsadsadsast",
          showWhen: true,
          createdLifeCycle: NotificationLifeCycle.Background,
          notificationLayout: NotificationLayout.BigText,
          displayOnBackground: true,
          displayOnForeground: true,
        ),
        actionButtons: [
          NotificationActionButton(
            key: 'exit',
            label: 'exit',
            autoDismissible: false,
            notificationActionType: NotificationActionType.KeepOnTopAction,
            // autoDismissable: false,
            // autoCancel: false,
            // buttonType: ActionButtonType.KeepOnTop
          ),
          NotificationActionButton(
            key: 'reload',
            label: 'reload',
            autoDismissible: false,
            notificationActionType: NotificationActionType.KeepOnTopAction,
            // autoCancel: false,
            // buttonType: ActionButtonType.KeepOnTop
          ),
        ]);
    // print(DateTime.parse("2021-11-04 04:20:36Z").toLocal());
    // return;
    print(await AwesomeNotifications().getLocalTimeZoneIdentifier());
    await AwesomeNotifications().createNotification(
        content: NotificationContent(
          id: 10,
          channelKey: 'test1',
          title: "sadadsadsad",
          body: "teasdsadsadsadsast",
          showWhen: true,
          createdLifeCycle: NotificationLifeCycle.Background,
          notificationLayout: NotificationLayout.BigText,
          displayOnBackground: true,
          displayOnForeground: true,
        ),
        schedule: NotificationInterval(
            interval: 60,
            repeats: true,
            allowWhileIdle: true,
            timeZone:
                await AwesomeNotifications().getLocalTimeZoneIdentifier()),
        actionButtons: [
          NotificationActionButton(
            key: 'exit',
            label: 'exit',
            autoDismissible: false,
            notificationActionType: NotificationActionType.KeepOnTopAction,
            // autoCancel: false,
            // buttonType: ActionButtonType.KeepOnTop
          ),
          NotificationActionButton(
            key: 'reload',
            label: 'reload',
            autoDismissible: false,
            notificationActionType: NotificationActionType.KeepOnTopAction,
            // autoCancel: false,
            // buttonType: ActionButtonType.KeepOnTop
          ),
        ]);
    // setState(() {
    //   // This call to setState tells the Flutter framework that something has
    //   // changed in this State, which causes it to rerun the build method below
    //   // so that the display can reflect the updated values. If we changed
    //   // _counter without calling setState(), then the build method would not be
    //   // called again, and so nothing would appear to happen.
    //   _counter++;
    // });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          // Column is also a layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Invoke "debug painting" (press "p" in the console, choose the
          // "Toggle Debug Paint" action from the Flutter Inspector in Android
          // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
          // to see the wireframe for each widget.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
                onPressed: () {
                  AndroidForegroundService.stopForeground();
                },
                child: Text('exit'))
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'test',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
