import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:learningflutter/components/item_list_error.dart';
import 'package:learningflutter/components/item_tile.dart';
import 'package:learningflutter/controllers/item_controller.dart';
import 'package:learningflutter/exception/custom_exception.dart';
import 'package:learningflutter/models/item_model.dart';

final currentItemProvider = Provider<Item>((_) => throw UnimplementedError());

class ItemList extends HookConsumerWidget {
  const ItemList({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final itemList = ref.watch(itemControllerProvider);
    return itemList.when(
        data: (items) => items.isEmpty
            ? Center(
                child: Text(
                "Tap + to add an item",
                style: TextStyle(fontSize: 20),
              ))
            : ListView.builder(
                itemCount: items.length,
                itemBuilder: (BuildContext ctx, int index) {
                  final item = items[index];
                  return ProviderScope(
                      child: const ItemTile(),
                      overrides: [currentItemProvider.overrideWithValue(item)]);
                }),
        error: (err, _) => ItemListError(
              message: err is CustomException
                  ? err.message!
                  : 'Something Went Wrong',
            ),
        loading: () => const Center(child: CircularProgressIndicator()));
  }
}
