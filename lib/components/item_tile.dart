import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:learningflutter/components/add_item_dialog.dart';
import 'package:learningflutter/components/item_list.dart';
import 'package:learningflutter/controllers/item_controller.dart';

class ItemTile extends HookConsumerWidget {
  const ItemTile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final item = ref.watch(currentItemProvider);
    return ListTile(
        key: ValueKey(item.id),
        title: Text(item.name),
        trailing: Checkbox(
          value: item.obtained,
          onChanged: (_) {
            ref.read(itemControllerProvider.notifier).updateItem(
                updatedItem: item.copyWith(obtained: !item.obtained));
          },
        ),
        onTap: () => AddItemDialog.show(context, item),
        onLongPress: () => ref
            .read(itemControllerProvider.notifier)
            .deleteItem(itemId: item.id!));
  }
}
