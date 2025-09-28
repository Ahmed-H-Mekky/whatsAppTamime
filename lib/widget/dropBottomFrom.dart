// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:whatsapp/model/countryCode.dart';

// ignore: must_be_immutable
class Dropbottomfrom extends StatelessWidget {
  const Dropbottomfrom({
    super.key,
    required this.selectedCountryCode,
    required this.selectedCountry,
    required this.onChanged,
  });
  final String selectedCountry;
  final String selectedCountryCode;
  final Function(String, String) onChanged; // ✅ دالة تستقبل الدولة والكود

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      initialValue: selectedCountry,
      decoration: const InputDecoration(
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.greenAccent, width: 0.7),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.greenAccent, width: 0.9),
        ),
      ),
      dropdownColor: Colors.black,
      style: const TextStyle(color: Colors.white),
      items: countryCodes.keys
          .map(
            (country) => DropdownMenuItem(value: country, child: Text(country)),
          )
          .toList(),
      onChanged: (country) {
        if (country != null) {
          String code = countryCodes[country]!;
          onChanged(country, code); // ✅ نبعث النتيجة للصفحة الرئيسية
        }
      },
    );
  }
}
