/// Curriculum data, two provenances:
///
/// - Classes 3-5 (all subjects) and Classes 1-2's own pre-2026 lists: the
///   Jharkhand School Education Department's abridged syllabus for 2021-22
///   (vani.pdf). Only chapters kept in the "प्रस्तावित संक्षिप्त पाठ्यक्रम"
///   column are included — chapters marked "पूर्णतः विलोपित" / "Not
///   Included" in the source are omitted.
/// - Classes 1-2 Hindi/English/Mathematics: replaced with the JCERT 2026
///   edition textbooks (see docs/*.pdf — "प्रथम संस्करण - अप्रैल 2026"),
///   transcribed from each book's own lesson headings. Those textbooks are
///   themselves only "Part-1" (JCERT splits each year into two parts); the
///   chapter lists here cover Part-1's lessons only — Part-2 isn't
///   available, so each of these three subject lists is an unknown amount
///   short of the full class. The 2021-22 chapter lists these replaced had
///   zero title overlap with the 2026 edition, confirmed chapter-by-chapter
///   before replacing (see PR/commit history), not assumed.
library;

class Subject {
  const Subject({required this.name, required this.chapters});

  final String name;
  final List<String> chapters;
}

class ClassCurriculum {
  const ClassCurriculum({required this.classNumber, required this.subjects});

  final int classNumber;
  final List<Subject> subjects;
}

