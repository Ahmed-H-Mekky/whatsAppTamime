import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:whatsapp/contextRoutPage/routPage.dart';
import 'package:whatsapp/helps/snalBar/showSnakbar.dart';
import 'package:whatsapp/pages/chatPage.dart';
import 'package:whatsapp/pages/pagesBottom/CallsPage.dart';
import 'package:whatsapp/pages/pagesBottom/ChatsPage.dart';
import 'package:whatsapp/pages/pagesBottom/GroupsPag.dart';
import 'package:whatsapp/pages/pagesBottom/StatusPage.dart';

class Chatepagehom extends StatefulWidget {
  const Chatepagehom({super.key});
  static String id = KChatepagehom;

  @override
  State<Chatepagehom> createState() => _ChatepagehomState();
}

class _ChatepagehomState extends State<Chatepagehom> {
  int _currentIndex = 3;
  String search = '';
  List<Map<String, dynamic>> searchResults = [];
  bool isLoading = false;

  Map<String, dynamic>? selectedUser;
  TextEditingController searchController = TextEditingController();

  // ScrollController لكل صفحة لتخزين موقع التمرير
  final ScrollController _scrollController = ScrollController();

  // توحيد أرقام الهاتف لجميع الصيغ
  String normalizePhone(String phone) {
    String normalized = phone.replaceAll(RegExp(r'\D'), '');
    if (normalized.startsWith('0020')) {
      normalized = '0' + normalized.substring(4);
    } else if (normalized.startsWith('20')) {
      normalized = '0' + normalized.substring(2);
    } else if (!normalized.startsWith('0')) {
      normalized = '0' + normalized;
    }
    return normalized;
  }

  // دالة البحث الجزئي بالرقم المحلي
  Future<void> searchphone({required String phone}) async {
    setState(() {
      isLoading = true;
    });

    try {
      final dbRef = FirebaseFirestore.instance.collection('users');
      final normalizedPhone = normalizePhone(phone);

      final querySnapshot = await dbRef.get();

      final results = querySnapshot.docs
          .where((doc) {
            final userPhone = doc['phone'] ?? '';
            final normalizedUserPhone = normalizePhone(userPhone);
            return normalizedUserPhone.contains(normalizedPhone);
          })
          .map((doc) => doc.data() as Map<String, dynamic>)
          .toList();

      setState(() {
        searchResults = results;
      });
    } catch (e) {
      showSnakBar(context, message: e.toString());
    }

    setState(() {
      isLoading = false;
    });
  }

  Widget _getPage(int index) {
    switch (index) {
      case 0:
        return const CallsPage();
      case 1:
        return const GroupsPage();
      case 2:
        return const StatusPage();
      case 3:
        return ChatsPage(
          key: const PageStorageKey('ChatsPage'), // حفظ حالة الصفحة
          searchResults: searchResults,
          onUserSelected: (user) {
            setState(() {
              selectedUser = user;
              searchResults = [];
              searchController.clear();
            });
          },
          scrollController: _scrollController, // تمرير ScrollController
        );
      default:
        return const SizedBox();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('واتساب تميم'),
        centerTitle: true,
        leadingWidth: 100,
        leading: Row(
          children: [
            PopupMenuButton(
              onSelected: (value) {
                if (value == 'setting') {
                  Navigator.pushNamed(context, KSettingpage);
                }
              },
              icon: const Icon(Icons.more_vert),
              itemBuilder: (context) => const [
                PopupMenuItem(value: 'newGrope', child: Text('مجموعه جديده')),
                PopupMenuItem(
                  value: 'newMessageToAll',
                  child: Text('رسالة جماعية جديدة'),
                ),
                PopupMenuItem(value: 'setting', child: Text('الاعدادات')),
                PopupMenuItem(
                  value: 'switchAcount',
                  child: Text('تبديل الحسابات'),
                ),
              ],
            ),
            IconButton(
              icon: const Icon(Icons.camera_alt_outlined),
              onPressed: () {},
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          // 1. حقل البحث
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: searchController,
              decoration: InputDecoration(
                hintText: 'ابحث عن رقم الهاتف',
                suffixIcon: const Icon(Icons.search_outlined),
                enabledBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.grey),
                  borderRadius: BorderRadius.circular(20),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.grey),
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              onChanged: (value) {
                search = value;
                if (value.isEmpty) {
                  setState(() {
                    searchResults = [];
                  });
                } else {
                  searchphone(phone: value);
                }
              },
            ),
          ),

          // 2. Container المستخدم المختار أسفل البحث
          if (_currentIndex == 3 && selectedUser != null)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 5),
              child: GestureDetector(
                onTap: () {
                  Navigator.pushNamed(
                    context,
                    ChatHome.id,
                    arguments: selectedUser,
                  );
                },
                child: Row(
                  textDirection: TextDirection.rtl,
                  children: [
                    CircleAvatar(
                      radius: 25,
                      backgroundImage: selectedUser!['image'] != null
                          ? FileImage(File(selectedUser!['image']))
                          : null,
                      child: selectedUser!['image'] == null
                          ? const Icon(Icons.person)
                          : null,
                    ),
                    const SizedBox(width: 10),

                    const Text('ahmed', style: TextStyle(fontSize: 19)),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        selectedUser!['MyName'] ?? '10:30 pm',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

          // 3. عرض باقي المستخدمين أو الدردشات
          Expanded(
            child: isLoading
                ? const Center(child: CircularProgressIndicator())
                : _getPage(_currentIndex),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
            // لا تمسح selectedUser عند الانتقال بين التبويبات
          });
        },
        selectedItemColor: Colors.green,
        unselectedItemColor: Colors.white,
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.call), label: 'المكالمات'),
          BottomNavigationBarItem(
            icon: Icon(Icons.group_add_outlined),
            label: 'الجروبات',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.adjust), label: 'الحالات'),
          BottomNavigationBarItem(icon: Icon(Icons.message), label: 'الدردشات'),
        ],
      ),
      floatingActionButton: selectBottom(),
      floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
    );
  }

  Widget selectBottom() {
    if (_currentIndex == 0) {
      return FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, kChatHome);
        },
        backgroundColor: const Color(0xFF25D366),
        child: const Icon(Icons.call),
      );
    } else if (_currentIndex == 1) {
      return FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, kChatHome);
        },
        backgroundColor: const Color(0xFF25D366),
        child: const Icon(Icons.group_add),
      );
    } else if (_currentIndex == 2) {
      return FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, kChatHome);
        },
        backgroundColor: const Color(0xFF25D366),
        child: const Icon(Icons.camera_alt_outlined),
      );
    } else {
      return FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, kChatHome);
        },
        backgroundColor: const Color(0xFF25D366),
        child: const Icon(Icons.add),
      );
    }
  }
}
