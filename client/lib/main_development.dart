import 'package:cloud_functions/cloud_functions.dart';
import 'package:depression/app/app.dart';
import 'package:depression/bootstrap.dart';
import 'package:firebase_auth/firebase_auth.dart';

Future<void> main() async {
  await bootstrap(
    () => const App(),
    initialize: () async {
      FirebaseFunctions.instance.useFunctionsEmulator('localhost', 5001);
      await FirebaseAuth.instance.useAuthEmulator('localhost', 9099);
    },
  );
}
