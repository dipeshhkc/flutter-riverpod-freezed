import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:learningflutter/controllers/item_controller.dart';
import 'package:learningflutter/models/item_model.dart';

class AddItemDialog extends HookConsumerWidget {
  static show(BuildContext ctx, Item item) {
    showDialog(
        context: ctx,
        builder: (_) => AddItemDialog(
              item: item,
            ));
  }

  final Item item;

  AddItemDialog({Key? key, required this.item}) : super(key: key);

  bool get isUpdating => item.id != null;

  Widget build(BuildContext ctx, WidgetRef ref) {
    final textController = useTextEditingController(text: item.name);
    return Dialog(
      child: Padding(
          padding: EdgeInsets.all(20),
          child: Column(children: [
            TextField(
              autofocus: true,
              controller: textController,
              decoration: InputDecoration(hintText: 'Enter Item Name here'),
            ),
            SizedBox(
              height: 12,
            ),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                child: Text(isUpdating ? "Update" : "Create"),
                onPressed: () {
                  isUpdating
                      ? ref.read(itemControllerProvider.notifier).updateItem(
                          updatedItem: item.copyWith(
                              name: textController.text.trim(),
                              obtained: item.obtained))
                      : ref
                          .read(itemControllerProvider.notifier)
                          .addItem(name: textController.text.trim());
                  Navigator.of(ctx).pop();
                },
              ),
            ),
          ])),
    );
  }
}
