/// Ready-made Hindi sentences a teacher says constantly in class, offered as
/// one-tap chips on the Translate screen so the common cases need neither
/// typing nor a clean recording.
///
/// The sentences are a verbatim copy of `models/test/classroom_sentences.txt`
/// — the in-domain list already used to test the MT pipeline, so every one of
/// them is known to translate sensibly. `test/classroom_prompts_test.dart`
/// pins the two together; edit the source file and the test fails until this
/// copy is updated to match.
///
/// [label] is a shortened form of [hindi] for the chip face, and is required
/// to be a substring-wise subset of it: a chip must never promise something
/// different from the sentence it inserts.
library;

class ClassroomPrompt {
  const ClassroomPrompt({
    required this.emoji,
    required this.label,
    required this.hindi,
  });

  final String emoji;

  /// Short form shown on the chip.
  final String label;

  /// The full sentence inserted into the source box when tapped.
  final String hindi;
}

const List<ClassroomPrompt> classroomPrompts = [
  ClassroomPrompt(
    emoji: '📖',
    label: 'किताब खोलो',
    hindi: 'बच्चों, अपनी किताब खोलो।',
  ),
  ClassroomPrompt(
    emoji: '🧍',
    label: 'खड़े हो जाओ',
    hindi: 'सब बच्चे खड़े हो जाओ।',
  ),
  ClassroomPrompt(
    emoji: '✏️',
    label: 'पेंसिल निकालो',
    hindi: 'अपनी पेंसिल निकालो।',
  ),
  ClassroomPrompt(emoji: '🎨', label: 'कौन सा रंग', hindi: 'यह कौन सा रंग है?'),
  ClassroomPrompt(emoji: '🔢', label: 'पाँच तक गिनो', hindi: 'पाँच तक गिनो।'),
  ClassroomPrompt(emoji: '✍️', label: 'नाम लिखो', hindi: 'अपना नाम लिखो।'),
  ClassroomPrompt(emoji: '📓', label: 'कॉपी खोलो', hindi: 'अपनी कॉपी खोलो।'),
  ClassroomPrompt(
    emoji: '🖼️',
    label: 'चित्र को देखो',
    hindi: 'चित्र को ध्यान से देखो।',
  ),
  ClassroomPrompt(
    emoji: '🙋',
    label: 'उत्तर बताएगा',
    hindi: 'कौन मुझे इसका उत्तर बताएगा?',
  ),
  ClassroomPrompt(
    emoji: '🧮',
    label: 'संख्याएँ सीखेंगे',
    hindi: 'आज हम संख्याएँ सीखेंगे।',
  ),
  ClassroomPrompt(
    emoji: '🤫',
    label: 'ध्यान से सुनो',
    hindi: 'बच्चों, ध्यान से सुनो।',
  ),
  ClassroomPrompt(
    emoji: '📕',
    label: 'किताब बंद करो',
    hindi: 'अब अपनी किताब बंद करो।',
  ),
  ClassroomPrompt(
    emoji: '🪧',
    label: 'बोर्ड की तरफ',
    hindi: 'बोर्ड की तरफ देखो।',
  ),
  ClassroomPrompt(
    emoji: '🧑‍🤝‍🧑',
    label: 'दोस्त के साथ',
    hindi: 'अपने दोस्त के साथ बैठो।',
  ),
  ClassroomPrompt(
    emoji: '🔤',
    label: 'कौन सा अक्षर',
    hindi: 'यह कौन सा अक्षर है?',
  ),
  ClassroomPrompt(
    emoji: '🔟',
    label: 'गिनती करो',
    hindi: 'एक से दस तक गिनती करो।',
  ),
  ClassroomPrompt(emoji: '🔴', label: 'लाल रंग', hindi: 'लाल रंग दिखाओ।'),
  ClassroomPrompt(emoji: '✋', label: 'हाथ ऊपर करो', hindi: 'अपना हाथ ऊपर करो।'),
  ClassroomPrompt(
    emoji: '🔍',
    label: 'चित्र को पहचानो',
    hindi: 'नीचे दिए गए चित्र को पहचानो।',
  ),
  ClassroomPrompt(
    emoji: '📚',
    label: 'कहानी पढ़ेंगे',
    hindi: 'आज हम एक कहानी पढ़ेंगे।',
  ),
];
