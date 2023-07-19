import 'package:firebase_auth/firebase_auth.dart' hide EmailAuthProvider;
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_id_token_bug/firebase_options.dart';
import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

Future<void> setupEmulators() async {
  await FirebaseAuth.instance.useAuthEmulator('localhost', 9099);
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await setupEmulators();
  // Always sign out to start from a clean slate
  await FirebaseAuth.instance.signOut();
  runApp(const ProviderScope(
    child: MainApp(),
  ));
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: AuthWidget(),
    );
  }
}

final authStateChangesProvider = StreamProvider<User?>((ref) {
  return FirebaseAuth.instance.authStateChanges();
});

class AuthWidget extends ConsumerWidget {
  const AuthWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // This code is needed to trigger the force refresh and reproduce the bug
    ref.listen<AsyncValue<User?>>(authStateChangesProvider,
        (previous, next) async {
      final user = next.value;
      if (user != null) {
        // force token refresh
        debugPrint('Force refresh ID token for UID: ${user.uid}');
        await user.getIdToken(true);
      }
    });
    return ref.watch(authStateChangesProvider).when(
          data: (user) {
            if (user == null) {
              return const CustomSignInScreen();
            } else {
              return const CustomProfileScreen();
            }
          },
          loading: () =>
              const Scaffold(body: Center(child: CircularProgressIndicator())),
          error: (e, st) => Scaffold(body: Center(child: Text(e.toString()))),
        );
  }
}

final authProviders = [EmailAuthProvider()];

class CustomSignInScreen extends StatelessWidget {
  const CustomSignInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sign in'),
      ),
      body: SignInScreen(
        providers: authProviders,
      ),
    );
  }
}

class CustomProfileScreen extends StatelessWidget {
  const CustomProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ProfileScreen(
      appBar: AppBar(
        title: const Text('Profile'),
      ),
      providers: authProviders,
    );
  }
}
