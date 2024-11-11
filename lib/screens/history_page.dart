import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import '../providers/history_provider.dart';

class HistoryPage extends StatelessWidget {
  const HistoryPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<HistoryProvider>(
      builder: (context, historyProvider, child) {
        return historyProvider.historyItems.isNotEmpty
            ? ListView.builder(
                itemCount: historyProvider.historyItems.length,
                itemBuilder: (context, index) {
                  final item = historyProvider.historyItems[index];
                  return Card(
                    margin: const EdgeInsets.symmetric(
                        vertical: 8.0, horizontal: 16.0),
                    child: ListTile(
                      leading: Image.file(
                        File(item["image"]),
                        width: 50,
                        height: 50,
                        fit: BoxFit.cover,
                      ),
                      title: Text(
                        item["text"],
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(fontSize: 16),
                      ),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: const Icon(Icons.copy, color: Colors.blue),
                            onPressed: () {
                              Clipboard.setData(
                                  ClipboardData(text: item["text"]));
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text("Text copied")),
                              );
                            },
                          ),
                          IconButton(
                            icon: const Icon(Icons.delete, color: Colors.red),
                            onPressed: () {
                              historyProvider.deleteHistoryItem(index);
                            },
                          ),
                        ],
                      ),
                    ),
                  );
                },
              )
            : const Center(
                child: Text(
                  "No history records yet.",
                  style: TextStyle(fontSize: 18, color: Colors.grey),
                ),
              );
      },
    );
  }
}
