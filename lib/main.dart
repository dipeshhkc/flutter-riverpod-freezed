import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:learningflutter/components/add_item_dialog.dart';
import 'package:learningflutter/components/item_list.dart';
import 'package:learningflutter/controllers/auth_controller.dart';
import 'package:learningflutter/controllers/item_controller.dart';
import 'package:learningflutter/exception/custom_exception.dart';
import 'package:learningflutter/models/item_model.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter RiverPod Practice',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends HookConsumerWidget {
  Widget build(BuildContext ctx, WidgetRef ref) {
    final authControllerState = ref.watch(authControllerProvider);

    ref.listen<StateController<CustomException?>>(itemExceptionProvider,
        (value) {
      ScaffoldMessenger.of(ctx).showSnackBar(SnackBar(
          content: Text(value.state!.message!), backgroundColor: Colors.red));
    });

    return Scaffold(
      appBar: AppBar(
        title: const Text("Shopping List"),
        leading: authControllerState != null
            ? IconButton(
                onPressed: () =>
                    ref.read(authControllerProvider.notifier).signOut(),
                icon: const Icon(Icons.logout))
            : null,
      ),
      body: const ItemList(),
      floatingActionButton: FloatingActionButton(
        onPressed: () => AddItemDialog.show(ctx, Item.empty()),
        child: const Icon(Icons.add),
      ),
    );
  }
}
