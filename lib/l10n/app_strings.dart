import 'package:flutter/widgets.dart';

import 'app_language.dart';
import 'app_language_scope.dart';

/// UI-chrome string lookup, keyed by [AppLanguage]. This covers interface
/// text only — nav labels, hints, button tooltips, screen titles — never
/// content data (curriculum chapter names, dictionary word pairs), which
/// stays in its source language regardless of the app's display language.
///
/// `{placeholder}` tokens in a template are substituted via the `params`
/// argument to [tr].
class AppStrings {
  const AppStrings._();

  static const Map<AppLanguage, Map<String, String>> _values = {
    AppLanguage.english: {
      'nav_curriculum': 'Curriculum',
      'nav_translate': 'Translate',
      'nav_dictionary': 'Dictionary',

      'speak_in_hindi': 'Speak in Hindi…',
      'type_in_santali': 'Type in Santali…',
      'swap_languages': 'Swap languages',
      'swap_unavailable': 'Only Santali supports both directions',
      'translate_to': 'Translate to',
      'translating': 'Translating…',
      'not_available_offline': 'Not available offline yet',
      'translation_appears_here': 'Translation appears here',
      'loading_speech_model': 'Loading speech model…',
      'select_a_language': 'Select a language',
      'copied_to_clipboard': 'Copied to clipboard',
      'translation_failed': 'Translation failed: {error}',
      'could_not_play_audio': 'Could not play audio: {error}',
      'could_not_play_audio_hindi':
          'Could not play audio — is a Hindi voice installed?: {error}',
      'unexpected_error': 'Unexpected error: {error}',
      'speak': 'Speak',
      'copy': 'Copy',

      'source_label': 'Source',
      'target_label': 'Target',
      'speech_in_asr': 'Speech In (ASR)',
      'tap_to_speak': 'Tap to Speak',
      'listening_tap_to_stop': 'Listening… tap to stop',
      'cleaned_asr': 'Cleaned ASR',
      'cleaned_asr_explained':
          'The recogniser emitted Latin letters or digits; they were rewritten into Devanagari before translating.',
      'classroom_prompts': 'Classroom Prompts',
      'view_all_n': 'View All ({n})',
      'santali_voice_tts': 'Santali Voice TTS',
      'hindi_voice_tts': 'Hindi Voice',

      'role_question': 'Who are you?',
      'role_subtitle':
          'We use this to show the right study material for each chapter.',
      'role_teacher': 'Teacher',
      'role_teacher_subtitle': 'Worksheets, flashcards, and answer keys',
      'role_student': 'Student',
      'role_student_subtitle': 'Flashcards and practice quizzes',
      'role_change_hint': 'You can change this later in Settings.',
      'role_label': 'I am a',
      'role_description':
          'Decides which study material a chapter offers. It does not lock anything — you can switch at any time.',
      'answer_key': 'Answer key',

      'settings_title': 'Settings',
      'app_language_label': 'App language',
      'app_language_description':
          'Choose the language used for menus, buttons, and labels throughout the app.',

      'diagnostics_label': 'Diagnostics',
      'ram_monitor_label': 'RAM usage monitor',
      'ram_monitor_description':
          'Shows a live memory usage badge on every screen — this project targets devices with a 2GB RAM budget.',

      'curriculum_title': 'Curriculum',
      'select_class_subtitle':
          'Select a class to view its subjects and chapters',
      'class_n': 'Class {n}',
      'class_n_subjects': 'Class {n} · Subjects',
      'class_n_subject': 'Class {n} · {subject}',
      'n_chapters': '{n} chapters',

      'dictionary_title': 'Dictionary',
      'dictionary_search_hint': 'Search Hindi, English, or Santali…',
      'no_matching_words': 'No matching words',

      'content_worksheet': 'Worksheet',
      'content_flashcards': 'Flashcards',
      'content_assessment': 'Assessment',
      'content_worksheet_subtitle':
          'Practice questions for "{chapter}" will appear here.',
      'content_flashcards_subtitle':
          'Key terms from "{chapter}" as flashcards will appear here.',
      'content_assessment_subtitle':
          'A short quiz for "{chapter}" will appear here.',
      'coming_soon': '{title} coming soon',

      'history_title': 'Translation History',
      'history_open_tooltip': 'Translation history',
      'history_empty_title': 'No translations yet',
      'history_empty_subtitle':
          'Every translation you make is saved here automatically, on this '
          'device only.',
      'history_clear_all': 'Clear all',
      'history_clear_all_title': 'Clear all history?',
      'history_clear_all_body':
          'This deletes all {n} saved translations from this device. This '
          'cannot be undone.',
      'history_delete_tooltip': 'Delete this entry',
      'history_delete_title': 'Delete this translation?',
      'history_delete_body': 'This cannot be undone.',
      'history_entry_deleted': 'Translation deleted',
      'history_all_cleared': 'All translation history cleared',
      'cancel': 'Cancel',
      'delete': 'Delete',
    },
    AppLanguage.hindi: {
      'nav_curriculum': 'पाठ्यक्रम',
      'nav_translate': 'अनुवाद',
      'nav_dictionary': 'शब्दकोश',

      'speak_in_hindi': 'हिंदी में बोलें…',
      'type_in_santali': 'संताली में लिखें…',
      'swap_languages': 'भाषाएँ बदलें',
      'swap_unavailable': 'केवल संताली दोनों दिशाओं में काम करता है',
      'translate_to': 'अनुवाद करें',
      'translating': 'अनुवाद हो रहा है…',
      'not_available_offline': 'ऑफ़लाइन अभी उपलब्ध नहीं है',
      'translation_appears_here': 'अनुवाद यहाँ दिखाई देगा',
      'loading_speech_model': 'स्पीच मॉडल लोड हो रहा है…',
      'select_a_language': 'भाषा चुनें',
      'copied_to_clipboard': 'क्लिपबोर्ड पर कॉपी किया गया',
      'translation_failed': 'अनुवाद विफल रहा: {error}',
      'could_not_play_audio': 'ऑडियो चलाया नहीं जा सका: {error}',
      'could_not_play_audio_hindi':
          'ऑडियो चलाया नहीं जा सका — क्या हिंदी आवाज़ इंस्टॉल है?: {error}',
      'unexpected_error': 'अनपेक्षित त्रुटि: {error}',
      'speak': 'बोलें',
      'copy': 'कॉपी करें',

      'source_label': 'स्रोत',
      'target_label': 'लक्ष्य',
      'speech_in_asr': 'बोलकर लिखें (ASR)',
      'tap_to_speak': 'बोलने के लिए दबाएँ',
      'listening_tap_to_stop': 'सुन रहे हैं… रोकने के लिए दबाएँ',
      'cleaned_asr': 'साफ़ किया गया',
      'cleaned_asr_explained':
          'पहचान में अंग्रेज़ी अक्षर या अंक आए थे; अनुवाद से पहले उन्हें देवनागरी में बदला गया।',
      'classroom_prompts': 'कक्षा के वाक्य',
      'view_all_n': 'सभी देखें ({n})',
      'santali_voice_tts': 'संताली आवाज़',
      'hindi_voice_tts': 'हिंदी आवाज़',

      'role_question': 'आप कौन हैं?',
      'role_subtitle':
          'इससे हम हर अध्याय के लिए सही अध्ययन सामग्री दिखाते हैं।',
      'role_teacher': 'शिक्षक',
      'role_teacher_subtitle': 'वर्कशीट, फ्लैशकार्ड और उत्तर कुंजी',
      'role_student': 'विद्यार्थी',
      'role_student_subtitle': 'फ्लैशकार्ड और अभ्यास प्रश्नोत्तरी',
      'role_change_hint': 'आप इसे बाद में सेटिंग्स में बदल सकते हैं।',
      'role_label': 'मैं हूँ',
      'role_description':
          'तय करता है कि अध्याय में कौन सी अध्ययन सामग्री दिखे। यह कुछ भी बंद नहीं करता — आप कभी भी बदल सकते हैं।',
      'answer_key': 'उत्तर कुंजी',

      'settings_title': 'सेटिंग्स',
      'app_language_label': 'ऐप की भाषा',
      'app_language_description': 'ऐप के मेनू, बटन और लेबल के लिए भाषा चुनें।',

      'diagnostics_label': 'डायग्नोस्टिक्स',
      'ram_monitor_label': 'RAM उपयोग मॉनिटर',
      'ram_monitor_description':
          'हर स्क्रीन पर लाइव मेमोरी उपयोग दिखाता है — इस प्रोजेक्ट का लक्ष्य 2GB RAM वाले डिवाइस हैं।',

      'curriculum_title': 'पाठ्यक्रम',
      'select_class_subtitle': 'विषय और अध्याय देखने के लिए कक्षा चुनें',
      'class_n': 'कक्षा {n}',
      'class_n_subjects': 'कक्षा {n} · विषय',
      'class_n_subject': 'कक्षा {n} · {subject}',
      'n_chapters': '{n} अध्याय',

      'dictionary_title': 'शब्दकोश',
      'dictionary_search_hint': 'हिंदी, अंग्रेज़ी या संताली में खोजें…',
      'no_matching_words': 'कोई मिलता-जुलता शब्द नहीं मिला',

      'content_worksheet': 'वर्कशीट',
      'content_flashcards': 'फ्लैशकार्ड',
      'content_assessment': 'मूल्यांकन',
      'content_worksheet_subtitle':
          '"{chapter}" के अभ्यास प्रश्न यहाँ दिखाई देंगे।',
      'content_flashcards_subtitle':
          '"{chapter}" के मुख्य शब्द फ्लैशकार्ड के रूप में यहाँ दिखाई देंगे।',
      'content_assessment_subtitle':
          '"{chapter}" के लिए एक छोटी प्रश्नोत्तरी यहाँ दिखाई देगी।',
      'coming_soon': '{title} जल्द आ रहा है',

      'history_title': 'अनुवाद इतिहास',
      'history_open_tooltip': 'अनुवाद इतिहास',
      'history_empty_title': 'अभी तक कोई अनुवाद नहीं',
      'history_empty_subtitle':
          'आपका हर अनुवाद यहाँ अपने आप सुरक्षित हो जाता है, सिर्फ़ इसी डिवाइस पर।',
      'history_clear_all': 'सभी हटाएँ',
      'history_clear_all_title': 'पूरा इतिहास हटाएँ?',
      'history_clear_all_body':
          'इससे इस डिवाइस से सभी {n} सुरक्षित अनुवाद हट जाएँगे। यह वापस नहीं '
          'किया जा सकता।',
      'history_delete_tooltip': 'यह अनुवाद हटाएँ',
      'history_delete_title': 'यह अनुवाद हटाएँ?',
      'history_delete_body': 'यह वापस नहीं किया जा सकता।',
      'history_entry_deleted': 'अनुवाद हटाया गया',
      'history_all_cleared': 'पूरा अनुवाद इतिहास हटाया गया',
      'cancel': 'रद्द करें',
      'delete': 'हटाएँ',
    },
  };

  static String _lookup(AppLanguage language, String key) {
    return _values[language]?[key] ?? _values[AppLanguage.english]![key] ?? key;
  }

  static String resolve(
    AppLanguage language,
    String key, [
    Map<String, String>? params,
  ]) {
    var result = _lookup(language, key);
    params?.forEach((name, value) {
      result = result.replaceAll('{$name}', value);
    });
    return result;
  }
}

/// Shorthand for `AppStrings.resolve(context.appLanguage, key, params)`.
String tr(BuildContext context, String key, [Map<String, String>? params]) {
  return AppStrings.resolve(context.appLanguage, key, params);
}
