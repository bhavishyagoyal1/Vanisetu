import 'package:flutter/material.dart';

class TranslateLanguage {
  const TranslateLanguage({
    required this.code,
    required this.name,
    required this.badge,
    required this.color,
  });

  final String code;
  final String name;
  final String badge;
  final Color color;
}

const List<TranslateLanguage> translateLanguages = [
  TranslateLanguage(
    code: 'hi',
    name: 'Hindi',
    badge: 'हिं',
    color: Color(0xFF1B3A6B),
  ),
  TranslateLanguage(
    code: 'sat',
    name: 'Santhali',
    badge: 'ᱥᱟ',
    color: Color(0xFF2E8B6F),
  ),
  TranslateLanguage(
    code: 'unr',
    name: 'Mundari',
    badge: 'Mu',
    color: Color(0xFFF6A522),
  ),
  TranslateLanguage(
    code: 'hoc',
    name: 'Ho',
    badge: 'Ho',
    color: Color(0xFF8E5FC4),
  ),
  TranslateLanguage(
    code: 'en',
    name: 'English',
    badge: 'En',
    color: Color(0xFF3B7DD8),
  ),
];
