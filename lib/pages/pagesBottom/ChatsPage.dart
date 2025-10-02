import 'dart:io';
import 'package:flutter/material.dart';

class ChatsPage extends StatefulWidget {
  final List<Map<String, dynamic>> searchResults;
  final Function(Map<String, dynamic>) onUserSelected;
  final ScrollController? scrollController; // حفظ موقع التمرير
  const ChatsPage({
    super.key,
    required this.searchResults,
    required this.onUserSelected,
    this.scrollController,
  });
  @override
  State<ChatsPage> createState() => _ChatsPageState();
}

class _ChatsPageState extends State<ChatsPage>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true; // الحفاظ على حالة الصفحة
  @override
  Widget build(BuildContext context) {
    super.build(context); // مهم مع AutomaticKeepAliveClientMixin

    return ListView.builder(
      controller: widget.scrollController,
      itemCount: widget.searchResults.length,
      itemBuilder: (context, index) {
        final user = widget.searchResults[index];
        return GestureDetector(
          onTap: () {
            widget.onUserSelected(user);
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 5),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(15),
              ),
              child: Row(
                textDirection: TextDirection.rtl,
                children: [
                  CircleAvatar(
                    radius: 25,
                    backgroundImage: user['image'] != null
                        ? FileImage(File(user['image']))
                        : null,
                    child: user['image'] == null
                        ? const Icon(Icons.person)
                        : null,
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      user['MyName'] ?? '-',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const Icon(Icons.message, color: Colors.green),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