const List<ClassCurriculum> curriculumData = [
  ClassCurriculum(
    classNumber: 1,
    subjects: [
      Subject(
        name: 'Hindi',
        chapters: [
          'मीरा का परिवार',
          'अम्मा कहाँ है?',
          'तलाश में',
          'नीलू का घर',
          'जब बाँधूँगा उनको राखी',
          'ईद का चाँद',
          'मीठे-मीठे गुलगुले',
          'खुशी का परब-करमा',
          'रूपा और बादल',
        ],
      ),
      Subject(
        name: 'English',
        chapters: [
          'All by Myself',
          'My Toothbrush',
          'I Like to Play',
          'My Home',
          'Gilli-Danda',
          'A Little Bird',
        ],
      ),
      Subject(
        name: 'Mathematics',
        chapters: [
          'मेरे आस पास',
          'मिलते जुलते',
          'एक, दो, तीन....गिनें',
          'बोल भाई कितने',
          'कोई लुढ़के कोई सरके',
          'मईयाँ का छठवाँ जन्मदिन',
          'छठ का दिन',
          'दस में करें झूमर',
        ],
      ),
    ],
  ),
  ClassCurriculum(
    classNumber: 2,
    subjects: [
      Subject(
        name: 'Hindi',
        chapters: [
          'दादा जी का छाता',
          'लालू और पीलू',
          'मैं भी…',
          'मेरी प्यारी दादी माँ',
          'तिल के लड्डू',
          'होली',
          'मेला',
          'उपहार बड़ा दिन का',
          'दोस्त की मदद',
        ],
      ),
      Subject(
        name: 'English',
        chapters: [
          'Somu Goes Fishing',
          'Tara Rum Pum Pum',
          'I Can Help',
          "Nani's Rooftop",
          'School Chale Hum!',
        ],
      ),
      Subject(
        name: 'Mathematics',
        chapters: [
          'रंग-बिरंगी वस्तुएँ',
          'दस का दम',
          'जोड़े-घटाएँ',
          'मौसम',
          'समूह बनाएँ',
        ],
      ),
    ],
  ),
  ClassCurriculum(
    classNumber: 3,
    subjects: [
      Subject(
        name: 'Hindi',
        chapters: [
          'रेलगाड़ी',
          'कंजूस',
          'ओ मेरी मछली तालाब लाजवाब',
          'मेरी टोपी तेरी टोपी',
          'सारस और लोमड़ी',
          'पेड़',
          'टोकरी में क्या है',
          'चंदा मामा कुएँ में, चाँद का सफ़र',
          'मन करता है',
          'एक थी चिड़िया',
          'खूब मज़े हैं मौसम के',
          'मेरा पत्र',
        ],
      ),
      Subject(
        name: 'English',
        chapters: [
          'My Dear One',
          'Hand Washing Day',
          'Old McDonald Had A Farm',
          'Androcles And The Lion',
          'My Teacher',
          'Who Will Mend My Shoe',
          'Games For Fun',
          'Dhoni My Hero',
          'Holi',
          'Karma',
          'Soldiers',
          'Veer Budhu Bhagat',
          'We Are Indians',
          'Our Country',
          'Traffic Light',
        ],
      ),
      Subject(
        name: 'Mathematics',
        chapters: [
          'रेखाओं से बनी आकृतियाँ',
          'मेला का दृश्य',
          'जोड़',
          'घटाव',
          'गुणा',
          'भाग',
          'मुद्रा',
          'मापन',
          'पैटर्न',
        ],
      ),
      Subject(
        name: 'Environmental Studies',
        chapters: [
          'हमारे अपने',
          'हरी भरी दुनिया',
          'देखे अनदेखे जानवर',
          'आओ काम करें हम भैया',
          'चूं चूं करती आई चिड़िया',
          'मेरा खेल',
          'खाना पकाना',
          'पसंद अपनी अपनी',
          'कच्चा पक्का',
          'कैसे कैसे घर',
          'छुक छुक छुक छुक',
          'पानी तेरे कितने नाम',
          'हम बनाएं',
          'बायाँ दायाँ',
        ],
      ),
    ],
  ),
  ClassCurriculum(
    classNumber: 4,
    subjects: [
      Subject(
        name: 'Hindi',
        chapters: [
          'कोयल',
          'बहुभाषी विद्वान',
          'पापा जब बच्चे थे',
          'मुझे मॉनिटर बना दो',
          'दादी की साड़ी',
          'क्यों',
          'सोने के जूते',
          'बादल',
          'स्वतंत्रता की ओर',
          'मुल्ला नसरुद्दीन',
          'बिजूका',
          'चूहे ने काटा माउस को',
        ],
      ),
      Subject(
        name: 'English',
        chapters: [
          'The Stars',
          'Sky and Her Children',
          'Frogs at School',
          'The Clever Fishes',
          'Love for Nation',
          'Pride of India',
          'The Land of Rising Sun',
          'A Trip to Japan',
          'A Wonderful Place',
          'Gulliver and the Lilliputians',
          'Playing in a Lane',
          "Let's Play Carrom-board",
          'Wonderful Flying Machine',
          'Chhau: A Martial Dance',
          'Sarhul: A Festival of Nature',
        ],
      ),
      Subject(
        name: 'Mathematics',
        chapters: [
          'ज्यामितीय आकृतियाँ',
          'संख्याएँ',
          'जोड़',
          'घटाव',
          'गुणा',
          'भाग',
          'भिन्न',
          'मापन',
          'पट्टीकरण, क्षेत्रफल एवं परिमाप',
          'पैटर्न',
        ],
      ),
      Subject(
        name: 'Environmental Studies',
        chapters: [
          'रिश्ते नाते',
          'छोटे कान, बड़े कान',
          'नक्शा',
          'आशा की मित्र मधुमक्खियाँ',
          'यात्रा ऋचा की',
          'पानी के बदलते रूप',
          'घर तब और अब',
          'जंगले के जानवर',
          'तांगा की सवारी',
          'जंतु हमारे मित्र',
          'पौधों की दुनिया',
          'कल कल, छल छल',
          'नोट एवं सिक्के',
          'भोजन कहाँ कहाँ से',
          'आओ खेलें खेल',
          'बनाते जाओ',
          'परमा का खेत',
        ],
      ),
    ],
  ),
  ClassCurriculum(
    classNumber: 5,
    subjects: [
      Subject(
        name: 'Hindi',
        chapters: [
          'हम सब सुमन एक उपवन के',
          'फसलों के त्योहार',
          'ईदगाह',
          'दोहा एकादश',
          'चावल की रोटियाँ',
          'लड़की की चतुराई',
          'चिठ्ठी',
          'दो गौरेयाँ',
          'काबुलीवाला',
          'बिरसा मुंडा # अल्बर्ट एक्का',
          'माँ, कह एक कहानी',
          'प्रकृति मेरी सखी : झारखंड',
        ],
      ),
      Subject(
        name: 'English',
        chapters: [
          'Good Night and Good Morning',
          'The Wooden Bowl',
          'A Blind Child Speaks',
          'Golu Goes to School',
          'My Nation',
          'Republic Day Parade',
          'Save the World',
          'The Bamboo Princess',
          'The Swing',
          'Bravery Award',
          'Science',
          'Our Friend: Computer',
          'Mother Teresa',
          'Sohrai Painting',
          'Newspaper',
        ],
      ),
      Subject(
        name: 'Mathematics',
        chapters: [
          'कोण',
          'संख्याएँ',
          'संक्रियाएँ',
          'गुणज और गुणनखंड',
          'भिन्न',
          'मापन',
          'मुद्रा',
          'पैटर्न',
        ],
      ),
      Subject(
        name: 'Environmental Studies',
        chapters: [
          'कौन किसके जैसा',
          'काम की खोज',
          'बदला बसेरा',
          'ठंडा गरम',
          'ज्ञानिन्द्रियों का कमाल',
          'मुझे ताज़ा खाओ',
          'किसानों की कहानी',
          'स्वाद से शक्ति तक',
          'बीज ही बीज',
          'कैसे कैसे घर',
          'प्रकृति का कहर',
          'पानी ही जीवन',
          'क्या डूबा क्या तैरा',
          'गाँव गाँव क़स्बा क़स्बा',
          'चढ़ाई पहाड़ की',
          'जंगल की बेटी',
        ],
      ),
    ],
  ),
];
