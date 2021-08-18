import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:learningflutter/controllers/item_controller.dart';

class ItemListError extends ConsumerWidget {
  final String message;

  const ItemListError({Key? key, required this.message}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            message,
            style: TextStyle(fontSize: 20),
          ),
          const SizedBox(
            height: 20,
          ),
          ElevatedButton(
            child: const Text('Retry'),
            onPressed: () {
              ref
                  .read(itemControllerProvider.notifier)
                  .retrieveItems(isRefreshing: true);
            },
          )
        ],
      ),
    );
  }
}
