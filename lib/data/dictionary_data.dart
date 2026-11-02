/// Hindi <-> Santali (Ol Chiki) phrase list for the Dictionary feature.
///
/// Source: `English-Hindi-Santali_Dataset.md` at the repo root (an
/// English -> Hindi -> Santali phrasebook). That file's own Santali column
/// is romanized (Latin script), which is incompatible with the rest of the
/// app — HindiSantaliMtService's MT output, and SantaliTtsService's voice
/// model, both work in Ol Chiki (U+1C50-1C7F) only. So the Latin Santali
/// column was discarded entirely and every Hindi entry was re-translated
/// through the same verified Hindi->Santali MT pipeline used elsewhere in
/// this app (models/indic_translate, via models/test/translate.py), the
/// same generation method the original word-list entries below this
/// comment's history used.
///
/// Categories (Basic Words / Example Sentences / What-Why-How-Which-Where
/// Questions / Everyday Conversation) were inferred from the source
/// document's own block structure — it has no explicit category column.
///
/// Audited the same way as the previous word-list pass: 9 of the 87 source
/// entries were dropped for provable failures, not spot-checked ones —
/// wrong-script output (Perso-Arabic "میٹنگ" for 'meeting', Meitei Mayek
/// "ꯃꯆꯨ" for 'colour'), degenerate token-repetition loops (e.g. 'What
/// should I do?' decoding to ᱤᱧ repeated over a hundred times), and two
/// tense-distinct sentence pairs ('is eating'/'ate', 'had gone'/'will go')
/// that collapsed to an identical Santali string, meaning at least one of
/// each pair is wrong. All are provable from the data itself or from Hindi
/// alone, the same standard applied before.
///
/// What this does *not* establish: correctness. No native-speaker
/// verification has been done on the 78 entries that remain. Treat this as
/// a best-effort offline reference, not an authoritative dictionary, and
/// get native-speaker review before relying on any entry for instruction.
library;

class DictionaryEntry {
  const DictionaryEntry({
    required this.category,
    required this.hindi,
    required this.gloss,
    required this.santali,
  });

  final String category;
  final String hindi;
  final String gloss;
  final String santali;
}

