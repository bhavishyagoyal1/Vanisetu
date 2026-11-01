/// Real per-chapter study content (Worksheet / Flashcards / Assessment) for
/// the curriculum, keyed by "Class {n}|{subject}|{chapter}".
///
/// Unlike the chapter *titles* (sourced from the Jharkhand government
/// syllabus PDF), this content has no source document — only chapter
/// titles exist upstream. It was authored from general subject/age-level
/// knowledge for each title, kept deliberately short and skill-focused
/// (vocabulary, comprehension, arithmetic practice) rather than inventing
/// specific plot/textbook details for chapters this project has no source
/// text for. Chapters referencing real people (e.g. Birsa Munda, Albert
/// Ekka, Mother Teresa, Dhoni) use their real, well-known biographical
/// facts. Treat this as a best-effort offline study aid, not a verified
/// textbook transcription.
library;

class Flashcard {
  const Flashcard({required this.term, required this.meaning});
  final String term;
  final String meaning;
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
