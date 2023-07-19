# firebase_id_token_bug

A demo project that can be used to reproduce this issue:

- [[firebase_auth] Task is not yet complete #11297](https://github.com/firebase/flutterfire/issues/11297)

## How to run

- Create a new project in the Firebase console and note the project ID.
- Enable Email & Password as a sign in method
  
Then run these commands on the terminal:

```
flutterfire configure --project firebase-project-id
flutter run # use Android emulator as a target device
```

Once the app is running, register a new account using email and password.

At this point the app will crash.

### Observed Output

```
I/flutter ( 7199): Force refresh ID token for UID: MqOOO0HXJcY1YrHG1USEySJJUGr1
W/System  ( 7199): Ignoring header X-Firebase-Locale because its value was null.
E/BasicMessageChannel#dev.flutter.pigeon.FirebaseAuthUserHostApi.getIdToken( 7199): Failed to handle message
E/BasicMessageChannel#dev.flutter.pigeon.FirebaseAuthUserHostApi.getIdToken( 7199): java.lang.IllegalStateException: Task is not yet complete
...
D/AndroidRuntime( 7199): Shutting down VM
E/AndroidRuntime( 7199): FATAL EXCEPTION: main
E/AndroidRuntime( 7199): Process: com.example.firebase_id_token_bug, PID: 7199
E/AndroidRuntime( 7199): java.lang.IllegalStateException: Reply already submitted
E/AndroidRuntime( 7199): 	at io.flutter.embedding.engine.dart.DartMessenger$Reply.reply(DartMessenger.java:435)
E/AndroidRuntime( 7199): 	at io.flutter.plugin.common.BasicMessageChannel$IncomingMessageHandler$1.reply(BasicMessageChannel.java:222)
E/AndroidRuntime( 7199): 	at io.flutter.plugins.firebase.auth.GeneratedAndroidFirebaseAuth$FirebaseAuthUserHostApi$2.success(GeneratedAndroidFirebaseAuth.java:3247)
E/AndroidRuntime( 7199): 	at io.flutter.plugins.firebase.auth.GeneratedAndroidFirebaseAuth$FirebaseAuthUserHostApi$2.success(GeneratedAndroidFirebaseAuth.java:3244)
E/AndroidRuntime( 7199): 	at io.flutter.plugins.firebase.auth.FlutterFirebaseAuthUser.lambda$getIdToken$1(FlutterFirebaseAuthUser.java:88)
E/AndroidRuntime( 7199): 	at io.flutter.plugins.firebase.auth.FlutterFirebaseAuthUser$$ExternalSyntheticLambda2.onComplete(Unknown Source:2)
E/AndroidRuntime( 7199): 	at com.google.android.gms.tasks.zzi.run(com.google.android.gms:play-services-tasks@@18.0.2:1)
E/AndroidRuntime( 7199): 	at android.os.Handler.handleCallback(Handler.java:938)
E/AndroidRuntime( 7199): 	at android.os.Handler.dispatchMessage(Handler.java:99)
E/AndroidRuntime( 7199): 	at android.os.Looper.loopOnce(Looper.java:201)
E/AndroidRuntime( 7199): 	at android.os.Looper.loop(Looper.java:288)
E/AndroidRuntime( 7199): 	at android.app.ActivityThread.main(ActivityThread.java:7839)
E/AndroidRuntime( 7199): 	at java.lang.reflect.Method.invoke(Native Method)
E/AndroidRuntime( 7199): 	at com.android.internal.os.RuntimeInit$MethodAndArgsCaller.run(RuntimeInit.java:548)
E/AndroidRuntime( 7199): 	at com.android.internal.os.ZygoteInit.main(ZygoteInit.java:1003)
I/Process ( 7199): Sending signal. PID: 7199 SIG: 9
Lost connection to device.
```

### [LICENSE: MIT](LICENSE.md)