const List<DictionaryEntry> dictionaryData = [
  DictionaryEntry(
    category: 'Basic Words',
    hindi: 'वह (महिला)',
    gloss: 'She',
    santali: 'ᱩᱱᱤ (ᱛᱤᱨᱞᱟᱹ) ᱾',
  ),
  DictionaryEntry(
    category: 'Basic Words',
    hindi: 'आप / तुम',
    gloss: 'You',
    santali: 'ᱟᱢ/ᱟᱢ ᱾',
  ),
  DictionaryEntry(
    category: 'Basic Words',
    hindi: 'यह / वह',
    gloss: 'It',
    santali: 'ᱱᱚᱶᱟ/ᱚᱱᱟ ᱾',
  ),
  DictionaryEntry(
    category: 'Basic Words',
    hindi: 'एक',
    gloss: 'A',
    santali: 'ᱢᱤᱫᱴᱟᱝ ᱾',
  ),
  DictionaryEntry(
    category: 'Basic Words',
    hindi: 'आओ / आना',
    gloss: 'Come',
    santali: 'ᱦᱮᱡ/ᱦᱮᱡ ᱢᱮ ᱾',
  ),
  DictionaryEntry(
    category: 'Basic Words',
    hindi: 'आएगा / आएगी',
    gloss: 'Will come',
    santali: 'ᱦᱮᱡ/ᱦᱮᱡ ᱾',
  ),
  DictionaryEntry(
    category: 'Basic Words',
    hindi: 'खोलना',
    gloss: 'Open',
    santali: 'ᱮᱦᱚᱵ ᱾',
  ),
  DictionaryEntry(
    category: 'Basic Words',
    hindi: 'खोला गया / खुला',
    gloss: 'Opened',
    santali: 'ᱮᱦᱚᱵ/ᱮᱦᱚᱵ ᱾',
  ),
  DictionaryEntry(
    category: 'Basic Words',
    hindi: 'खोलेगा / खोलेगी',
    gloss: 'Will open',
    santali: 'ᱮᱦᱚᱵᱚᱜᱼᱟ/ᱮᱦᱚᱵᱚᱜᱼᱟ ᱾',
  ),
  DictionaryEntry(
    category: 'Basic Words',
    hindi: 'बैठना',
    gloss: 'Sit',
    santali: 'ᱵᱮᱶᱦᱟᱨ ᱢᱮ ᱾',
  ),
  DictionaryEntry(
    category: 'Basic Words',
    hindi: 'चलना',
    gloss: 'Walk',
    santali: 'ᱪᱟᱞᱟᱣᱟᱱ ᱾',
  ),
  DictionaryEntry(
    category: 'Basic Words',
    hindi: 'खाना',
    gloss: 'Eat',
    santali: 'ᱡᱚᱢᱟᱜ ᱾',
  ),
  DictionaryEntry(
    category: 'Basic Words',
    hindi: 'पीना',
    gloss: 'Drink',
    santali: 'ᱰᱟᱣᱩᱱᱞᱳᱰ ᱢᱮ ᱾',
  ),
  DictionaryEntry(
    category: 'Basic Words',
    hindi: 'जाना',
    gloss: 'Go',
    santali: 'ᱪᱟᱞᱟᱣ ᱢᱮ ᱾',
  ),
  DictionaryEntry(
    category: 'Basic Words',
    hindi: 'दौड़ना',
    gloss: 'Run',
    santali: 'ᱫᱟᱹᱲ ᱢᱮ ᱾',
  ),
  DictionaryEntry(
    category: 'Example Sentences',
    hindi: 'मैंने पिछले सप्ताह फिल्म देखी।',
    gloss: 'I saw the film last week.',
    santali: 'ᱤᱧ ᱪᱟᱞᱟᱣᱮᱱ ᱦᱟᱯᱛᱟ ᱨᱮ ᱪᱚᱞᱚᱛ ᱪᱤᱛᱟᱹᱨ ᱧᱮᱞ ᱟᱠᱟᱫᱟ ᱾',
  ),
  DictionaryEntry(
    category: 'Example Sentences',
    hindi: 'वह कल बस से आई।',
    gloss: 'She came by bus yesterday.',
    santali: 'ᱩᱱᱤ ᱫᱚ ᱦᱚᱭᱦᱩᱫᱮ ᱵᱟᱥ ᱠᱷᱚᱱ ᱮ ᱦᱮᱡ ᱞᱮᱱᱟ ᱾',
  ),
  DictionaryEntry(
    category: 'Example Sentences',
    hindi: 'वे मंदिर गए।',
    gloss: 'They went to the temple.',
    santali: 'ᱩᱱᱠᱩ ᱫᱚ ᱢᱩᱱᱫᱤᱞ ᱨᱮᱭ ᱥᱮᱱ ᱞᱮᱱᱟ ᱾',
  ),
  DictionaryEntry(
    category: 'Example Sentences',
    hindi: 'वह पूरी रात सोया।',
    gloss: 'He slept the whole night.',
    santali: 'ᱩᱱᱤ ᱫᱚ ᱥᱟᱱᱟᱢ ᱫᱤᱱ ᱮ ᱥᱳᱯᱳᱨ ᱞᱮᱱᱟ ᱾',
  ),
  DictionaryEntry(
    category: 'Example Sentences',
    hindi: 'उसने परीक्षा में अच्छा लिखा।',
    gloss: 'He wrote well in the examination.',
    santali: 'ᱩᱱᱤ ᱫᱚ ᱵᱤᱰᱟᱹᱣ ᱨᱮ ᱱᱟᱯᱟᱭ ᱮ ᱚᱞ ᱞᱮᱫᱟ ᱾',
  ),
  DictionaryEntry(
    category: 'Example Sentences',
    hindi: 'उसने खा लिया है।',
    gloss: 'He has eaten.',
    santali: 'ᱩᱱᱤ ᱫᱚ ᱠᱷᱟᱱ ᱠᱟᱱᱟ ᱾',
  ),
  DictionaryEntry(
    category: 'Example Sentences',
    hindi: 'उसने खा लिया था।',
    gloss: 'He had eaten.',
    santali: 'ᱩᱱᱤ ᱫᱚ ᱠᱷᱟᱱ ᱛᱟᱦᱮᱸ ᱠᱟᱱᱟ ᱾',
  ),
  DictionaryEntry(
    category: 'Example Sentences',
    hindi: 'वह आ चुका था।',
    gloss: 'He had come.',
    santali: 'ᱩᱱᱤ ᱫᱚ ᱦᱮᱡ ᱮᱱᱟ ᱾',
  ),
  DictionaryEntry(
    category: 'Example Sentences',
    hindi: 'वह खाएगा।',
    gloss: 'He will eat.',
    santali: 'ᱩᱱᱤ ᱫᱚ ᱠᱷᱟᱱ ᱾',
  ),
  DictionaryEntry(
    category: 'Example Sentences',
    hindi: 'वह आएगा।',
    gloss: 'He will come.',
    santali: 'ᱩᱱᱤ ᱦᱮᱡ ᱮᱱᱟ ᱾',
  ),
  DictionaryEntry(
    category: 'What Questions',
    hindi: 'आपका नाम क्या है?',
    gloss: 'What is your name?',
    santali: 'ᱟᱢᱟᱜ ᱧᱩᱛᱩᱢ ᱪᱮᱫ?',
  ),
  DictionaryEntry(
    category: 'What Questions',
    hindi: 'क्या',
    gloss: 'What',
    santali: 'ᱪᱮᱫ ᱞᱟᱹᱜᱤᱫ?',
  ),
  DictionaryEntry(
    category: 'What Questions',
    hindi: 'है',
    gloss: 'Is',
    santali: 'ᱱᱚᱶᱟ ᱫᱚ ᱦᱩᱭᱩᱜ ᱠᱟᱱᱟ ᱾',
  ),
  DictionaryEntry(
    category: 'What Questions',
    hindi: 'आपका / तुम्हारा',
    gloss: 'Your',
    santali: 'ᱟᱢᱟᱜ/ᱟᱢᱟᱜ ᱾',
  ),
  DictionaryEntry(
    category: 'What Questions',
    hindi: 'नाम',
    gloss: 'Name',
    santali: 'ᱧᱩᱛᱩᱢ ᱾',
  ),
  DictionaryEntry(
    category: 'What Questions',
    hindi: 'आपने क्या किया?',
    gloss: 'What did you do?',
    santali: 'ᱟᱢ ᱪᱮᱫ ᱮᱢ ᱠᱚᱨᱟᱣ ᱟᱠᱟᱫᱟ?',
  ),
  DictionaryEntry(
    category: 'What Questions',
    hindi: 'मैं क्या कर सकता हूँ?',
    gloss: 'What can I do?',
    santali: 'ᱤᱧ ᱪᱮᱫ ᱮᱢ ᱠᱚᱨᱟᱣ ᱫᱟᱲᱮᱭᱟᱜᱼᱟ?',
  ),
  DictionaryEntry(
    category: 'What Questions',
    hindi: 'प्रश्न क्या हैं?',
    gloss: 'What are the questions?',
    santali: 'ᱯᱚᱨᱤᱢᱟᱱ ᱠᱚ ᱪᱮᱫ?',
  ),
  DictionaryEntry(
    category: 'What Questions',
    hindi: 'प्रश्न क्या थे?',
    gloss: 'What were the questions?',
    santali: 'ᱯᱚᱨᱤᱢᱟᱱ ᱠᱚ ᱪᱮᱫ ᱛᱟᱦᱮᱸ ᱠᱟᱱᱟ?',
  ),
  DictionaryEntry(
    category: 'What Questions',
    hindi: 'आखिरी प्रश्न क्या है?',
    gloss: 'What is the last question?',
    santali: 'ᱢᱩᱪᱟᱹᱫ ᱯᱚᱨᱤᱢᱟᱱ ᱫᱚ ᱪᱮᱫ?',
  ),
  DictionaryEntry(
    category: 'What Questions',
    hindi: 'पत्र में क्या लिखा है?',
    gloss: 'What is written in the letter?',
    santali: 'ᱞᱟᱹᱞᱤᱥ ᱨᱮ ᱪᱮᱫ ᱚᱞ ᱢᱮᱱᱟᱜᱼᱟ?',
  ),
  DictionaryEntry(
    category: 'What Questions',
    hindi: 'आपको क्या बताया गया था?',
    gloss: 'What you had been told?',
    santali: 'ᱟᱢ ᱪᱮᱫ ᱞᱟᱹᱭ ᱟᱠᱟᱫᱟ?',
  ),
  DictionaryEntry(
    category: 'What Questions',
    hindi: 'उत्तर क्या होगा?',
    gloss: 'What will be the answer?',
    santali: 'ᱩᱛᱛᱚᱨ ᱫᱚ ᱪᱮᱫ ᱦᱩᱭᱩᱜᱼᱟ?',
  ),
  DictionaryEntry(
    category: 'Why Questions',
    hindi: 'आप क्यों आए?',
    gloss: 'Why did you come?',
    santali: 'ᱟᱢ ᱪᱮᱫ ᱞᱟᱹᱜᱤᱫ ᱮ ᱦᱮᱡ ᱟᱠᱟᱱᱟ?',
  ),
  DictionaryEntry(
    category: 'Why Questions',
    hindi: 'आप क्यों सोए?',
    gloss: 'Why did you sleep?',
    santali: 'ᱟᱢ ᱪᱮᱫ ᱞᱟᱹᱜᱤᱫ ᱮ ᱥᱳᱯᱨᱳᱫᱚᱜ ᱠᱟᱱᱟ?',
  ),
  DictionaryEntry(
    category: 'Why Questions',
    hindi: 'आपने उसे जाने के लिए क्यों कहा?',
    gloss: 'Why did you tell him to go?',
    santali: 'ᱟᱢ ᱪᱮᱫ ᱞᱟᱹᱜᱤᱫ ᱩᱱᱤ ᱪᱟᱞᱟᱣ ᱞᱟᱹᱜᱤᱫ ᱮ ᱢᱮᱱ ᱟᱠᱟᱫᱟ?',
  ),
  DictionaryEntry(
    category: 'Why Questions',
    hindi: 'वह बैग क्यों लाया?',
    gloss: 'Why did he bring the bag?',
    santali: 'ᱩᱱᱤ ᱫᱚ ᱪᱮᱫ ᱞᱟᱹᱜᱤᱫ ᱵᱮᱜᱽ ᱮ ᱦᱟᱛᱟᱣ ᱞᱮᱫᱟ?',
  ),
  DictionaryEntry(
    category: 'Why Questions',
    hindi: 'उसने पैसे क्यों दिए?',
    gloss: 'Why did she pay the money?',
    santali: 'ᱩᱱᱤ ᱫᱚ ᱪᱮᱫ ᱞᱟᱹᱜᱤᱫ ᱠᱟᱹᱣᱰᱤ ᱮ ᱮᱢ ᱞᱮᱫᱟ?',
  ),
  DictionaryEntry(
    category: 'Why Questions',
    hindi: 'वे वहाँ क्यों बैठे?',
    gloss: 'Why did they sit there?',
    santali: 'ᱩᱱᱠᱩ ᱪᱮᱫ ᱞᱟᱹᱜᱤᱫ ᱮ ᱥᱮᱱ ᱞᱮᱱᱟ?',
  ),
  DictionaryEntry(
    category: 'Why Questions',
    hindi: 'आप कार क्यों चलाते हैं?',
    gloss: 'Why do you drive the car?',
    santali: 'ᱟᱢ ᱪᱮᱫ ᱞᱟᱹᱜᱤᱫ ᱜᱟᱹᱰᱤ ᱪᱟᱞᱟᱣ ᱮᱫᱟ?',
  ),
  DictionaryEntry(
    category: 'How Questions',
    hindi: 'आप कैसे आए?',
    gloss: 'How did you come?',
    santali: 'ᱟᱢ ᱪᱮᱫ ᱞᱮᱠᱟᱛᱮ ᱦᱮᱡ ᱟᱠᱟᱱᱟ?',
  ),
  DictionaryEntry(
    category: 'How Questions',
    hindi: 'आप कैसे सोए?',
    gloss: 'How did you sleep?',
    santali: 'ᱟᱢ ᱪᱮᱫ ᱞᱮᱠᱟᱛᱮ ᱥᱳᱯᱳᱨᱚᱜᱼᱟ?',
  ),
  DictionaryEntry(
    category: 'How Questions',
    hindi: 'आपने कार कैसे चलाई?',
    gloss: 'How did you drive the car?',
    santali: 'ᱟᱢ ᱪᱮᱫ ᱞᱮᱠᱟᱛᱮ ᱜᱟᱹᱰᱤ ᱪᱟᱞᱟᱣ ᱮᱫᱟ?',
  ),
  DictionaryEntry(
    category: 'How Questions',
    hindi: 'आपने कैसे लिखा?',
    gloss: 'How did you write?',
    santali: 'ᱟᱢ ᱪᱮᱫ ᱞᱮᱠᱟᱛᱮ ᱚᱞ ᱟᱠᱟᱫᱟ?',
  ),
  DictionaryEntry(
    category: 'How Questions',
    hindi: 'मेरे हाथ में कितने सेब हैं?',
    gloss: 'How many apples are there in my hand?',
    santali: 'ᱤᱧ ᱴᱷᱮᱱ ᱛᱤᱱᱟᱹᱜ ᱮᱯᱚᱞ ᱢᱮᱱᱟᱜᱼᱟ?',
  ),
  DictionaryEntry(
    category: 'How Questions',
    hindi: 'आपने कितने लिए?',
    gloss: 'How many did you take?',
    santali: 'ᱟᱢ ᱛᱤᱱᱟᱹᱜ ᱮᱢ ᱦᱟᱛᱟᱣ ᱟᱠᱟᱫᱟ?',
  ),
  DictionaryEntry(
    category: 'How Questions',
    hindi: 'उसने आपको कितने पैसे दिए?',
    gloss: 'How much did he pay you?',
    santali: 'ᱩᱱᱤ ᱫᱚ ᱟᱢ ᱛᱤᱱᱟᱹᱜ ᱠᱟᱹᱣᱰᱤ ᱮᱢ ᱞᱮᱫᱟᱭ?',
  ),
  DictionaryEntry(
    category: 'How Questions',
    hindi: 'कितनी दूरी जाना है?',
    gloss: 'How much distance to go?',
    santali: 'ᱛᱤᱱᱟᱹᱜ ᱥᱟᱹᱜᱤᱧ ᱪᱟᱞᱟᱜ ᱦᱩᱭᱩᱜ ᱠᱟᱱᱟ?',
  ),
  DictionaryEntry(
    category: 'How Questions',
    hindi: 'कल की यात्रा कैसी थी?',
    gloss: 'How was the journey yesterday?',
    santali: 'ᱦᱚᱭᱦᱩᱫᱤᱥ ᱨᱮᱭᱟᱜ ᱥᱟᱸᱜᱷᱟᱨ ᱪᱮᱫ ᱞᱮᱠᱟ ᱛᱟᱦᱮᱸ ᱠᱟᱱᱟ?',
  ),
  DictionaryEntry(
    category: 'Which Questions',
    hindi: 'आप किस रास्ते से आए?',
    gloss: 'Which way did you come?',
    santali: 'ᱟᱢ ᱪᱮᱫ ᱰᱟᱦᱟᱨ ᱠᱷᱚᱱ ᱦᱮᱡ ᱟᱠᱟᱱᱟ?',
  ),
  DictionaryEntry(
    category: 'Which Questions',
    hindi: 'आप किस कमरे में सोए?',
    gloss: 'In which room did you sleep?',
    santali: 'ᱟᱢ ᱪᱮᱫ ᱚᱲᱟᱜ ᱨᱮ ᱥᱳᱯᱳᱨᱚᱜᱼᱟ?',
  ),
  DictionaryEntry(
    category: 'Which Questions',
    hindi: 'आपने कौन-सी कहानी बताई?',
    gloss: 'Which story did you tell?',
    santali: 'ᱟᱢ ᱪᱮᱫ ᱠᱟᱹᱦᱱᱤ ᱞᱟᱹᱭ ᱟᱠᱟᱫᱟ?',
  ),
  DictionaryEntry(
    category: 'Which Questions',
    hindi: 'सबसे मीठा फल कौन-सा है?',
    gloss: 'Which is the sweetest fruit?',
    santali: 'ᱡᱚᱛᱚ ᱠᱷᱚᱱ ᱢᱚᱫᱽᱫᱷᱟᱹᱨ ᱯᱷᱚᱞᱮ ᱫᱚ ᱪᱮᱫ?',
  ),
  DictionaryEntry(
    category: 'Which Questions',
    hindi: 'हिंदी में सबसे अच्छा समाचार पत्र कौन-सा है?',
    gloss: 'Which is the best newspaper in Hindi?',
    santali: 'ᱦᱤᱱᱫᱤ ᱨᱮᱭᱟᱜ ᱥᱚᱨᱮᱥ ᱰᱚᱜᱚᱨ ᱥᱟᱠᱟᱢ ᱫᱚ ᱪᱮᱫ?',
  ),
  DictionaryEntry(
    category: 'Which Questions',
    hindi: 'भारत के किस राज्य की जनसंख्या सबसे अधिक है?',
    gloss: 'Which Indian state has the largest population?',
    santali: 'ᱵᱷᱟᱨᱚᱛ ᱨᱮᱭᱟᱜ ᱚᱠᱟ ᱯᱚᱱᱚᱛ ᱨᱮ ᱡᱚᱛᱚ ᱠᱷᱚᱱ ᱰᱷᱮᱨ ᱦᱚᱲ ᱞᱮᱠᱷᱟ ᱢᱮᱱᱟᱜ ᱠᱚᱣᱟ?',
  ),
  DictionaryEntry(
    category: 'Where Questions',
    hindi: 'आप कहाँ से आ रहे हैं?',
    gloss: 'Where are you coming from?',
    santali: 'ᱟᱢ ᱪᱮᱫ ᱠᱷᱚᱱ ᱦᱮᱡ ᱟᱠᱟᱱᱟ?',
  ),
  DictionaryEntry(
    category: 'Where Questions',
    hindi: 'आप कहाँ सोए?',
    gloss: 'Where did you sleep?',
    santali: 'ᱟᱢ ᱪᱮᱫ ᱴᱷᱟᱶ ᱨᱮ ᱥᱳᱯᱳᱨ ᱦᱩᱭᱩᱜ ᱠᱟᱱᱟ?',
  ),
  DictionaryEntry(
    category: 'Where Questions',
    hindi: 'मैनेजर का केबिन कहाँ है?',
    gloss: 'Where is the manager’s cabin?',
    santali: 'ᱢᱚᱱᱮᱡᱟᱨ ᱟᱜ ᱠᱮᱵᱤᱱ ᱫᱚ ᱪᱮᱫ ᱨᱮ ᱢᱮᱱᱟᱜᱼᱟ?',
  ),
  DictionaryEntry(
    category: 'Where Questions',
    hindi: 'मुझे कहाँ जाना चाहिए?',
    gloss: 'Where should I go?',
    santali: 'ᱤᱧ ᱪᱮᱫ ᱥᱮᱫ ᱪᱟᱞᱟᱣ ᱦᱩᱭᱩᱜ ᱛᱟᱢᱟ?',
  ),
  DictionaryEntry(
    category: 'Everyday Conversation',
    hindi: 'क्या यह एक किताब है?',
    gloss: 'Is it a book?',
    santali: 'ᱱᱚᱶᱟ ᱫᱚ ᱪᱮᱫ ᱢᱤᱫᱴᱟᱝ ᱯᱚᱛᱚᱵ ᱠᱟᱱᱟ?',
  ),
  DictionaryEntry(
    category: 'Everyday Conversation',
    hindi: 'हाँ, यह एक किताब है।',
    gloss: 'Yes, it is a book.',
    santali: 'ᱦᱩᱭᱩᱜ ᱠᱟᱱᱟ, ᱱᱚᱶᱟ ᱫᱚ ᱢᱤᱫᱴᱟᱝ ᱯᱚᱛᱚᱵ ᱾',
  ),
  DictionaryEntry(
    category: 'Everyday Conversation',
    hindi: 'क्या यह उत्तर है?',
    gloss: 'Is it the answer?',
    santali: 'ᱱᱚᱶᱟ ᱫᱚ ᱪᱮᱫ ᱩᱛᱛᱚᱨ ᱠᱟᱱᱟ?',
  ),
  DictionaryEntry(
    category: 'Everyday Conversation',
    hindi: 'हाँ, यह उत्तर है।',
    gloss: 'Yes, it is the answer.',
    santali: 'ᱦᱩᱭᱩᱜ ᱠᱟᱱᱟ, ᱱᱚᱶᱟ ᱫᱚ ᱦᱩᱭᱩᱜ ᱠᱟᱱᱟ ᱩᱛᱛᱚᱨ ᱾',
  ),
  DictionaryEntry(
    category: 'Everyday Conversation',
    hindi: 'क्या आप मेरे साथ आएँगे?',
    gloss: 'Will you come with me?',
    santali: 'ᱟᱢ ᱠᱤ ᱤᱧ ᱥᱟᱶ ᱮ ᱦᱮᱡᱚᱜᱼᱟ?',
  ),
  DictionaryEntry(
    category: 'Everyday Conversation',
    hindi: 'हाँ, मैं आपके साथ आऊँगा।',
    gloss: 'Yes, I shall come with you.',
    santali: 'ᱦᱩᱭᱩᱜ ᱠᱟᱱᱟ, ᱤᱧ ᱟᱢ ᱥᱟᱶᱛᱮ ᱦᱮᱡᱚᱜᱼᱟ ᱾',
  ),
  DictionaryEntry(
    category: 'Everyday Conversation',
    hindi: 'क्या आप मुझे अपना पेन देंगे?',
    gloss: 'Will you give me your pen?',
    santali: 'ᱟᱢ ᱠᱤ ᱤᱧ ᱟᱢᱟᱜ ᱯᱮᱱ ᱮᱢ ᱮᱢ ᱮᱫᱟ?',
  ),
  DictionaryEntry(
    category: 'Everyday Conversation',
    hindi: 'हाँ, बिल्कुल।',
    gloss: 'Yes, of course.',
    santali: 'ᱦᱩᱭᱩᱜ ᱠᱟᱱᱟ, ᱜᱚᱴᱟ ᱜᱮ ᱾',
  ),
  DictionaryEntry(
    category: 'Everyday Conversation',
    hindi: 'क्या आप मुझे अपना पेन दे सकते हैं?',
    gloss: 'Can you give me your pen?',
    santali: 'ᱟᱢ ᱠᱤ ᱤᱧ ᱟᱢᱟᱜ ᱯᱮᱱ ᱮᱢ ᱮᱢ ᱫᱟᱲᱮᱭᱟᱜᱼᱟ?',
  ),
  DictionaryEntry(
    category: 'Everyday Conversation',
    hindi: 'क्या आप डिब्बा उठा सकते हैं?',
    gloss: 'Can you lift the box?',
    santali: 'ᱟᱢ ᱠᱤ ᱢᱤᱫᱴᱟᱝ ᱵᱚᱠᱥ ᱦᱟᱛᱟᱣ ᱫᱟᱲᱮᱭᱟᱜᱼᱟᱢ?',
  ),
  DictionaryEntry(
    category: 'Everyday Conversation',
    hindi: 'क्या आप परीक्षा लिख सकते हैं?',
    gloss: 'Can you write the exam?',
    santali: 'ᱟᱢ ᱠᱤ ᱵᱤᱰᱟᱹᱣ ᱚᱞ ᱫᱟᱲᱮᱭᱟᱜᱼᱟᱢ?',
  ),
  DictionaryEntry(
    category: 'Everyday Conversation',
    hindi: 'क्या आपने दोपहर का खाना खाया?',
    gloss: 'Did you have lunch?',
    santali: 'ᱟᱢ ᱠᱤ ᱰᱟᱣᱩᱱᱞᱳᱰ ᱞᱮᱫᱟᱭ?',
  ),
  DictionaryEntry(
    category: 'Everyday Conversation',
    hindi: 'आप कैसे हैं?',
    gloss: 'How are you?',
    santali: 'ᱟᱢ ᱪᱮᱫ ᱞᱮᱠᱟ?',
  ),
  DictionaryEntry(
    category: 'Everyday Conversation',
    hindi: 'मैं ठीक हूँ।',
    gloss: 'I am fine.',
    santali: 'ᱤᱧ ᱱᱟᱯᱟᱭ ᱠᱟᱱᱟ ᱾',
  ),
];
