import 'package:flutter/material.dart';
import 'package:whatsapp/contextRoutPage/routPage.dart';
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
  int _currentIndex = 0;

  // ✅ الصفحات لكل تبويب
  Widget _getPage(int index) {
    switch (index) {
      case 0:
        return CallsPage();
      case 1:
        return GroupsPage();
      case 2:
        return StatusPage();
      case 3:
        return ChatsPage();
      default:
        return SizedBox();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'واتساب تميم',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        leadingWidth: 100,
        leading: Row(
          children: [
            PopupMenuButton(
              onSelected: (value) {
                if (value == 'setting') {
                  Navigator.pushNamed(context, KSettingpage);
                }
                // أضف إجراءات للخيارات الأخرى لو حبيت
              },
              icon: Icon(Icons.more_vert),
              itemBuilder: (context) => [
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
            IconButton(icon: Icon(Icons.camera_alt_outlined), onPressed: () {}),
          ],
        ),
      ),

      // ✅ محتوى الصفحة حسب التبويب المختار
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'او ابحث Ai اسال',
                  suffixIcon: Icon(Icons.search_outlined),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey),
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(child: SizedBox(height: 20)),
          SliverToBoxAdapter(child: _getPage(_currentIndex)),
        ],
      ),

      // ✅ BottomNavigationBar
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
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

      // ✅ FloatingActionButton
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, kChatHome);
        },
        backgroundColor: const Color(0xFF25D366),
        child: Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
    );
  }
}
