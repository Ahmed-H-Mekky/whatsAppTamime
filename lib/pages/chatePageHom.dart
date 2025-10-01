import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:whatsapp/contextRoutPage/routPage.dart';
import 'package:whatsapp/pages/pagesBottom/CallsPage.dart';
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
  String _searchQuery = "";

  // 🔹 إزالة كود الدولة + مسافات
  String normalizePhone(String phone) {
    phone = phone.replaceAll("+20", ""); // شيل كود الدولة
    phone = phone.replaceAll(" ", ""); // شيل أي مسافات
    return phone;
  }

  // 🔹 تحديد الصفحة
  Widget _getPage(int index) {
    switch (index) {
      case 0:
        return const CallsPage();
      case 1:
        return const GroupsPage();
      case 2:
        return const StatusPage();
      case 3:
        return _buildContactsList(); // صفحة الدردشات
      default:
        return const SizedBox();
    }
  }

  // 🔹 جلب المستخدمين من Firestore
  Widget _buildContactsList() {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('user').snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Center(child: CircularProgressIndicator());
        }

        final users = snapshot.data!.docs.map((doc) {
          final data = doc.data() as Map<String, dynamic>;
          return {
            'id': doc.id, // id الخاص بالدوكيومنت
            'phone':
                data['phone'] ?? '', // رقم الهاتف (مع قيمة افتراضية لو null)
            'name': data['MyName'] ?? 'مستخدم', // الاسم (لو null يرجع "مستخدم")
          };
        }).toList();

        // فلترة حسب البحث
        final query = _searchQuery.toLowerCase();
        final filteredUsers = users.where((user) {
          final phone = normalizePhone(user['phone'].toString()).toLowerCase();
          final name = user['name'].toString().toLowerCase();

          if (query.isEmpty) return true; // لو مفيش بحث اعرض الكل

          return phone.contains(normalizePhone(query)) || name.contains(query);
        }).toList();

        if (filteredUsers.isEmpty) {
          return const Center(
            child: Text("لا يوجد مستخدم بهذا الاسم أو الرقم"),
          );
        }

        return ListView.builder(
          itemCount: filteredUsers.length,
          itemBuilder: (context, index) {
            final user = filteredUsers[index];
            return ListTile(
              leading: const CircleAvatar(child: Icon(Icons.person)),
              title: Text(user['name']), // عرض الاسم
              subtitle: Text(user['phone']), // عرض رقم الهاتف
              onTap: () {
                Navigator.pushNamed(
                  context,
                  kChatHome,
                  arguments: user, // نمرر بيانات المستخدم للشات
                );
              },
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('واتساب تميم'), centerTitle: true),

      body: Column(
        children: [
          // 🔹 مربع البحث
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              onChanged: (val) {
                setState(() {
                  _searchQuery = val.trim();
                });
              },
              decoration: InputDecoration(
                hintText: 'ابحث بالاسم أو الرقم',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ),
          ),

          // 🔹 عرض الصفحة المناسبة
          Expanded(child: _getPage(_currentIndex)),
        ],
      ),

      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        selectedItemColor: Colors.green,
        unselectedItemColor: Colors.grey,
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.call), label: 'المكالمات'),
          BottomNavigationBarItem(icon: Icon(Icons.group), label: 'الجروبات'),
          BottomNavigationBarItem(icon: Icon(Icons.adjust), label: 'الحالات'),
          BottomNavigationBarItem(icon: Icon(Icons.chat), label: 'الدردشات'),
        ],
      ),
    );
  }
}
