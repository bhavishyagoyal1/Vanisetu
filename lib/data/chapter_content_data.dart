/// Real per-chapter study content (Worksheet / Flashcards / Assessment) for
/// the curriculum, keyed by "Class {n}|{subject}|{chapter}".
///
/// Two provenances, matching curriculum_data.dart's split:
///
/// - Classes 1-2 Hindi/English/Mathematics: grounded in the actual 2026
///   edition textbook text (docs/*.pdf, Part-1 only), extracted per-chapter
///   and used to author each chapter's worksheet/flashcards/assessment —
///   questions reference real characters, events and vocabulary from that
///   chapter's story/lesson, not generic filler. The PDF text extraction
///   has a font bug (documented where the extraction script lives) that
///   drops some conjunct letters; content authors were told to read past
///   that rather than reproduce typos, but this pass has not been
///   independently re-verified against the source PDFs.
/// - Everything else (classes 3-5, and classes 1-2's own pre-2026
///   Environmental-Studies-less other subjects if any): no source
///   document — only chapter titles exist upstream for these. Authored
///   from general subject/age-level knowledge for each title, kept
///   deliberately short and skill-focused (vocabulary, comprehension,
///   arithmetic practice) rather than inventing specific plot/textbook
///   details this project has no source text for. Chapters referencing
///   real people (e.g. Birsa Munda, Albert Ekka, Mother Teresa, Dhoni) use
///   their real, well-known biographical facts.
///
/// Treat all of it as a best-effort offline study aid, not a
/// native-speaker-verified or publisher-verified textbook transcription.
library;

class Flashcard {
  const Flashcard({required this.term, this.meaning = '', this.imagePath});
  final String term;
  final String meaning;

  /// When set, the flashcard is a pre-illustrated picture card (asset path)
  /// shown as-is instead of the flip-to-reveal term/meaning card.
  final String? imagePath;
}

class AssessmentQuestion {
  const AssessmentQuestion({
    required this.question,
    required this.options,
    required this.correctIndex,
  });
  final String question;
  final List<String> options;
  final int correctIndex;
}

class ChapterContent {
  const ChapterContent({
    required this.worksheet,
    required this.flashcards,
    required this.assessment,
  });

  final List<String> worksheet;
  final List<Flashcard> flashcards;
  final List<AssessmentQuestion> assessment;
}

String chapterContentKey(int classNumber, String subject, String chapter) =>
    'Class $classNumber|$subject|$chapter';

// The actual chapterContentData map lives in chapter_content_map.dart,
// generated from lib/data/chapter_content/class_*.json — kept as a
// separate file since it's ~5000 lines of data, not class definitions.
