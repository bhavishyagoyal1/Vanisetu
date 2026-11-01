import 'chapter_content_data.dart';

const Map<String, ChapterContent> chapterContentData = {
  'Class 1|Hindi|मेरा गाँव': ChapterContent(
    worksheet: [
      'तुम्हारे गाँव में कौन-कौन से पेड़ मिलते हैं? किन्हीं दो के नाम लिखो।',
      'गाँव में कौन-कौन से जानवर पाले जाते हैं? दो नाम लिखो।',
      'तुम्हें अपने गाँव में सबसे अच्छी कौन सी जगह लगती है? क्यों?',
    ],
    flashcards: [
      Flashcard(
        term: 'गाँव',
        meaning: 'छोटी बस्ती जहाँ लोग खेती करके रहते हैं',
      ),
      Flashcard(term: 'खेत', meaning: 'वह जगह जहाँ फसल उगाई जाती है'),
      Flashcard(term: 'कुआँ', meaning: 'पानी निकालने की जगह'),
      Flashcard(term: 'पेड़', meaning: 'बड़ा पौधा जो छाया और फल देता है'),
      Flashcard(term: 'किसान', meaning: 'खेती करने वाला व्यक्ति'),
    ],
    assessment: [
      AssessmentQuestion(
        question: 'फसल कहाँ उगाई जाती है?',
        options: ['घर में', 'खेत में', 'बाज़ार में', 'स्कूल में'],
        correctIndex: 1,
      ),
      AssessmentQuestion(
        question: 'खेती करने वाले व्यक्ति को क्या कहते हैं?',
        options: ['डॉक्टर', 'किसान', 'शिक्षक', 'दर्जी'],
        correctIndex: 1,
      ),
      AssessmentQuestion(
        question: 'गाँव में पानी कहाँ से मिलता था?',
        options: ['कुआँ', 'टीवी', 'मोबाइल', 'किताब'],
        correctIndex: 0,
      ),
    ],
  ),
  'Class 1|Hindi|घो-घो रानी': ChapterContent(
    worksheet: [
      '"घो-घो रानी" एक खेल-गीत है। तुम कौन सा खेल खेलना पसंद करते हो?',
      'इस तरह की कविताओं में शब्द बार-बार क्यों दोहराए जाते हैं?',
      'अपने दोस्तों के साथ खेले जाने वाले किसी एक खेल का नाम लिखो।',
    ],
    flashcards: [
      Flashcard(term: 'रानी', meaning: 'राजा की पत्नी, या खेल में एक पात्र'),
      Flashcard(term: 'घेरा', meaning: 'गोल आकार में बना घूमने का स्थान'),
      Flashcard(term: 'खेल', meaning: 'मनोरंजन के लिए की जाने वाली गतिविधि'),
      Flashcard(term: 'गीत', meaning: 'गाने के लिए बनी रचना'),
      Flashcard(term: 'दोस्त', meaning: 'साथ खेलने वाला साथी'),
    ],
    assessment: [
      AssessmentQuestion(
        question: '"घो-घो रानी" कैसी रचना है?',
        options: ['कहानी', 'खेल-गीत', 'पत्र', 'निबंध'],
        correctIndex: 1,
      ),
      AssessmentQuestion(
        question: 'खेल किसके साथ खेला जाता है?',
        options: ['अकेले', 'दोस्तों के साथ', 'सोकर', 'पढ़कर'],
        correctIndex: 1,
      ),
      AssessmentQuestion(
        question: 'गीत गाने में कैसा महसूस होता है?',
        options: ['उदास', 'आनंद', 'डर', 'गुस्सा'],
        correctIndex: 1,
      ),
    ],
  ),
  'Class 1|Hindi|तीन साथी': ChapterContent(
    worksheet: [
      'तीन साथियों की कहानी में मित्रता के बारे में क्या सीख मिल सकती है?',
      'तुम्हारे तीन सबसे अच्छे दोस्तों के नाम लिखो।',
      'दोस्त एक-दूसरे की मदद कैसे करते हैं? एक उदाहरण लिखो।',
    ],
    flashcards: [
      Flashcard(term: 'साथी', meaning: 'साथ रहने वाला व्यक्ति, दोस्त'),
      Flashcard(term: 'मित्रता', meaning: 'दोस्ती'),
      Flashcard(term: 'मदद', meaning: 'सहायता करना'),
      Flashcard(term: 'साथ', meaning: 'एक-दूसरे के पास, संग'),
      Flashcard(term: 'एकता', meaning: 'मिलकर रहना'),
    ],
    assessment: [
      AssessmentQuestion(
        question: '"तीन साथी" शीर्षक में कितने मित्रों की बात है?',
        options: ['दो', 'तीन', 'चार', 'पाँच'],
        correctIndex: 1,
      ),
      AssessmentQuestion(
        question: 'सच्चे दोस्त एक-दूसरे की क्या करते हैं?',
        options: ['मदद', 'झगड़ा', 'नुकसान', 'अनदेखा'],
        correctIndex: 0,
      ),
      AssessmentQuestion(
        question: 'मित्रता में कौन सी भावना जरूरी है?',
        options: ['गुस्सा', 'प्यार', 'डर', 'ईर्ष्या'],
        correctIndex: 1,
      ),
    ],
  ),
  'Class 1|Hindi|बकरी': ChapterContent(
    worksheet: [
      'बकरी क्या खाती है? दो चीज़ों के नाम लिखो।',
      'बकरी हमें क्या देती है?',
      'बकरी की आवाज़ कैसी होती है? लिखो।',
    ],
    flashcards: [
      Flashcard(term: 'बकरी', meaning: 'एक पालतू जानवर जो दूध देता है'),
      Flashcard(term: 'मिमियाना', meaning: 'बकरी की आवाज़'),
      Flashcard(term: 'सींग', meaning: 'सिर पर उगी नुकीली हड्डी'),
      Flashcard(term: 'दूध', meaning: 'बकरी या गाय से मिलने वाला पेय पदार्थ'),
      Flashcard(term: 'चरना', meaning: 'घास खाना'),
    ],
    assessment: [
      AssessmentQuestion(
        question: 'बकरी क्या देती है?',
        options: ['दूध', 'अंडा', 'शहद', 'ऊन'],
        correctIndex: 0,
      ),
      AssessmentQuestion(
        question: 'बकरी की आवाज़ को क्या कहते हैं?',
        options: ['भौंकना', 'मिमियाना', 'दहाड़ना', 'चहचहाना'],
        correctIndex: 1,
      ),
      AssessmentQuestion(
        question: 'बकरी क्या खाती है?',
        options: ['मांस', 'घास-पत्ती', 'मछली', 'चावल'],
        correctIndex: 1,
      ),
    ],
  ),
  'Class 1|Hindi|पतंग': ChapterContent(
    worksheet: [
      'पतंग किस मौसम में उड़ाई जाती है?',
      'पतंग बनाने में कौन-कौन सी चीज़ें लगती हैं?',
      'तुम्हें पतंग उड़ाना क्यों पसंद है (या नहीं)?',
    ],
    flashcards: [
      Flashcard(term: 'पतंग', meaning: 'कागज़ से बनी उड़ने वाली वस्तु'),
      Flashcard(term: 'डोर', meaning: 'पतंग उड़ाने वाला धागा'),
      Flashcard(term: 'आसमान', meaning: 'आकाश, जहाँ पतंग उड़ती है'),
      Flashcard(term: 'हवा', meaning: 'पतंग को उड़ाने वाली चीज़'),
      Flashcard(term: 'ढील', meaning: 'डोर को धीरे-धीरे छोड़ना'),
    ],
    assessment: [
      AssessmentQuestion(
        question: 'पतंग किससे बनती है?',
        options: ['लोहे से', 'कागज़ से', 'पत्थर से', 'काँच से'],
        correctIndex: 1,
      ),
      AssessmentQuestion(
        question: 'पतंग उड़ाने के लिए किसकी जरूरत होती है?',
        options: ['पानी', 'हवा', 'बर्फ', 'आग'],
        correctIndex: 1,
      ),
      AssessmentQuestion(
        question: 'पतंग उड़ाने के लिए क्या पकड़ते हैं?',
        options: ['डोर', 'पत्ता', 'पंख', 'डंडा'],
        correctIndex: 0,
      ),
    ],
  ),
  'Class 1|Hindi|दो तोते': ChapterContent(
    worksheet: [
      'तोता कैसा दिखता है? रंग बताओ।',
      'तोता क्या बोलना सीख सकता है?',
      'तोते क्या खाना पसंद करते हैं?',
    ],
    flashcards: [
      Flashcard(term: 'तोता', meaning: 'हरे रंग का बोलने वाला पक्षी'),
      Flashcard(term: 'पंख', meaning: 'पक्षी के उड़ने वाले अंग'),
      Flashcard(term: 'चोंच', meaning: 'पक्षी का मुँह'),
      Flashcard(term: 'पिंजरा', meaning: 'पक्षी को रखने के लिए बना घर'),
      Flashcard(term: 'उड़ना', meaning: 'हवा में पंखों से चलना'),
    ],
    assessment: [
      AssessmentQuestion(
        question: 'तोता किस रंग का होता है?',
        options: ['लाल', 'हरा', 'काला', 'सफेद'],
        correctIndex: 1,
      ),
      AssessmentQuestion(
        question: 'तोता क्या कर सकता है?',
        options: ['तैरना', 'बोलना', 'दौड़ना', 'खोदना'],
        correctIndex: 1,
      ),
      AssessmentQuestion(
        question: 'तोता क्या खाना पसंद करता है?',
        options: ['मछली', 'फल', 'मांस', 'पत्थर'],
        correctIndex: 1,
      ),
    ],
  ),
  'Class 1|Hindi|क्या है लम्बा': ChapterContent(
    worksheet: [
      'अपने घर में मिलने वाली लंबी चीज़ों के दो नाम लिखो।',
      'साँप और चींटी में कौन सी चीज़ लंबी होती है और कौन सी छोटी?',
      'रेलगाड़ी और साइकिल में कौन ज़्यादा लंबी होती है?',
    ],
    flashcards: [
      Flashcard(term: 'लम्बा', meaning: 'जो नाप में बड़ा हो'),
      Flashcard(term: 'छोटा', meaning: 'जो नाप में कम हो'),
      Flashcard(term: 'ऊँचा', meaning: 'जो ऊपर तक जाए'),
      Flashcard(term: 'नापना', meaning: 'किसी चीज़ की लंबाई जानना'),
      Flashcard(term: 'तुलना', meaning: 'दो चीज़ों को मिलाकर देखना'),
    ],
    assessment: [
      AssessmentQuestion(
        question: 'इनमें से कौन सी चीज़ सबसे लंबी होती है?',
        options: ['पेंसिल', 'रेलगाड़ी', 'चम्मच', 'चाबी'],
        correctIndex: 1,
      ),
      AssessmentQuestion(
        question: 'साँप और चींटी में कौन लंबा होता है?',
        options: ['चींटी', 'साँप', 'दोनों बराबर', 'पता नहीं'],
        correctIndex: 1,
      ),
      AssessmentQuestion(
        question: 'किसी चीज़ की लंबाई जानने के लिए क्या करते हैं?',
        options: ['रंग देखते हैं', 'नापते हैं', 'सूँघते हैं', 'चखते हैं'],
        correctIndex: 1,
      ),
    ],
  ),
  'Class 1|Hindi|बिल्ली और चूहा': ChapterContent(
    worksheet: [
      'बिल्ली और चूहे की आवाज़ें कैसी होती हैं?',
      'बिल्ली को कौन सा खाना पसंद है?',
      'चूहा बिल्ली से बचने के लिए क्या करता है?',
    ],
    flashcards: [
      Flashcard(term: 'बिल्ली', meaning: 'म्याऊँ बोलने वाला पालतू जानवर'),
      Flashcard(term: 'चूहा', meaning: 'छोटा जानवर जो बिल में रहता है'),
      Flashcard(term: 'बिल', meaning: 'चूहे के रहने की जगह'),
      Flashcard(term: 'म्याऊँ', meaning: 'बिल्ली की आवाज़'),
      Flashcard(term: 'पीछा करना', meaning: 'दौड़कर पकड़ने की कोशिश करना'),
    ],
    assessment: [
      AssessmentQuestion(
        question: 'बिल्ली की आवाज़ क्या है?',
        options: ['भौं-भौं', 'म्याऊँ', 'चूँ-चूँ', 'काँव-काँव'],
        correctIndex: 1,
      ),
      AssessmentQuestion(
        question: 'चूहा कहाँ छिपता है?',
        options: ['पेड़ पर', 'बिल में', 'पानी में', 'आसमान में'],
        correctIndex: 1,
      ),
      AssessmentQuestion(
        question: 'बिल्ली चूहे के पीछे क्यों भागती है?',
        options: [
          'खेलने के लिए',
          'पकड़ने के लिए',
          'सुलाने के लिए',
          'पढ़ाने के लिए',
        ],
        correctIndex: 1,
      ),
    ],
  ),
  'Class 1|Hindi|गाजर और टमाटर': ChapterContent(
    worksheet: [
      'गाजर किस रंग की होती है और टमाटर किस रंग का?',
      'गाजर पौधे के ज़मीन के अंदर उगती है या ऊपर?',
      'तुम्हें कौन सी सब्ज़ी सबसे ज़्यादा पसंद है?',
    ],
    flashcards: [
      Flashcard(term: 'गाजर', meaning: 'नारंगी रंग की जड़ वाली सब्ज़ी'),
      Flashcard(term: 'टमाटर', meaning: 'लाल रंग की गोल सब्ज़ी'),
      Flashcard(term: 'सब्ज़ी', meaning: 'खाने योग्य पौधों का भाग'),
      Flashcard(term: 'जड़', meaning: 'पौधे का ज़मीन के नीचे वाला भाग'),
      Flashcard(term: 'स्वाद', meaning: 'खाने का चखा हुआ अनुभव'),
    ],
    assessment: [
      AssessmentQuestion(
        question: 'गाजर किस रंग की होती है?',
        options: ['नारंगी', 'नीला', 'काला', 'बैंगनी'],
        correctIndex: 0,
      ),
      AssessmentQuestion(
        question: 'टमाटर किस रंग का होता है?',
        options: ['हरा', 'लाल', 'पीला', 'सफेद'],
        correctIndex: 1,
      ),
      AssessmentQuestion(
        question: 'गाजर पौधे का कौन सा भाग है?',
        options: ['पत्ती', 'जड़', 'फूल', 'तना'],
        correctIndex: 1,
      ),
    ],
  ),
  'Class 1|Hindi|भोला और भालू': ChapterContent(
    worksheet: [
      'भालू कैसा दिखता है? बताओ।',
      'अगर तुम भोला की जगह होते तो भालू को देखकर क्या करते?',
      'जंगल में और कौन-कौन से जानवर रहते हैं?',
    ],
    flashcards: [
      Flashcard(
        term: 'भालू',
        meaning: 'बड़े शरीर और घने बालों वाला जंगली जानवर',
      ),
      Flashcard(term: 'जंगल', meaning: 'पेड़ों से भरा बड़ा स्थान'),
      Flashcard(term: 'डर', meaning: 'खतरे से होने वाली भावना'),
      Flashcard(term: 'हिम्मत', meaning: 'बिना डरे कुछ करने की शक्ति'),
      Flashcard(term: 'गुफा', meaning: 'भालू के रहने की जगह'),
    ],
    assessment: [
      AssessmentQuestion(
        question: 'भालू कहाँ रहता है?',
        options: ['पानी में', 'जंगल में', 'समुद्र में', 'घर में'],
        correctIndex: 1,
      ),
      AssessmentQuestion(
        question: 'भालू के शरीर पर क्या होता है?',
        options: ['पंख', 'घने बाल', 'शल्क', 'कुछ नहीं'],
        correctIndex: 1,
      ),
      AssessmentQuestion(
        question: 'खतरे में हिम्मत रखना कैसा गुण है?',
        options: ['बुरा', 'अच्छा', 'बेकार', 'गलत'],
        correctIndex: 1,
      ),
    ],
  ),
  'Class 1|Hindi|पहेली': ChapterContent(
    worksheet: [
      'एक पहेली सोचो और लिखो, जैसे "गोल है, लाल है, खाने में मीठा है - मैं क्या हूँ?"',
      'पहेली बूझने में क्या मज़ा आता है?',
      'अपनी पसंदीदा पहेली और उसका उत्तर लिखो।',
    ],
    flashcards: [
      Flashcard(term: 'पहेली', meaning: 'सोचकर उत्तर निकालने वाला सवाल'),
      Flashcard(term: 'उत्तर', meaning: 'पहेली का सही जवाब'),
      Flashcard(term: 'अनुमान', meaning: 'सोचकर अंदाज़ा लगाना'),
      Flashcard(term: 'सुराग', meaning: 'पहेली में छिपा संकेत'),
      Flashcard(term: 'मज़ेदार', meaning: 'आनंद देने वाला'),
    ],
    assessment: [
      AssessmentQuestion(
        question: 'पहेली क्या होती है?',
        options: ['कहानी', 'सोचने वाला सवाल', 'गाना', 'चित्र'],
        correctIndex: 1,
      ),
      AssessmentQuestion(
        question: 'पहेली बूझने के लिए क्या करना पड़ता है?',
        options: ['सोना', 'सोचना', 'दौड़ना', 'रोना'],
        correctIndex: 1,
      ),
      AssessmentQuestion(
        question: 'पहेली में छिपे संकेत को क्या कहते हैं?',
        options: ['सुराग', 'रंग', 'आवाज़', 'कपड़ा'],
        correctIndex: 0,
      ),
    ],
  ),
  'Class 1|Hindi|हाय रे दैया': ChapterContent(
    worksheet: [
      '"हाय रे दैया" कब बोलते हैं - खुशी में या हैरानी में?',
      'कोई ऐसी बात लिखो जिसे सुनकर तुम "हाय रे दैया" बोलोगे।',
      'इस तरह के भाव प्रकट करने वाले शब्दों को क्या कहते हैं?',
    ],
    flashcards: [
      Flashcard(term: 'हैरानी', meaning: 'अचानक चौंकने की भावना'),
      Flashcard(
        term: 'विस्मयादिबोधक',
        meaning: 'अचानक भाव प्रकट करने वाला शब्द',
      ),
      Flashcard(
        term: 'दैया',
        meaning: 'आश्चर्य प्रकट करने के लिए बोला जाने वाला शब्द',
      ),
      Flashcard(term: 'चौंकना', meaning: 'अचानक हैरान होना'),
      Flashcard(term: 'भाव', meaning: 'मन की भावना या जज्बा'),
    ],
    assessment: [
      AssessmentQuestion(
        question: '"हाय रे दैया" किस भावना को दिखाता है?',
        options: ['गुस्सा', 'हैरानी', 'नींद', 'भूख'],
        correctIndex: 1,
      ),
      AssessmentQuestion(
        question: 'इस प्रकार के भाव-सूचक शब्दों को क्या कहते हैं?',
        options: ['संज्ञा', 'विस्मयादिबोधक', 'क्रिया', 'सर्वनाम'],
        correctIndex: 1,
      ),
      AssessmentQuestion(
        question: 'अचानक हैरान होने पर हम क्या करते हैं?',
        options: ['सो जाते हैं', 'चौंक जाते हैं', 'खाना खाते हैं', 'कूदते हैं'],
        correctIndex: 1,
      ),
    ],
  ),
  'Class 1|Hindi|नाव चली': ChapterContent(
    worksheet: [
      'नाव पानी में कैसे चलती है?',
      'नाव में कौन-कौन बैठ सकता है?',
      'तुमने कभी नाव देखी है? कहाँ?',
    ],
    flashcards: [
      Flashcard(term: 'नाव', meaning: 'पानी में चलने वाला वाहन'),
      Flashcard(term: 'नदी', meaning: 'बहता हुआ पानी'),
      Flashcard(term: 'खेवैया', meaning: 'नाव चलाने वाला व्यक्ति'),
      Flashcard(term: 'चप्पू', meaning: 'नाव चलाने का साधन'),
      Flashcard(term: 'पानी', meaning: 'नदी या तालाब में भरा तरल पदार्थ'),
    ],
    assessment: [
      AssessmentQuestion(
        question: 'नाव कहाँ चलती है?',
        options: ['सड़क पर', 'पानी में', 'आसमान में', 'रेल पटरी पर'],
        correctIndex: 1,
      ),
      AssessmentQuestion(
        question: 'नाव चलाने वाले को क्या कहते हैं?',
        options: ['ड्राइवर', 'खेवैया', 'पायलट', 'किसान'],
        correctIndex: 1,
      ),
      AssessmentQuestion(
        question: 'नाव चलाने के लिए किसका उपयोग होता है?',
        options: ['पहिया', 'चप्पू', 'पंख', 'केवल इंजन'],
        correctIndex: 1,
      ),
    ],
  ),
  'Class 1|English|I Know': ChapterContent(
    worksheet: [
      'Name three things you know how to do.',
      'Write one new thing you learned today.',
      'What is something new you want to learn?',
    ],
    flashcards: [
      Flashcard(
        term: 'know',
        meaning: 'to understand or be sure about something',
      ),
      Flashcard(term: 'learn', meaning: 'to gain new knowledge or skill'),
      Flashcard(term: 'new', meaning: 'not seen or done before'),
      Flashcard(term: 'skill', meaning: 'the ability to do something well'),
      Flashcard(term: 'try', meaning: 'to make an attempt'),
    ],
    assessment: [
      AssessmentQuestion(
        question: 'What does \'know\' mean?',
        options: ['To forget', 'To understand', 'To sleep', 'To run'],
        correctIndex: 1,
      ),
      AssessmentQuestion(
        question: 'Which word means \'to gain new knowledge\'?',
        options: ['Learn', 'Lose', 'Break', 'Jump'],
        correctIndex: 0,
      ),
      AssessmentQuestion(
        question: 'Something you have not seen before is called:',
        options: ['Old', 'New', 'Big', 'Small'],
        correctIndex: 1,
      ),
    ],
  ),
  'Class 1|English|Myself': ChapterContent(
    worksheet: [
      'Write your name and age.',
      'Name two parts of your body.',
      'What do you like to do best?',
    ],
    flashcards: [
      Flashcard(term: 'name', meaning: 'what a person is called'),
      Flashcard(term: 'age', meaning: 'how old someone is'),
      Flashcard(term: 'body', meaning: 'the whole physical form of a person'),
      Flashcard(term: 'like', meaning: 'to enjoy something'),
      Flashcard(term: 'myself', meaning: 'referring to one\'s own self'),
    ],
    assessment: [
      AssessmentQuestion(
        question: 'What tells us how old you are?',
        options: ['Name', 'Age', 'Colour', 'Size'],
        correctIndex: 1,
      ),
      AssessmentQuestion(
        question: 'Which of these is a part of your body?',
        options: ['Hand', 'Chair', 'Book', 'Table'],
        correctIndex: 0,
      ),
      AssessmentQuestion(
        question: 'The word \'myself\' refers to:',
        options: ['Another person', 'You', 'An animal', 'A place'],
        correctIndex: 1,
      ),
    ],
  ),
  'Class 1|English|My Daily Routine': ChapterContent(
    worksheet: [
      'What is the first thing you do after waking up?',
      'Name one thing you do before going to school.',
      'What do you do before going to bed at night?',
    ],
    flashcards: [
      Flashcard(term: 'morning', meaning: 'the early part of the day'),
      Flashcard(
        term: 'routine',
        meaning: 'things done regularly in the same order',
      ),
      Flashcard(term: 'brush', meaning: 'to clean your teeth'),
      Flashcard(term: 'bedtime', meaning: 'the time to go to sleep'),
      Flashcard(term: 'wake up', meaning: 'to stop sleeping'),
    ],
    assessment: [
      AssessmentQuestion(
        question: 'What do we do in the morning first?',
        options: ['Sleep', 'Wake up', 'Dream', 'Fly'],
        correctIndex: 1,
      ),
      AssessmentQuestion(
        question: 'What do we use to clean our teeth?',
        options: ['Comb', 'Brush', 'Spoon', 'Pencil'],
        correctIndex: 1,
      ),
      AssessmentQuestion(
        question: '\'Routine\' means things we do:',
        options: ['Once a year', 'Every day', 'Never', 'Only in summer'],
        correctIndex: 1,
      ),
    ],
  ),
  'Class 1|English|My Friend': ChapterContent(
    worksheet: [
      'Write the name of your best friend.',
      'What games do you play with your friend?',
      'Why is it good to have friends?',
    ],
    flashcards: [
      Flashcard(
        term: 'friend',
        meaning: 'a person you like and enjoy being with',
      ),
      Flashcard(
        term: 'share',
        meaning: 'to give a part of something to another',
      ),
      Flashcard(term: 'play', meaning: 'to have fun doing an activity'),
      Flashcard(term: 'help', meaning: 'to assist someone'),
      Flashcard(term: 'kind', meaning: 'gentle and caring'),
    ],
    assessment: [
      AssessmentQuestion(
        question: 'A friend is someone you:',
        options: ['Fight with', 'Like and play with', 'Ignore', 'Fear'],
        correctIndex: 1,
      ),
      AssessmentQuestion(
        question: 'Good friends should:',
        options: ['Fight', 'Share and help', 'Hide', 'Shout'],
        correctIndex: 1,
      ),
      AssessmentQuestion(
        question: 'Being kind means being:',
        options: ['Rude', 'Gentle and caring', 'Angry', 'Lazy'],
        correctIndex: 1,
      ),
    ],
  ),
  'Class 1|English|My Food': ChapterContent(
    worksheet: [
      'Name two foods you eat every day.',
      'Which food do you like the most?',
      'Why is it important to eat healthy food?',
    ],
    flashcards: [
      Flashcard(term: 'food', meaning: 'what we eat to stay alive'),
      Flashcard(term: 'healthy', meaning: 'good for the body'),
      Flashcard(
        term: 'fruit',
        meaning: 'a sweet food that grows on plants or trees',
      ),
      Flashcard(
        term: 'vegetable',
        meaning: 'a plant food like carrot or potato',
      ),
      Flashcard(
        term: 'meal',
        meaning: 'food eaten at a set time, like breakfast',
      ),
    ],
    assessment: [
      AssessmentQuestion(
        question: 'What do we eat to stay healthy?',
        options: ['Stones', 'Food', 'Toys', 'Books'],
        correctIndex: 1,
      ),
      AssessmentQuestion(
        question: 'Which of these is a fruit?',
        options: ['Potato', 'Mango', 'Chair', 'Spoon'],
        correctIndex: 1,
      ),
      AssessmentQuestion(
        question: 'Eating healthy food keeps us:',
        options: ['Sick', 'Strong', 'Sleepy', 'Sad'],
        correctIndex: 1,
      ),
    ],
  ),
  'Class 1|English|My House': ChapterContent(
    worksheet: [
      'Name two rooms in your house.',
      'What do you like most about your house?',
      'Describe the roof of your house.',
    ],
    flashcards: [
      Flashcard(term: 'house', meaning: 'a place where a family lives'),
      Flashcard(term: 'room', meaning: 'a part of a house'),
      Flashcard(term: 'roof', meaning: 'the top covering of a house'),
      Flashcard(term: 'door', meaning: 'an opening to enter or leave a room'),
      Flashcard(term: 'window', meaning: 'an opening for light and air'),
    ],
    assessment: [
      AssessmentQuestion(
        question: 'A house is a place where a:',
        options: ['Car lives', 'Family lives', 'Bird flies', 'Fish swims'],
        correctIndex: 1,
      ),
      AssessmentQuestion(
        question: 'What is at the top of a house?',
        options: ['Floor', 'Roof', 'Window', 'Door'],
        correctIndex: 1,
      ),
      AssessmentQuestion(
        question: 'We enter a room through a:',
        options: ['Window', 'Roof', 'Door', 'Wall'],
        correctIndex: 2,
      ),
    ],
  ),
  'Class 1|English|My Village Market': ChapterContent(
    worksheet: [
      'Name two things sold in a village market.',
      'Who sells vegetables in the market?',
      'Why do people go to the market?',
    ],
    flashcards: [
      Flashcard(
        term: 'market',
        meaning: 'a place where goods are bought and sold',
      ),
      Flashcard(term: 'seller', meaning: 'a person who sells things'),
      Flashcard(term: 'buyer', meaning: 'a person who buys things'),
      Flashcard(term: 'vegetable', meaning: 'a plant food sold in the market'),
      Flashcard(
        term: 'price',
        meaning: 'the amount of money paid for something',
      ),
    ],
    assessment: [
      AssessmentQuestion(
        question: 'A market is a place to:',
        options: ['Sleep', 'Buy and sell things', 'Study', 'Swim'],
        correctIndex: 1,
      ),
      AssessmentQuestion(
        question: 'A person who sells things is called a:',
        options: ['Buyer', 'Seller', 'Teacher', 'Doctor'],
        correctIndex: 1,
      ),
      AssessmentQuestion(
        question: 'What do we pay to buy something?',
        options: ['Price', 'Song', 'Story', 'Game'],
        correctIndex: 0,
      ),
    ],
  ),
  'Class 1|English|My School': ChapterContent(
    worksheet: [
      'Name one thing you like about your school.',
      'Who teaches you at school?',
      'What do you carry to school every day?',
    ],
    flashcards: [
      Flashcard(term: 'school', meaning: 'a place where children learn'),
      Flashcard(term: 'teacher', meaning: 'a person who teaches'),
      Flashcard(term: 'classroom', meaning: 'a room where students study'),
      Flashcard(term: 'bag', meaning: 'used to carry books to school'),
      Flashcard(term: 'learn', meaning: 'to gain knowledge'),
    ],
    assessment: [
      AssessmentQuestion(
        question: 'A school is a place to:',
        options: ['Sleep', 'Learn', 'Cook', 'Play only'],
        correctIndex: 1,
      ),
      AssessmentQuestion(
        question: 'Who teaches students at school?',
        options: ['Doctor', 'Teacher', 'Driver', 'Farmer'],
        correctIndex: 1,
      ),
      AssessmentQuestion(
        question: 'What do children carry books in?',
        options: ['Bag', 'Plate', 'Bucket', 'Bottle'],
        correctIndex: 0,
      ),
    ],
  ),
  'Class 1|English|My Village': ChapterContent(
    worksheet: [
      'Name two things you see in a village.',
      'What work do people do in a village?',
      'Why do you like your village?',
    ],
    flashcards: [
      Flashcard(
        term: 'village',
        meaning: 'a small place where people live, often with farms',
      ),
      Flashcard(term: 'farmer', meaning: 'a person who grows crops'),
      Flashcard(term: 'field', meaning: 'land where crops are grown'),
      Flashcard(term: 'pond', meaning: 'a small area of water'),
      Flashcard(term: 'neighbour', meaning: 'a person living nearby'),
    ],
    assessment: [
      AssessmentQuestion(
        question: 'A village mostly has:',
        options: [
          'Tall buildings',
          'Fields and farms',
          'Big airports',
          'Malls',
        ],
        correctIndex: 1,
      ),
      AssessmentQuestion(
        question: 'Who grows crops in a village?',
        options: ['Farmer', 'Doctor', 'Pilot', 'Singer'],
        correctIndex: 0,
      ),
      AssessmentQuestion(
        question: 'Crops are grown in a:',
        options: ['Field', 'River', 'Sky', 'Pond'],
        correctIndex: 0,
      ),
    ],
  ),
  'Class 1|English|My Family': ChapterContent(
    worksheet: [
      'Name the members of your family.',
      'Who is the oldest person in your family?',
      'What do you do together with your family?',
    ],
    flashcards: [
      Flashcard(
        term: 'family',
        meaning: 'people related to each other living together',
      ),
      Flashcard(term: 'mother', meaning: 'a female parent'),
      Flashcard(term: 'father', meaning: 'a male parent'),
      Flashcard(term: 'sibling', meaning: 'a brother or sister'),
      Flashcard(
        term: 'grandparent',
        meaning: 'parent of your mother or father',
      ),
    ],
    assessment: [
      AssessmentQuestion(
        question: 'A family is made up of:',
        options: ['Strangers', 'Related people', 'Animals only', 'Trees'],
        correctIndex: 1,
      ),
      AssessmentQuestion(
        question: 'Who is a female parent called?',
        options: ['Father', 'Mother', 'Sister', 'Teacher'],
        correctIndex: 1,
      ),
      AssessmentQuestion(
        question: 'A brother or sister is called a:',
        options: ['Sibling', 'Neighbour', 'Teacher', 'Friend only'],
        correctIndex: 0,
      ),
    ],
  ),
  'Class 1|English|My Classroom': ChapterContent(
    worksheet: [
      'Name two things found in your classroom.',
      'Where do you sit in the classroom?',
      'What do you use to write in class?',
    ],
    flashcards: [
      Flashcard(term: 'classroom', meaning: 'a room where students learn'),
      Flashcard(
        term: 'blackboard',
        meaning: 'a board used by teachers to write on',
      ),
      Flashcard(term: 'desk', meaning: 'a table used for studying'),
      Flashcard(term: 'chalk', meaning: 'used to write on a blackboard'),
      Flashcard(term: 'notebook', meaning: 'a book for writing notes'),
    ],
    assessment: [
      AssessmentQuestion(
        question: 'Where do students study?',
        options: ['Kitchen', 'Classroom', 'Garden', 'Market'],
        correctIndex: 1,
      ),
      AssessmentQuestion(
        question: 'What is used to write on a blackboard?',
        options: ['Chalk', 'Water', 'Spoon', 'Leaf'],
        correctIndex: 0,
      ),
      AssessmentQuestion(
        question: 'Students sit on a:',
        options: ['Desk', 'Roof', 'Tree', 'Cloud'],
        correctIndex: 0,
      ),
    ],
  ),
  'Class 1|English|Now I Know': ChapterContent(
    worksheet: [
      'Write two new things you have learned this year.',
      'What was your favourite lesson? Why?',
      'What do you want to learn next?',
    ],
    flashcards: [
      Flashcard(term: 'know', meaning: 'to understand something clearly'),
      Flashcard(term: 'review', meaning: 'to look back and remember'),
      Flashcard(term: 'favourite', meaning: 'liked the most'),
      Flashcard(term: 'remember', meaning: 'to keep something in mind'),
      Flashcard(
        term: 'practice',
        meaning: 'doing something again and again to get better',
      ),
    ],
    assessment: [
      AssessmentQuestion(
        question: '\'Now I Know\' means you have:',
        options: [
          'Forgotten things',
          'Learned things',
          'Lost things',
          'Broken things',
        ],
        correctIndex: 1,
      ),
      AssessmentQuestion(
        question: 'Looking back at what you learned is called:',
        options: ['Review', 'Sleep', 'Play', 'Run'],
        correctIndex: 0,
      ),
      AssessmentQuestion(
        question: 'Doing something again and again to improve is called:',
        options: ['Practice', 'Waste', 'Fear', 'Noise'],
        correctIndex: 0,
      ),
    ],
  ),
  'Class 1|Mathematics|आकृति और स्थान': ChapterContent(
    worksheet: [
      'अपने आस-पास मिलने वाली गोल आकृति की दो चीज़ों के नाम लिखो।',
      'वर्ग (चौकोर) आकार की एक चीज़ का नाम लिखो।',
      'एक त्रिभुज (तीन कोनों वाली आकृति) बनाओ।',
    ],
    flashcards: [
      Flashcard(term: 'वृत्त', meaning: 'गोल आकृति'),
      Flashcard(term: 'वर्ग', meaning: 'चार बराबर भुजाओं वाली आकृति'),
      Flashcard(term: 'त्रिभुज', meaning: 'तीन भुजाओं वाली आकृति'),
      Flashcard(term: 'आयत', meaning: 'चार भुजाओं वाली लंबी आकृति'),
      Flashcard(term: 'आकृति', meaning: 'किसी वस्तु का रूप या आकार'),
    ],
    assessment: [
      AssessmentQuestion(
        question: 'गेंद किस आकृति की होती है?',
        options: ['वर्ग', 'वृत्त', 'त्रिभुज', 'आयत'],
        correctIndex: 1,
      ),
      AssessmentQuestion(
        question: 'त्रिभुज में कितनी भुजाएँ होती हैं?',
        options: ['दो', 'तीन', 'चार', 'पाँच'],
        correctIndex: 1,
      ),
      AssessmentQuestion(
        question: 'खिड़की सामान्यतः किस आकृति की होती है?',
        options: ['वृत्त', 'त्रिभुज', 'आयत', 'तारा'],
        correctIndex: 2,
      ),
    ],
  ),
  'Class 1|Mathematics|संख्याएँ (1-9)': ChapterContent(
    worksheet: [
      '1 से 9 तक की संख्याएँ क्रम में लिखो।',
      'अपने कमरे में 3 चीज़ें गिनकर लिखो कि उनकी संख्या क्या है।',
      '5 के बाद कौन सी संख्या आती है?',
    ],
    flashcards: [
      Flashcard(term: 'संख्या', meaning: 'गिनती बताने वाला अंक'),
      Flashcard(term: 'एक', meaning: 'संख्या 1'),
      Flashcard(term: 'गिनती', meaning: 'वस्तुओं को गिनने की क्रिया'),
      Flashcard(term: 'क्रम', meaning: 'संख्याओं का सही सिलसिला'),
      Flashcard(term: 'अंक', meaning: 'संख्या लिखने का चिन्ह'),
    ],
    assessment: [
      AssessmentQuestion(
        question: '1 के बाद कौन सी संख्या आती है?',
        options: ['3', '2', '5', '0'],
        correctIndex: 1,
      ),
      AssessmentQuestion(
        question: 'इनमें सबसे बड़ी संख्या कौन सी है?',
        options: ['4', '9', '2', '6'],
        correctIndex: 1,
      ),
      AssessmentQuestion(
        question: 'पाँच सेबों की गिनती करने पर कुल कितने सेब हैं?',
        options: ['4', '5', '6', '3'],
        correctIndex: 1,
      ),
    ],
  ),
  'Class 1|Mathematics|जोड़': ChapterContent(
    worksheet: [
      '2 + 3 = ?',
      '4 + 4 = ?',
      '5 + 1 = ?',
      'अगर तुम्हारे पास 3 गेंदें हैं और दोस्त तुम्हें 2 और दे, तो कुल कितनी गेंदें होंगी?',
    ],
    flashcards: [
      Flashcard(term: 'जोड़', meaning: 'दो या दो से अधिक संख्याओं को मिलाना'),
      Flashcard(term: 'योग', meaning: 'जोड़ का उत्तर'),
      Flashcard(term: 'प्लस', meaning: 'जोड़ का चिन्ह (+)'),
      Flashcard(term: 'कुल', meaning: 'सब मिलाकर बनी संख्या'),
      Flashcard(term: 'मिलाना', meaning: 'साथ रखना'),
    ],
    assessment: [
      AssessmentQuestion(
        question: '3 + 2 = ?',
        options: ['4', '5', '6', '7'],
        correctIndex: 1,
      ),
      AssessmentQuestion(
        question: '4 + 4 = ?',
        options: ['6', '7', '8', '9'],
        correctIndex: 2,
      ),
      AssessmentQuestion(
        question: 'जोड़ का चिन्ह कौन सा है?',
        options: ['-', '+', 'x', '÷'],
        correctIndex: 1,
      ),
    ],
  ),
  'Class 1|Mathematics|घटाव': ChapterContent(
    worksheet: [
      '5 - 2 = ?',
      '8 - 3 = ?',
      '6 - 6 = ?',
      'अगर तुम्हारे पास 7 चॉकलेट थीं और तुमने 4 खा लीं, तो कितनी बची?',
    ],
    flashcards: [
      Flashcard(term: 'घटाव', meaning: 'किसी संख्या में से कुछ कम करना'),
      Flashcard(term: 'शेष', meaning: 'घटाने के बाद बची संख्या'),
      Flashcard(term: 'माइनस', meaning: 'घटाव का चिन्ह (-)'),
      Flashcard(term: 'कम करना', meaning: 'संख्या को घटाना'),
      Flashcard(term: 'बचना', meaning: 'शेष रह जाना'),
    ],
    assessment: [
      AssessmentQuestion(
        question: '5 - 2 = ?',
        options: ['2', '3', '4', '5'],
        correctIndex: 1,
      ),
      AssessmentQuestion(
        question: '8 - 3 = ?',
        options: ['4', '5', '6', '7'],
        correctIndex: 1,
      ),
      AssessmentQuestion(
        question: 'घटाव का चिन्ह कौन सा है?',
        options: ['+', '-', 'x', '='],
        correctIndex: 1,
      ),
    ],
  ),
  'Class 1|Mathematics|संख्याएँ (10 to 20)': ChapterContent(
    worksheet: [
      '10 से 20 तक की संख्याएँ क्रम में लिखो।',
      '15 के बाद कौन सी संख्या आती है?',
      '12 और 18 में कौन सी संख्या बड़ी है?',
    ],
    flashcards: [
      Flashcard(term: 'दस', meaning: 'संख्या 10'),
      Flashcard(term: 'बीस', meaning: 'संख्या 20'),
      Flashcard(term: 'पंद्रह', meaning: 'संख्या 15'),
      Flashcard(term: 'बड़ी संख्या', meaning: 'जो गिनती में अधिक हो'),
      Flashcard(term: 'छोटी संख्या', meaning: 'जो गिनती में कम हो'),
    ],
    assessment: [
      AssessmentQuestion(
        question: '10 के बाद कौन सी संख्या आती है?',
        options: ['9', '11', '20', '12'],
        correctIndex: 1,
      ),
      AssessmentQuestion(
        question: '20 से पहले कौन सी संख्या आती है?',
        options: ['18', '19', '21', '17'],
        correctIndex: 1,
      ),
      AssessmentQuestion(
        question: '14 और 19 में बड़ी संख्या कौन सी है?',
        options: ['14', '19', 'दोनों बराबर', 'कोई नहीं'],
        correctIndex: 1,
      ),
    ],
  ),
  'Class 1|Mathematics|समय': ChapterContent(
    worksheet: [
      'सुबह हम किस समय स्कूल जाते हैं?',
      'घड़ी में कितनी सुइयाँ होती हैं?',
      'रात को हम क्या करते हैं - सोते हैं या खेलते हैं?',
    ],
    flashcards: [
      Flashcard(term: 'घड़ी', meaning: 'समय बताने वाला यंत्र'),
      Flashcard(term: 'घंटा', meaning: 'समय की एक इकाई'),
      Flashcard(term: 'सुबह', meaning: 'दिन का पहला भाग'),
      Flashcard(term: 'रात', meaning: 'दिन का अंधेरा भाग'),
      Flashcard(term: 'समय', meaning: 'घटनाओं के होने की अवधि'),
    ],
    assessment: [
      AssessmentQuestion(
        question: 'समय बताने के लिए किसका उपयोग करते हैं?',
        options: ['घड़ी', 'किताब', 'चम्मच', 'बैग'],
        correctIndex: 0,
      ),
      AssessmentQuestion(
        question: 'दिन के पहले भाग को क्या कहते हैं?',
        options: ['रात', 'सुबह', 'शाम', 'दोपहर'],
        correctIndex: 1,
      ),
      AssessmentQuestion(
        question: 'हम रात में क्या करते हैं?',
        options: ['सोते हैं', 'स्कूल जाते हैं', 'खेत जोतते हैं', 'तैरते हैं'],
        correctIndex: 0,
      ),
    ],
  ),
  'Class 1|Mathematics|मापन': ChapterContent(
    worksheet: [
      'अपने घर में एक लंबी और एक छोटी वस्तु का नाम लिखो।',
      'कौन सी चीज़ भारी होती है - पत्थर या गुब्बारा?',
      'अपनी पेंसिल की लंबाई अपनी उंगली से नापो।',
    ],
    flashcards: [
      Flashcard(term: 'लंबाई', meaning: 'किसी वस्तु का माप जो लंबा-छोटा बताए'),
      Flashcard(term: 'वज़न', meaning: 'किसी वस्तु का भारीपन'),
      Flashcard(term: 'भारी', meaning: 'जिसका वज़न अधिक हो'),
      Flashcard(term: 'हल्का', meaning: 'जिसका वज़न कम हो'),
      Flashcard(term: 'नापना', meaning: 'लंबाई या वज़न को मापना'),
    ],
    assessment: [
      AssessmentQuestion(
        question: 'पत्थर और गुब्बारे में भारी कौन है?',
        options: ['गुब्बारा', 'पत्थर', 'दोनों बराबर', 'कोई नहीं'],
        correctIndex: 1,
      ),
      AssessmentQuestion(
        question: 'लंबाई नापने के लिए क्या उपयोग होता है?',
        options: ['स्केल', 'चम्मच', 'कटोरी', 'घड़ी'],
        correctIndex: 0,
      ),
      AssessmentQuestion(
        question: 'जिसका वज़न कम हो, वह कहलाता है:',
        options: ['भारी', 'हल्का', 'लंबा', 'छोटा'],
        correctIndex: 1,
      ),
    ],
  ),
  'Class 1|Mathematics|संख्याएँ (21 to 50)': ChapterContent(
    worksheet: [
      '21 से 30 तक की संख्याएँ लिखो।',
      '35 के बाद कौन सी संख्या आती है?',
      '28 और 42 में कौन सी संख्या बड़ी है?',
    ],
    flashcards: [
      Flashcard(term: 'इक्कीस', meaning: 'संख्या 21'),
      Flashcard(term: 'पचास', meaning: 'संख्या 50'),
      Flashcard(term: 'तीस', meaning: 'संख्या 30'),
      Flashcard(term: 'चालीस', meaning: 'संख्या 40'),
      Flashcard(term: 'दहाई', meaning: 'दस-दस के समूह में संख्या गिनना'),
    ],
    assessment: [
      AssessmentQuestion(
        question: '30 के बाद कौन सी संख्या आती है?',
        options: ['29', '31', '40', '21'],
        correctIndex: 1,
      ),
      AssessmentQuestion(
        question: '50 से पहले कौन सी संख्या आती है?',
        options: ['48', '49', '51', '45'],
        correctIndex: 1,
      ),
      AssessmentQuestion(
        question: '25 और 45 में बड़ी संख्या कौन सी है?',
        options: ['25', '45', 'दोनों बराबर', 'कोई नहीं'],
        correctIndex: 1,
      ),
    ],
  ),
  'Class 2|Hindi|मेरा विद्यालय': ChapterContent(
    worksheet: [
      'अपने विद्यालय का नाम लिखिए।',
      'आपके विद्यालय में कौन-कौन सी चीज़ें हैं? किन्हीं तीन का नाम लिखिए।',
      'आपको विद्यालय क्यों अच्छा लगता है? एक वाक्य में लिखिए।',
      '"विद्यालय" शब्द से एक वाक्य बनाइए।',
    ],
    flashcards: [
      Flashcard(term: 'विद्यालय', meaning: 'पढ़ने-लिखने की जगह, स्कूल'),
      Flashcard(term: 'अध्यापक', meaning: 'पढ़ाने वाला व्यक्ति'),
      Flashcard(term: 'कक्षा', meaning: 'विद्यार्थियों के पढ़ने का कमरा'),
      Flashcard(term: 'मित्र', meaning: 'दोस्त, साथी'),
      Flashcard(term: 'पुस्तक', meaning: 'किताब, ज्ञान का स्रोत'),
    ],
    assessment: [
      AssessmentQuestion(
        question: 'हम कहाँ पढ़ने जाते हैं?',
        options: ['बाज़ार', 'विद्यालय', 'खेत', 'नदी'],
        correctIndex: 1,
      ),
      AssessmentQuestion(
        question: '"अध्यापक" कौन होता है?',
        options: ['दुकानदार', 'किसान', 'पढ़ाने वाला', 'डाक्टर'],
        correctIndex: 2,
      ),
      AssessmentQuestion(
        question: 'विद्यार्थी विद्यालय में क्या करते हैं?',
        options: [
          'खेलते ही रहते हैं',
          'पढ़ते-लिखते हैं',
          'सोते हैं',
          'खाना बनाते हैं',
        ],
        correctIndex: 1,
      ),
      AssessmentQuestion(
        question: 'कक्षा में कौन बैठते हैं?',
        options: ['पशु', 'विद्यार्थी', 'पक्षी', 'मछली'],
        correctIndex: 1,
      ),
    ],
  ),
  'Class 2|Hindi|आई एक खबर': ChapterContent(
    worksheet: [
      '"खबर" शब्द का अर्थ अपने शब्दों में लिखिए।',
      'आपने घर में कोई अच्छी खबर सुनी हो तो एक वाक्य में लिखिए।',
      'खबर सुनकर हमें कैसा महसूस होता है? एक शब्द में लिखिए।',
      '"खबर" शब्द से एक वाक्य बनाइए।',
    ],
    flashcards: [
      Flashcard(term: 'खबर', meaning: 'समाचार, सूचना'),
      Flashcard(term: 'संदेश', meaning: 'किसी बात की सूचना'),
      Flashcard(term: 'खुशी', meaning: 'प्रसन्नता'),
      Flashcard(term: 'हैरानी', meaning: 'आश्चर्य'),
      Flashcard(term: 'जल्दी', meaning: 'शीघ्रता'),
    ],
    assessment: [
      AssessmentQuestion(
        question: '"खबर" का मतलब है?',
        options: ['खाना', 'समाचार', 'खेल', 'पानी'],
        correctIndex: 1,
      ),
      AssessmentQuestion(
        question: 'अच्छी खबर सुनकर हमें कैसा लगता है?',
        options: ['दुख', 'खुशी', 'गुस्सा', 'डर'],
        correctIndex: 1,
      ),
      AssessmentQuestion(
        question: 'खबर हमें कौन दे सकता है?',
        options: ['पेड़', 'पत्थर', 'व्यक्ति', 'कुर्सी'],
        correctIndex: 2,
      ),
      AssessmentQuestion(
        question: '"समाचार" का दूसरा शब्द है?',
        options: ['खबर', 'खेल', 'किताब', 'पानी'],
        correctIndex: 0,
      ),
    ],
  ),
  'Class 2|Hindi|मैं भी': ChapterContent(
    worksheet: [
      '"मैं भी" शीर्षक किस बारे में हो सकता है, अपने शब्दों में बताइए।',
      'आप भी क्या करना चाहते हैं जो बड़े करते हैं? एक वाक्य लिखिए।',
      '"मैं भी पढ़ूँगा" जैसा एक वाक्य स्वयं बनाइए।',
      'अपने बारे में तीन बातें लिखिए जो आप कर सकते हैं।',
    ],
    flashcards: [
      Flashcard(term: 'इच्छा', meaning: 'चाहत, कामना'),
      Flashcard(term: 'बराबर', meaning: 'समान'),
      Flashcard(term: 'कोशिश', meaning: 'प्रयत्न'),
      Flashcard(term: 'साहस', meaning: 'हिम्मत'),
      Flashcard(term: 'सहभागिता', meaning: 'साथ मिलकर भाग लेना'),
    ],
    assessment: [
      AssessmentQuestion(
        question: '"मैं भी" वाक्य में "भी" शब्द क्या दर्शाता है?',
        options: ['मना करना', 'शामिल होना', 'डरना', 'रोना'],
        correctIndex: 1,
      ),
      AssessmentQuestion(
        question: 'जब हम कुछ नया करना चाहते हैं तो हमें क्या दिखाना चाहिए?',
        options: ['डर', 'साहस', 'गुस्सा', 'आलस्य'],
        correctIndex: 1,
      ),
      AssessmentQuestion(
        question: '"इच्छा" शब्द का अर्थ है?',
        options: ['डर', 'चाहत', 'थकान', 'नींद'],
        correctIndex: 1,
      ),
      AssessmentQuestion(
        question: 'बड़ों की तरह काम करने की कोशिश करना कैसा गुण है?',
        options: ['बुरा', 'अच्छा', 'गलत', 'खतरनाक'],
        correctIndex: 1,
      ),
    ],
  ),
  'Class 2|Hindi|किसी से कहना मत': ChapterContent(
    worksheet: [
      '"राज़" शब्द का अर्थ अपने शब्दों में लिखिए।',
      'क्या हमें हर बात राज़ रखनी चाहिए? अपने विचार लिखिए।',
      '"किसी से कहना मत" इस वाक्य को अपने शब्दों में समझाइए।',
      'एक वाक्य बनाइए जिसमें "राज़" शब्द का प्रयोग हो।',
    ],
    flashcards: [
      Flashcard(term: 'राज़', meaning: 'गुप्त बात, भेद'),
      Flashcard(term: 'गुप्त', meaning: 'छिपी हुई'),
      Flashcard(term: 'भरोसा', meaning: 'विश्वास'),
      Flashcard(term: 'सच', meaning: 'सत्य'),
      Flashcard(term: 'चुप', meaning: 'खामोश'),
    ],
    assessment: [
      AssessmentQuestion(
        question: '"राज़" का अर्थ है?',
        options: ['खेल', 'गुप्त बात', 'खाना', 'गीत'],
        correctIndex: 1,
      ),
      AssessmentQuestion(
        question: '"गुप्त" शब्द का विपरीत क्या है?',
        options: ['प्रकट', 'छिपा', 'अंधेरा', 'शांत'],
        correctIndex: 0,
      ),
      AssessmentQuestion(
        question: 'दोस्तों के बीच क्या होना चाहिए?',
        options: ['झगड़ा', 'भरोसा', 'डर', 'चोरी'],
        correctIndex: 1,
      ),
      AssessmentQuestion(
        question: '"चुप" शब्द का अर्थ है?',
        options: ['शोर करना', 'खामोश रहना', 'दौड़ना', 'गाना'],
        correctIndex: 1,
      ),
    ],
  ),
  'Class 2|Hindi|रसोई में भगदड़': ChapterContent(
    worksheet: [
      'रसोई में कौन-कौन सी चीज़ें रखी होती हैं? किन्हीं चार का नाम लिखिए।',
      '"भगदड़" शब्द का अर्थ अपने शब्दों में लिखिए।',
      'रसोई में भगदड़ क्यों मच सकती है? एक कारण लिखिए।',
      'रसोई से जुड़ा एक वाक्य बनाइए।',
    ],
    flashcards: [
      Flashcard(term: 'रसोई', meaning: 'खाना बनाने की जगह'),
      Flashcard(term: 'भगदड़', meaning: 'अफरा-तफरी, हड़बड़ी'),
      Flashcard(term: 'बर्तन', meaning: 'खाना पकाने-खाने के सामान'),
      Flashcard(term: 'चूल्हा', meaning: 'खाना पकाने का साधन'),
      Flashcard(term: 'मसाला', meaning: 'स्वाद बढ़ाने वाली चीज़'),
    ],
    assessment: [
      AssessmentQuestion(
        question: '"रसोई" किसे कहते हैं?',
        options: [
          'सोने का कमरा',
          'खाना बनाने की जगह',
          'खेल का मैदान',
          'पढ़ने का कमरा',
        ],
        correctIndex: 1,
      ),
      AssessmentQuestion(
        question: '"भगदड़" का अर्थ है?',
        options: ['शांति', 'अफरा-तफरी', 'नींद', 'खुशी'],
        correctIndex: 1,
      ),
      AssessmentQuestion(
        question: 'रसोई में खाना किस पर पकाया जाता है?',
        options: ['चूल्हे पर', 'पलंग पर', 'मेज़ पर', 'कुर्सी पर'],
        correctIndex: 0,
      ),
      AssessmentQuestion(
        question: 'भोजन में स्वाद बढ़ाने के लिए क्या डाला जाता है?',
        options: ['पानी', 'मसाला', 'मिट्टी', 'रेत'],
        correctIndex: 1,
      ),
    ],
  ),
  'Class 2|Hindi|नटखट बंदर': ChapterContent(
    worksheet: [
      'बंदर कैसा जानवर होता है? दो गुण लिखिए।',
      '"नटखट" शब्द का अर्थ अपने शब्दों में लिखिए।',
      'बंदर को खाने में क्या पसंद है?',
      'बंदर से जुड़ी एक कहानी में क्या हो सकता है, अपने शब्दों में लिखिए।',
    ],
    flashcards: [
      Flashcard(term: 'नटखट', meaning: 'शरारती'),
      Flashcard(term: 'बंदर', meaning: 'एक चंचल जानवर जो पेड़ों पर रहता है'),
      Flashcard(term: 'शरारत', meaning: 'नटखटपन, उपद्रव'),
      Flashcard(term: 'पेड़', meaning: 'वृक्ष'),
      Flashcard(term: 'उछल-कूद', meaning: 'कूदना-फांदना'),
    ],
    assessment: [
      AssessmentQuestion(
        question: '"नटखट" का अर्थ है?',
        options: ['शांत', 'शरारती', 'उदास', 'बीमार'],
        correctIndex: 1,
      ),
      AssessmentQuestion(
        question: 'बंदर आमतौर पर कहाँ रहना पसंद करता है?',
        options: ['पानी में', 'पेड़ों पर', 'बर्फ में', 'रेगिस्तान में'],
        correctIndex: 1,
      ),
      AssessmentQuestion(
        question: 'बंदर को कौन सा फल बहुत पसंद है?',
        options: ['केला', 'मिर्च', 'प्याज', 'करेला'],
        correctIndex: 0,
      ),
      AssessmentQuestion(
        question: '"उछल-कूद" का अर्थ है?',
        options: ['सोना', 'कूदना-फांदना', 'खाना', 'रोना'],
        correctIndex: 1,
      ),
    ],
  ),
  'Class 2|Hindi|मैडम जी': ChapterContent(
    worksheet: [
      '"मैडम जी" किसे कहा जाता है?',
      'अपनी अध्यापिका के बारे में एक वाक्य लिखिए।',
      'अध्यापिका का हमें आदर क्यों करना चाहिए?',
      'अध्यापिका से जुड़ा एक वाक्य बनाइए।',
    ],
    flashcards: [
      Flashcard(
        term: 'मैडम',
        meaning: 'महिला अध्यापिका के लिए सम्मानसूचक शब्द',
      ),
      Flashcard(term: 'आदर', meaning: 'सम्मान'),
      Flashcard(term: 'अनुशासन', meaning: 'नियमों का पालन'),
      Flashcard(term: 'शिक्षा', meaning: 'ज्ञान'),
      Flashcard(term: 'विनम्रता', meaning: 'नम्र व्यवहार'),
    ],
    assessment: [
      AssessmentQuestion(
        question: '"मैडम जी" शब्द किसके लिए प्रयोग होता है?',
        options: ['दुकानदार', 'महिला अध्यापिका', 'डाक्टर', 'किसान'],
        correctIndex: 1,
      ),
      AssessmentQuestion(
        question: 'अध्यापिका के प्रति हमें कैसा व्यवहार रखना चाहिए?',
        options: ['असम्मान', 'आदर', 'गुस्सा', 'झगड़ा'],
        correctIndex: 1,
      ),
      AssessmentQuestion(
        question: '"अनुशासन" का अर्थ है?',
        options: ['नियमों का पालन', 'खेल', 'झगड़ा', 'नींद'],
        correctIndex: 0,
      ),
      AssessmentQuestion(
        question: 'विद्यालय में हमें क्या सीखने को मिलता है?',
        options: ['शिक्षा', 'सिर्फ खेल', 'सिर्फ नींद', 'कुछ नहीं'],
        correctIndex: 0,
      ),
    ],
  ),
  'Class 2|Hindi|गुब्बारा': ChapterContent(
    worksheet: [
      'गुब्बारा किस चीज़ से भरा होता है?',
      'गुब्बारे किन-किन रंगों के होते हैं? तीन रंगों के नाम लिखिए।',
      'हम गुब्बारे कब उड़ाते या खरीदते हैं?',
      '"गुब्बारा" शब्द से एक वाक्य बनाइए।',
    ],
    flashcards: [
      Flashcard(term: 'गुब्बारा', meaning: 'हवा से भरा रबर का खिलौना'),
      Flashcard(term: 'हवा', meaning: 'वायु'),
      Flashcard(term: 'रंग-बिरंगा', meaning: 'कई रंगों वाला'),
      Flashcard(term: 'त्योहार', meaning: 'उत्सव'),
      Flashcard(term: 'उड़ना', meaning: 'हवा में जाना'),
    ],
    assessment: [
      AssessmentQuestion(
        question: 'गुब्बारे में क्या भरा होता है?',
        options: ['पानी', 'हवा', 'रेत', 'दूध'],
        correctIndex: 1,
      ),
      AssessmentQuestion(
        question: 'गुब्बारा किस चीज़ का बना होता है?',
        options: ['लकड़ी', 'रबर', 'लोहा', 'कागज़'],
        correctIndex: 1,
      ),
      AssessmentQuestion(
        question: 'हम गुब्बारे किस अवसर पर सजाते हैं?',
        options: ['जन्मदिन', 'परीक्षा', 'सोते समय', 'बीमारी में'],
        correctIndex: 0,
      ),
      AssessmentQuestion(
        question: '"रंग-बिरंगा" का अर्थ है?',
        options: ['एक रंग वाला', 'कई रंगों वाला', 'रंगहीन', 'काला'],
        correctIndex: 1,
      ),
    ],
  ),
  'Class 2|Hindi|सरहुल': ChapterContent(
    worksheet: [
      'सरहुल पर्व कब मनाया जाता है?',
      'सरहुल में किस पेड़ की पूजा की जाती है?',
      'सरहुल पर्व में पूजा कौन कराता है?',
      'सरहुल पर्व झारखंड में क्यों खास है, एक वाक्य में लिखिए।',
    ],
    flashcards: [
      Flashcard(term: 'सरहुल', meaning: 'झारखंड का प्रसिद्ध आदिवासी पर्व'),
      Flashcard(term: 'साल वृक्ष', meaning: 'सरहुल में पूजा जाने वाला पेड़'),
      Flashcard(term: 'पाहन', meaning: 'पूजा कराने वाला पुजारी'),
      Flashcard(term: 'प्रकृति', meaning: 'कुदरत'),
      Flashcard(term: 'नृत्य', meaning: 'नाच'),
    ],
    assessment: [
      AssessmentQuestion(
        question: 'सरहुल पर्व किस पेड़ से जुड़ा है?',
        options: ['आम', 'साल', 'नीम', 'पीपल'],
        correctIndex: 1,
      ),
      AssessmentQuestion(
        question: 'सरहुल पर्व मुख्यतः कहाँ मनाया जाता है?',
        options: ['झारखंड', 'केरल', 'पंजाब', 'गुजरात'],
        correctIndex: 0,
      ),
      AssessmentQuestion(
        question: 'सरहुल पूजा कौन कराता है?',
        options: ['डाक्टर', 'पाहन (पुजारी)', 'शिक्षक', 'किसान'],
        correctIndex: 1,
      ),
      AssessmentQuestion(
        question: 'सरहुल पर्व किस ऋतु में मनाया जाता है?',
        options: ['सर्दी', 'वसंत', 'वर्षा', 'पतझड़'],
        correctIndex: 1,
      ),
    ],
  ),
  'Class 2|Hindi|ऊँट और सियार': ChapterContent(
    worksheet: [
      'ऊँट कैसा जानवर होता है? दो विशेषताएँ लिखिए।',
      'सियार कैसा जानवर होता है? एक विशेषता लिखिए।',
      'जानवरों की कहानियों से हमें क्या सीख मिलती है, अपने विचार लिखिए।',
      '"ऊँट" और "सियार" शब्दों से एक-एक वाक्य बनाइए।',
    ],
    flashcards: [
      Flashcard(
        term: 'ऊँट',
        meaning: 'रेगिस्तान में रहने वाला लंबी गर्दन का जानवर',
      ),
      Flashcard(
        term: 'सियार',
        meaning: 'चालाक जंगली जानवर, कुत्ते जैसा दिखने वाला',
      ),
      Flashcard(term: 'चालाक', meaning: 'होशियार, चतुर'),
      Flashcard(term: 'मित्रता', meaning: 'दोस्ती'),
      Flashcard(term: 'रेगिस्तान', meaning: 'सूखा, रेतीला क्षेत्र'),
    ],
    assessment: [
      AssessmentQuestion(
        question: 'ऊँट किस स्थान पर अधिक पाया जाता है?',
        options: ['बर्फीले क्षेत्र', 'रेगिस्तान', 'समुद्र', 'पहाड़ की चोटी'],
        correctIndex: 1,
      ),
      AssessmentQuestion(
        question: 'सियार को किस गुण के लिए जाना जाता है?',
        options: ['आलस्य', 'चालाकी', 'कमजोरी', 'उदासी'],
        correctIndex: 1,
      ),
      AssessmentQuestion(
        question: 'जानवरों की कहानियाँ हमें क्या सिखाती हैं?',
        options: ['अच्छी सीख', 'डरना', 'झूठ बोलना', 'आलस्य'],
        correctIndex: 0,
      ),
      AssessmentQuestion(
        question: '"चालाक" शब्द का अर्थ है?',
        options: ['कमजोर', 'होशियार', 'उदास', 'बीमार'],
        correctIndex: 1,
      ),
    ],
  ),
  'Class 2|Hindi|हाँ जी, ना जी': ChapterContent(
    worksheet: [
      '"हाँ जी" और "ना जी" कब कहा जाता है, अपने शब्दों में लिखिए।',
      'बड़ों से बात करते समय हमें कैसे शब्दों का प्रयोग करना चाहिए?',
      'विनम्रता से बात करने के दो तरीके लिखिए।',
      '"हाँ जी" और "ना जी" का प्रयोग करते हुए एक-एक वाक्य बनाइए।',
    ],
    flashcards: [
      Flashcard(term: 'हाँ', meaning: 'स्वीकृति दिखाने वाला शब्द'),
      Flashcard(term: 'ना', meaning: 'अस्वीकृति दिखाने वाला शब्द'),
      Flashcard(term: 'विनम्रता', meaning: 'नम्र व्यवहार'),
      Flashcard(term: 'सम्मान', meaning: 'आदर'),
      Flashcard(term: 'उत्तर', meaning: 'जवाब'),
    ],
    assessment: [
      AssessmentQuestion(
        question: 'जब हम किसी बात से सहमत होते हैं तो क्या कहते हैं?',
        options: ['ना जी', 'हाँ जी', 'चुप', 'शोर'],
        correctIndex: 1,
      ),
      AssessmentQuestion(
        question: 'बड़ों से बात करते समय कैसा व्यवहार होना चाहिए?',
        options: ['असभ्य', 'विनम्र', 'गुस्सैल', 'उदासीन'],
        correctIndex: 1,
      ),
      AssessmentQuestion(
        question: '"विनम्रता" का अर्थ है?',
        options: ['गुस्सा', 'नम्र व्यवहार', 'झूठ', 'आलस्य'],
        correctIndex: 1,
      ),
      AssessmentQuestion(
        question: 'जब हम किसी बात से असहमत होते हैं तो क्या कहते हैं?',
        options: ['हाँ जी', 'ना जी', 'शाबाश', 'धन्यवाद'],
        correctIndex: 1,
      ),
    ],
  ),
  'Class 2|Hindi|बूझिए मेरा नाम': ChapterContent(
    worksheet: [
      'पहेली किसे कहते हैं, अपने शब्दों में लिखिए।',
      'एक सरल पहेली स्वयं बनाइए।',
      'पहेलियाँ बूझने से हमें क्या फायदा होता है?',
      'अपने किसी पसंदीदा जानवर या वस्तु की एक पहेली लिखिए।',
    ],
    flashcards: [
      Flashcard(term: 'पहेली', meaning: 'बूझने वाला सवाल'),
      Flashcard(term: 'अनुमान', meaning: 'अंदाज़ा'),
      Flashcard(term: 'बुद्धि', meaning: 'समझ, सोचने की शक्ति'),
      Flashcard(term: 'उत्तर', meaning: 'जवाब'),
      Flashcard(term: 'चतुराई', meaning: 'होशियारी'),
    ],
    assessment: [
      AssessmentQuestion(
        question: '"पहेली" किसे कहते हैं?',
        options: ['कहानी', 'बूझने वाला सवाल', 'गीत', 'चित्र'],
        correctIndex: 1,
      ),
      AssessmentQuestion(
        question: 'पहेलियाँ हल करने से क्या बढ़ता है?',
        options: ['बुद्धि', 'आलस्य', 'डर', 'नींद'],
        correctIndex: 0,
      ),
      AssessmentQuestion(
        question: '"अनुमान" का अर्थ है?',
        options: ['निश्चित उत्तर', 'अंदाज़ा लगाना', 'भूल जाना', 'रोना'],
        correctIndex: 1,
      ),
      AssessmentQuestion(
        question: 'पहेली का सही जवाब देने के लिए क्या ज़रूरी है?',
        options: ['सोचना', 'सोना', 'भागना', 'रोना'],
        correctIndex: 0,
      ),
    ],
  ),
  'Class 2|Hindi|बब्बू और झब्बू': ChapterContent(
    worksheet: [
      'बब्बू और झब्बू के नाम सुनकर आपको क्या लगता है ये कौन हो सकते हैं?',
      'दोस्ती में कौन-कौन सी अच्छी बातें होती हैं? दो लिखिए।',
      '"बब्बू और झब्बू" जैसे तुकांत नामों का एक जोड़ा और बनाइए।',
      'अपने सबसे अच्छे दोस्त के बारे में एक वाक्य लिखिए।',
    ],
    flashcards: [
      Flashcard(term: 'दोस्ती', meaning: 'मित्रता'),
      Flashcard(term: 'साथी', meaning: 'संगी'),
      Flashcard(term: 'तुकांत', meaning: 'एक जैसी ध्वनि वाले शब्द'),
      Flashcard(term: 'मस्ती', meaning: 'खुशी भरा खेल'),
      Flashcard(term: 'सहयोग', meaning: 'मिलकर काम करना'),
    ],
    assessment: [
      AssessmentQuestion(
        question: '"दोस्ती" का अर्थ है?',
        options: ['झगड़ा', 'मित्रता', 'डर', 'उदासी'],
        correctIndex: 1,
      ),
      AssessmentQuestion(
        question: 'अच्छे दोस्त एक-दूसरे की क्या करते हैं?',
        options: ['मदद', 'बुराई', 'नकल', 'अनदेखी'],
        correctIndex: 0,
      ),
      AssessmentQuestion(
        question: '"तुकांत शब्द" किसे कहते हैं?',
        options: [
          'विपरीत शब्द',
          'एक जैसी ध्वनि वाले शब्द',
          'कठिन शब्द',
          'अंग्रेज़ी शब्द',
        ],
        correctIndex: 1,
      ),
      AssessmentQuestion(
        question: '"सहयोग" का अर्थ है?',
        options: ['मिलकर काम करना', 'अकेले रहना', 'झगड़ना', 'सोना'],
        correctIndex: 0,
      ),
    ],
  ),
  'Class 2|Hindi|भोर भई': ChapterContent(
    worksheet: [
      '"भोर" शब्द का अर्थ क्या है?',
      'सुबह उठकर आप सबसे पहले क्या करते हैं?',
      'सुबह के समय प्रकृति में क्या-क्या दिखाई देता है? दो चीज़ें लिखिए।',
      '"भोर" शब्द से एक वाक्य बनाइए।',
    ],
    flashcards: [
      Flashcard(term: 'भोर', meaning: 'सुबह, प्रातःकाल'),
      Flashcard(term: 'सूर्योदय', meaning: 'सूरज का निकलना'),
      Flashcard(term: 'पक्षी', meaning: 'चिड़िया'),
      Flashcard(term: 'ताज़गी', meaning: 'स्फूर्ति, ताज़ा एहसास'),
      Flashcard(term: 'प्रातःकाल', meaning: 'सुबह का समय'),
    ],
    assessment: [
      AssessmentQuestion(
        question: '"भोर" का अर्थ है?',
        options: ['रात', 'सुबह', 'दोपहर', 'शाम'],
        correctIndex: 1,
      ),
      AssessmentQuestion(
        question: 'सुबह सबसे पहले आकाश में क्या दिखाई देता है?',
        options: ['चाँद', 'सूरज', 'तारे', 'बादल'],
        correctIndex: 1,
      ),
      AssessmentQuestion(
        question: 'सुबह के समय पक्षी क्या करते हैं?',
        options: ['सोते हैं', 'चहचहाते हैं', 'रोते हैं', 'छिपते हैं'],
        correctIndex: 1,
      ),
      AssessmentQuestion(
        question: '"प्रातःकाल" किस समय को कहते हैं?',
        options: ['सुबह', 'रात', 'दोपहर', 'शाम'],
        correctIndex: 0,
      ),
    ],
  ),
  'Class 2|Hindi|पंचू और चटनी': ChapterContent(
    worksheet: [
      '"चटनी" किन-किन चीज़ों से बनाई जाती है? दो चीज़ें लिखिए।',
      'आपको कौन सी चटनी सबसे ज़्यादा पसंद है?',
      '"पंचू" नाम सुनकर आपको क्या लगता है यह कौन हो सकता है?',
      'भोजन से जुड़ा एक वाक्य बनाइए जिसमें "चटनी" शब्द हो।',
    ],
    flashcards: [
      Flashcard(term: 'चटनी', meaning: 'तीखा-खट्टा स्वाद वाला भोजन का साथी'),
      Flashcard(term: 'स्वाद', meaning: 'जायका'),
      Flashcard(term: 'खट्टा', meaning: 'नींबू जैसा स्वाद'),
      Flashcard(term: 'तीखा', meaning: 'मिर्च जैसा तेज़ स्वाद'),
      Flashcard(term: 'भोजन', meaning: 'खाना'),
    ],
    assessment: [
      AssessmentQuestion(
        question: 'चटनी किसके साथ खाई जाती है?',
        options: ['भोजन', 'कपड़े', 'किताब', 'खिलौने'],
        correctIndex: 0,
      ),
      AssessmentQuestion(
        question: '"खट्टा" स्वाद किसमें पाया जाता है?',
        options: ['आम (पका)', 'नींबू', 'गन्ना', 'शहद'],
        correctIndex: 1,
      ),
      AssessmentQuestion(
        question: '"तीखा" स्वाद किसमें होता है?',
        options: ['मिर्च', 'चीनी', 'दूध', 'पानी'],
        correctIndex: 0,
      ),
      AssessmentQuestion(
        question: '"स्वाद" का दूसरा शब्द है?',
        options: ['जायका', 'रंग', 'आकार', 'वज़न'],
        correctIndex: 0,
      ),
    ],
  ),
  'Class 2|English|I Know': ChapterContent(
    worksheet: [
      'Write three things you know how to do.',
      'Complete: I know how to ____.',
      'Name one thing you learned recently.',
      'Write a sentence starting with \'I know\'.',
    ],
    flashcards: [
      Flashcard(
        term: 'know',
        meaning: 'to understand or have information about something',
      ),
      Flashcard(term: 'learn', meaning: 'to gain knowledge or skill'),
      Flashcard(term: 'skill', meaning: 'the ability to do something well'),
      Flashcard(
        term: 'practice',
        meaning: 'doing something again and again to improve',
      ),
      Flashcard(
        term: 'understand',
        meaning: 'to know the meaning of something',
      ),
    ],
    assessment: [
      AssessmentQuestion(
        question: 'What does \'I know\' mean?',
        options: [
          'I am sleeping',
          'I understand',
          'I am eating',
          'I am running',
        ],
        correctIndex: 1,
      ),
      AssessmentQuestion(
        question: 'Which word means \'to gain knowledge\'?',
        options: ['learn', 'sleep', 'eat', 'run'],
        correctIndex: 0,
      ),
      AssessmentQuestion(
        question: '\'Skill\' means:',
        options: [
          'ability to do something well',
          'a type of food',
          'a color',
          'a place',
        ],
        correctIndex: 0,
      ),
      AssessmentQuestion(
        question: 'Choose the correct sentence:',
        options: [
          'I knows how to swim',
          'I know how to swim',
          'I knowing swim',
          'Knows I swim',
        ],
        correctIndex: 1,
      ),
    ],
  ),
  'Class 2|English|Myself': ChapterContent(
    worksheet: [
      'Write your name and age.',
      'Write two things about your family.',
      'Write one thing you like about yourself.',
      'Complete: My name is ____ and I am ____ years old.',
    ],
    flashcards: [
      Flashcard(term: 'myself', meaning: 'referring to one\'s own person'),
      Flashcard(term: 'name', meaning: 'what a person is called'),
      Flashcard(term: 'age', meaning: 'how old a person is'),
      Flashcard(term: 'family', meaning: 'parents, siblings, and relatives'),
      Flashcard(term: 'like', meaning: 'to enjoy something'),
    ],
    assessment: [
      AssessmentQuestion(
        question: 'Which word describes yourself?',
        options: ['myself', 'himself', 'herself', 'itself'],
        correctIndex: 0,
      ),
      AssessmentQuestion(
        question: '\'Age\' means:',
        options: [
          'a person\'s name',
          'how old someone is',
          'a place',
          'a color',
        ],
        correctIndex: 1,
      ),
      AssessmentQuestion(
        question: 'Who is part of your family?',
        options: ['mother', 'teacher', 'shopkeeper', 'doctor'],
        correctIndex: 0,
      ),
      AssessmentQuestion(
        question: 'Complete: My name ___ Rani.',
        options: ['is', 'am', 'are', 'be'],
        correctIndex: 0,
      ),
    ],
  ),
  'Class 2|English|Daily Routine': ChapterContent(
    worksheet: [
      'Write what you do in the morning.',
      'Write what you do before going to school.',
      'Write one thing you do at night before sleeping.',
      'Complete: I brush my teeth in the ____.',
    ],
    flashcards: [
      Flashcard(term: 'routine', meaning: 'things done regularly every day'),
      Flashcard(term: 'morning', meaning: 'the early part of the day'),
      Flashcard(term: 'brush', meaning: 'to clean teeth with a toothbrush'),
      Flashcard(term: 'bath', meaning: 'washing the body with water'),
      Flashcard(term: 'sleep', meaning: 'to rest at night'),
    ],
    assessment: [
      AssessmentQuestion(
        question: '\'Routine\' means:',
        options: [
          'things done once',
          'things done every day',
          'a game',
          'a food item',
        ],
        correctIndex: 1,
      ),
      AssessmentQuestion(
        question: 'What do we do first in the morning?',
        options: ['sleep', 'wake up', 'go to school', 'have dinner'],
        correctIndex: 1,
      ),
      AssessmentQuestion(
        question: 'We brush our teeth with a:',
        options: ['spoon', 'toothbrush', 'comb', 'plate'],
        correctIndex: 1,
      ),
      AssessmentQuestion(
        question: 'Choose the correct word: I take a ____ every morning.',
        options: ['bath', 'chair', 'book', 'shoe'],
        correctIndex: 0,
      ),
    ],
  ),
  'Class 2|English|Family': ChapterContent(
    worksheet: [
      'Name the members of your family.',
      'Write who is the oldest person in your family.',
      'Write one thing your family does together.',
      'Complete: My mother\'s name is ____.',
    ],
    flashcards: [
      Flashcard(
        term: 'family',
        meaning:
            'a group of people related to each other, like parents and children',
      ),
      Flashcard(term: 'mother', meaning: 'a female parent'),
      Flashcard(term: 'father', meaning: 'a male parent'),
      Flashcard(term: 'sibling', meaning: 'a brother or sister'),
      Flashcard(
        term: 'grandparent',
        meaning: 'the parent of one\'s mother or father',
      ),
    ],
    assessment: [
      AssessmentQuestion(
        question: 'Who is a female parent?',
        options: ['father', 'mother', 'brother', 'sister'],
        correctIndex: 1,
      ),
      AssessmentQuestion(
        question: 'Who is a male parent?',
        options: ['mother', 'sister', 'father', 'aunt'],
        correctIndex: 2,
      ),
      AssessmentQuestion(
        question: 'A brother or sister is called a:',
        options: ['parent', 'sibling', 'grandparent', 'neighbour'],
        correctIndex: 1,
      ),
      AssessmentQuestion(
        question: '\'Family\' means:',
        options: [
          'a group of friends',
          'a group of related people',
          'a group of teachers',
          'a group of animals',
        ],
        correctIndex: 1,
      ),
    ],
  ),
  'Class 2|English|Daily Routine (Unit 4)': ChapterContent(
    worksheet: [
      'Write three activities you do after school.',
      'Put these in order: sleep, wake up, eat breakfast, go to school.',
      'Write what time you go to bed.',
      'Complete: In the evening, I ____.',
    ],
    flashcards: [
      Flashcard(
        term: 'evening',
        meaning: 'the time between afternoon and night',
      ),
      Flashcard(term: 'breakfast', meaning: 'the first meal of the day'),
      Flashcard(term: 'homework', meaning: 'school work done at home'),
      Flashcard(term: 'bedtime', meaning: 'the time to go to sleep'),
      Flashcard(
        term: 'schedule',
        meaning: 'a plan of things to do at certain times',
      ),
    ],
    assessment: [
      AssessmentQuestion(
        question: '\'Breakfast\' is:',
        options: [
          'the last meal of the day',
          'the first meal of the day',
          'a game',
          'a toy',
        ],
        correctIndex: 1,
      ),
      AssessmentQuestion(
        question: 'What do we do after coming home from school?',
        options: ['homework', 'fly', 'swim in the sea', 'drive a car'],
        correctIndex: 0,
      ),
      AssessmentQuestion(
        question: '\'Bedtime\' means:',
        options: [
          'time to eat',
          'time to sleep',
          'time to play',
          'time to study',
        ],
        correctIndex: 1,
      ),
      AssessmentQuestion(
        question: 'Choose the correct order:',
        options: [
          'sleep, wake up, breakfast',
          'wake up, breakfast, school',
          'school, wake up, breakfast',
          'breakfast, sleep, wake up',
        ],
        correctIndex: 1,
      ),
    ],
  ),
  'Class 2|English|Food': ChapterContent(
    worksheet: [
      'Name three foods you eat every day.',
      'Write your favourite food.',
      'Write one fruit and one vegetable.',
      'Complete: I like to eat ____.',
    ],
    flashcards: [
      Flashcard(term: 'food', meaning: 'things we eat'),
      Flashcard(
        term: 'fruit',
        meaning: 'a sweet part of a plant we eat, like an apple',
      ),
      Flashcard(
        term: 'vegetable',
        meaning: 'a plant part we eat, like a carrot',
      ),
      Flashcard(term: 'meal', meaning: 'food eaten at a particular time'),
      Flashcard(term: 'healthy', meaning: 'good for the body'),
    ],
    assessment: [
      AssessmentQuestion(
        question: 'Which of these is a fruit?',
        options: ['potato', 'apple', 'spinach', 'onion'],
        correctIndex: 1,
      ),
      AssessmentQuestion(
        question: 'Which of these is a vegetable?',
        options: ['mango', 'banana', 'carrot', 'grapes'],
        correctIndex: 2,
      ),
      AssessmentQuestion(
        question: '\'Healthy\' food is good for our:',
        options: ['toys', 'body', 'books', 'clothes'],
        correctIndex: 1,
      ),
      AssessmentQuestion(
        question: 'A \'meal\' is:',
        options: ['a game', 'food eaten at a time', 'a toy', 'a song'],
        correctIndex: 1,
      ),
    ],
  ),
  'Class 2|English|House': ChapterContent(
    worksheet: [
      'Name three rooms in a house.',
      'Write what you do in the kitchen.',
      'Write where you sleep in your house.',
      'Complete: My house has a ____.',
    ],
    flashcards: [
      Flashcard(term: 'house', meaning: 'a place where people live'),
      Flashcard(term: 'kitchen', meaning: 'room where food is cooked'),
      Flashcard(term: 'bedroom', meaning: 'room where people sleep'),
      Flashcard(term: 'door', meaning: 'an opening to enter or leave a room'),
      Flashcard(term: 'roof', meaning: 'the top covering of a house'),
    ],
    assessment: [
      AssessmentQuestion(
        question: 'Where do we cook food?',
        options: ['bedroom', 'kitchen', 'roof', 'garden'],
        correctIndex: 1,
      ),
      AssessmentQuestion(
        question: 'Where do we sleep?',
        options: ['kitchen', 'bathroom', 'bedroom', 'garage'],
        correctIndex: 2,
      ),
      AssessmentQuestion(
        question: 'The top part of a house is called:',
        options: ['door', 'window', 'roof', 'wall'],
        correctIndex: 2,
      ),
      AssessmentQuestion(
        question: 'We enter a room through the:',
        options: ['roof', 'door', 'floor', 'wall'],
        correctIndex: 1,
      ),
    ],
  ),
  'Class 2|English|Means of Transport': ChapterContent(
    worksheet: [
      'Name three means of transport.',
      'Which transport travels on water?',
      'Which transport travels in the sky?',
      'Complete: I go to school by ____.',
    ],
    flashcards: [
      Flashcard(
        term: 'transport',
        meaning: 'a way of moving from one place to another',
      ),
      Flashcard(term: 'bicycle', meaning: 'a two-wheeled vehicle we pedal'),
      Flashcard(term: 'train', meaning: 'a vehicle that runs on rails'),
      Flashcard(term: 'boat', meaning: 'a vehicle that travels on water'),
      Flashcard(term: 'airplane', meaning: 'a vehicle that flies in the sky'),
    ],
    assessment: [
      AssessmentQuestion(
        question: 'Which vehicle flies in the sky?',
        options: ['car', 'airplane', 'boat', 'bicycle'],
        correctIndex: 1,
      ),
      AssessmentQuestion(
        question: 'Which vehicle travels on water?',
        options: ['boat', 'train', 'bus', 'bicycle'],
        correctIndex: 0,
      ),
      AssessmentQuestion(
        question: 'A train runs on:',
        options: ['roads', 'rails', 'water', 'sky'],
        correctIndex: 1,
      ),
      AssessmentQuestion(
        question: 'Which of these has two wheels?',
        options: ['car', 'bus', 'bicycle', 'train'],
        correctIndex: 2,
      ),
    ],
  ),
  'Class 2|English|The Village Market': ChapterContent(
    worksheet: [
      'Name three things you can buy at a market.',
      'Who sells vegetables in the market?',
      'Write one thing you like about a village market.',
      'Complete: At the market, I saw a ____.',
    ],
    flashcards: [
      Flashcard(
        term: 'market',
        meaning: 'a place where goods are bought and sold',
      ),
      Flashcard(term: 'vendor', meaning: 'a person who sells goods'),
      Flashcard(term: 'vegetables', meaning: 'plant food sold in the market'),
      Flashcard(term: 'price', meaning: 'the amount of money for something'),
      Flashcard(term: 'basket', meaning: 'a container to carry things'),
    ],
    assessment: [
      AssessmentQuestion(
        question: 'A \'market\' is a place where we:',
        options: ['sleep', 'buy and sell things', 'study', 'swim'],
        correctIndex: 1,
      ),
      AssessmentQuestion(
        question: 'A person who sells goods is called a:',
        options: ['teacher', 'vendor', 'doctor', 'driver'],
        correctIndex: 1,
      ),
      AssessmentQuestion(
        question: 'We carry things from the market in a:',
        options: ['basket', 'book', 'bed', 'shoe'],
        correctIndex: 0,
      ),
      AssessmentQuestion(
        question: '\'Price\' means:',
        options: [
          'the color of a thing',
          'the amount of money for something',
          'the shape of a thing',
          'the size of a thing',
        ],
        correctIndex: 1,
      ),
    ],
  ),
  'Class 2|Mathematics|आकृति और स्थान': ChapterContent(
    worksheet: [
      'अपने आस-पास की तीन गोल (वृत्ताकार) वस्तुओं के नाम लिखिए।',
      'त्रिभुज की कितनी भुजाएँ होती हैं?',
      'वर्ग और आयत में क्या अंतर है, एक वाक्य में लिखिए।',
      'अपनी कक्षा में एक चौकोर वस्तु और एक गोल वस्तु का नाम लिखिए।',
    ],
    flashcards: [
      Flashcard(term: 'वृत्त', meaning: 'गोल आकृति'),
      Flashcard(term: 'त्रिभुज', meaning: 'तीन भुजाओं वाली आकृति'),
      Flashcard(term: 'वर्ग', meaning: 'चार बराबर भुजाओं वाली आकृति'),
      Flashcard(
        term: 'आयत',
        meaning: 'चार भुजाओं वाली आकृति जिसकी विपरीत भुजाएँ बराबर होती हैं',
      ),
      Flashcard(
        term: 'घन',
        meaning: 'एक ठोस आकृति जिसके छह बराबर फलक होते हैं',
      ),
    ],
    assessment: [
      AssessmentQuestion(
        question: 'त्रिभुज की भुजाएँ कितनी होती हैं?',
        options: ['2', '3', '4', '5'],
        correctIndex: 1,
      ),
      AssessmentQuestion(
        question: 'गेंद किस आकृति जैसी होती है?',
        options: ['वर्ग', 'त्रिभुज', 'वृत्त (गोला)', 'आयत'],
        correctIndex: 2,
      ),
      AssessmentQuestion(
        question: 'वर्ग की सभी भुजाएँ कैसी होती हैं?',
        options: ['असमान', 'बराबर', 'टेढ़ी', 'गोल'],
        correctIndex: 1,
      ),
      AssessmentQuestion(
        question: 'दरवाज़ा प्रायः किस आकृति का होता है?',
        options: ['वृत्त', 'त्रिभुज', 'आयत', 'तारा'],
        correctIndex: 2,
      ),
    ],
  ),
  'Class 2|Mathematics|संख्याएँ': ChapterContent(
    worksheet: [
      '1 से 20 तक की संख्याएँ लिखिए।',
      '45 के बाद कौन सी संख्या आती है?',
      '30 और 40 के बीच की कोई पाँच संख्याएँ लिखिए।',
      'इनमें से सबसे बड़ी और सबसे छोटी संख्या चुनिए: 67, 23, 89, 12',
    ],
    flashcards: [
      Flashcard(
        term: 'संख्या',
        meaning: 'गिनती करने के लिए प्रयोग होने वाला अंक',
      ),
      Flashcard(
        term: 'इकाई',
        meaning: 'किसी संख्या के दायीं ओर का पहला स्थान मान',
      ),
      Flashcard(term: 'दहाई', meaning: 'दस-दस के समूह का स्थान मान'),
      Flashcard(term: 'बड़ी संख्या', meaning: 'अधिक मूल्य वाली संख्या'),
      Flashcard(term: 'छोटी संख्या', meaning: 'कम मूल्य वाली संख्या'),
    ],
    assessment: [
      AssessmentQuestion(
        question: '45 के बाद कौन सी संख्या आती है?',
        options: ['44', '46', '54', '40'],
        correctIndex: 1,
      ),
      AssessmentQuestion(
        question: 'इनमें सबसे बड़ी संख्या कौन सी है?',
        options: ['34', '43', '24', '42'],
        correctIndex: 1,
      ),
      AssessmentQuestion(
        question: '27 में दहाई के स्थान पर कौन सा अंक है?',
        options: ['7', '2', '9', '0'],
        correctIndex: 1,
      ),
      AssessmentQuestion(
        question: 'इनमें सबसे छोटी संख्या कौन सी है?',
        options: ['56', '65', '45', '54'],
        correctIndex: 2,
      ),
    ],
  ),
  'Class 2|Mathematics|जोड़': ChapterContent(
    worksheet: [
      '23 + 15 = ?',
      '34 + 42 = ?',
      'रीना के पास 12 पेंसिलें हैं और उसकी बहन के पास 8 पेंसिलें हैं। दोनों के पास कुल कितनी पेंसिलें हैं?',
      '45 + 30 = ?',
    ],
    flashcards: [
      Flashcard(term: 'जोड़', meaning: 'दो या दो से अधिक संख्याओं को मिलाना'),
      Flashcard(term: 'योग', meaning: 'जोड़ का परिणाम'),
      Flashcard(term: 'कुल', meaning: 'सब मिलाकर'),
      Flashcard(
        term: 'संख्या रेखा',
        meaning: 'संख्याओं को क्रम में दिखाने वाली रेखा',
      ),
      Flashcard(term: 'मिलाना', meaning: 'एक साथ रखना'),
    ],
    assessment: [
      AssessmentQuestion(
        question: '20 + 15 = ?',
        options: ['30', '35', '40', '25'],
        correctIndex: 1,
      ),
      AssessmentQuestion(
        question: '18 + 12 = ?',
        options: ['20', '28', '30', '32'],
        correctIndex: 2,
      ),
      AssessmentQuestion(
        question: '25 + 25 = ?',
        options: ['40', '45', '50', '55'],
        correctIndex: 2,
      ),
      AssessmentQuestion(
        question: 'जोड़ का परिणाम क्या कहलाता है?',
        options: ['अंतर', 'योग', 'गुणनफल', 'भागफल'],
        correctIndex: 1,
      ),
    ],
  ),
  'Class 2|Mathematics|घटाव': ChapterContent(
    worksheet: [
      '50 - 20 = ?',
      '48 - 15 = ?',
      'सोहन के पास 25 गेंदें थीं, उसने 10 गेंदें अपने दोस्त को दे दीं। अब सोहन के पास कितनी गेंदें बचीं?',
      '60 - 35 = ?',
    ],
    flashcards: [
      Flashcard(
        term: 'घटाव',
        meaning: 'एक संख्या में से दूसरी संख्या को कम करना',
      ),
      Flashcard(term: 'अंतर', meaning: 'घटाव का परिणाम'),
      Flashcard(term: 'बचा हुआ', meaning: 'शेष'),
      Flashcard(term: 'कम करना', meaning: 'घटाना'),
      Flashcard(term: 'शेष', meaning: 'बचा हुआ भाग'),
    ],
    assessment: [
      AssessmentQuestion(
        question: '30 - 10 = ?',
        options: ['10', '20', '30', '40'],
        correctIndex: 1,
      ),
      AssessmentQuestion(
        question: '45 - 20 = ?',
        options: ['15', '20', '25', '30'],
        correctIndex: 2,
      ),
      AssessmentQuestion(
        question: '100 - 50 = ?',
        options: ['40', '50', '60', '70'],
        correctIndex: 1,
      ),
      AssessmentQuestion(
        question: 'घटाव का परिणाम क्या कहलाता है?',
        options: ['योग', 'अंतर', 'गुणनफल', 'भागफल'],
        correctIndex: 1,
      ),
    ],
  ),
  'Class 2|Mathematics|समय': ChapterContent(
    worksheet: [
      'एक दिन में कितने घंटे होते हैं?',
      'घड़ी में कितनी सुइयाँ होती हैं?',
      'सुबह के 7 बजे आप क्या करते हैं?',
      'एक घंटे में कितने मिनट होते हैं?',
    ],
    flashcards: [
      Flashcard(term: 'घड़ी', meaning: 'समय बताने वाला यंत्र'),
      Flashcard(term: 'घंटा', meaning: 'समय की एक इकाई (60 मिनट)'),
      Flashcard(term: 'मिनट', meaning: 'समय की एक छोटी इकाई'),
      Flashcard(term: 'सुई', meaning: 'घड़ी में समय दिखाने वाली छड़ी'),
      Flashcard(term: 'सुबह', meaning: 'दिन का पहला भाग'),
    ],
    assessment: [
      AssessmentQuestion(
        question: 'एक दिन में कितने घंटे होते हैं?',
        options: ['12', '24', '60', '30'],
        correctIndex: 1,
      ),
      AssessmentQuestion(
        question: 'एक घंटे में कितने मिनट होते हैं?',
        options: ['30', '45', '60', '100'],
        correctIndex: 2,
      ),
      AssessmentQuestion(
        question: 'घड़ी में सामान्यतः कितनी सुइयाँ होती हैं (घंटे और मिनट की)?',
        options: ['1', '2', '3', '4'],
        correctIndex: 1,
      ),
      AssessmentQuestion(
        question: 'रात में हम आमतौर पर क्या करते हैं?',
        options: ['सोते हैं', 'स्कूल जाते हैं', 'खेलते हैं', 'नहाते हैं'],
        correctIndex: 0,
      ),
    ],
  ),
  'Class 2|Mathematics|मापन': ChapterContent(
    worksheet: [
      'लंबाई मापने के लिए किस यंत्र का प्रयोग करते हैं?',
      'भार (वज़न) मापने के लिए किसका प्रयोग होता है?',
      'अपने कमरे में किसी वस्तु की लंबाई का अनुमान लगाइए और लिखिए।',
      'एक मीटर में कितने सेंटीमीटर होते हैं?',
    ],
    flashcards: [
      Flashcard(term: 'मापन', meaning: 'किसी वस्तु की लंबाई, भार आदि नापना'),
      Flashcard(term: 'स्केल', meaning: 'लंबाई मापने का यंत्र'),
      Flashcard(term: 'मीटर', meaning: 'लंबाई मापने की इकाई'),
      Flashcard(term: 'किलोग्राम', meaning: 'भार मापने की इकाई'),
      Flashcard(term: 'तराजू', meaning: 'वज़न मापने का यंत्र'),
    ],
    assessment: [
      AssessmentQuestion(
        question: 'लंबाई मापने के लिए किसका प्रयोग होता है?',
        options: ['तराजू', 'स्केल', 'घड़ी', 'थर्मामीटर'],
        correctIndex: 1,
      ),
      AssessmentQuestion(
        question: 'वज़न मापने के लिए किसका प्रयोग होता है?',
        options: ['स्केल', 'तराजू', 'घड़ी', 'कप'],
        correctIndex: 1,
      ),
      AssessmentQuestion(
        question: 'एक मीटर में कितने सेंटीमीटर होते हैं?',
        options: ['10', '100', '1000', '50'],
        correctIndex: 1,
      ),
      AssessmentQuestion(
        question: 'भार मापने की इकाई कौन सी है?',
        options: ['मीटर', 'किलोग्राम', 'लीटर', 'घंटा'],
        correctIndex: 1,
      ),
    ],
  ),
  'Class 2|Mathematics|मुद्रा': ChapterContent(
    worksheet: [
      '5 रुपये के 4 सिक्के मिलाकर कुल कितने रुपये होंगे?',
      'रीता के पास 20 रुपये का एक नोट है। उसने 12 रुपये की पेंसिल खरीदी। उसके पास कितने रुपये बचे?',
      '10 रुपये के 3 नोट और 5 रुपये का 1 सिक्का मिलाकर कुल कितने रुपये होंगे?',
      '2 रुपये और 3 रुपये के सिक्कों को मिलाकर कुल राशि लिखिए।',
    ],
    flashcards: [
      Flashcard(term: 'मुद्रा', meaning: 'पैसे, रुपये'),
      Flashcard(term: 'सिक्का', meaning: 'धातु का पैसा'),
      Flashcard(term: 'नोट', meaning: 'कागज़ का पैसा'),
      Flashcard(term: 'रुपया', meaning: 'भारत की मुद्रा'),
      Flashcard(term: 'खरीदना', meaning: 'पैसे देकर वस्तु लेना'),
    ],
    assessment: [
      AssessmentQuestion(
        question: '10 रुपये के 2 नोट कुल कितने रुपये होंगे?',
        options: ['10', '12', '20', '22'],
        correctIndex: 2,
      ),
      AssessmentQuestion(
        question: 'भारत की मुद्रा को क्या कहते हैं?',
        options: ['डॉलर', 'रुपया', 'पाउंड', 'यूरो'],
        correctIndex: 1,
      ),
      AssessmentQuestion(
        question:
            'यदि आपके पास 50 रुपये हैं और आप 30 रुपये खर्च करते हैं, तो कितने बचेंगे?',
        options: ['10', '20', '30', '80'],
        correctIndex: 1,
      ),
      AssessmentQuestion(
        question: 'सिक्के किस चीज़ के बने होते हैं?',
        options: ['कागज़', 'धातु', 'कपड़ा', 'लकड़ी'],
        correctIndex: 1,
      ),
    ],
  ),
  'Class 2|Mathematics|पैटर्न': ChapterContent(
    worksheet: [
      'इस पैटर्न को आगे बढ़ाइए: 2, 4, 6, 8, __, __',
      'लाल, नीला, लाल, नीला, ___, ___ - पैटर्न पूरा कीजिए।',
      '5, 10, 15, 20, __ - अगली संख्या लिखिए।',
      'अपनी कॉपी में एक रंगीन पैटर्न बनाइए (गोला, त्रिभुज, गोला, त्रिभुज)।',
    ],
    flashcards: [
      Flashcard(
        term: 'पैटर्न',
        meaning: 'एक क्रम में दोहराई जाने वाली आकृति या संख्या',
      ),
      Flashcard(term: 'क्रम', meaning: 'तरतीब'),
      Flashcard(term: 'दोहराव', meaning: 'बार-बार आना'),
      Flashcard(term: 'अगला', meaning: 'आने वाला'),
      Flashcard(term: 'समूह', meaning: 'एक साथ रखी चीज़ें'),
    ],
    assessment: [
      AssessmentQuestion(
        question: '2, 4, 6, 8, __ में अगली संख्या क्या होगी?',
        options: ['9', '10', '12', '11'],
        correctIndex: 1,
      ),
      AssessmentQuestion(
        question: '5, 10, 15, __ में अगली संख्या क्या होगी?',
        options: ['18', '20', '25', '16'],
        correctIndex: 1,
      ),
      AssessmentQuestion(
        question: '"पैटर्न" शब्द का अर्थ है?',
        options: ['एक बार आना', 'क्रम में दोहराना', 'कभी न आना', 'उल्टा होना'],
        correctIndex: 1,
      ),
      AssessmentQuestion(
        question: 'लाल, नीला, लाल, नीला के बाद क्या आएगा?',
        options: ['पीला', 'लाल', 'हरा', 'सफेद'],
        correctIndex: 1,
      ),
    ],
  ),
  'Class 2|Mathematics|गुणा': ChapterContent(
    worksheet: [
      '2 × 3 = ?',
      '4 × 5 = ?',
      'एक डिब्बे में 3 चॉकलेट हैं। 4 डिब्बों में कुल कितनी चॉकलेट होंगी?',
      '5 × 2 = ?',
    ],
    flashcards: [
      Flashcard(
        term: 'गुणा',
        meaning: 'किसी संख्या को बार-बार जोड़ने की प्रक्रिया',
      ),
      Flashcard(term: 'गुणनफल', meaning: 'गुणा का परिणाम'),
      Flashcard(term: 'गुणनखंड', meaning: 'गुणा में प्रयुक्त संख्याएँ'),
      Flashcard(term: 'बार', meaning: 'कितनी बार जोड़ना है'),
      Flashcard(term: 'सारणी', meaning: 'पहाड़ा'),
    ],
    assessment: [
      AssessmentQuestion(
        question: '3 × 3 = ?',
        options: ['6', '9', '12', '3'],
        correctIndex: 1,
      ),
      AssessmentQuestion(
        question: '2 × 5 = ?',
        options: ['7', '10', '12', '25'],
        correctIndex: 1,
      ),
      AssessmentQuestion(
        question: '4 × 2 = ?',
        options: ['6', '8', '10', '4'],
        correctIndex: 1,
      ),
      AssessmentQuestion(
        question: 'गुणा का परिणाम क्या कहलाता है?',
        options: ['योग', 'अंतर', 'गुणनफल', 'भागफल'],
        correctIndex: 2,
      ),
    ],
  ),
  'Class 3|Hindi|रेलगाड़ी': ChapterContent(
    worksheet: [
      'रेलगाड़ी शब्द से क्या तात्पर्य है? एक वाक्य में लिखिए।',
      'रेलगाड़ी में यात्रा करते समय आपको बाहर क्या-क्या दिखाई देता है? तीन चीज़ें लिखिए।',
      'रेलगाड़ी की आवाज़ की नकल करते हुए एक पंक्ति लिखिए (जैसे- छुक-छुक)।',
      'रेलगाड़ी और बस में कोई दो अंतर लिखिए।',
    ],
    flashcards: [
      Flashcard(
        term: 'रेलगाड़ी',
        meaning: 'पटरी पर चलने वाला वाहन जो कई डिब्बों को जोड़कर चलता है',
      ),
      Flashcard(
        term: 'पटरी',
        meaning: 'वह लोहे का रास्ता जिस पर रेलगाड़ी चलती है',
      ),
      Flashcard(
        term: 'डिब्बा',
        meaning: 'रेलगाड़ी का वह भाग जिसमें यात्री बैठते हैं',
      ),
      Flashcard(term: 'स्टेशन', meaning: 'वह स्थान जहाँ रेलगाड़ी रुकती है'),
      Flashcard(term: 'चालक', meaning: 'रेलगाड़ी चलाने वाला व्यक्ति'),
    ],
    assessment: [
      AssessmentQuestion(
        question: 'रेलगाड़ी किस पर चलती है?',
        options: ['पानी', 'सड़क', 'पटरी', 'हवा'],
        correctIndex: 2,
      ),
      AssessmentQuestion(
        question: 'रेलगाड़ी रुकने का स्थान क्या कहलाता है?',
        options: ['बाज़ार', 'स्टेशन', 'मैदान', 'विद्यालय'],
        correctIndex: 1,
      ),
      AssessmentQuestion(
        question: 'रेलगाड़ी को चलाने वाले व्यक्ति को क्या कहते हैं?',
        options: ['पायलट', 'चालक', 'कप्तान', 'माली'],
        correctIndex: 1,
      ),
      AssessmentQuestion(
        question: 'रेलगाड़ी के डिब्बे आपस में किससे जुड़े होते हैं?',
        options: ['रस्सी से', 'जोड़ (कड़ी) से', 'गोंद से', 'धागे से'],
        correctIndex: 1,
      ),
    ],
  ),
  'Class 3|Hindi|कंजूस': ChapterContent(
    worksheet: [
      '\'कंजूस\' शब्द का क्या अर्थ है?',
      'कंजूस और मितव्ययी (बचत करने वाला) व्यक्ति में क्या अंतर है?',
      'धन का सही उपयोग किस प्रकार करना चाहिए? दो उदाहरण लिखिए।',
      '\'कंजूस\' शब्द का प्रयोग करते हुए एक वाक्य बनाइए।',
    ],
    flashcards: [
      Flashcard(
        term: 'कंजूस',
        meaning: 'वह व्यक्ति जो धन खर्च करने में बहुत हिचकिचाता है',
      ),
      Flashcard(term: 'धन', meaning: 'पैसा या संपत्ति'),
      Flashcard(term: 'बचत', meaning: 'ज़रूरत के लिए पैसा बचाकर रखना'),
      Flashcard(term: 'दान', meaning: 'दूसरों की सहायता के लिए कुछ देना'),
      Flashcard(term: 'लालच', meaning: 'अधिक पाने की इच्छा'),
    ],
    assessment: [
      AssessmentQuestion(
        question: '\'कंजूस\' व्यक्ति की विशेषता क्या होती है?',
        options: [
          'वह खूब खर्च करता है',
          'वह पैसा खर्च करने से बचता है',
          'वह दान करता है',
          'वह मददगार होता है',
        ],
        correctIndex: 1,
      ),
      AssessmentQuestion(
        question: 'बचत करना और कंजूस होना...',
        options: [
          'एक ही बात है',
          'अलग-अलग बातें हैं',
          'कोई संबंध नहीं है',
          'हमेशा गलत है',
        ],
        correctIndex: 1,
      ),
      AssessmentQuestion(
        question: 'निम्न में से \'धन\' का पर्यायवाची शब्द है',
        options: ['पैसा', 'पत्ता', 'पहाड़', 'पानी'],
        correctIndex: 0,
      ),
      AssessmentQuestion(
        question: 'दूसरों की सहायता के लिए धन देना क्या कहलाता है?',
        options: ['कंजूसी', 'दान', 'लालच', 'चोरी'],
        correctIndex: 1,
      ),
    ],
  ),
  'Class 3|Hindi|ओ मेरी मछली तालाब लाजवाब': ChapterContent(
    worksheet: [
      'तालाब में रहने वाले तीन जीवों के नाम लिखिए।',
      'मछली पानी में कैसे साँस लेती है?',
      'तालाब को साफ़ रखना क्यों ज़रूरी है?',
      '\'लाजवाब\' शब्द का अर्थ अपने शब्दों में लिखिए।',
    ],
    flashcards: [
      Flashcard(
        term: 'तालाब',
        meaning: 'पानी से भरा एक प्राकृतिक या बनावटी गड्ढा',
      ),
      Flashcard(term: 'मछली', meaning: 'पानी में रहने वाला जीव'),
      Flashcard(term: 'पंख', meaning: 'मछली के तैरने वाले अंग'),
      Flashcard(term: 'गलफड़े', meaning: 'मछली के साँस लेने के अंग'),
      Flashcard(term: 'जलचर', meaning: 'पानी में रहने वाले जीव'),
    ],
    assessment: [
      AssessmentQuestion(
        question: 'मछली किसकी सहायता से साँस लेती है?',
        options: ['फेफड़े', 'गलफड़े', 'नाक', 'त्वचा'],
        correctIndex: 1,
      ),
      AssessmentQuestion(
        question: 'मछली पानी में किसकी सहायता से तैरती है?',
        options: ['पैर', 'पंख', 'पंजे', 'हाथ'],
        correctIndex: 1,
      ),
      AssessmentQuestion(
        question: 'तालाब में पानी कैसा होना चाहिए?',
        options: ['गंदा', 'साफ़', 'सूखा', 'गर्म'],
        correctIndex: 1,
      ),
      AssessmentQuestion(
        question: '\'लाजवाब\' शब्द का अर्थ है',
        options: ['बेकार', 'अद्भुत/बेजोड़', 'डरावना', 'छोटा'],
        correctIndex: 1,
      ),
    ],
  ),
  'Class 3|Hindi|मेरी टोपी तेरी टोपी': ChapterContent(
    worksheet: [
      'टोपी पहनने के दो लाभ लिखिए।',
      'आपकी टोपी किस रंग की है? एक वाक्य में लिखिए।',
      'टोपी और छाता में क्या अंतर है?',
      '\'मेरी\' और \'तेरी\' शब्दों का प्रयोग करते हुए एक-एक वाक्य बनाइए।',
    ],
    flashcards: [
      Flashcard(term: 'टोपी', meaning: 'सिर पर पहनने की वस्तु'),
      Flashcard(term: 'धूप', meaning: 'सूर्य की किरणें'),
      Flashcard(term: 'रंग-बिरंगी', meaning: 'कई रंगों वाली'),
      Flashcard(term: 'पहनावा', meaning: 'पहनने के कपड़े और वस्तुएँ'),
      Flashcard(term: 'साझा करना', meaning: 'आपस में बाँटना'),
    ],
    assessment: [
      AssessmentQuestion(
        question: 'टोपी किस अंग पर पहनी जाती है?',
        options: ['हाथ', 'पैर', 'सिर', 'कमर'],
        correctIndex: 2,
      ),
      AssessmentQuestion(
        question: 'टोपी पहनने से किससे बचाव होता है?',
        options: ['ठंडी हवा और धूप', 'पानी की कमी', 'भूख', 'नींद'],
        correctIndex: 0,
      ),
      AssessmentQuestion(
        question: '\'रंग-बिरंगी\' शब्द का अर्थ है',
        options: ['एक रंग वाली', 'कई रंगों वाली', 'बिना रंग की', 'काली'],
        correctIndex: 1,
      ),
      AssessmentQuestion(
        question: '\'मेरी\' शब्द किसके लिए प्रयोग होता है?',
        options: [
          'अपनी वस्तु के लिए',
          'दूसरे की वस्तु के लिए',
          'किसी के लिए नहीं',
          'सबकी वस्तु के लिए',
        ],
        correctIndex: 0,
      ),
    ],
  ),
  'Class 3|Hindi|सारस और लोमड़ी': ChapterContent(
    worksheet: [
      'सारस किस प्रकार का जीव है - पक्षी या स्तनधारी?',
      'लोमड़ी सामान्यतः कहाँ रहती है?',
      'सारस और लोमड़ी में से कौन उड़ सकता है?',
      'मित्रता में एक-दूसरे का सम्मान करना क्यों ज़रूरी है? अपने शब्दों में लिखिए।',
    ],
    flashcards: [
      Flashcard(term: 'सारस', meaning: 'लंबी टांगों और चोंच वाला एक पक्षी'),
      Flashcard(term: 'लोमड़ी', meaning: 'एक चालाक जंगली जानवर'),
      Flashcard(term: 'चालाकी', meaning: 'होशियारी से काम लेना'),
      Flashcard(term: 'मित्रता', meaning: 'दोस्ती'),
      Flashcard(term: 'सम्मान', meaning: 'किसी की इज़्ज़त करना'),
    ],
    assessment: [
      AssessmentQuestion(
        question: 'सारस एक...',
        options: ['पक्षी है', 'मछली है', 'कीड़ा है', 'पेड़ है'],
        correctIndex: 0,
      ),
      AssessmentQuestion(
        question: 'लोमड़ी को किस गुण के लिए जाना जाता है?',
        options: ['भोलापन', 'चालाकी', 'आलस्य', 'कमजोरी'],
        correctIndex: 1,
      ),
      AssessmentQuestion(
        question: 'सच्ची मित्रता की पहचान क्या है?',
        options: [
          'एक-दूसरे को धोखा देना',
          'एक-दूसरे का सम्मान करना',
          'झगड़ा करना',
          'ईर्ष्या करना',
        ],
        correctIndex: 1,
      ),
      AssessmentQuestion(
        question: 'सारस की चोंच सामान्यतः कैसी होती है?',
        options: ['छोटी और मोटी', 'लंबी और पतली', 'गोल', 'बहुत नरम'],
        correctIndex: 1,
      ),
    ],
  ),
  'Class 3|Hindi|पेड़': ChapterContent(
    worksheet: [
      'पेड़ के तीन भागों के नाम लिखिए।',
      'पेड़ हमें क्या-क्या देते हैं? चार चीज़ें लिखिए।',
      'पेड़ लगाना क्यों ज़रूरी है?',
      'अपने घर के आस-पास दिखने वाले किसी एक पेड़ का नाम लिखिए।',
    ],
    flashcards: [
      Flashcard(
        term: 'जड़',
        meaning: 'पेड़ का वह भाग जो ज़मीन के अंदर होता है',
      ),
      Flashcard(term: 'तना', meaning: 'पेड़ का सीधा मोटा भाग'),
      Flashcard(term: 'शाखा', meaning: 'तने से निकलने वाली टहनी'),
      Flashcard(term: 'पत्ती', meaning: 'पेड़ का हरा भाग जो भोजन बनाता है'),
      Flashcard(term: 'ऑक्सीजन', meaning: 'पेड़ों से मिलने वाली जीवनदायी गैस'),
    ],
    assessment: [
      AssessmentQuestion(
        question: 'पेड़ का कौन-सा भाग ज़मीन के अंदर होता है?',
        options: ['पत्ती', 'जड़', 'तना', 'फूल'],
        correctIndex: 1,
      ),
      AssessmentQuestion(
        question: 'पेड़ हमें कौन-सी गैस देते हैं जिससे हम साँस लेते हैं?',
        options: ['कार्बन डाइऑक्साइड', 'ऑक्सीजन', 'नाइट्रोजन', 'धुआँ'],
        correctIndex: 1,
      ),
      AssessmentQuestion(
        question: 'पेड़ की पत्तियाँ भोजन बनाने के लिए किसका उपयोग करती हैं?',
        options: ['सूर्य का प्रकाश', 'अंधेरा', 'बर्फ', 'धुआँ'],
        correctIndex: 0,
      ),
      AssessmentQuestion(
        question: 'पेड़ काटने से पर्यावरण पर क्या प्रभाव पड़ता है?',
        options: [
          'कोई प्रभाव नहीं',
          'हवा और साफ हो जाती है',
          'प्रदूषण बढ़ता है',
          'बारिश ज़्यादा होती है',
        ],
        correctIndex: 2,
      ),
    ],
  ),
  'Class 3|Hindi|टोकरी में क्या है': ChapterContent(
    worksheet: [
      'टोकरी सामान्यतः किस चीज़ से बनती है?',
      'टोकरी में रखी जा सकने वाली चार वस्तुओं के नाम लिखिए।',
      'सब्ज़ी बाज़ार में टोकरी का उपयोग क्यों किया जाता है?',
      'अनुमान (guess) लगाना क्यों मज़ेदार होता है?',
    ],
    flashcards: [
      Flashcard(
        term: 'टोकरी',
        meaning: 'बाँस या तिनकों से बनी बर्तन जैसी वस्तु',
      ),
      Flashcard(term: 'बाँस', meaning: 'एक पौधा जिससे टोकरी बनती है'),
      Flashcard(term: 'फल', meaning: 'पेड़ से मिलने वाला खाने योग्य भाग'),
      Flashcard(term: 'सब्ज़ी', meaning: 'पौधों से मिलने वाला भोजन'),
      Flashcard(term: 'अनुमान', meaning: 'बिना देखे सोचकर बताना'),
    ],
    assessment: [
      AssessmentQuestion(
        question: 'टोकरी सामान्यतः किससे बनाई जाती है?',
        options: [
          'लोहे से',
          'बाँस/तिनकों से',
          'काँच से',
          'प्लास्टिक की चादर से',
        ],
        correctIndex: 1,
      ),
      AssessmentQuestion(
        question: 'बाज़ार में सब्ज़ी और फल ले जाने के लिए क्या उपयोग होता है?',
        options: ['टोकरी', 'तकिया', 'कंबल', 'दर्पण'],
        correctIndex: 0,
      ),
      AssessmentQuestion(
        question: 'बिना देखे सोचकर बताने को क्या कहते हैं?',
        options: ['निश्चय', 'अनुमान', 'आदेश', 'प्रश्न'],
        correctIndex: 1,
      ),
      AssessmentQuestion(
        question: 'निम्नलिखित में से कौन-सी वस्तु टोकरी में रखी जा सकती है?',
        options: ['सेब', 'हवा', 'आवाज़', 'विचार'],
        correctIndex: 0,
      ),
    ],
  ),
  'Class 3|Hindi|चंदा मामा कुएँ में, चाँद का सफ़र': ChapterContent(
    worksheet: [
      'चाँद को \'चंदा मामा\' क्यों कहा जाता है?',
      'कुएँ के पानी में चाँद कैसे दिखाई देता है?',
      'चाँद आकाश में सामान्यतः कब दिखाई देता है - दिन में या रात में?',
      'चाँद की रोशनी कहाँ से आती है?',
    ],
    flashcards: [
      Flashcard(term: 'चंदा मामा', meaning: 'चाँद को प्यार से बुलाने का नाम'),
      Flashcard(
        term: 'कुआँ',
        meaning: 'पानी निकालने के लिए ज़मीन में बना गहरा गड्ढा',
      ),
      Flashcard(
        term: 'प्रतिबिंब',
        meaning: 'पानी या शीशे में दिखने वाली परछाई/छवि',
      ),
      Flashcard(
        term: 'आकाश',
        meaning: 'वह स्थान जहाँ सूरज, चाँद और तारे दिखते हैं',
      ),
      Flashcard(term: 'रोशनी', meaning: 'प्रकाश'),
    ],
    assessment: [
      AssessmentQuestion(
        question: 'चाँद की अपनी रोशनी...',
        options: [
          'नहीं होती',
          'बहुत तेज़ होती है',
          'सूर्य से ज़्यादा होती है',
          'हमेशा लाल होती है',
        ],
        correctIndex: 0,
      ),
      AssessmentQuestion(
        question: 'पानी में चाँद दिखने की क्रिया को क्या कहते हैं?',
        options: ['प्रतिबिंब', 'प्रदूषण', 'प्रकोप', 'प्रयोग'],
        correctIndex: 0,
      ),
      AssessmentQuestion(
        question: 'चाँद सामान्यतः किस समय आकाश में दिखाई देता है?',
        options: ['केवल दोपहर में', 'रात में', 'केवल सुबह में', 'कभी नहीं'],
        correctIndex: 1,
      ),
      AssessmentQuestion(
        question: 'कुएँ का उपयोग मुख्यतः किसलिए किया जाता है?',
        options: [
          'सोने के लिए',
          'पानी निकालने के लिए',
          'खाना पकाने के लिए',
          'खेलने के लिए',
        ],
        correctIndex: 1,
      ),
    ],
  ),
  'Class 3|Hindi|मन करता है': ChapterContent(
    worksheet: [
      'आपका मन कब-कब खेलने का करता है? लिखिए।',
      'जब आपका मन उदास हो तो आप क्या करते हैं?',
      '\'मन करता है\' का उपयोग करते हुए दो वाक्य बनाइए।',
      'अपनी एक इच्छा (wish) के बारे में लिखिए।',
    ],
    flashcards: [
      Flashcard(term: 'इच्छा', meaning: 'कुछ पाने या करने की चाहत'),
      Flashcard(term: 'मन', meaning: 'विचार और भावनाओं का केंद्र'),
      Flashcard(term: 'खुशी', meaning: 'प्रसन्नता का भाव'),
      Flashcard(term: 'उदासी', meaning: 'दुख का भाव'),
      Flashcard(term: 'कल्पना', meaning: 'बिना देखे मन में चित्र बनाना'),
    ],
    assessment: [
      AssessmentQuestion(
        question: '\'इच्छा\' शब्द का अर्थ है',
        options: ['डर', 'चाहत', 'गुस्सा', 'नींद'],
        correctIndex: 1,
      ),
      AssessmentQuestion(
        question: 'जब हम खुश होते हैं तो हमारा मन कैसा महसूस करता है?',
        options: ['उदास', 'प्रसन्न', 'थका हुआ', 'डरा हुआ'],
        correctIndex: 1,
      ),
      AssessmentQuestion(
        question: 'बिना देखे मन में चित्र बनाने को क्या कहते हैं?',
        options: ['कल्पना', 'गणना', 'आलोचना', 'चोरी'],
        correctIndex: 0,
      ),
      AssessmentQuestion(
        question: 'भावनाओं और विचारों का केंद्र किसे कहा जाता है?',
        options: ['हाथ', 'मन', 'पैर', 'बाल'],
        correctIndex: 1,
      ),
    ],
  ),
  'Class 3|Hindi|एक थी चिड़िया': ChapterContent(
    worksheet: [
      'चिड़िया अपना घोंसला किससे बनाती है?',
      'चिड़िया क्या खाती है? दो चीज़ें लिखिए।',
      'चिड़िया उड़ने के लिए किसका उपयोग करती है?',
      'पक्षियों की रक्षा करना क्यों ज़रूरी है?',
    ],
    flashcards: [
      Flashcard(term: 'चिड़िया', meaning: 'छोटा उड़ने वाला पक्षी'),
      Flashcard(term: 'घोंसला', meaning: 'पक्षियों का घर जो तिनकों से बनता है'),
      Flashcard(term: 'चोंच', meaning: 'पक्षी का मुँह जिससे वह दाना चुगती है'),
      Flashcard(term: 'पंख', meaning: 'उड़ने के लिए पक्षी के अंग'),
      Flashcard(term: 'दाना', meaning: 'पक्षियों का भोजन (अनाज के कण)'),
    ],
    assessment: [
      AssessmentQuestion(
        question: 'चिड़िया अपना घोंसला किससे बनाती है?',
        options: ['पत्थर से', 'तिनकों से', 'लोहे से', 'प्लास्टिक से'],
        correctIndex: 1,
      ),
      AssessmentQuestion(
        question: 'पक्षी उड़ने के लिए किसका उपयोग करते हैं?',
        options: ['पैर', 'पंख', 'चोंच', 'आँख'],
        correctIndex: 1,
      ),
      AssessmentQuestion(
        question: 'पक्षी दाना किससे चुगते हैं?',
        options: ['पंख से', 'चोंच से', 'पूँछ से', 'पंजे से'],
        correctIndex: 1,
      ),
      AssessmentQuestion(
        question: 'पक्षियों को बचाने के लिए हमें क्या करना चाहिए?',
        options: [
          'उनके घोंसले तोड़ना',
          'उन्हें पानी और दाना देना',
          'उन्हें पकड़ना',
          'पेड़ काटना',
        ],
        correctIndex: 1,
      ),
    ],
  ),
  'Class 3|Hindi|खूब मज़े हैं मौसम के': ChapterContent(
    worksheet: [
      'भारत में पाए जाने वाले तीन मौसमों के नाम लिखिए।',
      'गर्मी के मौसम में हम कैसे कपड़े पहनते हैं?',
      'बरसात के मौसम में क्या-क्या होता है?',
      'आपको कौन-सा मौसम सबसे अच्छा लगता है और क्यों?',
    ],
    flashcards: [
      Flashcard(
        term: 'मौसम',
        meaning: 'वातावरण की स्थिति (गर्मी, सर्दी, बरसात)',
      ),
      Flashcard(term: 'गर्मी', meaning: 'गरम मौसम जिसमें तापमान अधिक होता है'),
      Flashcard(term: 'सर्दी', meaning: 'ठंडा मौसम'),
      Flashcard(term: 'बरसात', meaning: 'वर्षा का मौसम'),
      Flashcard(term: 'वसंत', meaning: 'फूलों और खुशनुमा मौसम का समय'),
    ],
    assessment: [
      AssessmentQuestion(
        question: 'भारत में वर्षा का मौसम क्या कहलाता है?',
        options: ['शीत ऋतु', 'ग्रीष्म ऋतु', 'वर्षा ऋतु', 'बसंत'],
        correctIndex: 2,
      ),
      AssessmentQuestion(
        question: 'गर्मी के मौसम में कैसे कपड़े पहनने चाहिए?',
        options: ['मोटे ऊनी कपड़े', 'हल्के सूती कपड़े', 'रेनकोट', 'स्वेटर'],
        correctIndex: 1,
      ),
      AssessmentQuestion(
        question: 'सर्दी के मौसम में तापमान कैसा होता है?',
        options: ['बहुत गर्म', 'ठंडा', 'हमेशा एक जैसा', 'आग जैसा'],
        correctIndex: 1,
      ),
      AssessmentQuestion(
        question: 'बरसात के मौसम में आकाश में क्या दिखाई देता है?',
        options: ['बादल', 'बर्फ', 'केवल धूल भरी आँधी', 'कुछ नहीं'],
        correctIndex: 0,
      ),
    ],
  ),
  'Class 3|Hindi|मेरा पत्र': ChapterContent(
    worksheet: [
      'पत्र लिखते समय सबसे ऊपर सामान्यतः क्या लिखा जाता है?',
      'पत्र के अंत में हम क्या लिखते हैं?',
      'आप किसे पत्र लिखना पसंद करेंगे और क्यों?',
      'पत्र और ईमेल में एक अंतर लिखिए।',
    ],
    flashcards: [
      Flashcard(term: 'पत्र', meaning: 'कागज़ पर लिखा गया संदेश'),
      Flashcard(term: 'प्रेषक', meaning: 'पत्र भेजने वाला व्यक्ति'),
      Flashcard(term: 'प्राप्तकर्ता', meaning: 'पत्र पाने वाला व्यक्ति'),
      Flashcard(term: 'पता', meaning: 'घर या स्थान की जानकारी'),
      Flashcard(term: 'डाकघर', meaning: 'जहाँ से पत्र भेजे जाते हैं'),
    ],
    assessment: [
      AssessmentQuestion(
        question: 'पत्र भेजने वाले व्यक्ति को क्या कहते हैं?',
        options: ['प्रेषक', 'प्राप्तकर्ता', 'डाकिया', 'संपादक'],
        correctIndex: 0,
      ),
      AssessmentQuestion(
        question: 'पत्र कहाँ से भेजे और प्राप्त किए जाते हैं?',
        options: ['विद्यालय', 'डाकघर', 'अस्पताल', 'बाज़ार'],
        correctIndex: 1,
      ),
      AssessmentQuestion(
        question: 'पत्र में पता लिखना क्यों ज़रूरी है?',
        options: [
          'पत्र सुंदर दिखे',
          'पत्र सही जगह पहुँचे',
          'पत्र भारी हो',
          'कोई कारण नहीं',
        ],
        correctIndex: 1,
      ),
      AssessmentQuestion(
        question: 'पत्र ले जाने वाले व्यक्ति को क्या कहते हैं?',
        options: ['डाकिया', 'शिक्षक', 'चालक', 'किसान'],
        correctIndex: 0,
      ),
    ],
  ),
  'Class 3|English|My Dear One': ChapterContent(
    worksheet: [
      'Name three people you consider your \'dear ones\' in your family.',
      'Write two things you can do to show love to your family members.',
      'Why is it important to care for the people we love?',
      'Write one sentence using the phrase \'my dear one\'.',
    ],
    flashcards: [
      Flashcard(term: 'Dear', meaning: 'much loved; precious'),
      Flashcard(
        term: 'Affection',
        meaning: 'a gentle feeling of love or fondness',
      ),
      Flashcard(
        term: 'Family',
        meaning: 'a group of people related to each other',
      ),
      Flashcard(term: 'Care', meaning: 'to look after someone with love'),
      Flashcard(term: 'Bond', meaning: 'a close connection between people'),
    ],
    assessment: [
      AssessmentQuestion(
        question: 'The word \'dear\' means:',
        options: ['much loved', 'angry', 'far away', 'forgotten'],
        correctIndex: 0,
      ),
      AssessmentQuestion(
        question: 'Which of these is an example of showing affection?',
        options: [
          'shouting at someone',
          'hugging a family member',
          'ignoring someone',
          'breaking a toy',
        ],
        correctIndex: 1,
      ),
      AssessmentQuestion(
        question: 'A \'bond\' between people means:',
        options: [
          'a close connection',
          'a type of food',
          'a kind of shoe',
          'a loud noise',
        ],
        correctIndex: 0,
      ),
      AssessmentQuestion(
        question: 'Which word means \'to look after someone with love\'?',
        options: ['care', 'hurt', 'forget', 'scold'],
        correctIndex: 0,
      ),
    ],
  ),
  'Class 3|English|Hand Washing Day': ChapterContent(
    worksheet: [
      'Write four times when you should wash your hands.',
      'What do we use along with water to wash our hands properly?',
      'Why is washing hands important for good health?',
      'Describe the correct way to wash your hands, step by step.',
    ],
    flashcards: [
      Flashcard(
        term: 'Hygiene',
        meaning: 'keeping ourselves and our surroundings clean',
      ),
      Flashcard(
        term: 'Germs',
        meaning: 'tiny living things that can cause illness',
      ),
      Flashcard(
        term: 'Soap',
        meaning: 'a substance used with water to clean hands',
      ),
      Flashcard(
        term: 'Infection',
        meaning: 'illness caused by germs entering the body',
      ),
      Flashcard(
        term: 'Handwashing',
        meaning: 'cleaning hands with soap and water',
      ),
    ],
    assessment: [
      AssessmentQuestion(
        question: 'What should we use with water to wash hands properly?',
        options: ['oil', 'soap', 'sand', 'sugar'],
        correctIndex: 1,
      ),
      AssessmentQuestion(
        question: 'Washing hands helps to remove:',
        options: ['germs', 'hunger', 'sleep', 'sound'],
        correctIndex: 0,
      ),
      AssessmentQuestion(
        question: 'We should wash our hands:',
        options: [
          'only in the morning',
          'before eating and after using the toilet',
          'only once a week',
          'never',
        ],
        correctIndex: 1,
      ),
      AssessmentQuestion(
        question: 'Global Handwashing Day helps spread awareness about:',
        options: ['hygiene', 'sports', 'music', 'cooking'],
        correctIndex: 0,
      ),
    ],
  ),
  'Class 3|English|Old McDonald Had A Farm': ChapterContent(
    worksheet: [
      'Name three animals mentioned in the song \'Old McDonald Had A Farm\'.',
      'Write the sound a cow makes and the sound a duck makes.',
      'What is a farm, and who takes care of it?',
      'Write two other animals you would like to add to Old McDonald\'s farm.',
    ],
    flashcards: [
      Flashcard(
        term: 'Farm',
        meaning: 'land used for growing crops and keeping animals',
      ),
      Flashcard(term: 'Farmer', meaning: 'a person who works on a farm'),
      Flashcard(term: 'Moo', meaning: 'the sound made by a cow'),
      Flashcard(term: 'Cluck', meaning: 'the sound made by a hen'),
      Flashcard(term: 'Oink', meaning: 'the sound made by a pig'),
    ],
    assessment: [
      AssessmentQuestion(
        question: 'In the song, who owns the farm?',
        options: [
          'Old McDonald',
          'Old Mother Hubbard',
          'Jack',
          'Little Bo Peep',
        ],
        correctIndex: 0,
      ),
      AssessmentQuestion(
        question: 'What sound does a cow make in the song?',
        options: ['Moo', 'Oink', 'Baa', 'Quack'],
        correctIndex: 0,
      ),
      AssessmentQuestion(
        question: 'What sound does a duck make?',
        options: ['Moo', 'Quack', 'Cluck', 'Neigh'],
        correctIndex: 1,
      ),
      AssessmentQuestion(
        question: 'A person who works on a farm is called a:',
        options: ['doctor', 'farmer', 'teacher', 'driver'],
        correctIndex: 1,
      ),
    ],
  ),
  'Class 3|English|Androcles And The Lion': ChapterContent(
    worksheet: [
      'Why did the lion not hurt Androcles when they first met in the forest?',
      'What kind deed did Androcles do for the lion?',
      'How did the lion help Androcles later in the story?',
      'What lesson does this story teach us about kindness?',
    ],
    flashcards: [
      Flashcard(
        term: 'Slave',
        meaning:
            'a person who was forced to work without freedom, as in old times',
      ),
      Flashcard(term: 'Thorn', meaning: 'a sharp pointed part of a plant'),
      Flashcard(
        term: 'Gratitude',
        meaning: 'being thankful for someone\'s help',
      ),
      Flashcard(
        term: 'Arena',
        meaning: 'a place where fights or shows were held',
      ),
      Flashcard(
        term: 'Kindness',
        meaning: 'being gentle and helpful to others',
      ),
    ],
    assessment: [
      AssessmentQuestion(
        question: 'What was stuck in the lion\'s paw?',
        options: ['A stone', 'A thorn', 'A rope', 'A bone'],
        correctIndex: 1,
      ),
      AssessmentQuestion(
        question: 'Who removed the thorn from the lion\'s paw?',
        options: ['A hunter', 'Androcles', 'A soldier', 'A king'],
        correctIndex: 1,
      ),
      AssessmentQuestion(
        question:
            'What did the lion do when it met Androcles again in the arena?',
        options: [
          'It attacked him',
          'It did not hurt him',
          'It ran away',
          'It roared angrily',
        ],
        correctIndex: 1,
      ),
      AssessmentQuestion(
        question: 'The story of Androcles and the Lion teaches us that:',
        options: [
          'animals cannot feel gratitude',
          'kindness is remembered and repaid',
          'lions are always dangerous',
          'we should avoid forests',
        ],
        correctIndex: 1,
      ),
    ],
  ),
  'Class 3|English|My Teacher': ChapterContent(
    worksheet: [
      'Write three qualities of a good teacher.',
      'What does your teacher do to help you learn?',
      'Why should we respect our teachers?',
      'Write one sentence about your favourite subject taught by your teacher.',
    ],
    flashcards: [
      Flashcard(term: 'Teacher', meaning: 'a person who helps students learn'),
      Flashcard(
        term: 'Respect',
        meaning: 'treating someone with honour and regard',
      ),
      Flashcard(
        term: 'Knowledge',
        meaning: 'information and understanding gained through learning',
      ),
      Flashcard(term: 'Classroom', meaning: 'a room where students are taught'),
      Flashcard(term: 'Guide', meaning: 'a person who shows the right way'),
    ],
    assessment: [
      AssessmentQuestion(
        question: 'A teacher\'s main job is to:',
        options: [
          'help students learn',
          'cook food',
          'drive vehicles',
          'build houses',
        ],
        correctIndex: 0,
      ),
      AssessmentQuestion(
        question: 'Treating someone with honour is called:',
        options: ['anger', 'respect', 'fear', 'jealousy'],
        correctIndex: 1,
      ),
      AssessmentQuestion(
        question: 'Where do teachers usually teach students?',
        options: ['classroom', 'kitchen', 'garage', 'farm'],
        correctIndex: 0,
      ),
      AssessmentQuestion(
        question: 'Which word means \'a person who shows the right way\'?',
        options: ['guide', 'thief', 'stranger', 'patient'],
        correctIndex: 0,
      ),
    ],
  ),
  'Class 3|English|Who Will Mend My Shoe': ChapterContent(
    worksheet: [
      'Who is the person who repairs shoes called?',
      'Name two tools a cobbler might use.',
      'Why is it useful to repair things instead of throwing them away?',
      'Write one sentence about a time something of yours needed to be mended.',
    ],
    flashcards: [
      Flashcard(term: 'Mend', meaning: 'to repair or fix something broken'),
      Flashcard(term: 'Cobbler', meaning: 'a person who repairs shoes'),
      Flashcard(
        term: 'Needle',
        meaning: 'a thin pointed tool used for stitching',
      ),
      Flashcard(term: 'Thread', meaning: 'thin string used for sewing'),
      Flashcard(term: 'Repair', meaning: 'to fix something that is damaged'),
    ],
    assessment: [
      AssessmentQuestion(
        question: 'A person who repairs shoes is called a:',
        options: ['farmer', 'cobbler', 'teacher', 'driver'],
        correctIndex: 1,
      ),
      AssessmentQuestion(
        question: 'The word \'mend\' means:',
        options: ['to break', 'to repair', 'to buy', 'to sell'],
        correctIndex: 1,
      ),
      AssessmentQuestion(
        question: 'Which tool is used for stitching?',
        options: ['hammer', 'needle', 'spoon', 'brush'],
        correctIndex: 1,
      ),
      AssessmentQuestion(
        question: 'Repairing old things instead of throwing them away helps:',
        options: [
          'waste more money',
          'save resources',
          'harm the environment',
          'nothing',
        ],
        correctIndex: 1,
      ),
    ],
  ),
  'Class 3|English|Games For Fun': ChapterContent(
    worksheet: [
      'Name three outdoor games you like to play.',
      'Why is playing games important for children?',
      'Name one indoor game and one outdoor game.',
      'Write two rules you must follow while playing a game with friends.',
    ],
    flashcards: [
      Flashcard(
        term: 'Game',
        meaning: 'an activity played for fun, often with rules',
      ),
      Flashcard(term: 'Team', meaning: 'a group of people playing together'),
      Flashcard(term: 'Outdoor', meaning: 'happening in the open air'),
      Flashcard(term: 'Indoor', meaning: 'happening inside a building'),
      Flashcard(
        term: 'Rules',
        meaning: 'instructions that must be followed in a game',
      ),
    ],
    assessment: [
      AssessmentQuestion(
        question: 'Which of these is an outdoor game?',
        options: ['chess', 'football', 'carrom', 'puzzle'],
        correctIndex: 1,
      ),
      AssessmentQuestion(
        question: 'Playing games helps children to:',
        options: [
          'stay unhealthy',
          'stay fit and active',
          'waste time',
          'feel bored',
        ],
        correctIndex: 1,
      ),
      AssessmentQuestion(
        question: 'A group of people playing together is called a:',
        options: ['team', 'crowd', 'family', 'class'],
        correctIndex: 0,
      ),
      AssessmentQuestion(
        question: 'Games have rules so that:',
        options: [
          'everyone plays fairly',
          'no one can play',
          'only one person always wins',
          'players fight',
        ],
        correctIndex: 0,
      ),
    ],
  ),
  'Class 3|English|Dhoni My Hero': ChapterContent(
    worksheet: [
      'What sport did M.S. Dhoni play?',
      'Name one position Dhoni played on the cricket field, besides being a batsman.',
      'Name one major tournament that India won under Dhoni\'s captaincy.',
      'Why do you think Dhoni is considered a hero by many children?',
    ],
    flashcards: [
      Flashcard(
        term: 'Cricket',
        meaning: 'a bat and ball sport played between two teams',
      ),
      Flashcard(term: 'Captain', meaning: 'the leader of a sports team'),
      Flashcard(
        term: 'Wicketkeeper',
        meaning: 'a player who stands behind the stumps to catch the ball',
      ),
      Flashcard(
        term: 'Hero',
        meaning: 'a person admired for great qualities or achievements',
      ),
      Flashcard(term: 'Champion', meaning: 'a winner of a competition'),
    ],
    assessment: [
      AssessmentQuestion(
        question: 'M.S. Dhoni is famous for playing which sport?',
        options: ['football', 'cricket', 'hockey', 'badminton'],
        correctIndex: 1,
      ),
      AssessmentQuestion(
        question:
            'What role did Dhoni play in the Indian cricket team, besides being a batsman?',
        options: ['bowler', 'wicketkeeper', 'umpire', 'coach'],
        correctIndex: 1,
      ),
      AssessmentQuestion(
        question:
            'Under Dhoni\'s captaincy, India won the ICC T20 World Cup in which year?',
        options: ['2003', '2007', '2015', '2019'],
        correctIndex: 1,
      ),
      AssessmentQuestion(
        question:
            'Under Dhoni\'s captaincy, India also won the ICC ODI World Cup in:',
        options: ['2003', '2007', '2011', '2015'],
        correctIndex: 2,
      ),
    ],
  ),
  'Class 3|English|Holi': ChapterContent(
    worksheet: [
      'What is Holi known as, and which season does it celebrate?',
      'Name two things people use to play Holi.',
      'What does Holi celebrate about good and evil?',
      'Write two ways people greet each other on Holi.',
    ],
    flashcards: [
      Flashcard(term: 'Festival', meaning: 'a special day of celebration'),
      Flashcard(
        term: 'Colours',
        meaning:
            'different hues, like red, green, and yellow, used during Holi',
      ),
      Flashcard(term: 'Gulal', meaning: 'coloured powder used to play Holi'),
      Flashcard(
        term: 'Bonfire',
        meaning:
            'a large fire lit as part of Holi celebrations, called Holika Dahan',
      ),
      Flashcard(
        term: 'Spring',
        meaning: 'the season in which Holi is celebrated',
      ),
    ],
    assessment: [
      AssessmentQuestion(
        question: 'Holi is known as the festival of:',
        options: ['lights', 'colours', 'boats', 'kites'],
        correctIndex: 1,
      ),
      AssessmentQuestion(
        question: 'Holi is celebrated at the arrival of which season?',
        options: ['winter', 'spring', 'monsoon', 'autumn'],
        correctIndex: 1,
      ),
      AssessmentQuestion(
        question: 'The bonfire lit before Holi is called:',
        options: ['Diwali', 'Holika Dahan', 'Lohri', 'Baisakhi'],
        correctIndex: 1,
      ),
      AssessmentQuestion(
        question: 'Holi celebrates the victory of:',
        options: [
          'good over evil',
          'day over night',
          'summer over winter',
          'rich over poor',
        ],
        correctIndex: 0,
      ),
    ],
  ),
  'Class 3|English|Karma': ChapterContent(
    worksheet: [
      'Which tree is worshipped during the Karma (Karam) festival?',
      'In which region of India is the Karma festival especially popular?',
      'What does the Karma festival pray for?',
      'Name one way people celebrate the Karma festival, such as song, dance, or a tree branch.',
    ],
    flashcards: [
      Flashcard(
        term: 'Karma/Karam',
        meaning:
            'a harvest festival celebrated in Jharkhand and nearby tribal regions',
      ),
      Flashcard(
        term: 'Karam tree',
        meaning: 'the sacred tree worshipped during the Karma festival',
      ),
      Flashcard(
        term: 'Harvest',
        meaning: 'the gathering of crops that are ripe',
      ),
      Flashcard(term: 'Prosperity', meaning: 'success and good fortune'),
      Flashcard(
        term: 'Folk dance',
        meaning: 'traditional dance of a region or community',
      ),
    ],
    assessment: [
      AssessmentQuestion(
        question:
            'The Karma (Karam) festival is especially celebrated in which region?',
        options: [
          'Jharkhand and nearby tribal regions',
          'Kashmir',
          'Kerala coast',
          'Rajasthan desert only',
        ],
        correctIndex: 0,
      ),
      AssessmentQuestion(
        question: 'Which tree is worshipped during the Karma festival?',
        options: ['Mango tree', 'Karam tree', 'Coconut tree', 'Neem tree'],
        correctIndex: 1,
      ),
      AssessmentQuestion(
        question: 'The Karma festival is mainly celebrated to pray for:',
        options: [
          'rain and floods',
          'prosperity and a good harvest',
          'winter snow',
          'city development',
        ],
        correctIndex: 1,
      ),
      AssessmentQuestion(
        question: 'Karma festival celebrations often include:',
        options: [
          'folk songs and dance',
          'cricket matches',
          'boat racing',
          'mountain climbing',
        ],
        correctIndex: 0,
      ),
    ],
  ),
  'Class 3|English|Soldiers': ChapterContent(
    worksheet: [
      'What is the main duty of a soldier?',
      'Name two qualities a soldier should have.',
      'Why should we respect and thank soldiers?',
      'Write one sentence about how soldiers protect our country.',
    ],
    flashcards: [
      Flashcard(
        term: 'Soldier',
        meaning: 'a person who serves in the army to protect the country',
      ),
      Flashcard(
        term: 'Brave',
        meaning: 'showing courage in difficult situations',
      ),
      Flashcard(term: 'Border', meaning: 'the line dividing two countries'),
      Flashcard(term: 'Uniform', meaning: 'special clothing worn by soldiers'),
      Flashcard(
        term: 'Duty',
        meaning: 'a task or responsibility one must perform',
      ),
    ],
    assessment: [
      AssessmentQuestion(
        question: 'A soldier\'s main duty is to:',
        options: [
          'protect the country',
          'cook food',
          'teach students',
          'build roads',
        ],
        correctIndex: 0,
      ),
      AssessmentQuestion(
        question: 'Soldiers often guard the:',
        options: ['border', 'kitchen', 'playground', 'library'],
        correctIndex: 0,
      ),
      AssessmentQuestion(
        question: 'Showing courage in difficult situations is called being:',
        options: ['brave', 'lazy', 'shy', 'careless'],
        correctIndex: 0,
      ),
      AssessmentQuestion(
        question: 'Special clothing worn by soldiers is called a:',
        options: ['costume', 'uniform', 'blanket', 'curtain'],
        correctIndex: 1,
      ),
    ],
  ),
  'Class 3|English|Veer Budhu Bhagat': ChapterContent(
    worksheet: [
      'Who was Budhu Bhagat?',
      'During which period, roughly, did Budhu Bhagat lead his fight against British rule?',
      'Why is Budhu Bhagat remembered as a hero in Jharkhand\'s history?',
      'Why is it important to learn about freedom fighters like Budhu Bhagat?',
    ],
    flashcards: [
      Flashcard(term: 'Veer', meaning: 'a Hindi word meaning \'brave\''),
      Flashcard(
        term: 'Freedom fighter',
        meaning: 'a person who fought for their country\'s independence',
      ),
      Flashcard(
        term: 'Rebellion',
        meaning: 'an organised resistance against authority',
      ),
      Flashcard(
        term: 'Tribal',
        meaning: 'relating to a tribe or indigenous community',
      ),
      Flashcard(
        term: 'Chota Nagpur',
        meaning: 'a plateau region in present-day Jharkhand',
      ),
    ],
    assessment: [
      AssessmentQuestion(
        question: 'Budhu Bhagat is remembered in Indian history as a:',
        options: [
          'freedom fighter/rebel leader',
          'British officer',
          'poet',
          'king of a foreign land',
        ],
        correctIndex: 0,
      ),
      AssessmentQuestion(
        question: 'Budhu Bhagat led resistance against:',
        options: [
          'neighbouring villages',
          'British rule',
          'another tribe',
          'wild animals',
        ],
        correctIndex: 1,
      ),
      AssessmentQuestion(
        question:
            'Budhu Bhagat\'s uprising, known as the Kol uprising, took place in which region?',
        options: [
          'Chota Nagpur region',
          'Kashmir valley',
          'Coastal Tamil Nadu',
          'Western Rajasthan',
        ],
        correctIndex: 0,
      ),
      AssessmentQuestion(
        question: 'The title \'Veer\' given to Budhu Bhagat means:',
        options: ['brave', 'weak', 'foreign', 'unknown'],
        correctIndex: 0,
      ),
    ],
  ),
  'Class 3|English|We Are Indians': ChapterContent(
    worksheet: [
      'What is the capital of India?',
      'Name our national flag\'s three colours.',
      'What is our national anthem called?',
      'Name one thing that makes you proud to be an Indian.',
    ],
    flashcards: [
      Flashcard(
        term: 'Nation',
        meaning:
            'a large group of people united by a common land and government',
      ),
      Flashcard(
        term: 'National Flag',
        meaning: 'the Tiranga, or tricolour, representing India',
      ),
      Flashcard(
        term: 'National Anthem',
        meaning: '\'Jana Gana Mana\', India\'s official song of honour',
      ),
      Flashcard(term: 'Unity', meaning: 'coming together as one'),
      Flashcard(
        term: 'Diversity',
        meaning: 'having many different languages, cultures, and religions',
      ),
    ],
    assessment: [
      AssessmentQuestion(
        question: 'What is the capital of India?',
        options: ['Mumbai', 'New Delhi', 'Kolkata', 'Chennai'],
        correctIndex: 1,
      ),
      AssessmentQuestion(
        question: 'India\'s national flag is called the:',
        options: ['Tiranga', 'Union Jack', 'Star and Stripes', 'Maple Leaf'],
        correctIndex: 0,
      ),
      AssessmentQuestion(
        question: 'India\'s national anthem is:',
        options: [
          'Vande Mataram',
          'Jana Gana Mana',
          'Saare Jahan Se Achha',
          'Ae Mere Watan Ke Logo',
        ],
        correctIndex: 1,
      ),
      AssessmentQuestion(
        question: 'India is known for its:',
        options: [
          'single language and culture',
          'unity in diversity',
          'one religion only',
          'no festivals',
        ],
        correctIndex: 1,
      ),
    ],
  ),
  'Class 3|English|Our Country': ChapterContent(
    worksheet: [
      'Name any two neighbouring countries of India.',
      'What is the national animal of India?',
      'What is the national bird of India?',
      'Name one famous river of India.',
    ],
    flashcards: [
      Flashcard(
        term: 'Neighbouring country',
        meaning: 'a country that shares a border with another',
      ),
      Flashcard(
        term: 'National animal',
        meaning: 'the Tiger, the animal chosen to represent India',
      ),
      Flashcard(
        term: 'National bird',
        meaning: 'the Peacock, the bird chosen to represent India',
      ),
      Flashcard(term: 'River', meaning: 'a large flowing body of fresh water'),
      Flashcard(
        term: 'Continent',
        meaning: 'a large landmass; India is part of Asia',
      ),
    ],
    assessment: [
      AssessmentQuestion(
        question: 'What is the national animal of India?',
        options: ['Lion', 'Tiger', 'Elephant', 'Deer'],
        correctIndex: 1,
      ),
      AssessmentQuestion(
        question: 'What is the national bird of India?',
        options: ['Parrot', 'Peacock', 'Crow', 'Sparrow'],
        correctIndex: 1,
      ),
      AssessmentQuestion(
        question: 'Which of these countries shares a border with India?',
        options: ['Nepal', 'Australia', 'Japan', 'Brazil'],
        correctIndex: 0,
      ),
      AssessmentQuestion(
        question: 'Which continent is India located in?',
        options: ['Africa', 'Asia', 'Europe', 'Australia'],
        correctIndex: 1,
      ),
    ],
  ),
  'Class 3|English|Traffic Light': ChapterContent(
    worksheet: [
      'Name the three colours of a traffic light.',
      'What should we do when the traffic light is red?',
      'What does the green light mean?',
      'Why should we follow traffic rules?',
    ],
    flashcards: [
      Flashcard(
        term: 'Traffic light',
        meaning:
            'a signal with red, yellow, and green lights to control traffic',
      ),
      Flashcard(
        term: 'Signal',
        meaning: 'a sign that gives information or instruction',
      ),
      Flashcard(
        term: 'Pedestrian',
        meaning: 'a person walking, especially on a road or footpath',
      ),
      Flashcard(
        term: 'Zebra crossing',
        meaning: 'a marked path for pedestrians to cross the road',
      ),
      Flashcard(
        term: 'Traffic rules',
        meaning: 'laws that keep roads safe for everyone',
      ),
    ],
    assessment: [
      AssessmentQuestion(
        question: 'What does a red traffic light mean?',
        options: ['Go', 'Stop', 'Slow down', 'Turn'],
        correctIndex: 1,
      ),
      AssessmentQuestion(
        question: 'What does a green traffic light mean?',
        options: ['Stop', 'Wait', 'Go', 'Reverse'],
        correctIndex: 2,
      ),
      AssessmentQuestion(
        question: 'What does a yellow/amber traffic light mean?',
        options: [
          'Stop immediately',
          'Get ready/slow down',
          'Go faster',
          'Turn off the engine',
        ],
        correctIndex: 1,
      ),
      AssessmentQuestion(
        question: 'A person walking on the road is called a:',
        options: ['driver', 'pedestrian', 'passenger', 'conductor'],
        correctIndex: 1,
      ),
    ],
  ),
  'Class 3|Mathematics|रेखाओं से बनी आकृतियाँ': ChapterContent(
    worksheet: [
      'एक सीधी रेखा और एक वक्र रेखा में अंतर बताइए।',
      'त्रिभुज बनाने के लिए कम से कम कितनी सीधी रेखाओं की आवश्यकता होती है?',
      'वर्ग और आयत में क्या अंतर है?',
      'अपने आस-पास मिलने वाली दो वस्तुओं के नाम लिखिए जो त्रिभुज आकार की हों।',
    ],
    flashcards: [
      Flashcard(
        term: 'रेखा',
        meaning: 'दो बिंदुओं को जोड़ने वाला सीधा या टेढ़ा मार्ग',
      ),
      Flashcard(term: 'त्रिभुज', meaning: 'तीन भुजाओं वाली आकृति'),
      Flashcard(term: 'वर्ग', meaning: 'चार बराबर भुजाओं वाली आकृति'),
      Flashcard(
        term: 'आयत',
        meaning: 'चार भुजाओं वाली आकृति जिसमें विपरीत भुजाएँ बराबर होती हैं',
      ),
      Flashcard(term: 'कोण', meaning: 'दो रेखाओं के मिलने से बना स्थान'),
    ],
    assessment: [
      AssessmentQuestion(
        question: 'त्रिभुज में कितनी भुजाएँ होती हैं?',
        options: ['2', '3', '4', '5'],
        correctIndex: 1,
      ),
      AssessmentQuestion(
        question: 'वर्ग की सभी भुजाएँ कैसी होती हैं?',
        options: ['असमान', 'बराबर', 'टेढ़ी', 'गोल'],
        correctIndex: 1,
      ),
      AssessmentQuestion(
        question: 'आयत में विपरीत भुजाएँ कैसी होती हैं?',
        options: ['असमान', 'बराबर', 'टूटी हुई', 'गायब'],
        correctIndex: 1,
      ),
      AssessmentQuestion(
        question: 'दो बिंदुओं को मिलाने वाले मार्ग को क्या कहते हैं?',
        options: ['बिंदु', 'रेखा', 'कोण', 'वृत्त'],
        correctIndex: 1,
      ),
    ],
  ),
  'Class 3|Mathematics|मेला का दृश्य': ChapterContent(
    worksheet: [
      'मेले में आप कौन-सी पाँच चीज़ें देख सकते हैं? लिखिए।',
      'यदि मेले में 25 झूले हैं और उनमें से 10 झूले खराब हो जाएँ, तो कितने झूले ठीक बचेंगे?',
      'मेले की 3 दुकानों में से हर दुकान पर 4 गुब्बारे हैं, तो कुल कितने गुब्बारे हैं?',
      'मेले में जाने पर सुरक्षा के लिए किन बातों का ध्यान रखना चाहिए?',
    ],
    flashcards: [
      Flashcard(
        term: 'मेला',
        meaning: 'लोगों के इकट्ठा होने और मनोरंजन का आयोजन',
      ),
      Flashcard(term: 'झूला', meaning: 'बैठकर झूलने का यंत्र'),
      Flashcard(term: 'गिनती', meaning: 'वस्तुओं को क्रम में गिनना'),
      Flashcard(term: 'दुकान', meaning: 'सामान बेचने का स्थान'),
      Flashcard(term: 'भीड़', meaning: 'बहुत सारे लोगों का जमावड़ा'),
    ],
    assessment: [
      AssessmentQuestion(
        question:
            'यदि मेले में 25 झूले हैं और 10 खराब हो जाते हैं, तो ठीक झूलों की संख्या है',
        options: ['10', '15', '20', '35'],
        correctIndex: 1,
      ),
      AssessmentQuestion(
        question:
            'मेले की 3 दुकानों में से हर एक पर 4 गुब्बारे हैं। कुल गुब्बारे कितने हैं?',
        options: ['7', '10', '12', '14'],
        correctIndex: 2,
      ),
      AssessmentQuestion(
        question: 'मेले में लोगों के इकट्ठा होने की जगह को क्या कहते हैं?',
        options: ['विद्यालय', 'मेला मैदान', 'अस्पताल', 'पुस्तकालय'],
        correctIndex: 1,
      ),
      AssessmentQuestion(
        question: 'मेले में खोने से बचने के लिए बच्चों को क्या करना चाहिए?',
        options: [
          'अकेले घूमना',
          'बड़ों का हाथ पकड़कर रहना',
          'भाग जाना',
          'छिप जाना',
        ],
        correctIndex: 1,
      ),
    ],
  ),
  'Class 3|Mathematics|जोड़': ChapterContent(
    worksheet: [
      '347 + 256 का योग ज्ञात कीजिए।',
      'रीना के पास 125 गोलियाँ हैं और सोहन के पास 168 गोलियाँ हैं। दोनों के पास मिलाकर कुल कितनी गोलियाँ हैं?',
      '500 + 275 का योग ज्ञात कीजिए।',
      '1230 + 1450 का योग ज्ञात कीजिए।',
    ],
    flashcards: [
      Flashcard(term: 'जोड़', meaning: 'दो या दो से अधिक संख्याओं को मिलाना'),
      Flashcard(term: 'योग', meaning: 'जोड़ का परिणाम'),
      Flashcard(
        term: 'हासिल',
        meaning: 'जोड़ते समय अगले स्थान पर ले जाई जाने वाली संख्या',
      ),
      Flashcard(term: 'इकाई', meaning: 'संख्या का सबसे दायाँ अंक स्थान'),
      Flashcard(term: 'दहाई', meaning: 'इकाई के बाद वाला अंक स्थान'),
    ],
    assessment: [
      AssessmentQuestion(
        question: '347 + 256 = ?',
        options: ['593', '603', '613', '503'],
        correctIndex: 1,
      ),
      AssessmentQuestion(
        question: '125 + 168 = ?',
        options: ['283', '293', '303', '273'],
        correctIndex: 1,
      ),
      AssessmentQuestion(
        question: '500 + 275 = ?',
        options: ['765', '775', '785', '675'],
        correctIndex: 1,
      ),
      AssessmentQuestion(
        question: '1230 + 1450 = ?',
        options: ['2670', '2680', '2690', '2580'],
        correctIndex: 1,
      ),
    ],
  ),
  'Class 3|Mathematics|घटाव': ChapterContent(
    worksheet: [
      '875 - 342 का मान ज्ञात कीजिए।',
      'एक टोकरी में 450 सेब हैं। उसमें से 180 सेब बेच दिए गए। टोकरी में कितने सेब बचे?',
      '1000 - 456 का मान ज्ञात कीजिए।',
      '723 - 289 का मान ज्ञात कीजिए।',
    ],
    flashcards: [
      Flashcard(
        term: 'घटाव',
        meaning: 'एक संख्या में से दूसरी संख्या को घटाना',
      ),
      Flashcard(term: 'शेष', meaning: 'घटाव का परिणाम'),
      Flashcard(term: 'उधार', meaning: 'घटाते समय पड़ोसी अंक से लेना'),
      Flashcard(term: 'बड़ी संख्या', meaning: 'जिसमें से घटाया जाता है'),
      Flashcard(term: 'छोटी संख्या', meaning: 'जो घटाई जाती है'),
    ],
    assessment: [
      AssessmentQuestion(
        question: '875 - 342 = ?',
        options: ['523', '533', '543', '513'],
        correctIndex: 1,
      ),
      AssessmentQuestion(
        question:
            'एक टोकरी में 450 सेब हैं, 180 सेब बेच दिए गए। कितने सेब बचे?',
        options: ['260', '270', '280', '250'],
        correctIndex: 1,
      ),
      AssessmentQuestion(
        question: '1000 - 456 = ?',
        options: ['534', '544', '554', '464'],
        correctIndex: 1,
      ),
      AssessmentQuestion(
        question: '723 - 289 = ?',
        options: ['424', '434', '444', '414'],
        correctIndex: 1,
      ),
    ],
  ),
  'Class 3|Mathematics|गुणा': ChapterContent(
    worksheet: [
      '6 × 7 का गुणनफल ज्ञात कीजिए।',
      'एक डिब्बे में 8 पेंसिलें हैं। ऐसे 5 डिब्बों में कुल कितनी पेंसिलें होंगी?',
      '9 × 8 का गुणनफल ज्ञात कीजिए।',
      '12 × 4 का गुणनफल ज्ञात कीजिए।',
    ],
    flashcards: [
      Flashcard(
        term: 'गुणा',
        meaning: 'किसी संख्या को बार-बार जोड़ने की प्रक्रिया',
      ),
      Flashcard(term: 'गुणनफल', meaning: 'गुणा का परिणाम'),
      Flashcard(term: 'गुणक', meaning: 'जिस संख्या से गुणा किया जाता है'),
      Flashcard(term: 'पहाड़ा', meaning: 'किसी संख्या की गुणन तालिका'),
      Flashcard(term: 'गुण्य', meaning: 'जिस संख्या को गुणा किया जाता है'),
    ],
    assessment: [
      AssessmentQuestion(
        question: '6 × 7 = ?',
        options: ['36', '42', '48', '40'],
        correctIndex: 1,
      ),
      AssessmentQuestion(
        question:
            'एक डिब्बे में 8 पेंसिलें हैं। 5 डिब्बों में कुल पेंसिलें कितनी होंगी?',
        options: ['35', '40', '45', '13'],
        correctIndex: 1,
      ),
      AssessmentQuestion(
        question: '9 × 8 = ?',
        options: ['63', '70', '72', '81'],
        correctIndex: 2,
      ),
      AssessmentQuestion(
        question: '12 × 4 = ?',
        options: ['44', '46', '48', '52'],
        correctIndex: 2,
      ),
    ],
  ),
  'Class 3|Mathematics|भाग': ChapterContent(
    worksheet: [
      '36 ÷ 6 का भागफल ज्ञात कीजिए।',
      '24 चॉकलेटों को 4 बच्चों में बराबर बाँटा जाए तो प्रत्येक बच्चे को कितनी चॉकलेट मिलेंगी?',
      '45 ÷ 9 का भागफल ज्ञात कीजिए।',
      '63 ÷ 7 का भागफल ज्ञात कीजिए।',
    ],
    flashcards: [
      Flashcard(term: 'भाग', meaning: 'किसी संख्या को बराबर भागों में बाँटना'),
      Flashcard(term: 'भागफल', meaning: 'भाग का परिणाम'),
      Flashcard(term: 'भाज्य', meaning: 'जिस संख्या को भाग दिया जाता है'),
      Flashcard(term: 'भाजक', meaning: 'जिससे भाग दिया जाता है'),
      Flashcard(term: 'शेषफल', meaning: 'भाग के बाद बची हुई संख्या'),
    ],
    assessment: [
      AssessmentQuestion(
        question: '36 ÷ 6 = ?',
        options: ['5', '6', '7', '8'],
        correctIndex: 1,
      ),
      AssessmentQuestion(
        question:
            '24 चॉकलेटों को 4 बच्चों में बराबर बाँटें, तो हर बच्चे को कितनी मिलेंगी?',
        options: ['4', '5', '6', '8'],
        correctIndex: 2,
      ),
      AssessmentQuestion(
        question: '45 ÷ 9 = ?',
        options: ['4', '5', '6', '9'],
        correctIndex: 1,
      ),
      AssessmentQuestion(
        question: '63 ÷ 7 = ?',
        options: ['7', '8', '9', '10'],
        correctIndex: 2,
      ),
    ],
  ),
  'Class 3|Mathematics|मुद्रा': ChapterContent(
    worksheet: [
      '1 रुपये में कितने पैसे होते हैं?',
      'यदि आपके पास ₹50 का एक नोट है और आप ₹35 की वस्तु खरीदते हैं, तो आपको कितने रुपये वापस मिलेंगे?',
      '₹20 के 3 नोट मिलाकर कुल कितने रुपये होंगे?',
      '₹10, ₹5 और ₹2 के सिक्कों को जोड़ने पर कुल कितने रुपये होंगे?',
    ],
    flashcards: [
      Flashcard(
        term: 'मुद्रा',
        meaning: 'लेन-देन के लिए उपयोग होने वाला धन (नोट और सिक्के)',
      ),
      Flashcard(term: 'नोट', meaning: 'कागज़ की मुद्रा'),
      Flashcard(term: 'सिक्का', meaning: 'धातु की मुद्रा'),
      Flashcard(term: 'खुदरा', meaning: 'अधिक भुगतान पर वापस मिलने वाली राशि'),
      Flashcard(term: 'कीमत', meaning: 'किसी वस्तु का मूल्य'),
    ],
    assessment: [
      AssessmentQuestion(
        question: '1 रुपये में कितने पैसे होते हैं?',
        options: ['10', '50', '100', '1000'],
        correctIndex: 2,
      ),
      AssessmentQuestion(
        question:
            '₹50 का नोट देकर ₹35 की वस्तु खरीदने पर कितने रुपये वापस मिलेंगे?',
        options: ['₹5', '₹10', '₹15', '₹20'],
        correctIndex: 2,
      ),
      AssessmentQuestion(
        question: '₹20 के 3 नोट मिलाकर कुल कितने रुपये होंगे?',
        options: ['₹40', '₹50', '₹60', '₹23'],
        correctIndex: 2,
      ),
      AssessmentQuestion(
        question: '₹10, ₹5 और ₹2 के सिक्कों को जोड़ने पर कुल राशि होगी',
        options: ['₹15', '₹16', '₹17', '₹18'],
        correctIndex: 2,
      ),
    ],
  ),
  'Class 3|Mathematics|मापन': ChapterContent(
    worksheet: [
      'लंबाई मापने की मूल इकाई क्या है?',
      '1 मीटर में कितने सेंटीमीटर होते हैं?',
      'यदि एक रस्सी की लंबाई 2 मीटर है, तो वह कितने सेंटीमीटर के बराबर है?',
      'वजन मापने के लिए किस यंत्र का उपयोग किया जाता है?',
    ],
    flashcards: [
      Flashcard(
        term: 'मापन',
        meaning: 'किसी वस्तु की लंबाई, वजन या क्षमता जानना',
      ),
      Flashcard(term: 'मीटर', meaning: 'लंबाई मापने की इकाई'),
      Flashcard(term: 'किलोग्राम', meaning: 'वजन मापने की इकाई'),
      Flashcard(term: 'लीटर', meaning: 'तरल पदार्थ मापने की इकाई'),
      Flashcard(term: 'तराज़ू', meaning: 'वजन मापने का यंत्र'),
    ],
    assessment: [
      AssessmentQuestion(
        question: '1 मीटर में कितने सेंटीमीटर होते हैं?',
        options: ['10', '100', '1000', '50'],
        correctIndex: 1,
      ),
      AssessmentQuestion(
        question: 'वजन मापने के लिए किस इकाई का उपयोग होता है?',
        options: ['मीटर', 'लीटर', 'किलोग्राम', 'सेकंड'],
        correctIndex: 2,
      ),
      AssessmentQuestion(
        question: 'तरल पदार्थ मापने की इकाई है',
        options: ['मीटर', 'लीटर', 'किलोग्राम', 'सेंटीमीटर'],
        correctIndex: 1,
      ),
      AssessmentQuestion(
        question: '2 मीटर लंबी रस्सी कितने सेंटीमीटर के बराबर है?',
        options: ['20', '100', '200', '2000'],
        correctIndex: 2,
      ),
    ],
  ),
  'Class 3|Mathematics|पैटर्न': ChapterContent(
    worksheet: [
      'यह पैटर्न पूरा कीजिए: 2, 4, 6, 8, __, __',
      'यह पैटर्न पूरा कीजिए: 5, 10, 15, __, 25',
      'वृत्त, वर्ग, वृत्त, वर्ग, __ - अगली आकृति क्या होगी?',
      'संख्या पैटर्न 3, 6, 9, 12, __ में अगली संख्या क्या होगी?',
    ],
    flashcards: [
      Flashcard(
        term: 'पैटर्न',
        meaning: 'एक निश्चित क्रम में दोहराई जाने वाली व्यवस्था',
      ),
      Flashcard(term: 'क्रम', meaning: 'वस्तुओं या संख्याओं का सिलसिला'),
      Flashcard(term: 'दोहराव', meaning: 'बार-बार होने वाली क्रिया'),
      Flashcard(term: 'बढ़ता क्रम', meaning: 'छोटी से बड़ी संख्या की ओर बढ़ना'),
      Flashcard(
        term: 'आकृति पैटर्न',
        meaning: 'आकारों की दोहराई जाने वाली व्यवस्था',
      ),
    ],
    assessment: [
      AssessmentQuestion(
        question: 'पैटर्न 2, 4, 6, 8, __ में अगली संख्या क्या होगी?',
        options: ['9', '10', '11', '12'],
        correctIndex: 1,
      ),
      AssessmentQuestion(
        question: 'पैटर्न 5, 10, 15, __, 25 में खाली स्थान पर क्या आएगा?',
        options: ['18', '20', '22', '24'],
        correctIndex: 1,
      ),
      AssessmentQuestion(
        question:
            'पैटर्न वृत्त, वर्ग, वृत्त, वर्ग, __ में अगली आकृति क्या होगी?',
        options: ['त्रिभुज', 'वृत्त', 'आयत', 'रेखा'],
        correctIndex: 1,
      ),
      AssessmentQuestion(
        question: 'पैटर्न 3, 6, 9, 12, __ में अगली संख्या है',
        options: ['13', '14', '15', '16'],
        correctIndex: 2,
      ),
    ],
  ),
  'Class 3|Environmental Studies|हमारे अपने': ChapterContent(
    worksheet: [
      'आपके परिवार में कौन-कौन सदस्य हैं? नाम लिखिए।',
      'दादा-दादी और नाना-नानी में क्या अंतर है?',
      'परिवार के सदस्यों की मदद करना क्यों ज़रूरी है?',
      'अपने किसी प्रिय रिश्तेदार का नाम और उनसे रिश्ता लिखिए।',
    ],
    flashcards: [
      Flashcard(term: 'परिवार', meaning: 'माता-पिता और बच्चों का समूह'),
      Flashcard(term: 'रिश्तेदार', meaning: 'परिवार से जुड़े लोग'),
      Flashcard(term: 'दादा-दादी', meaning: 'पिता के माता-पिता'),
      Flashcard(term: 'नाना-नानी', meaning: 'माता के माता-पिता'),
      Flashcard(
        term: 'संयुक्त परिवार',
        meaning: 'एक साथ रहने वाला बड़ा परिवार',
      ),
    ],
    assessment: [
      AssessmentQuestion(
        question: 'पिता के पिता को क्या कहते हैं?',
        options: ['नाना', 'दादा', 'मामा', 'चाचा'],
        correctIndex: 1,
      ),
      AssessmentQuestion(
        question: 'माता की माता को क्या कहते हैं?',
        options: ['दादी', 'नानी', 'बुआ', 'मौसी'],
        correctIndex: 1,
      ),
      AssessmentQuestion(
        question: 'एक साथ रहने वाले बड़े परिवार को क्या कहते हैं?',
        options: ['एकल परिवार', 'संयुक्त परिवार', 'पड़ोसी', 'मित्र'],
        correctIndex: 1,
      ),
      AssessmentQuestion(
        question: 'परिवार के सदस्यों की मदद करना कैसा व्यवहार है?',
        options: ['गलत', 'अच्छा', 'बेकार', 'हानिकारक'],
        correctIndex: 1,
      ),
    ],
  ),
  'Class 3|Environmental Studies|हरी भरी दुनिया': ChapterContent(
    worksheet: [
      'पौधों को बढ़ने के लिए किन-किन चीज़ों की आवश्यकता होती है?',
      'हमारे आस-पास हरियाली क्यों ज़रूरी है?',
      'पेड़-पौधे लगाने के दो तरीके लिखिए।',
      'वन (जंगल) से हमें क्या-क्या लाभ मिलते हैं?',
    ],
    flashcards: [
      Flashcard(term: 'हरियाली', meaning: 'पेड़-पौधों से भरा वातावरण'),
      Flashcard(term: 'वन', meaning: 'बहुत सारे पेड़ों वाला क्षेत्र'),
      Flashcard(term: 'पौधा', meaning: 'छोटा वृक्ष'),
      Flashcard(term: 'मिट्टी', meaning: 'पौधों के उगने का आधार'),
      Flashcard(
        term: 'प्रकाश संश्लेषण',
        meaning: 'पौधों द्वारा भोजन बनाने की प्रक्रिया',
      ),
    ],
    assessment: [
      AssessmentQuestion(
        question: 'पौधों को बढ़ने के लिए किसकी आवश्यकता होती है?',
        options: [
          'पानी, धूप और मिट्टी',
          'केवल पत्थर',
          'बिना पानी के हवा',
          'अंधेरा',
        ],
        correctIndex: 0,
      ),
      AssessmentQuestion(
        question: 'बहुत सारे पेड़ों वाले क्षेत्र को क्या कहते हैं?',
        options: ['रेगिस्तान', 'वन', 'समुद्र', 'पहाड़'],
        correctIndex: 1,
      ),
      AssessmentQuestion(
        question: 'पौधे अपना भोजन किसकी सहायता से बनाते हैं?',
        options: ['सूर्य के प्रकाश', 'चाँदनी', 'बर्फ', 'धुएँ'],
        correctIndex: 0,
      ),
      AssessmentQuestion(
        question: 'हरियाली बनाए रखने के लिए हमें क्या करना चाहिए?',
        options: ['पेड़ काटना', 'पेड़ लगाना', 'जंगल जलाना', 'मिट्टी हटाना'],
        correctIndex: 1,
      ),
    ],
  ),
  'Class 3|Environmental Studies|देखे अनदेखे जानवर': ChapterContent(
    worksheet: [
      'आपने अपने आस-पास कौन-से जानवर देखे हैं? तीन नाम लिखिए।',
      'कोई एक ऐसा जानवर लिखिए जिसे आपने केवल किताब या चित्र में देखा हो।',
      'जंगली जानवर और पालतू जानवर में क्या अंतर है?',
      'जानवरों की रक्षा करना क्यों ज़रूरी है?',
    ],
    flashcards: [
      Flashcard(term: 'पालतू जानवर', meaning: 'घर में पाले जाने वाले जानवर'),
      Flashcard(term: 'जंगली जानवर', meaning: 'जंगल में रहने वाले जानवर'),
      Flashcard(
        term: 'चिड़ियाघर',
        meaning: 'जहाँ विभिन्न जानवरों को देखा जा सकता है',
      ),
      Flashcard(term: 'वन्यजीव', meaning: 'जंगल में रहने वाले जीव'),
      Flashcard(term: 'संरक्षण', meaning: 'सुरक्षा और देखभाल करना'),
    ],
    assessment: [
      AssessmentQuestion(
        question: 'घर में पाले जाने वाले जानवर कहलाते हैं',
        options: ['जंगली जानवर', 'पालतू जानवर', 'वन्यजीव', 'समुद्री जीव'],
        correctIndex: 1,
      ),
      AssessmentQuestion(
        question: 'शेर और बाघ कैसे जानवर हैं?',
        options: ['पालतू', 'जंगली', 'पानी में रहने वाले', 'उड़ने वाले'],
        correctIndex: 1,
      ),
      AssessmentQuestion(
        question: 'विभिन्न जानवरों को देखने के लिए हम कहाँ जा सकते हैं?',
        options: ['विद्यालय', 'चिड़ियाघर', 'अस्पताल', 'डाकघर'],
        correctIndex: 1,
      ),
      AssessmentQuestion(
        question: 'जानवरों की सुरक्षा करने को क्या कहते हैं?',
        options: ['शिकार', 'संरक्षण', 'व्यापार', 'निर्माण'],
        correctIndex: 1,
      ),
    ],
  ),
  'Class 3|Environmental Studies|आओ काम करें हम भैया': ChapterContent(
    worksheet: [
      'घर के कामों में आप अपने माता-पिता की किस प्रकार मदद कर सकते हैं?',
      'मिलकर काम करने के दो लाभ लिखिए।',
      'विद्यालय में सामूहिक रूप से किए जाने वाले किसी कार्य का नाम लिखिए।',
      'आलस्य से क्या नुकसान होते हैं?',
    ],
    flashcards: [
      Flashcard(term: 'परिश्रम', meaning: 'मेहनत करना'),
      Flashcard(term: 'सहयोग', meaning: 'मिलकर काम करना'),
      Flashcard(term: 'ज़िम्मेदारी', meaning: 'अपना कर्तव्य निभाना'),
      Flashcard(term: 'आलस्य', meaning: 'काम करने से बचना'),
      Flashcard(term: 'टीम वर्क', meaning: 'समूह में मिलकर काम करना'),
    ],
    assessment: [
      AssessmentQuestion(
        question: 'मिलकर काम करने को क्या कहते हैं?',
        options: ['आलस्य', 'सहयोग', 'झगड़ा', 'चोरी'],
        correctIndex: 1,
      ),
      AssessmentQuestion(
        question: 'मेहनत करने को क्या कहा जाता है?',
        options: ['परिश्रम', 'आराम', 'नींद', 'खेल'],
        correctIndex: 0,
      ),
      AssessmentQuestion(
        question: 'काम से बचने की आदत को क्या कहते हैं?',
        options: ['परिश्रम', 'आलस्य', 'ईमानदारी', 'सहयोग'],
        correctIndex: 1,
      ),
      AssessmentQuestion(
        question: 'अपने कर्तव्य को निभाना क्या कहलाता है?',
        options: ['ज़िम्मेदारी', 'लापरवाही', 'झूठ', 'चोरी'],
        correctIndex: 0,
      ),
    ],
  ),
  'Class 3|Environmental Studies|चूं चूं करती आई चिड़िया': ChapterContent(
    worksheet: [
      'चिड़िया की आवाज़ को क्या कहते हैं?',
      'चिड़िया दाना कहाँ से चुगती है?',
      'सुबह-सुबह चिड़ियों की चहचहाहट सुनना क्यों अच्छा लगता है?',
      'चिड़ियों के लिए हम पानी और दाना कहाँ रख सकते हैं?',
    ],
    flashcards: [
      Flashcard(term: 'चहचहाना', meaning: 'पक्षियों की मीठी आवाज़ निकालना'),
      Flashcard(term: 'चुगना', meaning: 'चोंच से दाना खाना'),
      Flashcard(term: 'सुबह', meaning: 'दिन का पहला भाग'),
      Flashcard(term: 'घोंसला', meaning: 'पक्षी का घर'),
      Flashcard(term: 'पर्यावरण', meaning: 'हमारे चारों ओर का वातावरण'),
    ],
    assessment: [
      AssessmentQuestion(
        question: 'पक्षियों की मीठी आवाज़ को क्या कहते हैं?',
        options: ['दहाड़ना', 'चहचहाना', 'गुर्राना', 'भौंकना'],
        correctIndex: 1,
      ),
      AssessmentQuestion(
        question: 'चिड़िया दाना किससे खाती है?',
        options: ['पंख से', 'चोंच से', 'पूँछ से', 'पंजे से'],
        correctIndex: 1,
      ),
      AssessmentQuestion(
        question: 'दिन के पहले भाग को क्या कहते हैं?',
        options: ['रात', 'सुबह', 'शाम', 'दोपहर'],
        correctIndex: 1,
      ),
      AssessmentQuestion(
        question: 'गर्मी में चिड़ियों के लिए घर की छत पर क्या रखना चाहिए?',
        options: ['पानी और दाना', 'पत्थर', 'कपड़े', 'किताबें'],
        correctIndex: 0,
      ),
    ],
  ),
  'Class 3|Environmental Studies|मेरा खेल': ChapterContent(
    worksheet: [
      'आपको कौन-सा खेल सबसे अधिक पसंद है और क्यों?',
      'खेल खेलने से हमारे शरीर को क्या लाभ होता है?',
      'एक ऐसे खेल का नाम लिखिए जो मैदान में खेला जाता है।',
      'खेल खेलते समय हमें किन नियमों का पालन करना चाहिए?',
    ],
    flashcards: [
      Flashcard(
        term: 'खेल',
        meaning: 'मनोरंजन और व्यायाम के लिए की जाने वाली गतिविधि',
      ),
      Flashcard(term: 'मैदान', meaning: 'खुला स्थान जहाँ खेल खेले जाते हैं'),
      Flashcard(
        term: 'नियम',
        meaning: 'खेल के दौरान पालन किए जाने वाले निर्देश',
      ),
      Flashcard(term: 'टीम', meaning: 'मिलकर खेलने वाला समूह'),
      Flashcard(term: 'व्यायाम', meaning: 'शरीर को स्वस्थ रखने वाली क्रिया'),
    ],
    assessment: [
      AssessmentQuestion(
        question: 'खेल खेलने से शरीर कैसा रहता है?',
        options: ['कमजोर', 'स्वस्थ और फुर्तीला', 'आलसी', 'बीमार'],
        correctIndex: 1,
      ),
      AssessmentQuestion(
        question: 'खुले स्थान जहाँ खेल खेले जाते हैं, उसे क्या कहते हैं?',
        options: ['कक्षा', 'मैदान', 'रसोई', 'पुस्तकालय'],
        correctIndex: 1,
      ),
      AssessmentQuestion(
        question: 'खेल के दौरान पालन किए जाने वाले निर्देशों को क्या कहते हैं?',
        options: ['नियम', 'गीत', 'कहानी', 'चित्र'],
        correctIndex: 0,
      ),
      AssessmentQuestion(
        question: 'मिलकर खेलने वाले समूह को क्या कहते हैं?',
        options: ['परिवार', 'टीम', 'कक्षा', 'दुकान'],
        correctIndex: 1,
      ),
    ],
  ),
  'Class 3|Environmental Studies|खाना पकाना': ChapterContent(
    worksheet: [
      'भोजन पकाने के लिए किन-किन चीज़ों (बर्तन/साधन) की आवश्यकता होती है?',
      'खाना बनाते समय हमें सुरक्षा से जुड़ी किन बातों का ध्यान रखना चाहिए?',
      'आपके घर में खाना कौन पकाता है?',
      'दो ऐसे भोजन के नाम लिखिए जो बिना पकाए खाए जा सकते हैं।',
    ],
    flashcards: [
      Flashcard(term: 'रसोई', meaning: 'खाना पकाने का स्थान'),
      Flashcard(term: 'बर्तन', meaning: 'खाना पकाने और खाने के उपकरण'),
      Flashcard(term: 'चूल्हा', meaning: 'खाना पकाने का साधन'),
      Flashcard(
        term: 'सामग्री',
        meaning: 'खाना बनाने में उपयोग होने वाली चीज़ें',
      ),
      Flashcard(term: 'सावधानी', meaning: 'सुरक्षा का ध्यान रखना'),
    ],
    assessment: [
      AssessmentQuestion(
        question: 'खाना पकाने का स्थान क्या कहलाता है?',
        options: ['बैठक', 'रसोई', 'शयनकक्ष', 'बरामदा'],
        correctIndex: 1,
      ),
      AssessmentQuestion(
        question: 'खाना पकाने के लिए किस साधन का उपयोग होता है?',
        options: ['गैस स्टोव/चूल्हा', 'पंखा', 'टीवी', 'कुर्सी'],
        correctIndex: 0,
      ),
      AssessmentQuestion(
        question: 'गर्म बर्तन छूते समय हमें क्या सावधानी रखनी चाहिए?',
        options: [
          'बिना सोचे छूना',
          'कपड़े/दस्ताने का उपयोग करना',
          'तेज़ भागना',
          'कुछ नहीं',
        ],
        correctIndex: 1,
      ),
      AssessmentQuestion(
        question: 'निम्न में से कौन-सा भोजन बिना पकाए खाया जा सकता है?',
        options: ['कच्चा चावल', 'फल', 'कच्चा आटा', 'कच्ची दाल'],
        correctIndex: 1,
      ),
    ],
  ),
  'Class 3|Environmental Studies|पसंद अपनी अपनी': ChapterContent(
    worksheet: [
      'आपका पसंदीदा भोजन कौन-सा है?',
      'आपका पसंदीदा रंग कौन-सा है?',
      'क्या सभी लोगों की पसंद एक जैसी होती है? अपने शब्दों में लिखिए।',
      'दूसरों की पसंद का सम्मान करना क्यों ज़रूरी है?',
    ],
    flashcards: [
      Flashcard(term: 'पसंद', meaning: 'किसी चीज़ को अच्छा मानना'),
      Flashcard(term: 'नापसंद', meaning: 'किसी चीज़ को अच्छा न मानना'),
      Flashcard(term: 'विविधता', meaning: 'अलग-अलग तरह की चीज़ें या विचार'),
      Flashcard(term: 'सम्मान', meaning: 'किसी की भावना या राय का आदर करना'),
      Flashcard(term: 'रुचि', meaning: 'किसी काम या चीज़ में मन लगना'),
    ],
    assessment: [
      AssessmentQuestion(
        question: '\'पसंद\' शब्द का विपरीत शब्द क्या है?',
        options: ['नापसंद', 'अच्छा', 'सुंदर', 'रुचि'],
        correctIndex: 0,
      ),
      AssessmentQuestion(
        question: 'अलग-अलग लोगों की पसंद...',
        options: [
          'हमेशा एक जैसी होती है',
          'अलग-अलग हो सकती है',
          'कभी नहीं बदलती',
          'गलत होती है',
        ],
        correctIndex: 1,
      ),
      AssessmentQuestion(
        question: 'दूसरों की पसंद का आदर करना क्या दर्शाता है?',
        options: ['असम्मान', 'सम्मान', 'गुस्सा', 'ईर्ष्या'],
        correctIndex: 1,
      ),
      AssessmentQuestion(
        question: 'किसी काम में मन लगने को क्या कहते हैं?',
        options: ['रुचि', 'थकान', 'डर', 'दुख'],
        correctIndex: 0,
      ),
    ],
  ),
  'Class 3|Environmental Studies|कच्चा पक्का': ChapterContent(
    worksheet: [
      '\'कच्चा\' और \'पक्का\' शब्दों का अर्थ अपने शब्दों में लिखिए।',
      'एक कच्चे फल और एक पके फल का नाम लिखिए।',
      'कच्ची सड़क और पक्की सड़क में क्या अंतर होता है?',
      'भोजन को कच्चा खाना ठीक है या पकाकर खाना? कारण सहित लिखिए।',
    ],
    flashcards: [
      Flashcard(term: 'कच्चा', meaning: 'अधूरा, बिना पका हुआ या अस्थायी'),
      Flashcard(
        term: 'पक्का',
        meaning: 'पूर्ण रूप से तैयार, पका हुआ या स्थायी',
      ),
      Flashcard(term: 'फल', meaning: 'पेड़ पर उगने वाला खाने योग्य भाग'),
      Flashcard(term: 'सड़क', meaning: 'आने-जाने का मार्ग'),
      Flashcard(term: 'स्थायी', meaning: 'लंबे समय तक टिकने वाला'),
    ],
    assessment: [
      AssessmentQuestion(
        question: 'जो फल पूरी तरह पका हुआ है, उसे क्या कहते हैं?',
        options: ['कच्चा फल', 'पका (पक्का) फल', 'सड़ा फल', 'कटा फल'],
        correctIndex: 1,
      ),
      AssessmentQuestion(
        question:
            'जो सड़क सीमेंट/डामर से बनी और स्थायी होती है, उसे क्या कहते हैं?',
        options: ['कच्ची सड़क', 'पक्की सड़क', 'टूटी सड़क', 'अस्थायी सड़क'],
        correctIndex: 1,
      ),
      AssessmentQuestion(
        question: 'मिट्टी से बना अस्थायी मकान क्या कहलाता है?',
        options: ['पक्का मकान', 'कच्चा मकान', 'बड़ा मकान', 'नया मकान'],
        correctIndex: 1,
      ),
      AssessmentQuestion(
        question: 'भोजन को खाने से पहले सामान्यतः क्या करना चाहिए?',
        options: ['कच्चा ही खा लेना', 'ठीक से पकाना', 'फेंक देना', 'सुखा देना'],
        correctIndex: 1,
      ),
    ],
  ),
  'Class 3|Environmental Studies|कैसे कैसे घर': ChapterContent(
    worksheet: [
      'घर बनाने में उपयोग होने वाली किन्हीं दो सामग्रियों के नाम लिखिए।',
      'कच्चे घर और पक्के घर में क्या अंतर है?',
      'आपका घर किस प्रकार का है?',
      'लोग अलग-अलग जगहों पर अलग-अलग प्रकार के घर क्यों बनाते हैं?',
    ],
    flashcards: [
      Flashcard(term: 'मकान', meaning: 'रहने का स्थान'),
      Flashcard(term: 'ईंट', meaning: 'घर बनाने में उपयोग होने वाली सामग्री'),
      Flashcard(term: 'छत', meaning: 'घर का ऊपरी हिस्सा'),
      Flashcard(term: 'झोपड़ी', meaning: 'घास-फूस से बना छोटा घर'),
      Flashcard(term: 'फ्लैट', meaning: 'बहुमंज़िला इमारत में एक इकाई'),
    ],
    assessment: [
      AssessmentQuestion(
        question: 'घर बनाने में मुख्यतः किसका उपयोग होता है?',
        options: ['ईंट और सीमेंट', 'कागज़', 'कपड़ा', 'बर्फ'],
        correctIndex: 0,
      ),
      AssessmentQuestion(
        question: 'घास-फूस से बने छोटे घर को क्या कहते हैं?',
        options: ['महल', 'झोपड़ी', 'फ्लैट', 'किला'],
        correctIndex: 1,
      ),
      AssessmentQuestion(
        question: 'घर के सबसे ऊपरी भाग को क्या कहते हैं?',
        options: ['नींव', 'छत', 'दीवार', 'दरवाज़ा'],
        correctIndex: 1,
      ),
      AssessmentQuestion(
        question:
            'ठंडे पहाड़ी क्षेत्रों में लोग प्रायः किस प्रकार के घर बनाते हैं ताकि गर्मी बनी रहे?',
        options: [
          'लकड़ी और ढलवाँ छत वाले घर',
          'बिना छत के घर',
          'कागज़ के घर',
          'बिना दीवार के घर',
        ],
        correctIndex: 0,
      ),
    ],
  ),
  'Class 3|Environmental Studies|छुक छुक छुक छुक': ChapterContent(
    worksheet: [
      'रेलगाड़ी चलने की आवाज़ को हम किस शब्द से दर्शाते हैं?',
      'रेलगाड़ी के अलावा दो और परिवहन (transport) के साधनों के नाम लिखिए।',
      'रेलगाड़ी से यात्रा करना क्यों सुविधाजनक होता है?',
      'रेलगाड़ी में यात्रा करते समय किन नियमों का पालन करना चाहिए?',
    ],
    flashcards: [
      Flashcard(
        term: 'परिवहन',
        meaning: 'एक स्थान से दूसरे स्थान तक जाने का साधन',
      ),
      Flashcard(term: 'रेलगाड़ी', meaning: 'पटरी पर चलने वाला वाहन'),
      Flashcard(term: 'यात्री', meaning: 'यात्रा करने वाला व्यक्ति'),
      Flashcard(
        term: 'टिकट',
        meaning: 'यात्रा के लिए ली जाने वाली अनुमति पर्ची',
      ),
      Flashcard(term: 'सफर', meaning: 'यात्रा'),
    ],
    assessment: [
      AssessmentQuestion(
        question: 'रेलगाड़ी की आवाज़ को किस शब्द से दर्शाया जाता है?',
        options: ['भौं-भौं', 'छुक-छुक', 'म्याऊँ', 'टिक-टिक'],
        correctIndex: 1,
      ),
      AssessmentQuestion(
        question: 'यात्रा के लिए ली जाने वाली अनुमति पर्ची को क्या कहते हैं?',
        options: ['टिकट', 'पत्र', 'रसीद', 'किताब'],
        correctIndex: 0,
      ),
      AssessmentQuestion(
        question: 'एक स्थान से दूसरे स्थान जाने के साधन को क्या कहते हैं?',
        options: ['परिवहन', 'प्रदूषण', 'पर्यावरण', 'प्रकाश'],
        correctIndex: 0,
      ),
      AssessmentQuestion(
        question: 'निम्न में से कौन-सा परिवहन का साधन नहीं है?',
        options: ['बस', 'रेलगाड़ी', 'हवाई जहाज़', 'कुर्सी'],
        correctIndex: 3,
      ),
    ],
  ),
  'Class 3|Environmental Studies|पानी तेरे कितने नाम': ChapterContent(
    worksheet: [
      'पानी के तीन स्रोतों (sources) के नाम लिखिए।',
      'पानी को व्यर्थ बहने से रोकने के दो उपाय लिखिए।',
      'पानी हमारे लिए क्यों ज़रूरी है?',
      'वर्षा का पानी कहाँ-कहाँ इकट्ठा होता है?',
    ],
    flashcards: [
      Flashcard(term: 'जल', meaning: 'पानी'),
      Flashcard(term: 'नदी', meaning: 'पानी की बड़ी प्राकृतिक धारा'),
      Flashcard(term: 'वर्षा', meaning: 'आकाश से गिरने वाला पानी'),
      Flashcard(term: 'जल संरक्षण', meaning: 'पानी को बचाना'),
      Flashcard(term: 'स्रोत', meaning: 'जहाँ से कोई चीज़ प्राप्त होती है'),
    ],
    assessment: [
      AssessmentQuestion(
        question: 'आकाश से गिरने वाले पानी को क्या कहते हैं?',
        options: ['नदी', 'वर्षा', 'तालाब', 'कुआँ'],
        correctIndex: 1,
      ),
      AssessmentQuestion(
        question: 'पानी की बड़ी प्राकृतिक धारा को क्या कहते हैं?',
        options: ['नदी', 'सड़क', 'पहाड़', 'मैदान'],
        correctIndex: 0,
      ),
      AssessmentQuestion(
        question: 'पानी बचाने के प्रयास को क्या कहते हैं?',
        options: ['जल प्रदूषण', 'जल संरक्षण', 'जल बहाव', 'जल हानि'],
        correctIndex: 1,
      ),
      AssessmentQuestion(
        question: 'पानी का उपयोग हम किसके लिए करते हैं?',
        options: [
          'केवल पीने के लिए',
          'पीने, नहाने और खाना बनाने के लिए',
          'केवल खेलने के लिए',
          'किसी काम के लिए नहीं',
        ],
        correctIndex: 1,
      ),
    ],
  ),
  'Class 3|Environmental Studies|हम बनाएं': ChapterContent(
    worksheet: [
      'आप कागज़ से कौन-सी वस्तु बनाना पसंद करेंगे?',
      'कोई वस्तु बनाने के लिए किन-किन सामग्रियों की आवश्यकता हो सकती है?',
      'अपने हाथों से चीज़ें बनाने के दो लाभ लिखिए।',
      'पुरानी वस्तुओं से नई वस्तु बनाने को क्या कहते हैं?',
    ],
    flashcards: [
      Flashcard(term: 'शिल्प', meaning: 'हाथ से बनाई जाने वाली कलात्मक वस्तु'),
      Flashcard(
        term: 'पुनः उपयोग',
        meaning: 'पुरानी वस्तु को फिर से काम में लाना',
      ),
      Flashcard(
        term: 'सामग्री',
        meaning: 'वस्तु बनाने में उपयोग होने वाली चीज़ें',
      ),
      Flashcard(
        term: 'रचनात्मकता',
        meaning: 'नई और अनोखी चीज़ें सोचने-बनाने की क्षमता',
      ),
      Flashcard(term: 'कतरन', meaning: 'कागज़ या कपड़े का कटा हुआ टुकड़ा'),
    ],
    assessment: [
      AssessmentQuestion(
        question: 'हाथ से बनाई गई कलात्मक वस्तु को क्या कहते हैं?',
        options: ['शिल्प', 'यंत्र', 'वाहन', 'भोजन'],
        correctIndex: 0,
      ),
      AssessmentQuestion(
        question: 'पुरानी वस्तुओं का फिर से उपयोग करना क्या कहलाता है?',
        options: ['बर्बादी', 'पुनः उपयोग', 'चोरी', 'नुकसान'],
        correctIndex: 1,
      ),
      AssessmentQuestion(
        question: 'नई और अनोखी चीज़ें सोचने की क्षमता को क्या कहते हैं?',
        options: ['रचनात्मकता', 'आलस्य', 'भूलना', 'डर'],
        correctIndex: 0,
      ),
      AssessmentQuestion(
        question: 'कागज़ से वस्तु बनाने के लिए हमें और क्या चाहिए हो सकता है?',
        options: ['कैंची और गोंद', 'पानी की बाल्टी', 'चूल्हा', 'फावड़ा'],
        correctIndex: 0,
      ),
    ],
  ),
  'Class 3|Environmental Studies|बायाँ दायाँ': ChapterContent(
    worksheet: [
      'आप जिस हाथ से लिखते हैं, वह दायाँ है या बायाँ?',
      'सड़क पार करते समय पहले किस दिशा में देखना चाहिए और फिर किस दिशा में?',
      'अपने बाएँ हाथ की ओर की एक वस्तु का नाम लिखिए।',
      'दायाँ और बायाँ पहचानना क्यों ज़रूरी है?',
    ],
    flashcards: [
      Flashcard(
        term: 'दायाँ',
        meaning: 'एक दिशा जो अधिकतर लोगों के लेखन हाथ की ओर होती है',
      ),
      Flashcard(term: 'बायाँ', meaning: 'दायें के विपरीत दिशा'),
      Flashcard(term: 'दिशा', meaning: 'किसी वस्तु या स्थान की ओर का रुख'),
      Flashcard(
        term: 'सड़क पार करना',
        meaning: 'सुरक्षित रूप से सड़क के एक ओर से दूसरी ओर जाना',
      ),
      Flashcard(term: 'पहचान', meaning: 'किसी चीज़ को जानना और अलग करना'),
    ],
    assessment: [
      AssessmentQuestion(
        question: '\'दायाँ\' का विपरीत शब्द क्या है?',
        options: ['ऊपर', 'बायाँ', 'नीचे', 'आगे'],
        correctIndex: 1,
      ),
      AssessmentQuestion(
        question: 'सड़क पार करते समय हमें सबसे पहले क्या करना चाहिए?',
        options: ['दौड़ना', 'दायें-बायें देखना', 'आँखें बंद करना', 'गाना गाना'],
        correctIndex: 1,
      ),
      AssessmentQuestion(
        question: 'अधिकतर लोग किस हाथ से लिखते हैं?',
        options: ['बायें हाथ से', 'दायें हाथ से', 'दोनों हाथ से', 'पैर से'],
        correctIndex: 1,
      ),
      AssessmentQuestion(
        question: 'दिशाओं को पहचानना हमारे लिए क्यों उपयोगी है?',
        options: [
          'सुरक्षित चलने के लिए',
          'सोने के लिए',
          'खाने के लिए',
          'गाने के लिए',
        ],
        correctIndex: 0,
      ),
    ],
  ),
  'Class 4|Hindi|कोयल': ChapterContent(
    worksheet: [
      'कोयल किस मौसम में अधिक बोलती है?',
      'कोयल का रंग कैसा होता है?',
      'कोयल की आवाज़ किस तरह की होती है, अपने शब्दों में लिखिए।',
      'आपको कौन सा पक्षी सबसे अच्छा लगता है और क्यों?',
      'कोयल पर पाँच वाक्य लिखिए।',
    ],
    flashcards: [
      Flashcard(
        term: 'कोयल',
        meaning: 'एक काले रंग का पक्षी जो मीठी आवाज़ में गाता है',
      ),
      Flashcard(term: 'वसंत', meaning: 'सर्दी के बाद आने वाला सुहावना मौसम'),
      Flashcard(term: 'कूक', meaning: 'कोयल की मीठी आवाज़'),
      Flashcard(term: 'पंख', meaning: 'पक्षियों के उड़ने में सहायक अंग'),
      Flashcard(term: 'घोंसला', meaning: 'पक्षियों का रहने का घर'),
    ],
    assessment: [
      AssessmentQuestion(
        question: 'कोयल का रंग कैसा होता है?',
        options: ['काला', 'सफेद', 'लाल', 'नीला'],
        correctIndex: 0,
      ),
      AssessmentQuestion(
        question: 'कोयल की आवाज़ को क्या कहते हैं?',
        options: ['कूक', 'भौंकना', 'दहाड़', 'म्याऊँ'],
        correctIndex: 0,
      ),
      AssessmentQuestion(
        question: 'कोयल किस ऋतु में अधिक बोलती है?',
        options: ['वसंत', 'सर्दी', 'पतझड़', 'शीत'],
        correctIndex: 0,
      ),
      AssessmentQuestion(
        question: 'पक्षी अपने घर को क्या कहते हैं?',
        options: ['घोंसला', 'बिल', 'गुफा', 'तालाब'],
        correctIndex: 0,
      ),
      AssessmentQuestion(
        question: 'कोयल किस श्रेणी का जीव है?',
        options: ['पक्षी', 'स्तनधारी', 'कीट', 'मछली'],
        correctIndex: 0,
      ),
    ],
  ),
  'Class 4|Hindi|बहुभाषी विद्वान': ChapterContent(
    worksheet: [
      'बहुभाषी शब्द का अर्थ क्या है?',
      'आप कौन-कौन सी भाषाएँ जानते या समझते हैं?',
      'एक से अधिक भाषा जानने के दो लाभ लिखिए।',
      'झारखंड में बोली जाने वाली किन्हीं दो भाषाओं के नाम लिखिए।',
      'अपनी मातृभाषा का नाम लिखकर उसके बारे में तीन वाक्य लिखिए।',
    ],
    flashcards: [
      Flashcard(term: 'बहुभाषी', meaning: 'कई भाषाएँ जानने वाला व्यक्ति'),
      Flashcard(
        term: 'मातृभाषा',
        meaning: 'वह भाषा जो हम अपनी माँ से सीखते हैं',
      ),
      Flashcard(term: 'विद्वान', meaning: 'बहुत ज्ञान रखने वाला व्यक्ति'),
      Flashcard(
        term: 'बोली',
        meaning: 'किसी क्षेत्र में बोली जाने वाली भाषा का रूप',
      ),
      Flashcard(term: 'अनुवाद', meaning: 'एक भाषा से दूसरी भाषा में बदलना'),
    ],
    assessment: [
      AssessmentQuestion(
        question: 'बहुभाषी व्यक्ति किसे कहते हैं?',
        options: [
          'जो कई भाषाएँ जानता हो',
          'जो एक भाषा जानता हो',
          'जो पढ़ नहीं सकता',
          'जो गा नहीं सकता',
        ],
        correctIndex: 0,
      ),
      AssessmentQuestion(
        question: 'मातृभाषा किसे कहते हैं?',
        options: [
          'माँ से सीखी भाषा',
          'स्कूल में सीखी भाषा',
          'विदेशी भाषा',
          'कठिन भाषा',
        ],
        correctIndex: 0,
      ),
      AssessmentQuestion(
        question: 'झारखंड में बोली जाने वाली भाषा है?',
        options: ['संथाली', 'जापानी', 'स्पेनिश', 'रूसी'],
        correctIndex: 0,
      ),
      AssessmentQuestion(
        question: 'एक भाषा को दूसरी भाषा में बदलना क्या कहलाता है?',
        options: ['अनुवाद', 'लेखन', 'पठन', 'श्रवण'],
        correctIndex: 0,
      ),
      AssessmentQuestion(
        question: 'विद्वान शब्द का अर्थ है?',
        options: ['ज्ञानी व्यक्ति', 'अनपढ़ व्यक्ति', 'बच्चा', 'किसान'],
        correctIndex: 0,
      ),
    ],
  ),
  'Class 4|Hindi|पापा जब बच्चे थे': ChapterContent(
    worksheet: [
      'अपने पापा या दादा जी के बचपन के बारे में उनसे पूछकर तीन बातें लिखिए।',
      'पहले के समय के खेल आज के खेलों से किस प्रकार अलग थे?',
      'आपके परिवार में पहले किस तरह की चीज़ें उपयोग होती थीं?',
      'समय के साथ जीवन में क्या-क्या बदलाव आए हैं, दो उदाहरण दीजिए।',
      'अपने बचपन की एक याद लिखिए जो आप बड़े होकर अपने बच्चों को सुनाना चाहेंगे।',
    ],
    flashcards: [
      Flashcard(term: 'बचपन', meaning: 'जीवन का बाल्यकाल'),
      Flashcard(term: 'पीढ़ी', meaning: 'एक ही समय में जन्मे लोगों का समूह'),
      Flashcard(term: 'स्मृति', meaning: 'याद'),
      Flashcard(term: 'परिवर्तन', meaning: 'बदलाव'),
      Flashcard(
        term: 'परंपरा',
        meaning: 'पुरानी रीति-रिवाज जो पीढ़ी दर पीढ़ी चलती है',
      ),
    ],
    assessment: [
      AssessmentQuestion(
        question: '\'पापा जब बच्चे थे\' कहानी किस विषय पर आधारित है?',
        options: ['बचपन की यादें', 'विज्ञान', 'गणित', 'भूगोल'],
        correctIndex: 0,
      ),
      AssessmentQuestion(
        question: 'पीढ़ी शब्द का अर्थ है?',
        options: ['एक समय में जन्मे लोग', 'एक जानवर', 'एक फल', 'एक शहर'],
        correctIndex: 0,
      ),
      AssessmentQuestion(
        question: 'समय के साथ चीज़ों में क्या होता है?',
        options: ['बदलाव', 'कुछ नहीं', 'गायब होना', 'जमना'],
        correctIndex: 0,
      ),
      AssessmentQuestion(
        question: 'पुरानी रीति-रिवाज को क्या कहते हैं?',
        options: ['परंपरा', 'फैशन', 'खेल', 'भोजन'],
        correctIndex: 0,
      ),
      AssessmentQuestion(
        question: 'बड़ों से बातचीत करने से हमें क्या मिलता है?',
        options: ['अनुभव और ज्ञान', 'केवल मनोरंजन', 'कुछ नहीं', 'डर'],
        correctIndex: 0,
      ),
    ],
  ),
  'Class 4|Hindi|मुझे मॉनिटर बना दो': ChapterContent(
    worksheet: [
      'मॉनिटर बनने के लिए किन गुणों की आवश्यकता होती है?',
      'कक्षा मॉनिटर की तीन ज़िम्मेदारियाँ लिखिए।',
      'यदि आप मॉनिटर बनें तो कक्षा में क्या सुधार करना चाहेंगे?',
      'अच्छे नेता के दो गुण लिखिए।',
      'मॉनिटर बनने की इच्छा क्यों अच्छी बात हो सकती है, अपने विचार लिखिए।',
    ],
    flashcards: [
      Flashcard(
        term: 'मॉनिटर',
        meaning: 'कक्षा की देखभाल करने वाला विद्यार्थी',
      ),
      Flashcard(term: 'ज़िम्मेदारी', meaning: 'कोई काम पूरी तरह निभाने का भार'),
      Flashcard(term: 'अनुशासन', meaning: 'नियमों का पालन'),
      Flashcard(
        term: 'नेतृत्व',
        meaning: 'दूसरों का मार्गदर्शन करने की क्षमता',
      ),
      Flashcard(term: 'कर्तव्य', meaning: 'करने योग्य कार्य'),
    ],
    assessment: [
      AssessmentQuestion(
        question: 'कक्षा मॉनिटर का मुख्य कार्य क्या है?',
        options: [
          'कक्षा में अनुशासन बनाए रखना',
          'खेलना',
          'सोना',
          'खाना बाँटना',
        ],
        correctIndex: 0,
      ),
      AssessmentQuestion(
        question: 'अनुशासन का अर्थ है?',
        options: ['नियमों का पालन', 'नियम तोड़ना', 'शोर मचाना', 'झगड़ा करना'],
        correctIndex: 0,
      ),
      AssessmentQuestion(
        question: 'अच्छा नेता कैसा होता है?',
        options: ['जिम्मेदार और ईमानदार', 'आलसी', 'झूठा', 'डरपोक'],
        correctIndex: 0,
      ),
      AssessmentQuestion(
        question: 'ज़िम्मेदारी शब्द का संबंध है?',
        options: ['कर्तव्य से', 'खेल से', 'भोजन से', 'नींद से'],
        correctIndex: 0,
      ),
      AssessmentQuestion(
        question: 'मॉनिटर किसकी सहायता करता है?',
        options: ['शिक्षक की', 'दुकानदार की', 'डाकिया की', 'किसान की'],
        correctIndex: 0,
      ),
    ],
  ),
  'Class 4|Hindi|दादी की साड़ी': ChapterContent(
    worksheet: [
      'दादी की साड़ी से जुड़ी कोई पुरानी याद अपने घर में पूछकर लिखिए।',
      'साड़ी हमारे देश की किस प्रकार की पोशाक है?',
      'अपनी दादी या नानी के बारे में पाँच वाक्य लिखिए।',
      'पुराने कपड़ों को संभालकर रखना क्यों ज़रूरी है?',
      'अपने घर की किसी पुरानी वस्तु के बारे में लिखिए जो आपको प्रिय है।',
    ],
    flashcards: [
      Flashcard(term: 'साड़ी', meaning: 'भारतीय महिलाओं की पारंपरिक पोशाक'),
      Flashcard(term: 'विरासत', meaning: 'पूर्वजों से मिली वस्तु या परंपरा'),
      Flashcard(term: 'स्मृति चिन्ह', meaning: 'याद दिलाने वाली वस्तु'),
      Flashcard(term: 'पीढ़ी', meaning: 'परिवार की एक पीढ़ी'),
      Flashcard(term: 'पारंपरिक', meaning: 'परंपरा से जुड़ा हुआ'),
    ],
    assessment: [
      AssessmentQuestion(
        question: 'साड़ी किस देश की पारंपरिक पोशाक है?',
        options: ['भारत', 'जापान', 'अमेरिका', 'रूस'],
        correctIndex: 0,
      ),
      AssessmentQuestion(
        question: 'पूर्वजों से मिली वस्तु को क्या कहते हैं?',
        options: ['विरासत', 'कचरा', 'खिलौना', 'भोजन'],
        correctIndex: 0,
      ),
      AssessmentQuestion(
        question: 'कहानी में दादी की कौन-सी वस्तु का ज़िक्र है?',
        options: ['साड़ी', 'जूते', 'टोपी', 'घड़ी'],
        correctIndex: 0,
      ),
      AssessmentQuestion(
        question: 'पुरानी वस्तुओं को संभालकर क्यों रखना चाहिए?',
        options: [
          'यादों के कारण',
          'वे बेकार होती हैं',
          'उन्हें फेंकना है',
          'कोई कारण नहीं',
        ],
        correctIndex: 0,
      ),
      AssessmentQuestion(
        question: 'स्मृति चिन्ह किसे कहते हैं?',
        options: ['याद दिलाने वाली वस्तु', 'नया खिलौना', 'भोजन', 'किताब'],
        correctIndex: 0,
      ),
    ],
  ),
  'Class 4|Hindi|क्यों': ChapterContent(
    worksheet: [
      'बच्चे \'क्यों\' प्रश्न सबसे ज़्यादा किससे पूछते हैं?',
      'अपने मन में उठने वाले तीन \'क्यों\' प्रश्न लिखिए।',
      'प्रश्न पूछना अच्छी आदत क्यों है?',
      'आकाश नीला क्यों दिखता है, इस पर अपने विचार लिखिए।',
      'जिज्ञासा शब्द का अर्थ अपने शब्दों में समझाइए।',
    ],
    flashcards: [
      Flashcard(term: 'जिज्ञासा', meaning: 'जानने की इच्छा'),
      Flashcard(term: 'प्रश्न', meaning: 'पूछा जाने वाला सवाल'),
      Flashcard(term: 'उत्तर', meaning: 'प्रश्न का जवाब'),
      Flashcard(term: 'कारण', meaning: 'किसी बात के पीछे की वजह'),
      Flashcard(term: 'खोज', meaning: 'नई जानकारी पाने की क्रिया'),
    ],
    assessment: [
      AssessmentQuestion(
        question: 'जानने की इच्छा को क्या कहते हैं?',
        options: ['जिज्ञासा', 'आलस्य', 'भय', 'क्रोध'],
        correctIndex: 0,
      ),
      AssessmentQuestion(
        question: 'प्रश्न का जवाब क्या कहलाता है?',
        options: ['उत्तर', 'कारण', 'खोज', 'प्रश्न'],
        correctIndex: 0,
      ),
      AssessmentQuestion(
        question: 'बच्चों में प्रश्न पूछने की आदत कैसी होती है?',
        options: ['अच्छी', 'बुरी', 'बेकार', 'गलत'],
        correctIndex: 0,
      ),
      AssessmentQuestion(
        question: 'किसी बात के पीछे की वजह को क्या कहते हैं?',
        options: ['कारण', 'उत्तर', 'खोज', 'प्रश्न'],
        correctIndex: 0,
      ),
      AssessmentQuestion(
        question: 'नई जानकारी पाने की क्रिया को क्या कहते हैं?',
        options: ['खोज', 'नींद', 'भोजन', 'खेल'],
        correctIndex: 0,
      ),
    ],
  ),
  'Class 4|Hindi|सोने के जूते': ChapterContent(
    worksheet: [
      '\'सोने के जूते\' शीर्षक पढ़कर आपको कैसी कहानी लगती है - सच्ची या कल्पित?',
      'सोना किस प्रकार की धातु है?',
      'इस कहानी से आप क्या सीख की उम्मीद करते हैं?',
      'कल्पना पर आधारित कहानियाँ पढ़ना क्यों अच्छा लगता है?',
      'यदि आपको सोने के जूते मिलें तो आप क्या करेंगे, लिखिए।',
    ],
    flashcards: [
      Flashcard(term: 'सोना', meaning: 'एक कीमती पीली धातु'),
      Flashcard(term: 'कल्पना', meaning: 'मन में गढ़ी हुई बात'),
      Flashcard(term: 'लालच', meaning: 'अधिक पाने की इच्छा'),
      Flashcard(term: 'संतोष', meaning: 'जो मिला उसमें खुश रहना'),
      Flashcard(term: 'शिक्षा', meaning: 'कहानी से मिलने वाली सीख'),
    ],
    assessment: [
      AssessmentQuestion(
        question: 'सोना किस रंग की धातु है?',
        options: ['पीली', 'हरी', 'नीली', 'काली'],
        correctIndex: 0,
      ),
      AssessmentQuestion(
        question: 'अधिक पाने की इच्छा को क्या कहते हैं?',
        options: ['लालच', 'संतोष', 'भय', 'क्रोध'],
        correctIndex: 0,
      ),
      AssessmentQuestion(
        question: 'जो मिला उसमें खुश रहना क्या कहलाता है?',
        options: ['संतोष', 'लालच', 'ईर्ष्या', 'घमंड'],
        correctIndex: 0,
      ),
      AssessmentQuestion(
        question: 'कहानियों से हमें क्या मिलता है?',
        options: ['शिक्षा', 'केवल मनोरंजन', 'कुछ नहीं', 'भय'],
        correctIndex: 0,
      ),
      AssessmentQuestion(
        question: 'कल्पना पर आधारित कहानी कैसी होती है?',
        options: ['काल्पनिक', 'सच्ची', 'वैज्ञानिक', 'ऐतिहासिक'],
        correctIndex: 0,
      ),
    ],
  ),
  'Class 4|Hindi|बादल': ChapterContent(
    worksheet: [
      'बादल किससे बनते हैं?',
      'बादलों का रंग कब काला हो जाता है?',
      'बारिश होने की प्रक्रिया को अपने शब्दों में लिखिए।',
      'बादलों के आकार के बारे में तीन वाक्य लिखिए।',
      'वर्षा ऋतु में आपको क्या करना पसंद है?',
    ],
    flashcards: [
      Flashcard(term: 'बादल', meaning: 'आकाश में तैरता जलवाष्प का समूह'),
      Flashcard(term: 'वर्षा', meaning: 'बादलों से गिरने वाला पानी'),
      Flashcard(term: 'जलवाष्प', meaning: 'पानी की भाप'),
      Flashcard(term: 'आकाश', meaning: 'पृथ्वी के ऊपर का विस्तार'),
      Flashcard(term: 'गरज', meaning: 'बादलों की तेज़ आवाज़'),
    ],
    assessment: [
      AssessmentQuestion(
        question: 'बादल किससे बने होते हैं?',
        options: ['जलवाष्प', 'रेत', 'धुआँ', 'मिट्टी'],
        correctIndex: 0,
      ),
      AssessmentQuestion(
        question: 'वर्षा ऋतु में क्या गिरता है?',
        options: ['पानी', 'बर्फ केवल', 'पत्थर', 'रेत'],
        correctIndex: 0,
      ),
      AssessmentQuestion(
        question: 'बादलों की तेज़ आवाज़ को क्या कहते हैं?',
        options: ['गरज', 'कूक', 'दहाड़', 'भौंकना'],
        correctIndex: 0,
      ),
      AssessmentQuestion(
        question: 'पानी की भाप को क्या कहते हैं?',
        options: ['जलवाष्प', 'बर्फ', 'ओस', 'कोहरा'],
        correctIndex: 0,
      ),
      AssessmentQuestion(
        question: 'घने काले बादल किस बात का संकेत देते हैं?',
        options: ['वर्षा होने का', 'गर्मी बढ़ने का', 'सूखे का', 'रात होने का'],
        correctIndex: 0,
      ),
    ],
  ),
  'Class 4|Hindi|स्वतंत्रता की ओर': ChapterContent(
    worksheet: [
      'भारत को अंग्रेज़ों की गुलामी से कब आज़ादी मिली?',
      'महात्मा गांधी ने स्वतंत्रता संग्राम में किस तरीके का प्रयोग किया?',
      'भारत के किन्हीं दो स्वतंत्रता सेनानियों के नाम लिखिए।',
      'स्वतंत्रता दिवस हम किस तारीख़ को मनाते हैं?',
      'आज़ादी का महत्व अपने शब्दों में लिखिए।',
    ],
    flashcards: [
      Flashcard(term: 'स्वतंत्रता', meaning: 'आज़ादी, पराधीनता से मुक्ति'),
      Flashcard(
        term: 'स्वतंत्रता सेनानी',
        meaning: 'देश को आज़ाद कराने के लिए लड़ने वाला व्यक्ति',
      ),
      Flashcard(term: 'अहिंसा', meaning: 'बिना हिंसा के विरोध करने का तरीका'),
      Flashcard(term: 'तिरंगा', meaning: 'भारत का राष्ट्रीय ध्वज'),
      Flashcard(term: 'गणतंत्र', meaning: 'जनता द्वारा चुनी गई शासन व्यवस्था'),
    ],
    assessment: [
      AssessmentQuestion(
        question: 'भारत को स्वतंत्रता कब मिली?',
        options: [
          '15 अगस्त 1947',
          '26 जनवरी 1950',
          '2 अक्टूबर 1869',
          '15 अगस्त 1950',
        ],
        correctIndex: 0,
      ),
      AssessmentQuestion(
        question: 'महात्मा गांधी ने किस मार्ग से स्वतंत्रता संग्राम लड़ा?',
        options: ['अहिंसा', 'हिंसा', 'युद्ध', 'कुछ नहीं'],
        correctIndex: 0,
      ),
      AssessmentQuestion(
        question: 'भारत का राष्ट्रीय ध्वज कहलाता है?',
        options: ['तिरंगा', 'पताका', 'झंडा केवल', 'निशान'],
        correctIndex: 0,
      ),
      AssessmentQuestion(
        question: 'स्वतंत्रता दिवस किस महीने में मनाया जाता है?',
        options: ['अगस्त', 'जनवरी', 'अक्टूबर', 'दिसंबर'],
        correctIndex: 0,
      ),
      AssessmentQuestion(
        question: '2 अक्टूबर को किनकी जयंती मनाई जाती है?',
        options: [
          'महात्मा गांधी',
          'जवाहरलाल नेहरू',
          'सुभाष चंद्र बोस',
          'भगत सिंह',
        ],
        correctIndex: 0,
      ),
    ],
  ),
  'Class 4|Hindi|मुल्ला नसरुद्दीन': ChapterContent(
    worksheet: [
      'मुल्ला नसरुद्दीन की कहानियाँ किस प्रकार की होती हैं - हास्यपूर्ण या दुखद?',
      'हास्य कहानियाँ पढ़ने से हमें क्या लाभ होता है?',
      'चतुराई और हास्य से भरी कोई एक बात लिखिए जो आपने कहीं सुनी हो।',
      'मुल्ला नसरुद्दीन जैसे पात्र कहानियों में क्यों लोकप्रिय होते हैं?',
      'अपने शब्दों में एक छोटा हास्य प्रसंग लिखिए।',
    ],
    flashcards: [
      Flashcard(term: 'हास्य', meaning: 'हँसी उत्पन्न करने वाली बात'),
      Flashcard(term: 'चतुराई', meaning: 'बुद्धिमानी से काम लेना'),
      Flashcard(term: 'लोककथा', meaning: 'लोगों में प्रचलित पुरानी कहानी'),
      Flashcard(term: 'मूर्खता', meaning: 'नासमझी भरा व्यवहार'),
      Flashcard(
        term: 'व्यंग्य',
        meaning: 'हल्के-फुल्के ढंग से कही गई तीखी बात',
      ),
    ],
    assessment: [
      AssessmentQuestion(
        question: 'मुल्ला नसरुद्दीन की कहानियाँ किस लिए प्रसिद्ध हैं?',
        options: ['हास्य और चतुराई', 'भय', 'दुख', 'युद्ध'],
        correctIndex: 0,
      ),
      AssessmentQuestion(
        question: 'लोगों में प्रचलित पुरानी कहानी को क्या कहते हैं?',
        options: ['लोककथा', 'समाचार', 'निबंध', 'पत्र'],
        correctIndex: 0,
      ),
      AssessmentQuestion(
        question: 'बुद्धिमानी से काम लेने को क्या कहते हैं?',
        options: ['चतुराई', 'मूर्खता', 'आलस्य', 'भय'],
        correctIndex: 0,
      ),
      AssessmentQuestion(
        question: 'हास्य कहानियाँ पढ़ने से क्या मिलता है?',
        options: ['मनोरंजन और सीख', 'केवल डर', 'थकान', 'कुछ नहीं'],
        correctIndex: 0,
      ),
      AssessmentQuestion(
        question: 'मुल्ला नसरुद्दीन किस प्रकार का पात्र माना जाता है?',
        options: [
          'लोक-कथाओं का चतुर पात्र',
          'ऐतिहासिक राजा',
          'वैज्ञानिक',
          'सैनिक',
        ],
        correctIndex: 0,
      ),
    ],
  ),
  'Class 4|Hindi|बिजूका': ChapterContent(
    worksheet: [
      'बिजूका खेतों में क्यों लगाया जाता है?',
      'बिजूका किन चीज़ों से बनाया जाता है?',
      'यदि बिजूका बोल सकता तो वह पक्षियों से क्या कहता?',
      'किसान अपनी फसल की रक्षा किस-किस तरह करते हैं?',
      'बिजूका पर पाँच वाक्य लिखिए।',
    ],
    flashcards: [
      Flashcard(
        term: 'बिजूका',
        meaning: 'पक्षियों को डराने के लिए खेत में लगाई गई पुतले जैसी आकृति',
      ),
      Flashcard(term: 'फसल', meaning: 'खेत में उगाई गई पैदावार'),
      Flashcard(term: 'किसान', meaning: 'खेती करने वाला व्यक्ति'),
      Flashcard(term: 'खेत', meaning: 'फसल उगाने की भूमि'),
      Flashcard(term: 'पुआल', meaning: 'सूखी घास/फसल के डंठल'),
    ],
    assessment: [
      AssessmentQuestion(
        question: 'बिजूका किसलिए लगाया जाता है?',
        options: [
          'पक्षियों को डराने के लिए',
          'फूल उगाने के लिए',
          'पानी देने के लिए',
          'घर बनाने के लिए',
        ],
        correctIndex: 0,
      ),
      AssessmentQuestion(
        question: 'बिजूका आमतौर पर किससे बनता है?',
        options: ['पुआल और पुराने कपड़े', 'लोहा', 'प्लास्टिक', 'शीशा'],
        correctIndex: 0,
      ),
      AssessmentQuestion(
        question: 'खेत में फसल उगाने वाले व्यक्ति को क्या कहते हैं?',
        options: ['किसान', 'शिक्षक', 'डॉक्टर', 'दुकानदार'],
        correctIndex: 0,
      ),
      AssessmentQuestion(
        question: 'बिजूका किसकी रक्षा करता है?',
        options: ['फसल की', 'घर की', 'स्कूल की', 'नदी की'],
        correctIndex: 0,
      ),
      AssessmentQuestion(
        question: 'सूखी घास या डंठल को क्या कहते हैं?',
        options: ['पुआल', 'रेत', 'मिट्टी', 'पत्थर'],
        correctIndex: 0,
      ),
    ],
  ),
  'Class 4|Hindi|चूहे ने काटा माउस को': ChapterContent(
    worksheet: [
      '\'चूहा\' और \'माउस\' (कंप्यूटर) में क्या अंतर है?',
      'कंप्यूटर के माउस का उपयोग किसलिए किया जाता है?',
      'इस शीर्षक में किस प्रकार का शब्द-खेल (पन) है, समझाइए।',
      'असली चूहे और कंप्यूटर माउस के तीन-तीन अंतर लिखिए।',
      'कंप्यूटर से जुड़े किन्हीं तीन उपकरणों के नाम लिखिए।',
    ],
    flashcards: [
      Flashcard(term: 'माउस', meaning: 'कंप्यूटर चलाने का एक उपकरण'),
      Flashcard(term: 'चूहा', meaning: 'एक छोटा जंतु'),
      Flashcard(term: 'कंप्यूटर', meaning: 'सूचना संसाधित करने वाला यंत्र'),
      Flashcard(term: 'कीबोर्ड', meaning: 'टाइप करने का उपकरण'),
      Flashcard(term: 'स्क्रीन', meaning: 'कंप्यूटर का प्रदर्शन पटल'),
    ],
    assessment: [
      AssessmentQuestion(
        question: 'कंप्यूटर माउस का उपयोग क्या है?',
        options: [
          'कंप्यूटर को संचालित करना',
          'भोजन बनाना',
          'कपड़े धोना',
          'पानी भरना',
        ],
        correctIndex: 0,
      ),
      AssessmentQuestion(
        question: 'असली चूहा किस प्रकार का प्राणी है?',
        options: ['जीवित जंतु', 'यंत्र', 'पौधा', 'पत्थर'],
        correctIndex: 0,
      ),
      AssessmentQuestion(
        question: 'टाइप करने के लिए किस उपकरण का प्रयोग होता है?',
        options: ['कीबोर्ड', 'माउस केवल', 'पंखा', 'घड़ी'],
        correctIndex: 0,
      ),
      AssessmentQuestion(
        question: 'कंप्यूटर की जानकारी दिखाने वाले भाग को क्या कहते हैं?',
        options: ['स्क्रीन', 'कीबोर्ड', 'माउस', 'तार'],
        correctIndex: 0,
      ),
      AssessmentQuestion(
        question: 'शीर्षक में शब्दों का मज़ेदार खेल किसे कहते हैं?',
        options: ['पन/श्लेष', 'कविता', 'निबंध', 'पत्र'],
        correctIndex: 0,
      ),
    ],
  ),
  'Class 4|English|The Stars': ChapterContent(
    worksheet: [
      'What do you see in the sky at night?',
      'Write three words to describe how stars look.',
      'Why do you think stars twinkle?',
      'Name one constellation or star pattern you have heard of.',
      'Write four lines about a starry night sky.',
    ],
    flashcards: [
      Flashcard(
        term: 'Star',
        meaning: 'A huge ball of burning gas in space that gives light',
      ),
      Flashcard(term: 'Twinkle', meaning: 'To shine with a flickering light'),
      Flashcard(
        term: 'Sky',
        meaning: 'The space above the earth we see from the ground',
      ),
      Flashcard(
        term: 'Night',
        meaning: 'The time when it is dark, opposite of day',
      ),
      Flashcard(
        term: 'Constellation',
        meaning: 'A group of stars that forms a pattern',
      ),
    ],
    assessment: [
      AssessmentQuestion(
        question: 'When do we usually see stars in the sky?',
        options: ['At night', 'At noon', 'In the morning', 'Never'],
        correctIndex: 0,
      ),
      AssessmentQuestion(
        question: 'Stars are mainly made of?',
        options: ['Burning gas', 'Water', 'Soil', 'Ice'],
        correctIndex: 0,
      ),
      AssessmentQuestion(
        question: 'What does \'twinkle\' mean?',
        options: [
          'To shine with a flickering light',
          'To fall down',
          'To disappear',
          'To grow bigger',
        ],
        correctIndex: 0,
      ),
      AssessmentQuestion(
        question: 'A group of stars forming a pattern is called a?',
        options: ['Constellation', 'Planet', 'Comet', 'Cloud'],
        correctIndex: 0,
      ),
      AssessmentQuestion(
        question: 'The sun is also a?',
        options: ['Star', 'Planet', 'Moon', 'Cloud'],
        correctIndex: 0,
      ),
    ],
  ),
  'Class 4|English|Sky and Her Children': ChapterContent(
    worksheet: [
      'Who do you think are the \'children\' of the sky in this story\'s title?',
      'Name three things you can see in the sky during the day.',
      'Name three things you can see in the sky during the night.',
      'Why is the sky important for us?',
      'Describe the sky in your own words.',
    ],
    flashcards: [
      Flashcard(term: 'Sky', meaning: 'The space above the earth'),
      Flashcard(
        term: 'Sun',
        meaning: 'The star that gives us light and heat during the day',
      ),
      Flashcard(
        term: 'Moon',
        meaning: 'The natural satellite that shines at night',
      ),
      Flashcard(
        term: 'Cloud',
        meaning: 'A visible mass of tiny water droplets in the sky',
      ),
      Flashcard(
        term: 'Rainbow',
        meaning: 'A colourful arc that appears in the sky after rain',
      ),
    ],
    assessment: [
      AssessmentQuestion(
        question: 'Which of these is seen in the sky during the day?',
        options: ['Sun', 'Moon only', 'Stars only', 'Nothing'],
        correctIndex: 0,
      ),
      AssessmentQuestion(
        question: 'Which of these is seen in the sky at night?',
        options: ['Moon', 'Sun', 'Rainbow only', 'Nothing'],
        correctIndex: 0,
      ),
      AssessmentQuestion(
        question: 'A rainbow appears after?',
        options: ['Rain', 'Snow only', 'Wind', 'Earthquake'],
        correctIndex: 0,
      ),
      AssessmentQuestion(
        question: 'Clouds are made of?',
        options: ['Tiny water droplets', 'Sand', 'Smoke only', 'Rock'],
        correctIndex: 0,
      ),
      AssessmentQuestion(
        question: 'The sky is located?',
        options: [
          'Above the earth',
          'Below the earth',
          'Inside the earth',
          'Under the sea',
        ],
        correctIndex: 0,
      ),
    ],
  ),
  'Class 4|English|Frogs at School': ChapterContent(
    worksheet: [
      'Where do frogs usually live?',
      'What sound does a frog make?',
      'Write three things frogs might learn if they went to school, using your imagination.',
      'Name two other animals that live both on land and in water.',
      'Write four lines imagining a school for animals.',
    ],
    flashcards: [
      Flashcard(
        term: 'Frog',
        meaning: 'An amphibian that can live on land and in water',
      ),
      Flashcard(
        term: 'Amphibian',
        meaning: 'An animal that lives both in water and on land',
      ),
      Flashcard(term: 'Croak', meaning: 'The sound made by a frog'),
      Flashcard(
        term: 'Pond',
        meaning: 'A small body of still water where frogs often live',
      ),
      Flashcard(term: 'Tadpole', meaning: 'A baby frog'),
    ],
    assessment: [
      AssessmentQuestion(
        question: 'Frogs are an example of?',
        options: ['Amphibians', 'Birds', 'Mammals', 'Insects'],
        correctIndex: 0,
      ),
      AssessmentQuestion(
        question: 'The sound a frog makes is called a?',
        options: ['Croak', 'Bark', 'Roar', 'Chirp'],
        correctIndex: 0,
      ),
      AssessmentQuestion(
        question: 'A baby frog is called a?',
        options: ['Tadpole', 'Cub', 'Calf', 'Kitten'],
        correctIndex: 0,
      ),
      AssessmentQuestion(
        question: 'Frogs can live?',
        options: [
          'On land and in water',
          'Only underground',
          'Only in the sky',
          'Only in fire',
        ],
        correctIndex: 0,
      ),
      AssessmentQuestion(
        question: 'A small body of still water is a?',
        options: ['Pond', 'Desert', 'Mountain', 'Volcano'],
        correctIndex: 0,
      ),
    ],
  ),
  'Class 4|English|The Clever Fishes': ChapterContent(
    worksheet: [
      'Where do fish live?',
      'How do fish breathe underwater?',
      'What does being \'clever\' mean in your own words?',
      'Write three qualities of a clever character in a story.',
      'Name three fish you know about.',
    ],
    flashcards: [
      Flashcard(
        term: 'Fish',
        meaning: 'An animal that lives in water and breathes through gills',
      ),
      Flashcard(
        term: 'Gills',
        meaning: 'The body part fish use to breathe underwater',
      ),
      Flashcard(
        term: 'Clever',
        meaning: 'Quick to understand and think of smart solutions',
      ),
      Flashcard(term: 'Fin', meaning: 'The body part fish use to swim'),
      Flashcard(term: 'Aquatic', meaning: 'Living or growing in water'),
    ],
    assessment: [
      AssessmentQuestion(
        question: 'Fish breathe using their?',
        options: ['Gills', 'Lungs', 'Nose', 'Skin only'],
        correctIndex: 0,
      ),
      AssessmentQuestion(
        question: '\'Clever\' means?',
        options: [
          'Quick and smart in thinking',
          'Slow and lazy',
          'Angry',
          'Sleepy',
        ],
        correctIndex: 0,
      ),
      AssessmentQuestion(
        question: 'Fish use which part to swim?',
        options: ['Fins', 'Wings', 'Legs', 'Hands'],
        correctIndex: 0,
      ),
      AssessmentQuestion(
        question: 'Animals that live in water are called?',
        options: ['Aquatic', 'Terrestrial', 'Aerial', 'Nocturnal'],
        correctIndex: 0,
      ),
      AssessmentQuestion(
        question: 'A story about clever fishes usually teaches us?',
        options: ['A moral lesson', 'Cooking', 'Maths', 'Driving'],
        correctIndex: 0,
      ),
    ],
  ),
  'Class 4|English|Love for Nation': ChapterContent(
    worksheet: [
      'What does it mean to love your country?',
      'Name three symbols of India (like the flag or anthem).',
      'Write three ways children can show love for their nation.',
      'Why should we respect our national flag?',
      'Write four lines about why you love your country.',
    ],
    flashcards: [
      Flashcard(term: 'Nation', meaning: 'A country and its people'),
      Flashcard(
        term: 'Patriotism',
        meaning: 'Love and devotion for one\'s country',
      ),
      Flashcard(
        term: 'National flag',
        meaning: 'The flag that represents a country',
      ),
      Flashcard(
        term: 'National anthem',
        meaning: 'The official song of a country',
      ),
      Flashcard(term: 'Unity', meaning: 'Being together as one'),
    ],
    assessment: [
      AssessmentQuestion(
        question: 'Love and devotion for one\'s country is called?',
        options: ['Patriotism', 'Selfishness', 'Laziness', 'Anger'],
        correctIndex: 0,
      ),
      AssessmentQuestion(
        question: 'India\'s national flag is called the?',
        options: ['Tiranga', 'Union Jack', 'Stars and Stripes', 'Maple Leaf'],
        correctIndex: 0,
      ),
      AssessmentQuestion(
        question: 'What should we do when the national anthem plays?',
        options: ['Stand respectfully', 'Run away', 'Laugh', 'Sleep'],
        correctIndex: 0,
      ),
      AssessmentQuestion(
        question: 'A nation means a country and its?',
        options: ['People', 'Animals only', 'Rivers only', 'Mountains only'],
        correctIndex: 0,
      ),
      AssessmentQuestion(
        question: 'Being together as one is called?',
        options: ['Unity', 'Division', 'Conflict', 'Isolation'],
        correctIndex: 0,
      ),
    ],
  ),
  'Class 4|English|Pride of India': ChapterContent(
    worksheet: [
      'Name three things India is proud of (monuments, people, or achievements).',
      'What does \'pride\' mean?',
      'Name one famous Indian monument.',
      'Write three reasons why India is a great country.',
      'Write about one Indian achievement that makes you proud.',
    ],
    flashcards: [
      Flashcard(
        term: 'Pride',
        meaning: 'A feeling of deep satisfaction and honour',
      ),
      Flashcard(
        term: 'Monument',
        meaning: 'A structure built to remember a person or event',
      ),
      Flashcard(
        term: 'Heritage',
        meaning:
            'Things passed down from our ancestors, like culture and monuments',
      ),
      Flashcard(
        term: 'Achievement',
        meaning: 'Something accomplished successfully',
      ),
      Flashcard(
        term: 'Diversity',
        meaning: 'Having many different kinds of people, cultures, or things',
      ),
    ],
    assessment: [
      AssessmentQuestion(
        question: '\'Pride\' means a feeling of?',
        options: ['Deep satisfaction and honour', 'Sadness', 'Fear', 'Anger'],
        correctIndex: 0,
      ),
      AssessmentQuestion(
        question: 'The Taj Mahal is an example of a famous Indian?',
        options: ['Monument', 'River', 'Animal', 'Fruit'],
        correctIndex: 0,
      ),
      AssessmentQuestion(
        question: 'Things passed down from our ancestors are called?',
        options: ['Heritage', 'Waste', 'Toys', 'Food'],
        correctIndex: 0,
      ),
      AssessmentQuestion(
        question:
            'India is known for having many languages and cultures, which is called?',
        options: ['Diversity', 'Uniformity', 'Poverty', 'Silence'],
        correctIndex: 0,
      ),
      AssessmentQuestion(
        question: 'Something accomplished successfully is called an?',
        options: ['Achievement', 'Failure', 'Mistake', 'Accident'],
        correctIndex: 0,
      ),
    ],
  ),
  'Class 4|English|The Land of Rising Sun': ChapterContent(
    worksheet: [
      'Why is Japan called the \'Land of the Rising Sun\'?',
      'Name the capital city of Japan.',
      'What is the currency used in Japan?',
      'Name one famous traditional Japanese art or craft.',
      'Locate Japan on a map and name the ocean near it.',
    ],
    flashcards: [
      Flashcard(
        term: 'Japan',
        meaning:
            'An island country in East Asia, known as the Land of the Rising Sun',
      ),
      Flashcard(term: 'Tokyo', meaning: 'The capital city of Japan'),
      Flashcard(term: 'Yen', meaning: 'The currency of Japan'),
      Flashcard(term: 'Origami', meaning: 'The Japanese art of paper folding'),
      Flashcard(
        term: 'Sakura',
        meaning:
            'Japanese cherry blossom trees, famous for their spring flowers',
      ),
    ],
    assessment: [
      AssessmentQuestion(
        question: 'Japan is called the Land of the?',
        options: ['Rising Sun', 'Setting Sun', 'Full Moon', 'Falling Stars'],
        correctIndex: 0,
      ),
      AssessmentQuestion(
        question: 'What is the capital of Japan?',
        options: ['Tokyo', 'Beijing', 'Seoul', 'Bangkok'],
        correctIndex: 0,
      ),
      AssessmentQuestion(
        question: 'What is the currency of Japan?',
        options: ['Yen', 'Rupee', 'Dollar', 'Pound'],
        correctIndex: 0,
      ),
      AssessmentQuestion(
        question: 'Origami is the Japanese art of?',
        options: ['Paper folding', 'Cooking', 'Painting walls', 'Pottery only'],
        correctIndex: 0,
      ),
      AssessmentQuestion(
        question: 'Japan lies to the east of which continent?',
        options: ['Asia', 'Africa', 'Europe', 'South America'],
        correctIndex: 0,
      ),
    ],
  ),
  'Class 4|English|A Trip to Japan': ChapterContent(
    worksheet: [
      'If you visited Japan, name two places you would like to see.',
      'What is the famous high-speed train of Japan called?',
      'Name a traditional Japanese dish.',
      'What is Mount Fuji, and why is it famous?',
      'Write four lines describing an imaginary trip to Japan.',
    ],
    flashcards: [
      Flashcard(
        term: 'Shinkansen',
        meaning: 'Japan\'s famous high-speed bullet train',
      ),
      Flashcard(
        term: 'Mount Fuji',
        meaning: 'The highest and most famous mountain in Japan',
      ),
      Flashcard(
        term: 'Sushi',
        meaning:
            'A traditional Japanese dish made with vinegared rice and fish',
      ),
      Flashcard(term: 'Kimono', meaning: 'A traditional Japanese garment'),
      Flashcard(
        term: 'Temple',
        meaning: 'A place of worship, many of which are famous in Japan',
      ),
    ],
    assessment: [
      AssessmentQuestion(
        question: 'Japan\'s famous high-speed train is called the?',
        options: ['Shinkansen', 'Metro', 'Tram', 'Rickshaw'],
        correctIndex: 0,
      ),
      AssessmentQuestion(
        question: 'Mount Fuji is Japan\'s?',
        options: [
          'Highest mountain',
          'Longest river',
          'Largest lake',
          'Biggest city',
        ],
        correctIndex: 0,
      ),
      AssessmentQuestion(
        question: 'Sushi is a traditional food from?',
        options: ['Japan', 'Mexico', 'Italy', 'Brazil'],
        correctIndex: 0,
      ),
      AssessmentQuestion(
        question: 'A traditional Japanese garment is called a?',
        options: ['Kimono', 'Sari', 'Kilt', 'Toga'],
        correctIndex: 0,
      ),
      AssessmentQuestion(
        question: 'Which ocean lies along the east coast of Japan?',
        options: [
          'Pacific Ocean',
          'Atlantic Ocean',
          'Arctic Ocean',
          'Indian Ocean',
        ],
        correctIndex: 0,
      ),
    ],
  ),
  'Class 4|English|A Wonderful Place': ChapterContent(
    worksheet: [
      'Describe a place you find wonderful, in three sentences.',
      'Name three things that make a place beautiful.',
      'Write about your favourite place to visit.',
      'Why is it important to keep beautiful places clean?',
      'Write four lines about a place you dream of visiting.',
    ],
    flashcards: [
      Flashcard(term: 'Wonderful', meaning: 'Extremely good or pleasing'),
      Flashcard(
        term: 'Scenery',
        meaning: 'The natural features of a landscape',
      ),
      Flashcard(
        term: 'Destination',
        meaning: 'A place someone is travelling to',
      ),
      Flashcard(
        term: 'Landscape',
        meaning: 'The visible features of an area of land',
      ),
      Flashcard(
        term: 'Explore',
        meaning: 'To travel through a place to learn about it',
      ),
    ],
    assessment: [
      AssessmentQuestion(
        question: '\'Wonderful\' means?',
        options: [
          'Extremely good or pleasing',
          'Very bad',
          'Boring',
          'Dangerous',
        ],
        correctIndex: 0,
      ),
      AssessmentQuestion(
        question: 'The natural features of a landscape are called?',
        options: ['Scenery', 'Traffic', 'Noise', 'Pollution'],
        correctIndex: 0,
      ),
      AssessmentQuestion(
        question: 'A place someone is travelling to is called a?',
        options: ['Destination', 'Departure', 'Delay', 'Distance'],
        correctIndex: 0,
      ),
      AssessmentQuestion(
        question: 'To travel through a place to learn about it means to?',
        options: ['Explore', 'Ignore', 'Destroy', 'Forget'],
        correctIndex: 0,
      ),
      AssessmentQuestion(
        question: 'Keeping a beautiful place clean helps to?',
        options: [
          'Preserve it for others',
          'Destroy it',
          'Waste it',
          'Hide it',
        ],
        correctIndex: 0,
      ),
    ],
  ),
  'Class 4|English|Gulliver and the Lilliputians': ChapterContent(
    worksheet: [
      'Who is the author of the story \'Gulliver\'s Travels\'?',
      'Why were the Lilliputians surprised when they first saw Gulliver?',
      'How big were the Lilliputians compared to Gulliver?',
      'What lesson can we learn from the story of Gulliver and the Lilliputians?',
      'Write four lines imagining you meet very tiny people.',
    ],
    flashcards: [
      Flashcard(
        term: 'Gulliver',
        meaning:
            'The main character in the famous story \'Gulliver\'s Travels\'',
      ),
      Flashcard(
        term: 'Lilliputian',
        meaning: 'A tiny person from the imaginary land of Lilliput',
      ),
      Flashcard(
        term: 'Jonathan Swift',
        meaning: 'The author who wrote \'Gulliver\'s Travels\'',
      ),
      Flashcard(
        term: 'Giant',
        meaning: 'A very large person compared to others',
      ),
      Flashcard(
        term: 'Shipwreck',
        meaning: 'When a ship is destroyed or stranded, often by a storm',
      ),
    ],
    assessment: [
      AssessmentQuestion(
        question: 'Who wrote the story \'Gulliver\'s Travels\'?',
        options: [
          'Jonathan Swift',
          'William Shakespeare',
          'Rudyard Kipling',
          'Leo Tolstoy',
        ],
        correctIndex: 0,
      ),
      AssessmentQuestion(
        question: 'The Lilliputians in the story were?',
        options: [
          'Very tiny people',
          'Very tall giants',
          'Talking animals',
          'Robots',
        ],
        correctIndex: 0,
      ),
      AssessmentQuestion(
        question: 'How did Gulliver end up in Lilliput?',
        options: [
          'He was shipwrecked',
          'He flew there',
          'He was born there',
          'He drove there',
        ],
        correctIndex: 0,
      ),
      AssessmentQuestion(
        question: 'Compared to the Lilliputians, Gulliver was a?',
        options: ['Giant', 'Dwarf', 'Same size', 'Invisible'],
        correctIndex: 0,
      ),
      AssessmentQuestion(
        question: 'The land of the tiny people in the story is called?',
        options: ['Lilliput', 'Wonderland', 'Neverland', 'Narnia'],
        correctIndex: 0,
      ),
    ],
  ),
  'Class 4|English|Playing in a Lane': ChapterContent(
    worksheet: [
      'Name three games children can play in a lane or street.',
      'Why is it important to be careful while playing outdoors?',
      'Write three safety rules for playing outside.',
      'What games do you like to play with your friends in your neighbourhood?',
      'Write four lines about your favourite outdoor game.',
    ],
    flashcards: [
      Flashcard(term: 'Lane', meaning: 'A narrow road or street'),
      Flashcard(
        term: 'Neighbourhood',
        meaning: 'The area or streets close to one\'s home',
      ),
      Flashcard(
        term: 'Outdoor',
        meaning: 'Done or existing outside a building',
      ),
      Flashcard(term: 'Safety', meaning: 'Being protected from danger or harm'),
      Flashcard(term: 'Playmate', meaning: 'A friend who plays with you'),
    ],
    assessment: [
      AssessmentQuestion(
        question: 'A \'lane\' is a?',
        options: [
          'Narrow road',
          'Type of food',
          'Musical instrument',
          'Animal',
        ],
        correctIndex: 0,
      ),
      AssessmentQuestion(
        question: 'Games played outside are called?',
        options: [
          'Outdoor games',
          'Indoor games',
          'Board games only',
          'Video games only',
        ],
        correctIndex: 0,
      ),
      AssessmentQuestion(
        question: 'Why should children be careful while playing in a lane?',
        options: [
          'To avoid traffic accidents',
          'To win always',
          'To make noise',
          'To break rules',
        ],
        correctIndex: 0,
      ),
      AssessmentQuestion(
        question: 'A friend who plays with you is called a?',
        options: ['Playmate', 'Stranger', 'Teacher', 'Doctor'],
        correctIndex: 0,
      ),
      AssessmentQuestion(
        question: 'The area close to one\'s home is called the?',
        options: ['Neighbourhood', 'Ocean', 'Desert', 'Forest'],
        correctIndex: 0,
      ),
    ],
  ),
  'Class 4|English|Let\'s Play Carrom-board': ChapterContent(
    worksheet: [
      'What equipment is needed to play carrom?',
      'How many players can play carrom at one time?',
      'Write three rules of the game carrom.',
      'Why are indoor games like carrom good to play on rainy days?',
      'Write four lines describing how to play carrom.',
    ],
    flashcards: [
      Flashcard(
        term: 'Carrom',
        meaning: 'An indoor board game played by striking coins with a striker',
      ),
      Flashcard(
        term: 'Striker',
        meaning: 'The disc used to hit the coins in carrom',
      ),
      Flashcard(
        term: 'Board game',
        meaning: 'A game played on a flat board using pieces',
      ),
      Flashcard(
        term: 'Indoor game',
        meaning: 'A game played inside a building',
      ),
      Flashcard(
        term: 'Pocket',
        meaning: 'The corner hole in a carrom board where coins are aimed',
      ),
    ],
    assessment: [
      AssessmentQuestion(
        question: 'Carrom is played using a board and?',
        options: ['Coins and a striker', 'A ball and bat', 'A racket', 'A net'],
        correctIndex: 0,
      ),
      AssessmentQuestion(
        question: 'The disc used to strike coins in carrom is called the?',
        options: ['Striker', 'Racket', 'Bat', 'Puck'],
        correctIndex: 0,
      ),
      AssessmentQuestion(
        question: 'Carrom is an example of a?',
        options: ['Board game', 'Water sport', 'Athletic race', 'Card game'],
        correctIndex: 0,
      ),
      AssessmentQuestion(
        question: 'The corner holes on a carrom board are called?',
        options: ['Pockets', 'Goals', 'Wickets', 'Nets'],
        correctIndex: 0,
      ),
      AssessmentQuestion(
        question: 'Carrom is usually played?',
        options: ['Indoors', 'Underwater', 'In the sky', 'On a mountain'],
        correctIndex: 0,
      ),
    ],
  ),
  'Class 4|English|Wonderful Flying Machine': ChapterContent(
    worksheet: [
      'Name a machine that can fly.',
      'Who is credited with inventing the first successful airplane?',
      'Write three uses of aeroplanes.',
      'Imagine you invented a flying machine - describe it in three sentences.',
      'Name two parts of an aeroplane.',
    ],
    flashcards: [
      Flashcard(
        term: 'Aeroplane',
        meaning: 'A powered flying vehicle with fixed wings',
      ),
      Flashcard(
        term: 'Wright Brothers',
        meaning:
            'Inventors credited with building the first successful airplane',
      ),
      Flashcard(term: 'Pilot', meaning: 'A person who flies an aircraft'),
      Flashcard(term: 'Wing', meaning: 'The part of a plane that helps it fly'),
      Flashcard(
        term: 'Engine',
        meaning: 'The part of a machine that produces power to move it',
      ),
    ],
    assessment: [
      AssessmentQuestion(
        question:
            'Who is credited with inventing the first successful aeroplane?',
        options: [
          'The Wright Brothers',
          'Isaac Newton',
          'Albert Einstein',
          'Thomas Edison',
        ],
        correctIndex: 0,
      ),
      AssessmentQuestion(
        question: 'A person who flies an aircraft is called a?',
        options: ['Pilot', 'Driver', 'Sailor', 'Conductor'],
        correctIndex: 0,
      ),
      AssessmentQuestion(
        question: 'The part of a plane that helps it fly is the?',
        options: ['Wing', 'Wheel', 'Door', 'Seat'],
        correctIndex: 0,
      ),
      AssessmentQuestion(
        question: 'The part that produces power in a flying machine is the?',
        options: ['Engine', 'Window', 'Mirror', 'Carpet'],
        correctIndex: 0,
      ),
      AssessmentQuestion(
        question: 'Aeroplanes are used mainly to?',
        options: [
          'Travel through the air',
          'Sail on water',
          'Dig underground',
          'Swim in the sea',
        ],
        correctIndex: 0,
      ),
    ],
  ),
  'Class 4|English|Chhau: A Martial Dance': ChapterContent(
    worksheet: [
      'Which Indian states is Chhau dance famous in?',
      'What kind of themes does Chhau dance usually portray?',
      'Why is Chhau called a martial dance?',
      'Name one feature (like masks or costumes) associated with Chhau dance.',
      'Why is it important to preserve traditional dance forms like Chhau?',
    ],
    flashcards: [
      Flashcard(
        term: 'Chhau',
        meaning:
            'A traditional masked martial dance form from Jharkhand, Odisha, and West Bengal',
      ),
      Flashcard(
        term: 'Mask',
        meaning: 'A covering worn on the face, used in some styles of Chhau',
      ),
      Flashcard(
        term: 'Martial',
        meaning: 'Related to fighting or warrior skills',
      ),
      Flashcard(
        term: 'Folk dance',
        meaning: 'A traditional dance performed by the people of a region',
      ),
      Flashcard(
        term: 'Costume',
        meaning: 'Special clothing worn for a performance',
      ),
    ],
    assessment: [
      AssessmentQuestion(
        question: 'Chhau dance is traditionally performed in which region?',
        options: [
          'Jharkhand, Odisha and West Bengal',
          'Kerala and Tamil Nadu',
          'Punjab and Haryana',
          'Gujarat and Rajasthan',
        ],
        correctIndex: 0,
      ),
      AssessmentQuestion(
        question: 'Chhau is described as a martial dance because it includes?',
        options: [
          'Warrior-like movements',
          'Only singing',
          'Only sitting',
          'Cooking actions',
        ],
        correctIndex: 0,
      ),
      AssessmentQuestion(
        question: 'What is often worn during some styles of Chhau performance?',
        options: ['Masks', 'Helmets', 'Glasses', 'Gloves'],
        correctIndex: 0,
      ),
      AssessmentQuestion(
        question:
            'A dance performed traditionally by people of a region is called a?',
        options: ['Folk dance', 'Classical music', 'Sport', 'Painting'],
        correctIndex: 0,
      ),
      AssessmentQuestion(
        question:
            'Preserving traditional dances like Chhau helps to protect our?',
        options: [
          'Cultural heritage',
          'Only buildings',
          'Only food',
          'Only language',
        ],
        correctIndex: 0,
      ),
    ],
  ),
  'Class 4|English|Sarhul: A Festival of Nature': ChapterContent(
    worksheet: [
      'Which tree is worshipped during the Sarhul festival?',
      'In which season is Sarhul celebrated?',
      'Which communities in Jharkhand celebrate Sarhul?',
      'What does the Sarhul festival teach us about nature?',
      'Write four lines about why festivals connected to nature are important.',
    ],
    flashcards: [
      Flashcard(
        term: 'Sarhul',
        meaning:
            'A tribal spring festival of Jharkhand celebrating nature and the Sal tree',
      ),
      Flashcard(
        term: 'Sal tree',
        meaning: 'A tree considered sacred and worshipped during Sarhul',
      ),
      Flashcard(
        term: 'Tribal',
        meaning: 'Relating to a tribe or indigenous community',
      ),
      Flashcard(
        term: 'Spring',
        meaning: 'The season between winter and summer when new flowers bloom',
      ),
      Flashcard(
        term: 'Nature worship',
        meaning:
            'Honouring elements of nature like trees, rivers, and mountains',
      ),
    ],
    assessment: [
      AssessmentQuestion(
        question: 'Sarhul is a festival that worships which tree?',
        options: ['Sal tree', 'Mango tree', 'Banyan tree', 'Neem tree'],
        correctIndex: 0,
      ),
      AssessmentQuestion(
        question:
            'Sarhul is celebrated mainly by tribal communities of which state?',
        options: ['Jharkhand', 'Punjab', 'Gujarat', 'Kerala'],
        correctIndex: 0,
      ),
      AssessmentQuestion(
        question: 'In which season is Sarhul celebrated?',
        options: ['Spring', 'Winter', 'Monsoon', 'Autumn'],
        correctIndex: 0,
      ),
      AssessmentQuestion(
        question: 'Sarhul festival is closely connected with?',
        options: ['Nature and trees', 'Cricket', 'Technology', 'Cooking'],
        correctIndex: 0,
      ),
      AssessmentQuestion(
        question: 'Honouring elements of nature is called?',
        options: ['Nature worship', 'Shopping', 'Farming only', 'Cooking'],
        correctIndex: 0,
      ),
    ],
  ),
  'Class 4|Mathematics|ज्यामितीय आकृतियाँ': ChapterContent(
    worksheet: [
      'त्रिभुज की कितनी भुजाएँ होती हैं?',
      'वर्ग और आयत में क्या अंतर है?',
      'अपने आसपास की तीन गोल आकृतियों के नाम लिखिए।',
      'वृत्त की कोई एक विशेषता लिखिए।',
      'पंचभुज की कितनी भुजाएँ होती हैं?',
    ],
    flashcards: [
      Flashcard(term: 'त्रिभुज', meaning: 'तीन भुजाओं वाली आकृति'),
      Flashcard(term: 'वर्ग', meaning: 'चार बराबर भुजाओं वाली आकृति'),
      Flashcard(
        term: 'आयत',
        meaning: 'चार भुजाओं वाली आकृति जिसमें सम्मुख भुजाएँ बराबर होती हैं',
      ),
      Flashcard(term: 'वृत्त', meaning: 'एक गोल बंद आकृति'),
      Flashcard(term: 'पंचभुज', meaning: 'पाँच भुजाओं वाली आकृति'),
    ],
    assessment: [
      AssessmentQuestion(
        question: 'त्रिभुज की भुजाओं की संख्या कितनी होती है?',
        options: ['3', '4', '5', '6'],
        correctIndex: 0,
      ),
      AssessmentQuestion(
        question: 'वर्ग की सभी भुजाएँ कैसी होती हैं?',
        options: ['बराबर', 'असमान', 'गोल', 'टेढ़ी'],
        correctIndex: 0,
      ),
      AssessmentQuestion(
        question: 'वृत्त की कितनी भुजाएँ होती हैं?',
        options: ['कोई भुजा नहीं', '4 भुजाएँ', '3 भुजाएँ', '6 भुजाएँ'],
        correctIndex: 0,
      ),
      AssessmentQuestion(
        question: 'पंचभुज में कितनी भुजाएँ होती हैं?',
        options: ['5', '4', '3', '6'],
        correctIndex: 0,
      ),
      AssessmentQuestion(
        question: 'आयत में सम्मुख भुजाएँ कैसी होती हैं?',
        options: ['बराबर', 'असमान', 'गोल', 'एक जैसी नहीं'],
        correctIndex: 0,
      ),
    ],
  ),
  'Class 4|Mathematics|संख्याएँ': ChapterContent(
    worksheet: [
      '4-अंकों की सबसे बड़ी संख्या लिखिए।',
      '3245 में सैकड़े के स्थान का अंक बताइए।',
      'संख्याओं को आरोही क्रम (बढ़ते क्रम) में लिखिए: 452, 245, 524, 254',
      '6789 का विस्तारित रूप (expanded form) लिखिए।',
      '1000 से पहले आने वाली संख्या कौन-सी है?',
    ],
    flashcards: [
      Flashcard(term: 'इकाई', meaning: 'संख्या का सबसे दायाँ अंक स्थान'),
      Flashcard(term: 'दहाई', meaning: 'दायें से दूसरा स्थान'),
      Flashcard(term: 'सैकड़ा', meaning: 'दायें से तीसरा स्थान'),
      Flashcard(term: 'हज़ार', meaning: 'दायें से चौथा स्थान'),
      Flashcard(term: 'आरोही क्रम', meaning: 'छोटी से बड़ी संख्या का क्रम'),
    ],
    assessment: [
      AssessmentQuestion(
        question: '3245 में सैकड़े के स्थान पर कौन-सा अंक है?',
        options: ['2', '3', '4', '5'],
        correctIndex: 0,
      ),
      AssessmentQuestion(
        question: '4 अंकों की सबसे बड़ी संख्या कौन-सी है?',
        options: ['9999', '1000', '9000', '8999'],
        correctIndex: 0,
      ),
      AssessmentQuestion(
        question: '999 के बाद कौन-सी संख्या आती है?',
        options: ['1000', '998', '1001', '900'],
        correctIndex: 0,
      ),
      AssessmentQuestion(
        question: 'संख्याओं 452, 245, 524 में सबसे बड़ी संख्या कौन-सी है?',
        options: ['524', '452', '245', 'सभी बराबर'],
        correctIndex: 0,
      ),
      AssessmentQuestion(
        question: '6000 + 700 + 80 + 9 किस संख्या के बराबर है?',
        options: ['6789', '6879', '6798', '6978'],
        correctIndex: 0,
      ),
    ],
  ),
  'Class 4|Mathematics|जोड़': ChapterContent(
    worksheet: [
      '2345 + 1234 = ? जोड़िए।',
      '5678 + 2222 = ? जोड़िए।',
      'रीना के पास 350 रुपये हैं और उसकी माँ ने उसे 275 रुपये और दिए। अब उसके पास कुल कितने रुपये हैं?',
      '4009 + 991 = ? जोड़िए।',
      '1500 और 2500 का योग ज्ञात कीजिए।',
    ],
    flashcards: [
      Flashcard(term: 'जोड़', meaning: 'दो या अधिक संख्याओं को मिलाना'),
      Flashcard(term: 'योग', meaning: 'जोड़ का परिणाम'),
      Flashcard(term: 'योगजक', meaning: 'जोड़ी जाने वाली संख्याएँ'),
      Flashcard(
        term: 'हासिल',
        meaning: 'जोड़ते समय आगे बढ़ाया गया अंक (carry)',
      ),
      Flashcard(term: 'कुल', meaning: 'सबका मिलाकर योग'),
    ],
    assessment: [
      AssessmentQuestion(
        question: '2345 + 1234 = ?',
        options: ['3579', '3589', '3479', '3679'],
        correctIndex: 0,
      ),
      AssessmentQuestion(
        question: '4009 + 991 = ?',
        options: ['5000', '4999', '5100', '4900'],
        correctIndex: 0,
      ),
      AssessmentQuestion(
        question: '1500 + 2500 = ?',
        options: ['4000', '3500', '4500', '3000'],
        correctIndex: 0,
      ),
      AssessmentQuestion(
        question: 'जोड़ का परिणाम क्या कहलाता है?',
        options: ['योग', 'अंतर', 'गुणनफल', 'भागफल'],
        correctIndex: 0,
      ),
      AssessmentQuestion(
        question: '5678 + 2222 = ?',
        options: ['7900', '7800', '7990', '7890'],
        correctIndex: 0,
      ),
    ],
  ),
  'Class 4|Mathematics|घटाव': ChapterContent(
    worksheet: [
      '5000 - 2345 = ? घटाइए।',
      '9876 - 4321 = ? घटाइए।',
      'मोहन के पास 800 रुपये थे, उसने 350 रुपये खर्च कर दिए। अब उसके पास कितने रुपये बचे?',
      '7000 - 999 = ? घटाइए।',
      '6543 - 1234 = ? घटाइए।',
    ],
    flashcards: [
      Flashcard(
        term: 'घटाव',
        meaning: 'एक संख्या में से दूसरी संख्या को निकालना',
      ),
      Flashcard(term: 'अंतर', meaning: 'घटाव का परिणाम'),
      Flashcard(
        term: 'घटावट',
        meaning: 'जिस संख्या में से घटाया जाता है (minuend)',
      ),
      Flashcard(
        term: 'उधार लेना',
        meaning: 'घटाते समय पड़ोसी अंक से लिया गया मान (borrow)',
      ),
      Flashcard(term: 'शेष', meaning: 'बचा हुआ भाग'),
    ],
    assessment: [
      AssessmentQuestion(
        question: '5000 - 2345 = ?',
        options: ['2655', '2755', '2645', '2565'],
        correctIndex: 0,
      ),
      AssessmentQuestion(
        question: '9876 - 4321 = ?',
        options: ['5555', '5545', '5655', '5455'],
        correctIndex: 0,
      ),
      AssessmentQuestion(
        question: '7000 - 999 = ?',
        options: ['6001', '6011', '5999', '6100'],
        correctIndex: 0,
      ),
      AssessmentQuestion(
        question: 'घटाव का परिणाम क्या कहलाता है?',
        options: ['अंतर', 'योग', 'गुणनफल', 'भागफल'],
        correctIndex: 0,
      ),
      AssessmentQuestion(
        question: '6543 - 1234 = ?',
        options: ['5309', '5319', '5209', '5409'],
        correctIndex: 0,
      ),
    ],
  ),
  'Class 4|Mathematics|गुणा': ChapterContent(
    worksheet: [
      '25 × 4 = ? गुणा कीजिए।',
      '123 × 3 = ? गुणा कीजिए।',
      'एक डिब्बे में 12 पेंसिलें हैं। ऐसे 8 डिब्बों में कुल कितनी पेंसिलें होंगी?',
      '45 × 10 = ? गुणा कीजिए।',
      '7 × 8 = ? गुणनफल ज्ञात कीजिए।',
    ],
    flashcards: [
      Flashcard(
        term: 'गुणा',
        meaning: 'किसी संख्या को बार-बार जोड़ने की क्रिया',
      ),
      Flashcard(term: 'गुणनफल', meaning: 'गुणा का परिणाम'),
      Flashcard(term: 'गुणक', meaning: 'जिससे गुणा किया जाता है'),
      Flashcard(term: 'गुण्य', meaning: 'जिसे गुणा किया जाता है'),
      Flashcard(term: 'पहाड़ा', meaning: 'गुणा की तालिका'),
    ],
    assessment: [
      AssessmentQuestion(
        question: '25 × 4 = ?',
        options: ['100', '90', '110', '120'],
        correctIndex: 0,
      ),
      AssessmentQuestion(
        question: '7 × 8 = ?',
        options: ['56', '54', '64', '48'],
        correctIndex: 0,
      ),
      AssessmentQuestion(
        question: '12 पेंसिलों के 8 डिब्बों में कुल पेंसिलें कितनी होंगी?',
        options: ['96', '84', '108', '100'],
        correctIndex: 0,
      ),
      AssessmentQuestion(
        question: '45 × 10 = ?',
        options: ['450', '405', '540', '45'],
        correctIndex: 0,
      ),
      AssessmentQuestion(
        question: 'गुणा का परिणाम क्या कहलाता है?',
        options: ['गुणनफल', 'योग', 'अंतर', 'भागफल'],
        correctIndex: 0,
      ),
    ],
  ),
  'Class 4|Mathematics|भाग': ChapterContent(
    worksheet: [
      '84 ÷ 7 = ? भाग कीजिए।',
      '96 ÷ 8 = ? भाग कीजिए।',
      '45 सेबों को 5 बच्चों में बराबर बाँटा जाए तो प्रत्येक बच्चे को कितने सेब मिलेंगे?',
      '100 ÷ 4 = ? भाग कीजिए।',
      '63 ÷ 9 = ? भागफल ज्ञात कीजिए।',
    ],
    flashcards: [
      Flashcard(term: 'भाग', meaning: 'किसी संख्या को बराबर भागों में बाँटना'),
      Flashcard(term: 'भागफल', meaning: 'भाग का परिणाम'),
      Flashcard(term: 'भाजक', meaning: 'जिससे भाग दिया जाता है'),
      Flashcard(term: 'भाज्य', meaning: 'जिसे भाग दिया जाता है'),
      Flashcard(term: 'शेषफल', meaning: 'भाग करने के बाद बचा हुआ भाग'),
    ],
    assessment: [
      AssessmentQuestion(
        question: '84 ÷ 7 = ?',
        options: ['12', '11', '13', '14'],
        correctIndex: 0,
      ),
      AssessmentQuestion(
        question:
            '45 सेबों को 5 बच्चों में बराबर बाँटने पर प्रत्येक को कितने मिलेंगे?',
        options: ['9', '8', '10', '7'],
        correctIndex: 0,
      ),
      AssessmentQuestion(
        question: '100 ÷ 4 = ?',
        options: ['25', '20', '30', '24'],
        correctIndex: 0,
      ),
      AssessmentQuestion(
        question: 'भाग का परिणाम क्या कहलाता है?',
        options: ['भागफल', 'गुणनफल', 'योग', 'अंतर'],
        correctIndex: 0,
      ),
      AssessmentQuestion(
        question: '63 ÷ 9 = ?',
        options: ['7', '6', '8', '9'],
        correctIndex: 0,
      ),
    ],
  ),
  'Class 4|Mathematics|भिन्न': ChapterContent(
    worksheet: [
      '1/2 और 1/4 में कौन-सी भिन्न बड़ी है?',
      'एक पिज़्ज़ा को 4 बराबर भागों में बाँटा गया है, यदि आपने 1 भाग खाया तो आपने कितना भाग खाया, भिन्न में लिखिए।',
      '3/4 भिन्न में अंश और हर बताइए।',
      '2/8 को सरलतम रूप में लिखिए।',
      '1/2 + 1/2 = ? जोड़िए।',
    ],
    flashcards: [
      Flashcard(
        term: 'भिन्न',
        meaning: 'किसी वस्तु के बराबर भागों को दर्शाने वाली संख्या',
      ),
      Flashcard(term: 'अंश', meaning: 'भिन्न में ऊपर लिखी संख्या'),
      Flashcard(term: 'हर', meaning: 'भिन्न में नीचे लिखी संख्या'),
      Flashcard(term: 'सरलतम रूप', meaning: 'भिन्न का सबसे छोटा रूप'),
      Flashcard(term: 'समान भिन्न', meaning: 'वे भिन्न जिनका मान बराबर हो'),
    ],
    assessment: [
      AssessmentQuestion(
        question: '3/4 में अंश कौन-सा है?',
        options: ['3', '4', '7', '1'],
        correctIndex: 0,
      ),
      AssessmentQuestion(
        question: '1/2 और 1/4 में बड़ी भिन्न कौन-सी है?',
        options: ['1/2', '1/4', 'दोनों बराबर', 'कोई नहीं'],
        correctIndex: 0,
      ),
      AssessmentQuestion(
        question: '2/8 का सरलतम रूप है?',
        options: ['1/4', '1/2', '2/4', '1/8'],
        correctIndex: 0,
      ),
      AssessmentQuestion(
        question: '1/2 + 1/2 = ?',
        options: ['1', '2', '1/4', '0'],
        correctIndex: 0,
      ),
      AssessmentQuestion(
        question: 'भिन्न में नीचे लिखी संख्या को क्या कहते हैं?',
        options: ['हर', 'अंश', 'योग', 'गुणनफल'],
        correctIndex: 0,
      ),
    ],
  ),
  'Class 4|Mathematics|मापन': ChapterContent(
    worksheet: [
      'लंबाई मापने की मानक इकाई क्या है?',
      '1 मीटर में कितने सेंटीमीटर होते हैं?',
      '1 किलोग्राम में कितने ग्राम होते हैं?',
      'अपने घर की किसी वस्तु की लंबाई अनुमान लगाकर लिखिए।',
      '1 लीटर में कितने मिलीलीटर होते हैं?',
    ],
    flashcards: [
      Flashcard(term: 'मीटर', meaning: 'लंबाई मापने की मानक इकाई'),
      Flashcard(term: 'किलोग्राम', meaning: 'भार मापने की मानक इकाई'),
      Flashcard(term: 'लीटर', meaning: 'आयतन/तरल मापने की मानक इकाई'),
      Flashcard(term: 'सेंटीमीटर', meaning: 'मीटर का छोटा भाग (1/100 मीटर)'),
      Flashcard(term: 'तराजू', meaning: 'भार मापने का यंत्र'),
    ],
    assessment: [
      AssessmentQuestion(
        question: '1 मीटर में कितने सेंटीमीटर होते हैं?',
        options: ['100', '10', '1000', '50'],
        correctIndex: 0,
      ),
      AssessmentQuestion(
        question: '1 किलोग्राम में कितने ग्राम होते हैं?',
        options: ['1000', '100', '10', '500'],
        correctIndex: 0,
      ),
      AssessmentQuestion(
        question: '1 लीटर में कितने मिलीलीटर होते हैं?',
        options: ['1000', '100', '10', '500'],
        correctIndex: 0,
      ),
      AssessmentQuestion(
        question: 'लंबाई मापने की मानक इकाई कौन-सी है?',
        options: ['मीटर', 'किलोग्राम', 'लीटर', 'सेकंड'],
        correctIndex: 0,
      ),
      AssessmentQuestion(
        question: 'भार मापने के लिए किस यंत्र का प्रयोग होता है?',
        options: ['तराजू', 'घड़ी', 'स्केल', 'थर्मामीटर'],
        correctIndex: 0,
      ),
    ],
  ),
  'Class 4|Mathematics|पट्टीकरण, क्षेत्रफल एवं परिमाप': ChapterContent(
    worksheet: [
      'एक आयत की लंबाई 5 सेमी और चौड़ाई 3 सेमी है। उसका परिमाप ज्ञात कीजिए।',
      'उसी आयत का क्षेत्रफल ज्ञात कीजिए।',
      '4 सेमी भुजा वाले वर्ग का परिमाप ज्ञात कीजिए।',
      'उसी वर्ग का क्षेत्रफल ज्ञात कीजिए।',
      'यदि एक फर्श को 1 वर्ग सेमी की टाइलों से ढका जाए और फर्श का क्षेत्रफल 20 वर्ग सेमी हो, तो कितनी टाइलों की आवश्यकता होगी?',
    ],
    flashcards: [
      Flashcard(term: 'परिमाप', meaning: 'किसी आकृति की सीमा की कुल लंबाई'),
      Flashcard(term: 'क्षेत्रफल', meaning: 'किसी आकृति द्वारा घेरा गया स्थान'),
      Flashcard(
        term: 'पट्टीकरण',
        meaning: 'बिना खाली जगह छोड़े आकृतियों से सतह ढकना (टाइलिंग)',
      ),
      Flashcard(term: 'वर्ग सेमी', meaning: 'क्षेत्रफल मापने की इकाई'),
      Flashcard(term: 'भुजा', meaning: 'आकृति की सीमा रेखा'),
    ],
    assessment: [
      AssessmentQuestion(
        question: '5 सेमी लंबाई और 3 सेमी चौड़ाई वाले आयत का परिमाप क्या होगा?',
        options: ['16 सेमी', '15 सेमी', '8 सेमी', '18 सेमी'],
        correctIndex: 0,
      ),
      AssessmentQuestion(
        question: 'उसी आयत का क्षेत्रफल क्या होगा?',
        options: [
          '15 वर्ग सेमी',
          '16 वर्ग सेमी',
          '8 वर्ग सेमी',
          '20 वर्ग सेमी',
        ],
        correctIndex: 0,
      ),
      AssessmentQuestion(
        question: '4 सेमी भुजा वाले वर्ग का क्षेत्रफल क्या होगा?',
        options: [
          '16 वर्ग सेमी',
          '8 वर्ग सेमी',
          '12 वर्ग सेमी',
          '20 वर्ग सेमी',
        ],
        correctIndex: 0,
      ),
      AssessmentQuestion(
        question: '4 सेमी भुजा वाले वर्ग का परिमाप क्या होगा?',
        options: ['16 सेमी', '12 सेमी', '8 सेमी', '20 सेमी'],
        correctIndex: 0,
      ),
      AssessmentQuestion(
        question: 'क्षेत्रफल किसे कहते हैं?',
        options: [
          'आकृति द्वारा घेरा गया स्थान',
          'आकृति की सीमा की लंबाई',
          'आकृति का रंग',
          'आकृति का वजन',
        ],
        correctIndex: 0,
      ),
    ],
  ),
  'Class 4|Mathematics|पैटर्न': ChapterContent(
    worksheet: [
      '2, 4, 6, 8, __ अगली संख्या क्या होगी?',
      '5, 10, 15, 20, __ पैटर्न पूरा कीजिए।',
      'गोला, त्रिभुज, गोला, त्रिभुज, __ अगली आकृति क्या होगी?',
      '3, 6, 9, 12, __ पैटर्न में अगली संख्या लिखिए।',
      'अपने आसपास दिखने वाला एक पैटर्न (जैसे कपड़े या दीवार पर) लिखिए।',
    ],
    flashcards: [
      Flashcard(
        term: 'पैटर्न',
        meaning: 'एक निश्चित क्रम में दोहराई जाने वाली आकृति या संख्या',
      ),
      Flashcard(term: 'क्रम', meaning: 'वस्तुओं या संख्याओं का व्यवस्थित रूप'),
      Flashcard(term: 'दोहराव', meaning: 'बार-बार आना'),
      Flashcard(
        term: 'बढ़ता पैटर्न',
        meaning: 'पैटर्न जिसमें संख्याएँ बढ़ती जाती हैं',
      ),
      Flashcard(
        term: 'संख्या शृंखला',
        meaning: 'क्रम में लिखी गई संख्याओं की सूची',
      ),
    ],
    assessment: [
      AssessmentQuestion(
        question: '2, 4, 6, 8, __ में अगली संख्या क्या है?',
        options: ['10', '9', '12', '11'],
        correctIndex: 0,
      ),
      AssessmentQuestion(
        question: '5, 10, 15, 20, __ में अगली संख्या क्या है?',
        options: ['25', '22', '30', '24'],
        correctIndex: 0,
      ),
      AssessmentQuestion(
        question: '3, 6, 9, 12, __ में अगली संख्या क्या है?',
        options: ['15', '14', '16', '13'],
        correctIndex: 0,
      ),
      AssessmentQuestion(
        question:
            'एक निश्चित क्रम में दोहराई जाने वाली संख्या या आकृति को क्या कहते हैं?',
        options: ['पैटर्न', 'भिन्न', 'परिमाप', 'क्षेत्रफल'],
        correctIndex: 0,
      ),
      AssessmentQuestion(
        question: 'गोला, त्रिभुज, गोला, त्रिभुज, __ में अगली आकृति क्या होगी?',
        options: ['गोला', 'वर्ग', 'आयत', 'पंचभुज'],
        correctIndex: 0,
      ),
    ],
  ),
  'Class 4|Environmental Studies|रिश्ते नाते': ChapterContent(
    worksheet: [
      'अपने परिवार के पाँच सदस्यों के नाम और उनसे अपना रिश्ता लिखिए।',
      'माता-पिता के माता-पिता को क्या कहते हैं?',
      'रिश्तों में प्रेम और सम्मान क्यों ज़रूरी है?',
      'संयुक्त परिवार और एकल परिवार में क्या अंतर है?',
      'अपने किसी प्रिय रिश्तेदार के बारे में तीन वाक्य लिखिए।',
    ],
    flashcards: [
      Flashcard(
        term: 'परिवार',
        meaning: 'साथ रहने वाले माता-पिता व बच्चों का समूह',
      ),
      Flashcard(term: 'रिश्ता', meaning: 'दो व्यक्तियों के बीच का संबंध'),
      Flashcard(
        term: 'संयुक्त परिवार',
        meaning: 'जिसमें दादा-दादी, चाचा-चाची आदि साथ रहते हैं',
      ),
      Flashcard(
        term: 'एकल परिवार',
        meaning: 'जिसमें केवल माता-पिता और बच्चे रहते हैं',
      ),
      Flashcard(term: 'सम्मान', meaning: 'दूसरों के प्रति आदर का भाव'),
    ],
    assessment: [
      AssessmentQuestion(
        question: 'माता-पिता के माता-पिता को क्या कहते हैं?',
        options: ['दादा-दादी', 'भाई-बहन', 'मामा-मामी', 'पड़ोसी'],
        correctIndex: 0,
      ),
      AssessmentQuestion(
        question:
            'जिस परिवार में दादा-दादी, चाचा-चाची साथ रहते हैं उसे क्या कहते हैं?',
        options: ['संयुक्त परिवार', 'एकल परिवार', 'पड़ोसी', 'मित्र'],
        correctIndex: 0,
      ),
      AssessmentQuestion(
        question: 'केवल माता-पिता और बच्चों वाले परिवार को क्या कहते हैं?',
        options: ['एकल परिवार', 'संयुक्त परिवार', 'विद्यालय', 'समाज'],
        correctIndex: 0,
      ),
      AssessmentQuestion(
        question: 'रिश्तों में क्या होना ज़रूरी है?',
        options: ['प्रेम और सम्मान', 'झगड़ा', 'ईर्ष्या', 'भय'],
        correctIndex: 0,
      ),
      AssessmentQuestion(
        question: 'पिता के भाई को क्या कहते हैं?',
        options: ['चाचा', 'मामा', 'भांजा', 'भतीजा'],
        correctIndex: 0,
      ),
    ],
  ),
  'Class 4|Environmental Studies|छोटे कान, बड़े कान': ChapterContent(
    worksheet: [
      'किन-किन जानवरों के कान बड़े होते हैं?',
      'किन-किन जानवरों के कान छोटे होते हैं?',
      'जानवरों के कान उन्हें क्या सुनने में मदद करते हैं?',
      'हाथी के कान बड़े होने का क्या लाभ होता है?',
      'अपने कान की देखभाल कैसे करनी चाहिए, तीन तरीके लिखिए।',
    ],
    flashcards: [
      Flashcard(term: 'कान', meaning: 'सुनने का अंग'),
      Flashcard(term: 'हाथी', meaning: 'बड़े कानों वाला विशाल जानवर'),
      Flashcard(term: 'खरगोश', meaning: 'लंबे कानों वाला छोटा जानवर'),
      Flashcard(term: 'साँप', meaning: 'बिना बाहरी कान वाला जीव'),
      Flashcard(term: 'श्रवण शक्ति', meaning: 'सुनने की क्षमता'),
    ],
    assessment: [
      AssessmentQuestion(
        question: 'हाथी के कान कैसे होते हैं?',
        options: ['बड़े', 'छोटे', 'गायब', 'बहुत पतले'],
        correctIndex: 0,
      ),
      AssessmentQuestion(
        question: 'खरगोश के कान कैसे होते हैं?',
        options: ['लंबे', 'बहुत छोटे', 'चौकोर', 'गोल केवल'],
        correctIndex: 0,
      ),
      AssessmentQuestion(
        question: 'कान किस काम आते हैं?',
        options: ['सुनने में', 'देखने में', 'सूंघने में', 'चखने में'],
        correctIndex: 0,
      ),
      AssessmentQuestion(
        question: 'सुनने की क्षमता को क्या कहते हैं?',
        options: [
          'श्रवण शक्ति',
          'दृष्टि शक्ति',
          'स्वाद शक्ति',
          'सूंघने की शक्ति',
        ],
        correctIndex: 0,
      ),
      AssessmentQuestion(
        question: 'साँप के बाहरी कान कैसे होते हैं?',
        options: ['नहीं होते', 'बहुत बड़े', 'चौकोर', 'रंगीन'],
        correctIndex: 0,
      ),
    ],
  ),
  'Class 4|Environmental Studies|नक्शा': ChapterContent(
    worksheet: [
      'नक्शा किसे कहते हैं?',
      'नक्शे में उत्तर दिशा किस ओर दिखाई जाती है (सामान्यतः)?',
      'नक्शे में नदी को किस रंग से दिखाया जाता है?',
      'अपने विद्यालय तक जाने के रास्ते का एक सरल नक्शा बनाइए।',
      'नक्शा पढ़ने से हमें क्या लाभ होता है?',
    ],
    flashcards: [
      Flashcard(term: 'नक्शा', meaning: 'किसी क्षेत्र का चित्रात्मक निरूपण'),
      Flashcard(
        term: 'दिशा',
        meaning: 'उत्तर, दक्षिण, पूर्व, पश्चिम जैसी स्थिति बताने वाला संकेत',
      ),
      Flashcard(
        term: 'चिन्ह',
        meaning: 'नक्शे में वस्तुओं को दर्शाने वाला प्रतीक',
      ),
      Flashcard(
        term: 'पैमाना',
        meaning: 'नक्शे और वास्तविक दूरी के बीच का अनुपात',
      ),
      Flashcard(term: 'भूगोल', meaning: 'पृथ्वी की सतह और स्थानों का अध्ययन'),
    ],
    assessment: [
      AssessmentQuestion(
        question: 'नक्शे में सामान्यतः उत्तर दिशा किस ओर होती है?',
        options: ['ऊपर', 'नीचे', 'बाएँ', 'दाएँ'],
        correctIndex: 0,
      ),
      AssessmentQuestion(
        question: 'नक्शे में नदियों को सामान्यतः किस रंग से दिखाया जाता है?',
        options: ['नीला', 'लाल', 'पीला', 'काला'],
        correctIndex: 0,
      ),
      AssessmentQuestion(
        question: 'नक्शा किसका चित्रात्मक निरूपण है?',
        options: [
          'किसी क्षेत्र का',
          'किसी व्यक्ति का',
          'किसी जानवर का',
          'किसी फल का',
        ],
        correctIndex: 0,
      ),
      AssessmentQuestion(
        question: 'नक्शे और असली दूरी के अनुपात को क्या कहते हैं?',
        options: ['पैमाना', 'चिन्ह', 'दिशा', 'रंग'],
        correctIndex: 0,
      ),
      AssessmentQuestion(
        question: 'पृथ्वी की सतह और स्थानों के अध्ययन को क्या कहते हैं?',
        options: ['भूगोल', 'इतिहास', 'विज्ञान', 'गणित'],
        correctIndex: 0,
      ),
    ],
  ),
  'Class 4|Environmental Studies|आशा की मित्र मधुमक्खियाँ': ChapterContent(
    worksheet: [
      'मधुमक्खियाँ किससे शहद बनाती हैं?',
      'मधुमक्खियाँ पौधों के लिए किस प्रकार सहायक होती हैं?',
      'मधुमक्खी के छत्ते को क्या कहते हैं?',
      'मधुमक्खियों से हमें कौन-कौन सी चीज़ें प्राप्त होती हैं?',
      'मधुमक्खियों को क्यों नहीं छेड़ना चाहिए?',
    ],
    flashcards: [
      Flashcard(term: 'मधुमक्खी', meaning: 'शहद बनाने वाला कीट'),
      Flashcard(term: 'छत्ता', meaning: 'मधुमक्खियों का घर'),
      Flashcard(
        term: 'परागण',
        meaning: 'फूलों से पराग एक पौधे से दूसरे तक पहुँचाने की क्रिया',
      ),
      Flashcard(
        term: 'शहद',
        meaning: 'मधुमक्खियों द्वारा बनाया गया मीठा पदार्थ',
      ),
      Flashcard(term: 'रानी मक्खी', meaning: 'छत्ते की मुखिया मक्खी'),
    ],
    assessment: [
      AssessmentQuestion(
        question: 'मधुमक्खियाँ किसके लिए जानी जाती हैं?',
        options: [
          'शहद बनाने के लिए',
          'दूध देने के लिए',
          'अंडे देने के लिए',
          'ऊन देने के लिए',
        ],
        correctIndex: 0,
      ),
      AssessmentQuestion(
        question:
            'फूलों से पराग एक पौधे से दूसरे तक ले जाने की क्रिया क्या कहलाती है?',
        options: ['परागण', 'श्वसन', 'पाचन', 'उत्सर्जन'],
        correctIndex: 0,
      ),
      AssessmentQuestion(
        question: 'मधुमक्खियों का घर क्या कहलाता है?',
        options: ['छत्ता', 'घोंसला', 'बिल', 'कोटर'],
        correctIndex: 0,
      ),
      AssessmentQuestion(
        question: 'छत्ते की मुखिया मक्खी को क्या कहते हैं?',
        options: ['रानी मक्खी', 'राजा मक्खी', 'सैनिक मक्खी', 'मजदूर मक्खी'],
        correctIndex: 0,
      ),
      AssessmentQuestion(
        question: 'मधुमक्खियाँ पौधों की किस प्रकार सहायता करती हैं?',
        options: ['परागण द्वारा', 'पानी देकर', 'खाद देकर', 'छाया देकर'],
        correctIndex: 0,
      ),
    ],
  ),
  'Class 4|Environmental Studies|यात्रा ऋचा की': ChapterContent(
    worksheet: [
      'ऋचा की यात्रा में वह किन-किन जगहों से गुज़री होगी, अपने विचार से लिखिए।',
      'आपने अब तक की सबसे यादगार यात्रा के बारे में तीन वाक्य लिखिए।',
      'यात्रा के दौरान हमें किन बातों का ध्यान रखना चाहिए?',
      'यात्रा करने से हमें क्या-क्या सीखने को मिलता है?',
      'यात्रा के लिए उपयोग होने वाले तीन साधनों के नाम लिखिए।',
    ],
    flashcards: [
      Flashcard(term: 'यात्रा', meaning: 'एक स्थान से दूसरे स्थान तक जाना'),
      Flashcard(term: 'साधन', meaning: 'यात्रा के लिए उपयोग होने वाला वाहन'),
      Flashcard(term: 'मार्ग', meaning: 'यात्रा का रास्ता'),
      Flashcard(term: 'अनुभव', meaning: 'यात्रा से प्राप्त जानकारी और सीख'),
      Flashcard(term: 'गंतव्य', meaning: 'यात्रा की मंज़िल'),
    ],
    assessment: [
      AssessmentQuestion(
        question: 'यात्रा के लिए किस साधन का उपयोग किया जा सकता है?',
        options: ['बस', 'कुर्सी', 'मेज़', 'किताब'],
        correctIndex: 0,
      ),
      AssessmentQuestion(
        question: 'यात्रा की मंज़िल को क्या कहते हैं?',
        options: ['गंतव्य', 'मार्ग', 'साधन', 'अनुभव'],
        correctIndex: 0,
      ),
      AssessmentQuestion(
        question: 'यात्रा से हमें क्या मिलता है?',
        options: ['नया अनुभव', 'कुछ नहीं', 'केवल थकान', 'भय'],
        correctIndex: 0,
      ),
      AssessmentQuestion(
        question: 'यात्रा का रास्ता क्या कहलाता है?',
        options: ['मार्ग', 'गंतव्य', 'साधन', 'अनुभव'],
        correctIndex: 0,
      ),
      AssessmentQuestion(
        question: 'एक स्थान से दूसरे स्थान तक जाने को क्या कहते हैं?',
        options: ['यात्रा', 'विश्राम', 'भोजन', 'नींद'],
        correctIndex: 0,
      ),
    ],
  ),
  'Class 4|Environmental Studies|पानी के बदलते रूप': ChapterContent(
    worksheet: [
      'पानी की तीन अवस्थाओं के नाम लिखिए।',
      'बर्फ किस अवस्था का उदाहरण है?',
      'पानी भाप में कब बदलता है?',
      'जल चक्र को अपने शब्दों में समझाइए।',
      'भाप ठंडी होकर किसमें बदलती है?',
    ],
    flashcards: [
      Flashcard(
        term: 'ठोस',
        meaning: 'पदार्थ की वह अवस्था जिसका निश्चित आकार होता है, जैसे बर्फ',
      ),
      Flashcard(
        term: 'द्रव',
        meaning: 'पदार्थ की वह अवस्था जो बहती है, जैसे पानी',
      ),
      Flashcard(
        term: 'गैस',
        meaning: 'पदार्थ की वह अवस्था जिसका न आकार होता है न आयतन, जैसे भाप',
      ),
      Flashcard(term: 'वाष्पीकरण', meaning: 'पानी का भाप में बदलना'),
      Flashcard(term: 'संघनन', meaning: 'भाप का ठंडा होकर पानी में बदलना'),
    ],
    assessment: [
      AssessmentQuestion(
        question: 'बर्फ पानी की किस अवस्था का उदाहरण है?',
        options: ['ठोस', 'द्रव', 'गैस', 'कोई नहीं'],
        correctIndex: 0,
      ),
      AssessmentQuestion(
        question: 'पानी गर्म होकर किसमें बदलता है?',
        options: ['भाप', 'बर्फ', 'पत्थर', 'मिट्टी'],
        correctIndex: 0,
      ),
      AssessmentQuestion(
        question: 'भाप का पानी में बदलना क्या कहलाता है?',
        options: ['संघनन', 'वाष्पीकरण', 'पिघलना', 'जमना'],
        correctIndex: 0,
      ),
      AssessmentQuestion(
        question: 'पानी का भाप में बदलना क्या कहलाता है?',
        options: ['वाष्पीकरण', 'संघनन', 'जमना', 'पिघलना'],
        correctIndex: 0,
      ),
      AssessmentQuestion(
        question: 'पानी की कितनी मुख्य अवस्थाएँ होती हैं?',
        options: ['तीन', 'दो', 'चार', 'पाँच'],
        correctIndex: 0,
      ),
    ],
  ),
  'Class 4|Environmental Studies|घर तब और अब': ChapterContent(
    worksheet: [
      'पहले के घर किस सामग्री से बनते थे?',
      'आजकल के घर किस सामग्री से बनते हैं?',
      'पहले और अब के घरों में तीन अंतर लिखिए।',
      'अपने घर की बनावट के बारे में पाँच वाक्य लिखिए।',
      'घर बनाने की तकनीक में समय के साथ क्या बदलाव आया है?',
    ],
    flashcards: [
      Flashcard(
        term: 'झोपड़ी',
        meaning: 'मिट्टी, बांस और घास से बना पुराने समय का घर',
      ),
      Flashcard(
        term: 'ईंट',
        meaning: 'घर बनाने में प्रयोग होने वाली एक निर्माण सामग्री',
      ),
      Flashcard(
        term: 'सीमेंट',
        meaning: 'भवन निर्माण में उपयोग होने वाला बंधक पदार्थ',
      ),
      Flashcard(
        term: 'कंक्रीट',
        meaning: 'आधुनिक भवनों में प्रयुक्त मज़बूत सामग्री',
      ),
      Flashcard(term: 'वास्तुकला', meaning: 'भवन बनाने की कला और विज्ञान'),
    ],
    assessment: [
      AssessmentQuestion(
        question: 'पुराने समय में घर सामान्यतः किससे बनते थे?',
        options: ['मिट्टी और घास', 'कंक्रीट', 'शीशा', 'प्लास्टिक'],
        correctIndex: 0,
      ),
      AssessmentQuestion(
        question: 'आजकल घर मुख्यतः किससे बनाए जाते हैं?',
        options: ['ईंट और सीमेंट', 'बांस केवल', 'पत्तों से', 'कपड़े से'],
        correctIndex: 0,
      ),
      AssessmentQuestion(
        question: 'भवन निर्माण की कला और विज्ञान को क्या कहते हैं?',
        options: ['वास्तुकला', 'चित्रकला', 'संगीतकला', 'नृत्यकला'],
        correctIndex: 0,
      ),
      AssessmentQuestion(
        question: 'मिट्टी, बांस और घास से बने पुराने घर को क्या कहते हैं?',
        options: ['झोपड़ी', 'महल', 'अपार्टमेंट', 'विद्यालय'],
        correctIndex: 0,
      ),
      AssessmentQuestion(
        question: 'समय के साथ घर बनाने की तकनीक कैसी हुई है?',
        options: ['अधिक विकसित', 'वैसी ही', 'बंद', 'गायब'],
        correctIndex: 0,
      ),
    ],
  ),
  'Class 4|Environmental Studies|जंगले के जानवर': ChapterContent(
    worksheet: [
      'जंगल में रहने वाले किन्हीं पाँच जानवरों के नाम लिखिए।',
      'जंगल के जानवरों का भोजन क्या होता है?',
      'जंगल क्यों ज़रूरी है, तीन कारण लिखिए।',
      'शेर और हिरण में से कौन मांसाहारी है?',
      'जंगली जानवरों की सुरक्षा क्यों ज़रूरी है?',
    ],
    flashcards: [
      Flashcard(term: 'जंगल', meaning: 'घने पेड़-पौधों वाला प्राकृतिक क्षेत्र'),
      Flashcard(term: 'वन्य जीव', meaning: 'जंगल में रहने वाले जानवर'),
      Flashcard(term: 'मांसाहारी', meaning: 'मांस खाने वाला जीव'),
      Flashcard(term: 'शाकाहारी', meaning: 'पौधे खाने वाला जीव'),
      Flashcard(
        term: 'अभयारण्य',
        meaning: 'जंगली जानवरों की सुरक्षा के लिए बनाया गया संरक्षित क्षेत्र',
      ),
    ],
    assessment: [
      AssessmentQuestion(
        question: 'शेर किस प्रकार का जीव है?',
        options: ['मांसाहारी', 'शाकाहारी', 'केवल पौधे खाने वाला', 'कोई नहीं'],
        correctIndex: 0,
      ),
      AssessmentQuestion(
        question: 'हिरण किस प्रकार का जीव है?',
        options: ['शाकाहारी', 'मांसाहारी', 'कीटभक्षी', 'कोई नहीं'],
        correctIndex: 0,
      ),
      AssessmentQuestion(
        question:
            'जंगली जानवरों की सुरक्षा के लिए बनाए गए क्षेत्र को क्या कहते हैं?',
        options: ['अभयारण्य', 'बाज़ार', 'विद्यालय', 'अस्पताल'],
        correctIndex: 0,
      ),
      AssessmentQuestion(
        question: 'जंगल में रहने वाले जानवरों को क्या कहते हैं?',
        options: ['वन्य जीव', 'पालतू जीव', 'जलीय जीव', 'घरेलू जीव'],
        correctIndex: 0,
      ),
      AssessmentQuestion(
        question: 'जंगल हमारे लिए क्यों महत्वपूर्ण है?',
        options: [
          'यह जीवों को आवास और ऑक्सीजन देता है',
          'यह बेकार है',
          'यह केवल लकड़ी देता है',
          'इसका कोई महत्व नहीं',
        ],
        correctIndex: 0,
      ),
    ],
  ),
  'Class 4|Environmental Studies|तांगा की सवारी': ChapterContent(
    worksheet: [
      'तांगा किस जानवर की सहायता से चलता है?',
      'तांगे और आजकल की गाड़ियों में क्या अंतर है?',
      'पहले के समय में लोग यात्रा के लिए किन साधनों का प्रयोग करते थे?',
      'तांगे की सवारी का अनुभव अपने शब्दों में (कल्पना करके) लिखिए।',
      'पशु से चलने वाले तीन अन्य परिवहन साधनों के नाम लिखिए।',
    ],
    flashcards: [
      Flashcard(
        term: 'तांगा',
        meaning: 'घोड़े द्वारा खींचा जाने वाला परिवहन साधन',
      ),
      Flashcard(
        term: 'परिवहन',
        meaning: 'एक स्थान से दूसरे स्थान तक ले जाने की प्रक्रिया',
      ),
      Flashcard(term: 'सारथी', meaning: 'तांगा या रथ चलाने वाला व्यक्ति'),
      Flashcard(
        term: 'बैलगाड़ी',
        meaning: 'बैलों द्वारा खींची जाने वाली गाड़ी',
      ),
      Flashcard(term: 'यातायात', meaning: 'सड़क पर वाहनों की आवाजाही'),
    ],
    assessment: [
      AssessmentQuestion(
        question: 'तांगा किस जानवर की सहायता से चलता है?',
        options: ['घोड़ा', 'हाथी', 'ऊँट', 'भैंस'],
        correctIndex: 0,
      ),
      AssessmentQuestion(
        question: 'तांगा चलाने वाले व्यक्ति को क्या कहते हैं?',
        options: ['सारथी', 'केवल कार का चालक', 'पायलट', 'कप्तान'],
        correctIndex: 0,
      ),
      AssessmentQuestion(
        question: 'बैलों द्वारा खींची जाने वाली गाड़ी क्या कहलाती है?',
        options: ['बैलगाड़ी', 'तांगा', 'कार', 'ट्रेन'],
        correctIndex: 0,
      ),
      AssessmentQuestion(
        question:
            'एक स्थान से दूसरे स्थान तक ले जाने की प्रक्रिया क्या कहलाती है?',
        options: ['परिवहन', 'संचार', 'शिक्षा', 'मनोरंजन'],
        correctIndex: 0,
      ),
      AssessmentQuestion(
        question: 'आजकल तांगे की जगह अधिकतर क्या उपयोग होता है?',
        options: ['मोटर वाहन', 'बैलगाड़ी', 'नाव', 'केवल हवाई जहाज़'],
        correctIndex: 0,
      ),
    ],
  ),
  'Class 4|Environmental Studies|जंतु हमारे मित्र': ChapterContent(
    worksheet: [
      'हमें जानवरों से क्या-क्या लाभ मिलते हैं?',
      'पालतू जानवरों के नाम लिखिए जो लोग घर में रखते हैं।',
      'कुत्ता किस प्रकार हमारा मित्र है?',
      'जानवरों की देखभाल करना क्यों ज़रूरी है?',
      'जानवरों के प्रति दया और प्रेम क्यों दिखाना चाहिए?',
    ],
    flashcards: [
      Flashcard(term: 'पालतू जानवर', meaning: 'घर में पाला जाने वाला जीव'),
      Flashcard(term: 'गाय', meaning: 'दूध देने वाला पालतू पशु'),
      Flashcard(term: 'कुत्ता', meaning: 'वफादार पालतू जानवर'),
      Flashcard(term: 'दया', meaning: 'दूसरों के प्रति करुणा का भाव'),
      Flashcard(term: 'संरक्षण', meaning: 'सुरक्षा और देखभाल करना'),
    ],
    assessment: [
      AssessmentQuestion(
        question: 'गाय हमें मुख्य रूप से क्या देती है?',
        options: ['दूध', 'अंडे', 'ऊन', 'शहद'],
        correctIndex: 0,
      ),
      AssessmentQuestion(
        question: 'कौन-सा जानवर अपनी वफादारी के लिए जाना जाता है?',
        options: ['कुत्ता', 'साँप', 'मगरमच्छ', 'बिच्छू'],
        correctIndex: 0,
      ),
      AssessmentQuestion(
        question: 'घर में पाले जाने वाले जानवर को क्या कहते हैं?',
        options: ['पालतू जानवर', 'जंगली जानवर', 'वन्य जीव', 'समुद्री जीव'],
        correctIndex: 0,
      ),
      AssessmentQuestion(
        question: 'जानवरों के प्रति करुणा के भाव को क्या कहते हैं?',
        options: ['दया', 'क्रोध', 'भय', 'घृणा'],
        correctIndex: 0,
      ),
      AssessmentQuestion(
        question: 'जानवरों की देखभाल करना क्यों ज़रूरी है?',
        options: [
          'वे भी हमारी तरह जीवित प्राणी हैं',
          'वे बेकार हैं',
          'कोई ज़रूरत नहीं',
          'केवल पैसे के लिए',
        ],
        correctIndex: 0,
      ),
    ],
  ),
  'Class 4|Environmental Studies|पौधों की दुनिया': ChapterContent(
    worksheet: [
      'पौधों के मुख्य भागों के नाम लिखिए।',
      'पौधे अपना भोजन कैसे बनाते हैं?',
      'पेड़-पौधे हमें क्या-क्या देते हैं?',
      'जड़ का मुख्य कार्य क्या है?',
      'पौधे लगाना क्यों ज़रूरी है?',
    ],
    flashcards: [
      Flashcard(
        term: 'जड़',
        meaning: 'पौधे का वह भाग जो मिट्टी से पानी और पोषक तत्व सोखता है',
      ),
      Flashcard(term: 'तना', meaning: 'पौधे को सीधा खड़ा रखने वाला भाग'),
      Flashcard(term: 'पत्ती', meaning: 'भोजन बनाने वाला हरा भाग'),
      Flashcard(
        term: 'प्रकाश संश्लेषण',
        meaning: 'पौधों द्वारा सूर्य के प्रकाश से भोजन बनाने की प्रक्रिया',
      ),
      Flashcard(
        term: 'क्लोरोफिल',
        meaning: 'पत्तियों में पाया जाने वाला हरा पदार्थ',
      ),
    ],
    assessment: [
      AssessmentQuestion(
        question: 'पौधे भोजन बनाने की प्रक्रिया को क्या कहते हैं?',
        options: ['प्रकाश संश्लेषण', 'श्वसन', 'पाचन', 'उत्सर्जन'],
        correctIndex: 0,
      ),
      AssessmentQuestion(
        question: 'पौधे का कौन-सा भाग मिट्टी से पानी सोखता है?',
        options: ['जड़', 'पत्ती', 'फूल', 'तना'],
        correctIndex: 0,
      ),
      AssessmentQuestion(
        question: 'पत्तियों में पाया जाने वाला हरा पदार्थ क्या कहलाता है?',
        options: ['क्लोरोफिल', 'हीमोग्लोबिन', 'प्रोटीन', 'स्टार्च'],
        correctIndex: 0,
      ),
      AssessmentQuestion(
        question: 'पौधे भोजन बनाने के लिए किसका उपयोग करते हैं?',
        options: ['सूर्य का प्रकाश', 'चाँदनी', 'बिजली', 'आग'],
        correctIndex: 0,
      ),
      AssessmentQuestion(
        question: 'पौधे को सीधा खड़ा रखने वाला भाग कौन-सा है?',
        options: ['तना', 'जड़', 'फूल', 'बीज'],
        correctIndex: 0,
      ),
    ],
  ),
  'Class 4|Environmental Studies|कल कल, छल छल': ChapterContent(
    worksheet: [
      'नदियाँ कहाँ से निकलती हैं?',
      'नदी का पानी बहते समय कैसी आवाज़ करता है?',
      'नदियाँ हमारे जीवन में किस प्रकार उपयोगी हैं?',
      'झारखंड की किसी एक नदी का नाम लिखिए।',
      'नदियों को स्वच्छ रखना क्यों ज़रूरी है?',
    ],
    flashcards: [
      Flashcard(term: 'नदी', meaning: 'पहाड़ों से निकलकर बहने वाली जल धारा'),
      Flashcard(term: 'स्रोत', meaning: 'नदी के निकलने का स्थान'),
      Flashcard(term: 'जल धारा', meaning: 'बहता हुआ पानी'),
      Flashcard(term: 'प्रदूषण', meaning: 'पानी या वातावरण का दूषित होना'),
      Flashcard(term: 'संगम', meaning: 'दो नदियों का आपस में मिलना'),
    ],
    assessment: [
      AssessmentQuestion(
        question: 'नदियाँ सामान्यतः कहाँ से निकलती हैं?',
        options: ['पहाड़ों से', 'समुद्र से', 'रेगिस्तान से', 'आकाश से'],
        correctIndex: 0,
      ),
      AssessmentQuestion(
        question: 'नदी के बहते पानी की आवाज़ को किस शब्द से दर्शाया जाता है?',
        options: ['कल कल, छल छल', 'दहाड़', 'कूक', 'भौंकना'],
        correctIndex: 0,
      ),
      AssessmentQuestion(
        question: 'दो नदियों के मिलने के स्थान को क्या कहते हैं?',
        options: ['संगम', 'स्रोत', 'तट', 'मुहाना'],
        correctIndex: 0,
      ),
      AssessmentQuestion(
        question: 'नदियाँ हमें मुख्य रूप से क्या देती हैं?',
        options: ['पानी', 'सोना', 'तेल', 'कोयला'],
        correctIndex: 0,
      ),
      AssessmentQuestion(
        question: 'पानी के दूषित होने को क्या कहते हैं?',
        options: ['प्रदूषण', 'संगम', 'स्रोत', 'शुद्धिकरण'],
        correctIndex: 0,
      ),
    ],
  ),
  'Class 4|Environmental Studies|नोट एवं सिक्के': ChapterContent(
    worksheet: [
      'भारत की मुद्रा का नाम क्या है?',
      'नोट किस सामग्री से बने होते हैं?',
      'सिक्के किस सामग्री से बने होते हैं?',
      '1 रुपये में कितने पैसे होते हैं?',
      'नकली नोटों की पहचान क्यों ज़रूरी है?',
    ],
    flashcards: [
      Flashcard(
        term: 'मुद्रा',
        meaning: 'किसी देश में लेन-देन के लिए उपयोग होने वाला धन',
      ),
      Flashcard(term: 'रुपया', meaning: 'भारत की मुद्रा'),
      Flashcard(term: 'सिक्का', meaning: 'धातु से बना गोल आकार का धन'),
      Flashcard(term: 'नोट', meaning: 'कागज़ जैसी सामग्री से बना धन'),
      Flashcard(
        term: 'बैंक',
        meaning: 'पैसों के लेन-देन और सुरक्षा के लिए संस्था',
      ),
    ],
    assessment: [
      AssessmentQuestion(
        question: 'भारत की मुद्रा का नाम क्या है?',
        options: ['रुपया', 'डॉलर', 'पाउंड', 'येन'],
        correctIndex: 0,
      ),
      AssessmentQuestion(
        question: 'नोट सामान्यतः किससे बने होते हैं?',
        options: ['कागज़ जैसी विशेष सामग्री', 'लोहा', 'सोना', 'केवल प्लास्टिक'],
        correctIndex: 0,
      ),
      AssessmentQuestion(
        question: 'सिक्के सामान्यतः किससे बने होते हैं?',
        options: ['धातु', 'कागज़', 'लकड़ी', 'कपड़ा'],
        correctIndex: 0,
      ),
      AssessmentQuestion(
        question: '1 रुपये में कितने पैसे होते हैं?',
        options: ['100', '10', '1000', '50'],
        correctIndex: 0,
      ),
      AssessmentQuestion(
        question: 'पैसों के लेन-देन के लिए बनी संस्था को क्या कहते हैं?',
        options: ['बैंक', 'विद्यालय', 'अस्पताल', 'डाकघर'],
        correctIndex: 0,
      ),
    ],
  ),
  'Class 4|Environmental Studies|भोजन कहाँ कहाँ से': ChapterContent(
    worksheet: [
      'गेहूँ और चावल कहाँ से प्राप्त होते हैं?',
      'दूध हमें किस जानवर से मिलता है?',
      'सब्ज़ियाँ और फल कहाँ उगाए जाते हैं?',
      'भोजन बर्बाद क्यों नहीं करना चाहिए?',
      'अपने पसंदीदा भोजन के बारे में लिखिए कि वह कहाँ से आता है।',
    ],
    flashcards: [
      Flashcard(term: 'फसल', meaning: 'खेत में उगाई जाने वाली पैदावार'),
      Flashcard(term: 'अनाज', meaning: 'गेहूँ, चावल जैसे खाद्य पदार्थ'),
      Flashcard(term: 'कृषि', meaning: 'खेती करने की क्रिया'),
      Flashcard(term: 'डेयरी', meaning: 'दूध और दूध उत्पादों से संबंधित'),
      Flashcard(term: 'पोषण', meaning: 'भोजन से मिलने वाली शक्ति और तत्व'),
    ],
    assessment: [
      AssessmentQuestion(
        question: 'गेहूँ और चावल हमें कहाँ से प्राप्त होते हैं?',
        options: [
          'खेतों से',
          'कारखानों से',
          'सीधे दुकान से बिना उगाए',
          'समुद्र से',
        ],
        correctIndex: 0,
      ),
      AssessmentQuestion(
        question: 'दूध हमें मुख्य रूप से किस पशु से मिलता है?',
        options: ['गाय', 'मुर्गी', 'मछली', 'केवल बकरी'],
        correctIndex: 0,
      ),
      AssessmentQuestion(
        question: 'खेती करने की क्रिया को क्या कहते हैं?',
        options: ['कृषि', 'व्यापार', 'शिक्षा', 'चिकित्सा'],
        correctIndex: 0,
      ),
      AssessmentQuestion(
        question: 'भोजन से हमें क्या प्राप्त होता है?',
        options: ['पोषण और शक्ति', 'कुछ नहीं', 'केवल स्वाद', 'भय'],
        correctIndex: 0,
      ),
      AssessmentQuestion(
        question: 'अनाज के उदाहरण कौन-से हैं?',
        options: [
          'गेहूँ और चावल',
          'लोहा और सोना',
          'कागज़ और प्लास्टिक',
          'पानी और हवा',
        ],
        correctIndex: 0,
      ),
    ],
  ),
  'Class 4|Environmental Studies|आओ खेलें खेल': ChapterContent(
    worksheet: [
      'आपको कौन-सा खेल सबसे अधिक पसंद है और क्यों?',
      'इनडोर खेल और आउटडोर खेल में क्या अंतर है?',
      'खेलने से हमारे शरीर को क्या लाभ होता है?',
      'टीम भावना से खेले जाने वाले दो खेलों के नाम लिखिए।',
      'खेल खेलते समय किन नियमों का पालन करना चाहिए?',
    ],
    flashcards: [
      Flashcard(
        term: 'खेल',
        meaning: 'मनोरंजन और व्यायाम के लिए की जाने वाली गतिविधि',
      ),
      Flashcard(term: 'टीम भावना', meaning: 'मिलकर काम करने की भावना'),
      Flashcard(term: 'नियम', meaning: 'खेल में पालन किए जाने वाले निर्देश'),
      Flashcard(
        term: 'व्यायाम',
        meaning: 'शरीर को स्वस्थ रखने वाली शारीरिक गतिविधि',
      ),
      Flashcard(term: 'खिलाड़ी', meaning: 'खेल खेलने वाला व्यक्ति'),
    ],
    assessment: [
      AssessmentQuestion(
        question: 'खेलने से हमारे शरीर को क्या लाभ होता है?',
        options: [
          'यह स्वस्थ रखता है',
          'यह कमजोर करता है',
          'कोई लाभ नहीं',
          'यह बीमार करता है',
        ],
        correctIndex: 0,
      ),
      AssessmentQuestion(
        question: 'मिलकर काम करने की भावना को क्या कहते हैं?',
        options: ['टीम भावना', 'स्वार्थ', 'ईर्ष्या', 'क्रोध'],
        correctIndex: 0,
      ),
      AssessmentQuestion(
        question: 'खेल के दौरान पालन किए जाने वाले निर्देशों को क्या कहते हैं?',
        options: ['नियम', 'गीत', 'कहानी', 'चित्र'],
        correctIndex: 0,
      ),
      AssessmentQuestion(
        question: 'कबड्डी किस प्रकार का खेल है?',
        options: ['टीम खेल', 'केवल एकल खेल', 'बोर्ड गेम', 'संगीत'],
        correctIndex: 0,
      ),
      AssessmentQuestion(
        question: 'खेल खेलने वाले व्यक्ति को क्या कहते हैं?',
        options: ['खिलाड़ी', 'केवल दर्शक', 'केवल न्यायाधीश', 'लेखक'],
        correctIndex: 0,
      ),
    ],
  ),
  'Class 4|Environmental Studies|बनाते जाओ': ChapterContent(
    worksheet: [
      'आप कागज़ से कौन-कौन सी चीज़ें बना सकते हैं?',
      'घर में मौजूद बेकार वस्तुओं से कोई नई वस्तु बनाने का विचार लिखिए।',
      'हस्तकला (क्राफ्ट) बनाना क्यों अच्छी आदत है?',
      'अपनी बनाई किसी वस्तु के बारे में तीन वाक्य लिखिए।',
      'पुरानी वस्तुओं को नया रूप देने को क्या कहते हैं?',
    ],
    flashcards: [
      Flashcard(term: 'हस्तकला', meaning: 'हाथों से बनाई गई कलात्मक वस्तु'),
      Flashcard(
        term: 'पुनर्चक्रण',
        meaning: 'पुरानी वस्तुओं का दोबारा उपयोग करना',
      ),
      Flashcard(
        term: 'रचनात्मकता',
        meaning: 'नई और अनोखी चीज़ें सोचने की क्षमता',
      ),
      Flashcard(
        term: 'सामग्री',
        meaning: 'वस्तु बनाने में उपयोग होने वाली चीज़ें',
      ),
      Flashcard(term: 'कैंची', meaning: 'कागज़ या कपड़ा काटने का उपकरण'),
    ],
    assessment: [
      AssessmentQuestion(
        question: 'पुरानी वस्तुओं का दोबारा उपयोग करना क्या कहलाता है?',
        options: ['पुनर्चक्रण', 'बर्बादी', 'प्रदूषण', 'विनाश'],
        correctIndex: 0,
      ),
      AssessmentQuestion(
        question: 'नई और अनोखी चीज़ें सोचने की क्षमता को क्या कहते हैं?',
        options: ['रचनात्मकता', 'आलस्य', 'भय', 'क्रोध'],
        correctIndex: 0,
      ),
      AssessmentQuestion(
        question: 'कागज़ काटने के लिए किस उपकरण का प्रयोग होता है?',
        options: ['कैंची', 'हथौड़ा', 'चम्मच', 'सुई'],
        correctIndex: 0,
      ),
      AssessmentQuestion(
        question: 'हाथों से बनाई गई कलात्मक वस्तु को क्या कहते हैं?',
        options: ['हस्तकला', 'मशीनी वस्तु', 'प्राकृतिक वस्तु', 'खनिज'],
        correctIndex: 0,
      ),
      AssessmentQuestion(
        question: 'पुनर्चक्रण करना पर्यावरण के लिए कैसा है?',
        options: ['अच्छा', 'बुरा', 'हानिकारक', 'बेकार'],
        correctIndex: 0,
      ),
    ],
  ),
  'Class 4|Environmental Studies|परमा का खेत': ChapterContent(
    worksheet: [
      'किसान खेत में फसल उगाने के लिए सबसे पहले क्या करता है?',
      'बीज बोने से पहले खेत की मिट्टी को कैसे तैयार किया जाता है?',
      'फसल को पानी देने के दो तरीके लिखिए।',
      'फसल पकने के बाद किसान क्या करता है?',
      'किसानों के परिश्रम का सम्मान क्यों करना चाहिए?',
    ],
    flashcards: [
      Flashcard(term: 'खेत', meaning: 'फसल उगाने की भूमि'),
      Flashcard(
        term: 'जुताई',
        meaning: 'बीज बोने से पहले मिट्टी को पलटने की क्रिया',
      ),
      Flashcard(term: 'बीज', meaning: 'पौधा बनने वाला मूल तत्व'),
      Flashcard(term: 'सिंचाई', meaning: 'खेत को पानी देने की प्रक्रिया'),
      Flashcard(term: 'फसल कटाई', meaning: 'पकी हुई फसल को काटने की क्रिया'),
    ],
    assessment: [
      AssessmentQuestion(
        question: 'बीज बोने से पहले मिट्टी पलटने की क्रिया को क्या कहते हैं?',
        options: ['जुताई', 'सिंचाई', 'कटाई', 'बुवाई'],
        correctIndex: 0,
      ),
      AssessmentQuestion(
        question: 'खेत को पानी देने की प्रक्रिया को क्या कहते हैं?',
        options: ['सिंचाई', 'जुताई', 'कटाई', 'भंडारण'],
        correctIndex: 0,
      ),
      AssessmentQuestion(
        question: 'पकी फसल को काटने की क्रिया को क्या कहते हैं?',
        options: ['फसल कटाई', 'जुताई', 'सिंचाई', 'बुवाई'],
        correctIndex: 0,
      ),
      AssessmentQuestion(
        question: 'किसान सबसे पहले खेत में क्या करता है?',
        options: ['मिट्टी तैयार करना', 'फसल बेचना', 'भोजन पकाना', 'कपड़े धोना'],
        correctIndex: 0,
      ),
      AssessmentQuestion(
        question: 'पौधा बनने वाले मूल तत्व को क्या कहते हैं?',
        options: ['बीज', 'पत्ती', 'जड़', 'फूल'],
        correctIndex: 0,
      ),
    ],
  ),
  'Class 5|Hindi|हम सब सुमन एक उपवन के': ChapterContent(
    worksheet: [
      'इस कविता/पाठ का शीर्षक क्या संदेश देता है, अपने शब्दों में लिखो।',
      '\'उपवन\' और \'सुमन\' शब्दों का अर्थ लिखकर एक-एक वाक्य बनाओ।',
      'हमें आपस में मिलजुल कर रहने से क्या लाभ होते हैं? तीन बिंदु लिखो।',
      'एकता में बल है - इस विचार को अपने स्कूल के उदाहरण से समझाओ।',
      'पाठ में आए किन्हीं पाँच नए शब्दों को छाँटकर उनके अर्थ लिखो।',
    ],
    flashcards: [
      Flashcard(term: 'उपवन', meaning: 'बगीचा या फूलों से भरा स्थान'),
      Flashcard(term: 'सुमन', meaning: 'फूल'),
      Flashcard(term: 'एकता', meaning: 'मिलजुल कर रहना, एकजुटता'),
      Flashcard(term: 'सहयोग', meaning: 'मिलकर काम करना, मदद करना'),
      Flashcard(term: 'भाईचारा', meaning: 'आपसी प्रेम और भाईपन का भाव'),
      Flashcard(term: 'समानता', meaning: 'सबको बराबर समझना'),
    ],
    assessment: [
      AssessmentQuestion(
        question: '\'सुमन\' शब्द का अर्थ क्या है?',
        options: ['पत्ता', 'फूल', 'जड़', 'डाल'],
        correctIndex: 1,
      ),
      AssessmentQuestion(
        question: '\'उपवन\' किसे कहते हैं?',
        options: ['तालाब', 'पहाड़', 'बगीचा', 'रेगिस्तान'],
        correctIndex: 2,
      ),
      AssessmentQuestion(
        question: 'इस पाठ का मुख्य संदेश क्या है?',
        options: ['आलस्य', 'एकता और मिलजुल कर रहना', 'झगड़ा', 'डर'],
        correctIndex: 1,
      ),
      AssessmentQuestion(
        question: '\'एकता में बल है\' का अर्थ है',
        options: [
          'अकेले रहने में शक्ति है',
          'मिलकर रहने में शक्ति है',
          'झगड़ने में शक्ति है',
          'सोने में शक्ति है',
        ],
        correctIndex: 1,
      ),
      AssessmentQuestion(
        question: '\'भाईचारा\' शब्द किस भाव को दर्शाता है?',
        options: ['वैर', 'प्रेम और अपनापन', 'डर', 'लालच'],
        correctIndex: 1,
      ),
    ],
  ),
  'Class 5|Hindi|फसलों के त्योहार': ChapterContent(
    worksheet: [
      'झारखंड में मनाए जाने वाले किन्हीं तीन फसल त्योहारों के नाम लिखो।',
      'सोहराय त्योहार किस मौसम में और क्यों मनाया जाता है?',
      'करमा पर्व के बारे में तुम क्या जानते हो, तीन पंक्तियों में लिखो।',
      'मकर संक्रांति को हम किस प्रकार मनाते हैं?',
      'फसल त्योहार किसानों के लिए महत्वपूर्ण क्यों होते हैं?',
    ],
    flashcards: [
      Flashcard(
        term: 'सोहराय',
        meaning:
            'झारखंड का एक फसल/पशुधन उत्सव, जिसमें घरों की भित्ति चित्रकारी होती है',
      ),
      Flashcard(
        term: 'करमा',
        meaning: 'करम वृक्ष की पूजा से जुड़ा झारखंड का लोकप्रिय पर्व',
      ),
      Flashcard(
        term: 'सरहुल',
        meaning: 'साल वृक्ष के फूलने पर मनाया जाने वाला आदिवासी पर्व',
      ),
      Flashcard(
        term: 'मकर संक्रांति',
        meaning: 'फसल कटाई का त्योहार, जनवरी माह में मनाया जाता है',
      ),
      Flashcard(term: 'फसल', meaning: 'खेत में उगाई गई उपज जैसे धान, गेहूँ'),
      Flashcard(term: 'कृषि', meaning: 'खेती करने का कार्य'),
    ],
    assessment: [
      AssessmentQuestion(
        question: 'सोहराय किस राज्य से जुड़ा प्रसिद्ध त्योहार है?',
        options: ['पंजाब', 'झारखंड', 'गुजरात', 'केरल'],
        correctIndex: 1,
      ),
      AssessmentQuestion(
        question: 'करमा पर्व किस वृक्ष से जुड़ा है?',
        options: ['आम', 'करम', 'नीम', 'पीपल'],
        correctIndex: 1,
      ),
      AssessmentQuestion(
        question: 'मकर संक्रांति किस महीने में मनाई जाती है?',
        options: ['जनवरी', 'अप्रैल', 'अगस्त', 'अक्टूबर'],
        correctIndex: 0,
      ),
      AssessmentQuestion(
        question: 'सरहुल किस वृक्ष के फूलने पर मनाया जाता है?',
        options: ['साल', 'आम', 'नीम', 'बबूल'],
        correctIndex: 0,
      ),
      AssessmentQuestion(
        question: 'फसल त्योहार मुख्यतः किससे जुड़े होते हैं?',
        options: ['खेल', 'कृषि और फसल कटाई', 'बाजार', 'यातायात'],
        correctIndex: 1,
      ),
    ],
  ),
  'Class 5|Hindi|ईदगाह': ChapterContent(
    worksheet: [
      'हामिद ईद के मेले में अपने साथियों के साथ क्यों गया था?',
      'हामिद ने खिलौनों और मिठाइयों की जगह चिमटा क्यों खरीदा?',
      'हामिद के इस निर्णय से उसके स्वभाव की कौन-सी अच्छाई पता चलती है?',
      '\'ईदगाह\' कहानी के लेखक का नाम लिखो।',
      'हामिद की दादी अमीना का नाम लेकर बताओ कि वह घर पर उसका इंतजार क्यों कर रही थी।',
    ],
    flashcards: [
      Flashcard(
        term: 'ईदगाह',
        meaning: 'वह स्थान जहाँ ईद की नमाज़ पढ़ी जाती है',
      ),
      Flashcard(
        term: 'चिमटा',
        meaning:
            'रोटी सेंकते समय हाथ न जले इसके लिए प्रयोग होने वाला लोहे का औज़ार',
      ),
      Flashcard(
        term: 'मेला',
        meaning:
            'त्योहार पर लगने वाला बाज़ार जहाँ खेल-तमाशे और दुकानें होती हैं',
      ),
      Flashcard(
        term: 'प्रेमचंद',
        meaning: '\'ईदगाह\' कहानी के प्रसिद्ध हिंदी लेखक, मुंशी प्रेमचंद',
      ),
      Flashcard(
        term: 'त्याग',
        meaning: 'अपनी इच्छा छोड़कर दूसरे के भले के लिए काम करना',
      ),
      Flashcard(term: 'समझदारी', meaning: 'सही-गलत को परखने की बुद्धि'),
    ],
    assessment: [
      AssessmentQuestion(
        question: '\'ईदगाह\' कहानी के लेखक कौन हैं?',
        options: [
          'रवींद्रनाथ टैगोर',
          'मुंशी प्रेमचंद',
          'सुमित्रानंदन पंत',
          'महादेवी वर्मा',
        ],
        correctIndex: 1,
      ),
      AssessmentQuestion(
        question: 'हामिद ने मेले से क्या खरीदा?',
        options: ['खिलौना', 'मिठाई', 'चिमटा', 'गुब्बारा'],
        correctIndex: 2,
      ),
      AssessmentQuestion(
        question: 'हामिद ने चिमटा किसके लिए खरीदा?',
        options: [
          'अपने लिए',
          'दोस्त के लिए',
          'अपनी दादी के लिए',
          'शिक्षक के लिए',
        ],
        correctIndex: 2,
      ),
      AssessmentQuestion(
        question: 'हामिद अपनी दादी को किस नाम से पुकारता था?',
        options: ['अमीना', 'दादी अम्मा', 'माँ', 'बीबी'],
        correctIndex: 1,
      ),
      AssessmentQuestion(
        question: 'इस कहानी से हमें कौन-सा गुण सीखने को मिलता है?',
        options: ['स्वार्थ', 'त्याग और समझदारी', 'आलस्य', 'क्रोध'],
        correctIndex: 1,
      ),
    ],
  ),
  'Class 5|Hindi|दोहा एकादश': ChapterContent(
    worksheet: [
      'दोहा किसे कहते हैं? यह कितनी पंक्तियों का होता है, लिखो।',
      'दोहे किस प्रकार जीवन में उपयोगी बातें सिखाते हैं?',
      'तुम्हें कोई एक दोहा याद हो तो लिखो और उसका सरल अर्थ बताओ।',
      'दोहा और कविता में क्या अंतर है?',
      'दोहों में मुख्यतः किन विषयों पर बातें कही जाती हैं?',
    ],
    flashcards: [
      Flashcard(
        term: 'दोहा',
        meaning:
            'दो पंक्तियों का एक छोटा काव्य रूप जिसमें गहरी बात कही जाती है',
      ),
      Flashcard(term: 'छंद', meaning: 'काव्य रचना का एक निश्चित रूप या बनावट'),
      Flashcard(term: 'कवि', meaning: 'कविता लिखने वाला व्यक्ति'),
      Flashcard(term: 'अलंकार', meaning: 'भाषा को सुंदर बनाने वाला काव्य साधन'),
      Flashcard(term: 'उपदेश', meaning: 'अच्छी सीख या सलाह'),
      Flashcard(
        term: 'मुक्तक',
        meaning: 'स्वतंत्र भाव से लिखी गई छोटी काव्य रचना',
      ),
    ],
    assessment: [
      AssessmentQuestion(
        question: 'दोहा सामान्यतः कितनी पंक्तियों का होता है?',
        options: ['दो', 'चार', 'छह', 'आठ'],
        correctIndex: 0,
      ),
      AssessmentQuestion(
        question: 'दोहे मुख्यतः किस उद्देश्य से लिखे जाते हैं?',
        options: [
          'मनोरंजन के लिए',
          'सीख देने के लिए',
          'डराने के लिए',
          'गाने के लिए',
        ],
        correctIndex: 1,
      ),
      AssessmentQuestion(
        question: 'कविता लिखने वाले को क्या कहते हैं?',
        options: ['लेखक', 'कवि', 'गायक', 'चित्रकार'],
        correctIndex: 1,
      ),
      AssessmentQuestion(
        question: '\'छंद\' शब्द का संबंध किससे है?',
        options: ['काव्य की बनावट से', 'भोजन से', 'खेल से', 'यातायात से'],
        correctIndex: 0,
      ),
      AssessmentQuestion(
        question: 'दोहे किस भाषा-शैली में लिखे जाते हैं?',
        options: [
          'केवल अंग्रेज़ी',
          'सरल और संक्षिप्त',
          'बहुत जटिल',
          'केवल संस्कृत',
        ],
        correctIndex: 1,
      ),
    ],
  ),
  'Class 5|Hindi|चावल की रोटियाँ': ChapterContent(
    worksheet: [
      '\'चावल की रोटियाँ\' शीर्षक पढ़कर तुम्हें कहानी में क्या घटित होने का अनुमान है?',
      'चावल से बनने वाले किन्हीं तीन व्यंजनों के नाम लिखो।',
      'अपने घर में बनने वाले किसी खास पकवान के बारे में पाँच वाक्य लिखो।',
      'मेहनत और धैर्य से जुड़ी कोई एक सीख लिखो जो भोजन बनाने से जुड़ी हो।',
      'चावल की खेती के लिए किन चीज़ों की आवश्यकता होती है?',
    ],
    flashcards: [
      Flashcard(
        term: 'चावल',
        meaning: 'धान से प्राप्त होने वाला मुख्य खाद्यान्न',
      ),
      Flashcard(term: 'रोटी', meaning: 'आटे या चावल के आटे से बना गोल भोजन'),
      Flashcard(term: 'धान', meaning: 'वह पौधा जिससे चावल प्राप्त होता है'),
      Flashcard(term: 'पकवान', meaning: 'खास अवसरों पर बनाया जाने वाला भोजन'),
      Flashcard(term: 'श्रम', meaning: 'मेहनत, परिश्रम'),
      Flashcard(term: 'अन्न', meaning: 'खाने योग्य अनाज'),
    ],
    assessment: [
      AssessmentQuestion(
        question: 'चावल किस पौधे से प्राप्त होता है?',
        options: ['गेहूँ', 'धान', 'मक्का', 'जौ'],
        correctIndex: 1,
      ),
      AssessmentQuestion(
        question: 'रोटी सामान्यतः किससे बनाई जाती है?',
        options: ['आटा', 'पानी', 'पत्थर', 'लकड़ी'],
        correctIndex: 0,
      ),
      AssessmentQuestion(
        question: 'अन्न शब्द का अर्थ क्या है?',
        options: ['खाने योग्य अनाज', 'पानी', 'कपड़ा', 'मकान'],
        correctIndex: 0,
      ),
      AssessmentQuestion(
        question: 'भोजन बनाने के लिए सबसे ज़रूरी गुण कौन-सा है?',
        options: ['जल्दबाज़ी', 'धैर्य और मेहनत', 'क्रोध', 'आलस्य'],
        correctIndex: 1,
      ),
      AssessmentQuestion(
        question: '\'श्रम\' शब्द का अर्थ है',
        options: ['आराम', 'मेहनत', 'नींद', 'खेल'],
        correctIndex: 1,
      ),
    ],
  ),
  'Class 5|Hindi|लड़की की चतुराई': ChapterContent(
    worksheet: [
      '\'चतुराई\' शब्द का अर्थ लिखो और एक वाक्य में प्रयोग करो।',
      'तुम्हारे विचार से एक चतुर व्यक्ति में कौन-से गुण होते हैं?',
      'किसी कठिन परिस्थिति में तुमने या किसी और ने अपनी बुद्धि से समाधान निकाला हो, वह घटना लिखो।',
      'चतुराई और छल में क्या अंतर है, समझाओ।',
      '\'लड़की की चतुराई\' शीर्षक से कहानी में किस प्रकार की घटना होने का अनुमान लगता है?',
    ],
    flashcards: [
      Flashcard(term: 'चतुराई', meaning: 'बुद्धिमानी से काम निकालने की कला'),
      Flashcard(
        term: 'बुद्धिमत्ता',
        meaning: 'समझदारी और सोच-विचार करने की शक्ति',
      ),
      Flashcard(term: 'युक्ति', meaning: 'किसी समस्या को हल करने का उपाय'),
      Flashcard(term: 'साहस', meaning: 'डर का सामना करने की हिम्मत'),
      Flashcard(term: 'समस्या', meaning: 'कठिनाई या उलझन'),
      Flashcard(term: 'समाधान', meaning: 'समस्या का हल'),
    ],
    assessment: [
      AssessmentQuestion(
        question: '\'चतुराई\' का अर्थ है',
        options: ['बुद्धिमानी', 'आलस्य', 'डर', 'क्रोध'],
        correctIndex: 0,
      ),
      AssessmentQuestion(
        question: '\'युक्ति\' शब्द का अर्थ क्या है?',
        options: ['समस्या', 'उपाय', 'सजा', 'खेल'],
        correctIndex: 1,
      ),
      AssessmentQuestion(
        question: 'समस्या का हल निकालने के लिए क्या चाहिए?',
        options: ['बुद्धि और सूझबूझ', 'डर', 'जल्दबाज़ी', 'आलस्य'],
        correctIndex: 0,
      ),
      AssessmentQuestion(
        question: 'चतुराई से काम लेने वाला व्यक्ति कैसा माना जाता है?',
        options: ['मूर्ख', 'समझदार', 'कमजोर', 'डरपोक'],
        correctIndex: 1,
      ),
      AssessmentQuestion(
        question: '\'साहस\' शब्द का विलोम (उल्टा) क्या है?',
        options: ['वीरता', 'कायरता', 'बुद्धि', 'चतुराई'],
        correctIndex: 1,
      ),
    ],
  ),
  'Class 5|Hindi|चिठ्ठी': ChapterContent(
    worksheet: [
      'पत्र (चिठ्ठी) लिखने के मुख्य भाग कौन-कौन से होते हैं?',
      'अपने मित्र को अपने विद्यालय के बारे में बताते हुए एक संक्षिप्त पत्र लिखो।',
      'औपचारिक (formal) और अनौपचारिक (informal) पत्र में क्या अंतर होता है?',
      'आजकल चिठ्ठी की जगह किन साधनों का प्रयोग किया जाता है?',
      'पत्र लिखते समय किन बातों का ध्यान रखना चाहिए?',
    ],
    flashcards: [
      Flashcard(term: 'चिठ्ठी', meaning: 'किसी को लिखा गया पत्र'),
      Flashcard(term: 'प्रेषक', meaning: 'पत्र भेजने वाला व्यक्ति'),
      Flashcard(term: 'प्राप्तकर्ता', meaning: 'पत्र पाने वाला व्यक्ति'),
      Flashcard(term: 'पता', meaning: 'किसी स्थान की स्थिति बताने वाला विवरण'),
      Flashcard(
        term: 'अभिवादन',
        meaning: 'पत्र में प्रयोग किया जाने वाला सम्मानसूचक संबोधन',
      ),
      Flashcard(
        term: 'डाकघर',
        meaning: 'चिठ्ठी और पार्सल भेजने की सरकारी सेवा वाला स्थान',
      ),
    ],
    assessment: [
      AssessmentQuestion(
        question: 'पत्र भेजने वाले को क्या कहते हैं?',
        options: ['प्राप्तकर्ता', 'प्रेषक', 'डाकिया', 'लेखक'],
        correctIndex: 1,
      ),
      AssessmentQuestion(
        question: 'चिठ्ठी कहाँ से भेजी और प्राप्त की जाती है?',
        options: ['स्कूल', 'डाकघर', 'बाज़ार', 'अस्पताल'],
        correctIndex: 1,
      ),
      AssessmentQuestion(
        question: 'मित्र को लिखा गया पत्र किस प्रकार का पत्र है?',
        options: ['औपचारिक', 'अनौपचारिक', 'सरकारी', 'व्यापारिक'],
        correctIndex: 1,
      ),
      AssessmentQuestion(
        question: 'पत्र में पता लिखना क्यों जरूरी है?',
        options: [
          'सुंदरता के लिए',
          'सही स्थान तक पहुँचाने के लिए',
          'लंबा दिखाने के लिए',
          'इनमें से कोई नहीं',
        ],
        correctIndex: 1,
      ),
      AssessmentQuestion(
        question: 'आजकल चिठ्ठी की जगह किसका अधिक प्रयोग होता है?',
        options: ['ईमेल और मोबाइल संदेश', 'पत्थर की तख्ती', 'ढोल', 'पतंग'],
        correctIndex: 0,
      ),
    ],
  ),
  'Class 5|Hindi|दो गौरेयाँ': ChapterContent(
    worksheet: [
      'गौरैया पक्षी के बारे में तुम क्या जानते हो? पाँच वाक्य लिखो।',
      'आजकल गौरैया की संख्या कम क्यों होती जा रही है?',
      'हम गौरैया और अन्य पक्षियों को कैसे बचा सकते हैं?',
      '\'दो गौरेयाँ\' शीर्षक से कहानी में किस प्रकार का विषय होने की संभावना है?',
      'पक्षियों के लिए पानी और दाना रखना क्यों जरूरी है?',
    ],
    flashcards: [
      Flashcard(
        term: 'गौरैया',
        meaning: 'एक छोटी, भूरे रंग की चिड़िया जो अक्सर घरों के पास रहती है',
      ),
      Flashcard(
        term: 'घोंसला',
        meaning: 'पक्षियों का रहने का घर, जो वे तिनकों से बनाते हैं',
      ),
      Flashcard(term: 'पर्यावरण', meaning: 'हमारे चारों ओर का वातावरण'),
      Flashcard(term: 'संरक्षण', meaning: 'किसी चीज़ की रक्षा करना'),
      Flashcard(term: 'प्रवास', meaning: 'एक स्थान से दूसरे स्थान पर जाना'),
      Flashcard(term: 'चहचहाना', meaning: 'पक्षियों की मीठी आवाज़ निकालना'),
    ],
    assessment: [
      AssessmentQuestion(
        question: 'गौरैया किस रंग की होती है?',
        options: ['नीली', 'भूरी', 'हरी', 'काली'],
        correctIndex: 1,
      ),
      AssessmentQuestion(
        question: 'पक्षी अपने रहने के लिए क्या बनाते हैं?',
        options: ['घोंसला', 'बिल', 'गुफा', 'मकान'],
        correctIndex: 0,
      ),
      AssessmentQuestion(
        question: 'गौरैया की संख्या घटने का एक मुख्य कारण क्या है?',
        options: [
          'अधिक पेड़ लगाना',
          'मोबाइल टावर और आवास की कमी',
          'साफ हवा',
          'अधिक पानी',
        ],
        correctIndex: 1,
      ),
      AssessmentQuestion(
        question: 'हम पक्षियों की मदद कैसे कर सकते हैं?',
        options: [
          'पानी और दाना रखकर',
          'घोंसले तोड़कर',
          'शोर मचाकर',
          'पेड़ काटकर',
        ],
        correctIndex: 0,
      ),
      AssessmentQuestion(
        question: '\'पर्यावरण\' शब्द का अर्थ है',
        options: ['हमारे आसपास का वातावरण', 'एक खेल', 'एक पक्षी', 'एक भोजन'],
        correctIndex: 0,
      ),
    ],
  ),
  'Class 5|Hindi|काबुलीवाला': ChapterContent(
    worksheet: [
      'काबुलीवाला (रहमत) कहाँ से आया था और वह क्या बेचता था?',
      'मिनी और रहमत की दोस्ती के बारे में तीन वाक्य लिखो।',
      'रहमत को मिनी की याद क्यों आती थी?',
      '\'काबुलीवाला\' कहानी के लेखक का नाम लिखो।',
      'इस कहानी से हमें मित्रता के बारे में क्या सीख मिलती है?',
    ],
    flashcards: [
      Flashcard(
        term: 'काबुलीवाला',
        meaning: 'अफगानिस्तान (काबुल) से आकर सूखे मेवे बेचने वाला विक्रेता',
      ),
      Flashcard(term: 'रहमत', meaning: 'कहानी का मुख्य पात्र, एक काबुलीवाला'),
      Flashcard(
        term: 'मिनी',
        meaning: 'कहानी की छोटी बच्ची जो रहमत की मित्र बनती है',
      ),
      Flashcard(term: 'मेवा', meaning: 'सूखे फल जैसे बादाम, किशमिश, अखरोट'),
      Flashcard(
        term: 'रवींद्रनाथ टैगोर',
        meaning: '\'काबुलीवाला\' कहानी के प्रसिद्ध बंगाली लेखक',
      ),
      Flashcard(term: 'स्नेह', meaning: 'प्रेम और वात्सल्य का भाव'),
    ],
    assessment: [
      AssessmentQuestion(
        question: '\'काबुलीवाला\' कहानी के लेखक कौन हैं?',
        options: [
          'मुंशी प्रेमचंद',
          'रवींद्रनाथ टैगोर',
          'सुभद्रा कुमारी चौहान',
          'जयशंकर प्रसाद',
        ],
        correctIndex: 1,
      ),
      AssessmentQuestion(
        question: 'काबुलीवाला (रहमत) क्या बेचता था?',
        options: ['कपड़े', 'सूखे मेवे', 'मिठाई', 'खिलौने'],
        correctIndex: 1,
      ),
      AssessmentQuestion(
        question: 'रहमत की छोटी दोस्त का नाम क्या था?',
        options: ['मिनी', 'सीता', 'गीता', 'राधा'],
        correctIndex: 0,
      ),
      AssessmentQuestion(
        question: 'रहमत मूल रूप से कहाँ का निवासी था?',
        options: ['काबुल, अफगानिस्तान', 'दिल्ली', 'कोलकाता', 'मुंबई'],
        correctIndex: 0,
      ),
      AssessmentQuestion(
        question: 'इस कहानी का मुख्य भाव क्या है?',
        options: ['वैर', 'स्नेह और मित्रता', 'डर', 'लालच'],
        correctIndex: 1,
      ),
    ],
  ),
  'Class 5|Hindi|बिरसा मुंडा # अल्बर्ट एक्का': ChapterContent(
    worksheet: [
      'बिरसा मुंडा को \'भगवान\' क्यों कहा जाता है?',
      'बिरसा मुंडा ने अंग्रेज़ों और जमींदारों के विरुद्ध कौन-सा आंदोलन चलाया था?',
      'अल्बर्ट एक्का को कौन-सा वीरता पुरस्कार मिला और क्यों?',
      'बिरसा मुंडा और अल्बर्ट एक्का झारखंड के लिए गौरव क्यों हैं?',
      'इन दोनों महान व्यक्तित्वों से हमें क्या सीख मिलती है?',
    ],
    flashcards: [
      Flashcard(
        term: 'बिरसा मुंडा',
        meaning:
            'झारखंड के महान आदिवासी स्वतंत्रता सेनानी, जिन्होंने उलगुलान आंदोलन चलाया',
      ),
      Flashcard(
        term: 'उलगुलान',
        meaning:
            'बिरसा मुंडा द्वारा अंग्रेज़ों और जमींदारों के विरुद्ध चलाया गया विद्रोह',
      ),
      Flashcard(
        term: 'अल्बर्ट एक्का',
        meaning:
            'झारखंड के वीर सैनिक, जिन्हें 1971 के युद्ध में परमवीर चक्र मिला',
      ),
      Flashcard(
        term: 'परमवीर चक्र',
        meaning: 'भारत का सर्वोच्च सैन्य वीरता पुरस्कार',
      ),
      Flashcard(
        term: 'स्वतंत्रता सेनानी',
        meaning: 'देश की आज़ादी के लिए संघर्ष करने वाला व्यक्ति',
      ),
      Flashcard(
        term: 'बलिदान',
        meaning: 'देश या किसी उद्देश्य के लिए अपना जीवन त्याग देना',
      ),
    ],
    assessment: [
      AssessmentQuestion(
        question: 'बिरसा मुंडा ने कौन-सा प्रसिद्ध आंदोलन चलाया?',
        options: [
          'उलगुलान',
          'असहयोग आंदोलन',
          'चंपारण सत्याग्रह',
          'नमक सत्याग्रह',
        ],
        correctIndex: 0,
      ),
      AssessmentQuestion(
        question: 'बिरसा मुंडा का निधन किस वर्ष हुआ था?',
        options: ['1857', '1900', '1947', '1971'],
        correctIndex: 1,
      ),
      AssessmentQuestion(
        question:
            'अल्बर्ट एक्का को परमवीर चक्र किस युद्ध में वीरता के लिए मिला?',
        options: [
          '1962 का युद्ध',
          '1965 का युद्ध',
          '1971 का युद्ध',
          'करगिल युद्ध',
        ],
        correctIndex: 2,
      ),
      AssessmentQuestion(
        question: 'परमवीर चक्र भारत का कैसा सम्मान है?',
        options: [
          'सबसे बड़ा खेल पुरस्कार',
          'सर्वोच्च सैन्य वीरता पुरस्कार',
          'साहित्य पुरस्कार',
          'फिल्म पुरस्कार',
        ],
        correctIndex: 1,
      ),
      AssessmentQuestion(
        question:
            'बिरसा मुंडा और अल्बर्ट एक्का मूलतः किस राज्य से संबंधित हैं?',
        options: ['पंजाब', 'झारखंड', 'राजस्थान', 'केरल'],
        correctIndex: 1,
      ),
    ],
  ),
  'Class 5|Hindi|माँ, कह एक कहानी': ChapterContent(
    worksheet: [
      'तुम्हें माँ या दादी से सुनी हुई कोई कहानी याद है? उसका सार पाँच वाक्यों में लिखो।',
      'माँ द्वारा सुनाई गई कहानियों से बच्चों को क्या लाभ होता है?',
      '\'कहानी\' और \'कविता\' में क्या अंतर होता है?',
      'अपने परिवार में सोने से पहले कहानी सुनने की कोई आदत हो तो लिखो।',
      'कहानी सुनाने की परंपरा हमारी संस्कृति में क्यों महत्वपूर्ण है?',
    ],
    flashcards: [
      Flashcard(
        term: 'कहानी',
        meaning: 'किसी घटना या पात्र के बारे में सुनाया या लिखा गया वृत्तांत',
      ),
      Flashcard(
        term: 'कल्पना',
        meaning: 'मन में नई बातें या दृश्य सोचने की शक्ति',
      ),
      Flashcard(term: 'परंपरा', meaning: 'पीढ़ी दर पीढ़ी चली आ रही प्रथा'),
      Flashcard(
        term: 'लोरी',
        meaning: 'बच्चे को सुलाने के लिए गाया जाने वाला गीत',
      ),
      Flashcard(term: 'नैतिक शिक्षा', meaning: 'अच्छे आचरण की सीख'),
      Flashcard(term: 'किस्सा', meaning: 'कोई छोटी कहानी या वृत्तांत'),
    ],
    assessment: [
      AssessmentQuestion(
        question: 'बच्चों को सुलाने के लिए गाया जाने वाला गीत क्या कहलाता है?',
        options: ['लोरी', 'भजन', 'गजल', 'कव्वाली'],
        correctIndex: 0,
      ),
      AssessmentQuestion(
        question: '\'कल्पना\' शब्द का अर्थ है',
        options: [
          'सच्ची घटना',
          'मन में नई बातें सोचना',
          'गुस्सा करना',
          'सो जाना',
        ],
        correctIndex: 1,
      ),
      AssessmentQuestion(
        question: 'कहानियाँ सुनाने की परंपरा किससे चली आती है?',
        options: ['पीढ़ी दर पीढ़ी', 'केवल किताबों से', 'टीवी से', 'मोबाइल से'],
        correctIndex: 0,
      ),
      AssessmentQuestion(
        question: 'कहानियों से बच्चों को मुख्यतः क्या मिलता है?',
        options: ['डर', 'नैतिक शिक्षा और आनंद', 'थकान', 'गुस्सा'],
        correctIndex: 1,
      ),
      AssessmentQuestion(
        question: '\'किस्सा\' शब्द का समानार्थी शब्द है',
        options: ['कहानी', 'गणित', 'विज्ञान', 'खेल'],
        correctIndex: 0,
      ),
    ],
  ),
  'Class 5|Hindi|प्रकृति मेरी सखी : झारखंड': ChapterContent(
    worksheet: [
      'झारखंड की किन्हीं तीन प्रमुख नदियों के नाम लिखो।',
      'झारखंड को \'जंगलों और पठारों का प्रदेश\' क्यों कहा जाता है?',
      'झारखंड में पाए जाने वाले किन्हीं तीन वन्य जीवों के नाम लिखो।',
      'झारखंड की आदिवासी संस्कृति की कोई दो विशेषताएँ लिखो।',
      'हमें प्रकृति और जंगलों की रक्षा क्यों करनी चाहिए?',
    ],
    flashcards: [
      Flashcard(term: 'सुवर्णरेखा', meaning: 'झारखंड की एक प्रमुख नदी'),
      Flashcard(
        term: 'दामोदर',
        meaning:
            'झारखंड की एक महत्वपूर्ण नदी, जिसे \'दुखों की नदी\' भी कहा जाता था',
      ),
      Flashcard(
        term: 'पठार',
        meaning: 'समतल ऊँची भूमि, झारखंड में छोटानागपुर पठार प्रसिद्ध है',
      ),
      Flashcard(
        term: 'वन्य जीव',
        meaning: 'जंगलों में रहने वाले जानवर जैसे हाथी, बाघ',
      ),
      Flashcard(term: 'आदिवासी', meaning: 'मूल निवासी जनजाति समुदाय'),
      Flashcard(term: 'छोटानागपुर', meaning: 'झारखंड का प्रमुख पठारी क्षेत्र'),
    ],
    assessment: [
      AssessmentQuestion(
        question: 'झारखंड की प्रमुख नदी कौन-सी है?',
        options: ['सुवर्णरेखा', 'यमुना', 'कावेरी', 'सतलुज'],
        correctIndex: 0,
      ),
      AssessmentQuestion(
        question: 'झारखंड का प्रमुख पठार कौन-सा है?',
        options: ['दक्कन पठार', 'छोटानागपुर पठार', 'मालवा पठार', 'तिब्बत पठार'],
        correctIndex: 1,
      ),
      AssessmentQuestion(
        question: 'झारखंड मुख्यतः किसके लिए प्रसिद्ध है?',
        options: [
          'रेगिस्तान',
          'जंगल और खनिज संपदा',
          'समुद्र तट',
          'बर्फीले पहाड़',
        ],
        correctIndex: 1,
      ),
      AssessmentQuestion(
        question: 'झारखंड में रहने वाले मूल निवासी समुदाय क्या कहलाते हैं?',
        options: ['आदिवासी', 'व्यापारी', 'किसान', 'मछुआरे'],
        correctIndex: 0,
      ),
      AssessmentQuestion(
        question: 'हमें जंगलों की रक्षा क्यों करनी चाहिए?',
        options: [
          'क्योंकि वे बेकार हैं',
          'क्योंकि वे पर्यावरण संतुलन बनाए रखते हैं',
          'क्योंकि वे शहर हैं',
          'इनमें से कोई नहीं',
        ],
        correctIndex: 1,
      ),
    ],
  ),
  'Class 5|English|Good Night and Good Morning': ChapterContent(
    worksheet: [
      'Write five things you do every night before going to sleep.',
      'Write five things you do every morning after waking up.',
      'Why is it important to sleep on time and wake up early?',
      'Make a short daily routine chart with at least four activities and their times.',
      'Use the words \'night\' and \'morning\' each in a sentence of your own.',
    ],
    flashcards: [
      Flashcard(
        term: 'routine',
        meaning: 'things done regularly in a fixed order',
      ),
      Flashcard(
        term: 'dawn',
        meaning: 'the time when the sun rises, early morning',
      ),
      Flashcard(
        term: 'dusk',
        meaning: 'the time just before night, evening twilight',
      ),
      Flashcard(
        term: 'yawn',
        meaning: 'to open the mouth wide when sleepy or tired',
      ),
      Flashcard(term: 'refresh', meaning: 'to feel new energy after rest'),
      Flashcard(term: 'punctual', meaning: 'doing things on time'),
    ],
    assessment: [
      AssessmentQuestion(
        question: 'What is the opposite of \'morning\'?',
        options: ['Noon', 'Night', 'Evening', 'Dawn'],
        correctIndex: 1,
      ),
      AssessmentQuestion(
        question: '\'Dawn\' means',
        options: ['sunset', 'sunrise time', 'midnight', 'afternoon'],
        correctIndex: 1,
      ),
      AssessmentQuestion(
        question: 'Why should we sleep on time?',
        options: [
          'To stay lazy',
          'To stay healthy and active',
          'To watch TV',
          'To skip school',
        ],
        correctIndex: 1,
      ),
      AssessmentQuestion(
        question: 'A person who is always on time is called',
        options: ['lazy', 'punctual', 'careless', 'sleepy'],
        correctIndex: 1,
      ),
      AssessmentQuestion(
        question: 'Which activity is a good morning habit?',
        options: [
          'Brushing teeth',
          'Sleeping all day',
          'Skipping breakfast',
          'Staying in bed',
        ],
        correctIndex: 0,
      ),
    ],
  ),
  'Class 5|English|The Wooden Bowl': ChapterContent(
    worksheet: [
      'Why do you think the old man in the story was given food in a wooden bowl?',
      'What lesson can children learn from watching how elders are treated at home?',
      'Write three ways you can show respect to elders in your family.',
      'Why is it important to care for grandparents and old people?',
      'In your own words, explain what the moral of a story about a \'wooden bowl\' might be.',
    ],
    flashcards: [
      Flashcard(
        term: 'elder',
        meaning: 'an older person, especially in the family',
      ),
      Flashcard(
        term: 'respect',
        meaning: 'a feeling of honour and regard for someone',
      ),
      Flashcard(term: 'moral', meaning: 'the lesson taught by a story'),
      Flashcard(term: 'care', meaning: 'to look after someone with love'),
      Flashcard(
        term: 'kindness',
        meaning: 'being gentle and helpful to others',
      ),
      Flashcard(
        term: 'example',
        meaning: 'something that shows how to behave, a model',
      ),
    ],
    assessment: [
      AssessmentQuestion(
        question: 'The word \'elder\' refers to',
        options: [
          'a younger person',
          'an older person',
          'a stranger',
          'a teacher only',
        ],
        correctIndex: 1,
      ),
      AssessmentQuestion(
        question: 'What does \'respect\' mean?',
        options: ['fear', 'honour and regard', 'anger', 'jealousy'],
        correctIndex: 1,
      ),
      AssessmentQuestion(
        question: 'The lesson taught by a story is called its',
        options: ['title', 'moral', 'author', 'setting'],
        correctIndex: 1,
      ),
      AssessmentQuestion(
        question: 'Children usually learn behaviour by',
        options: [
          'watching elders',
          'ignoring everyone',
          'reading only',
          'sleeping',
        ],
        correctIndex: 0,
      ),
      AssessmentQuestion(
        question: 'Which is a good way to treat grandparents?',
        options: [
          'With kindness and care',
          'With anger',
          'By ignoring them',
          'By shouting at them',
        ],
        correctIndex: 0,
      ),
    ],
  ),
  'Class 5|English|A Blind Child Speaks': ChapterContent(
    worksheet: [
      'How do you think a blind person uses their other senses like hearing and touch?',
      'Write three ways we can help a blind or visually impaired friend at school.',
      'Why should we never make fun of someone with a disability?',
      'Name any device or tool that helps blind people move around safely.',
      'Write five sentences on how everyone deserves equal respect regardless of ability.',
    ],
    flashcards: [
      Flashcard(term: 'blind', meaning: 'unable to see'),
      Flashcard(
        term: 'senses',
        meaning: 'sight, hearing, smell, taste and touch',
      ),
      Flashcard(
        term: 'braille',
        meaning:
            'a system of raised dots that blind people read with their fingers',
      ),
      Flashcard(
        term: 'disability',
        meaning: 'a condition that limits a person\'s movement or senses',
      ),
      Flashcard(
        term: 'empathy',
        meaning: 'understanding and sharing another person\'s feelings',
      ),
      Flashcard(
        term: 'equality',
        meaning: 'treating everyone fairly and the same',
      ),
    ],
    assessment: [
      AssessmentQuestion(
        question: 'A blind person is unable to',
        options: ['hear', 'see', 'touch', 'smell'],
        correctIndex: 1,
      ),
      AssessmentQuestion(
        question: 'Braille is read using which sense?',
        options: ['Sight', 'Touch', 'Taste', 'Smell'],
        correctIndex: 1,
      ),
      AssessmentQuestion(
        question: 'How many main senses do humans have?',
        options: ['Three', 'Four', 'Five', 'Six'],
        correctIndex: 2,
      ),
      AssessmentQuestion(
        question: 'Understanding another person\'s feelings is called',
        options: ['empathy', 'anger', 'jealousy', 'pride'],
        correctIndex: 0,
      ),
      AssessmentQuestion(
        question: 'How should we treat people with disabilities?',
        options: [
          'With mockery',
          'With equal respect and kindness',
          'By ignoring them',
          'With fear',
        ],
        correctIndex: 1,
      ),
    ],
  ),
  'Class 5|English|Golu Goes to School': ChapterContent(
    worksheet: [
      'Write five things you carry in your school bag.',
      'Describe your first day at school in five sentences.',
      'Why is going to school important for every child?',
      'Write about your favourite subject and why you like it.',
      'Make a list of five rules students should follow at school.',
    ],
    flashcards: [
      Flashcard(
        term: 'school bag',
        meaning: 'a bag used to carry books and school items',
      ),
      Flashcard(
        term: 'timetable',
        meaning: 'a chart showing subjects and their timings',
      ),
      Flashcard(
        term: 'classmate',
        meaning: 'a student who studies in the same class',
      ),
      Flashcard(
        term: 'uniform',
        meaning: 'the same dress worn by all students of a school',
      ),
      Flashcard(
        term: 'discipline',
        meaning: 'following rules and behaving properly',
      ),
      Flashcard(
        term: 'curious',
        meaning: 'eager to learn or know about something',
      ),
    ],
    assessment: [
      AssessmentQuestion(
        question: 'What do students usually carry to school?',
        options: [
          'A school bag with books',
          'A television',
          'A car',
          'A stove',
        ],
        correctIndex: 0,
      ),
      AssessmentQuestion(
        question: 'A chart showing subjects and their timings is called a',
        options: ['report card', 'timetable', 'certificate', 'invitation'],
        correctIndex: 1,
      ),
      AssessmentQuestion(
        question: 'A student who studies in the same class as you is your',
        options: ['teacher', 'classmate', 'principal', 'guardian'],
        correctIndex: 1,
      ),
      AssessmentQuestion(
        question: 'Following rules and behaving properly is called',
        options: ['discipline', 'disorder', 'laziness', 'noise'],
        correctIndex: 0,
      ),
      AssessmentQuestion(
        question: 'Why is school important?',
        options: [
          'It teaches us and helps us grow',
          'It wastes time',
          'It is only for play',
          'It is not useful',
        ],
        correctIndex: 0,
      ),
    ],
  ),
  'Class 5|English|My Nation': ChapterContent(
    worksheet: [
      'Write five sentences about why you love your country.',
      'Name the national flag, national anthem, and national emblem of India.',
      'What can you do as a citizen to help keep your country clean and united?',
      'Write about one festival that shows the unity of India.',
      'Why is it important to respect people from different states, languages and religions?',
    ],
    flashcards: [
      Flashcard(
        term: 'nation',
        meaning: 'a country with its own people, land and government',
      ),
      Flashcard(
        term: 'citizen',
        meaning: 'a person who legally belongs to a country',
      ),
      Flashcard(term: 'unity', meaning: 'being together as one'),
      Flashcard(
        term: 'patriotism',
        meaning: 'love and devotion for one\'s country',
      ),
      Flashcard(
        term: 'diversity',
        meaning: 'variety of cultures, languages and people',
      ),
      Flashcard(
        term: 'national anthem',
        meaning: 'the official song of a country sung to show respect',
      ),
    ],
    assessment: [
      AssessmentQuestion(
        question: 'A person who legally belongs to a country is called a',
        options: ['tourist', 'citizen', 'foreigner', 'guest'],
        correctIndex: 1,
      ),
      AssessmentQuestion(
        question: 'Love and devotion for one\'s country is called',
        options: ['patriotism', 'anger', 'jealousy', 'fear'],
        correctIndex: 0,
      ),
      AssessmentQuestion(
        question: 'India\'s national anthem is',
        options: [
          'Vande Mataram',
          'Jana Gana Mana',
          'Saare Jahan Se Achha',
          'Ae Mere Watan Ke Logo',
        ],
        correctIndex: 1,
      ),
      AssessmentQuestion(
        question: '\'Unity\' means',
        options: [
          'being divided',
          'being together as one',
          'fighting',
          'ignoring others',
        ],
        correctIndex: 1,
      ),
      AssessmentQuestion(
        question: 'India is known for its',
        options: [
          'single language',
          'diversity of cultures and languages',
          'one religion only',
          'no festivals',
        ],
        correctIndex: 1,
      ),
    ],
  ),
  'Class 5|English|Republic Day Parade': ChapterContent(
    worksheet: [
      'On which date is Republic Day celebrated in India, and why?',
      'Where is the main Republic Day parade held every year?',
      'Who unfurls (hoists) the national flag on Republic Day?',
      'Write five things you might see at a Republic Day parade.',
      'Why is Republic Day different from Independence Day? Explain in a few sentences.',
    ],
    flashcards: [
      Flashcard(
        term: 'Republic Day',
        meaning:
            '26 January, the day India\'s Constitution came into effect in 1950',
      ),
      Flashcard(
        term: 'Constitution',
        meaning: 'the set of rules by which a country is governed',
      ),
      Flashcard(
        term: 'parade',
        meaning: 'a public march showing soldiers, tableaux and bands',
      ),
      Flashcard(
        term: 'tableau',
        meaning: 'a decorated float showing a state\'s or theme\'s culture',
      ),
      Flashcard(
        term: 'Rajpath/Kartavya Path',
        meaning: 'the avenue in Delhi where the Republic Day parade is held',
      ),
      Flashcard(
        term: 'salute',
        meaning: 'a formal gesture of respect, often to the flag or army',
      ),
    ],
    assessment: [
      AssessmentQuestion(
        question: 'Republic Day is celebrated on',
        options: ['15 August', '26 January', '2 October', '14 November'],
        correctIndex: 1,
      ),
      AssessmentQuestion(
        question: 'Republic Day marks the day India\'s',
        options: [
          'Constitution came into effect',
          'cricket team won a match',
          'first train ran',
          'first school opened',
        ],
        correctIndex: 0,
      ),
      AssessmentQuestion(
        question: 'The main Republic Day parade is held in',
        options: ['Mumbai', 'Delhi', 'Chennai', 'Kolkata'],
        correctIndex: 1,
      ),
      AssessmentQuestion(
        question:
            'A decorated float showing a state\'s culture in the parade is called a',
        options: ['tableau', 'chariot', 'bicycle', 'train'],
        correctIndex: 0,
      ),
      AssessmentQuestion(
        question:
            'Who is present as the chief guest tradition at India\'s Republic Day parade?',
        options: [
          'A foreign dignitary is often invited',
          'No one is invited',
          'Only school children',
          'Only soldiers',
        ],
        correctIndex: 0,
      ),
    ],
  ),
  'Class 5|English|Save the World': ChapterContent(
    worksheet: [
      'Write five things you can do every day to help protect the environment.',
      'Why is planting trees important for the world?',
      'What happens if we do not stop pollution and waste?',
      'Write a short slogan encouraging people to save water.',
      'Explain the meaning of \'reduce, reuse, recycle\' with one example each.',
    ],
    flashcards: [
      Flashcard(
        term: 'environment',
        meaning: 'the natural world around us, including air, water and land',
      ),
      Flashcard(
        term: 'pollution',
        meaning: 'harmful substances that dirty air, water or land',
      ),
      Flashcard(
        term: 'recycle',
        meaning: 'to process waste to make it usable again',
      ),
      Flashcard(
        term: 'conserve',
        meaning: 'to save or protect something carefully',
      ),
      Flashcard(
        term: 'sustainable',
        meaning: 'using resources in a way that does not harm the future',
      ),
      Flashcard(
        term: 'ecosystem',
        meaning: 'a community of living things and their environment',
      ),
    ],
    assessment: [
      AssessmentQuestion(
        question: '\'Pollution\' means',
        options: [
          'clean air',
          'harmful substances that dirty the environment',
          'growing trees',
          'saving water',
        ],
        correctIndex: 1,
      ),
      AssessmentQuestion(
        question: '\'Recycle\' means',
        options: [
          'throwing waste away',
          'processing waste to reuse it',
          'burning waste',
          'burying waste only',
        ],
        correctIndex: 1,
      ),
      AssessmentQuestion(
        question: 'Why should we plant trees?',
        options: [
          'They give shade and oxygen',
          'They cause pollution',
          'They waste water',
          'They are not useful',
        ],
        correctIndex: 0,
      ),
      AssessmentQuestion(
        question: 'The full form of the 3 R\'s for the environment is',
        options: [
          'Reduce, Reuse, Recycle',
          'Run, Read, Rest',
          'Rice, Rain, Road',
          'Red, Round, Real',
        ],
        correctIndex: 0,
      ),
      AssessmentQuestion(
        question: '\'Conserve\' means',
        options: ['to waste', 'to save or protect', 'to destroy', 'to ignore'],
        correctIndex: 1,
      ),
    ],
  ),
  'Class 5|English|The Bamboo Princess': ChapterContent(
    worksheet: [
      'What do you think a story titled \'The Bamboo Princess\' could be about?',
      'Write five words that describe qualities of a good princess or hero in a story.',
      'Bamboo is used to make many things - name three items made from bamboo.',
      'Write a short imaginative paragraph (4-5 sentences) about a princess found in a bamboo forest.',
      'What is the moral lesson usually found in fairy tales like this one?',
    ],
    flashcards: [
      Flashcard(
        term: 'bamboo',
        meaning: 'a tall, hollow-stemmed plant used for building and crafts',
      ),
      Flashcard(term: 'princess', meaning: 'the daughter of a king or queen'),
      Flashcard(
        term: 'folk tale',
        meaning: 'a traditional story passed down through generations',
      ),
      Flashcard(
        term: 'kindness',
        meaning: 'being gentle and caring towards others',
      ),
      Flashcard(
        term: 'imagination',
        meaning: 'the ability to form new ideas or pictures in the mind',
      ),
      Flashcard(
        term: 'fairy tale',
        meaning: 'a magical, imaginative story often with a moral',
      ),
    ],
    assessment: [
      AssessmentQuestion(
        question: 'Bamboo is a type of',
        options: ['metal', 'tall hollow plant', 'animal', 'rock'],
        correctIndex: 1,
      ),
      AssessmentQuestion(
        question:
            'A traditional story passed down through generations is called a',
        options: ['newspaper', 'folk tale', 'timetable', 'report'],
        correctIndex: 1,
      ),
      AssessmentQuestion(
        question: 'The daughter of a king or queen is called a',
        options: ['princess', 'minister', 'farmer', 'soldier'],
        correctIndex: 0,
      ),
      AssessmentQuestion(
        question: 'Fairy tales usually end with',
        options: [
          'a moral lesson',
          'a weather report',
          'a math problem',
          'a shopping list',
        ],
        correctIndex: 0,
      ),
      AssessmentQuestion(
        question: 'Which of these is commonly made from bamboo?',
        options: [
          'Baskets and furniture',
          'Glass bottles',
          'Steel rods',
          'Plastic bags',
        ],
        correctIndex: 0,
      ),
    ],
  ),
  'Class 5|English|The Swing': ChapterContent(
    worksheet: [
      'Describe how it feels to sit on a swing and go up and down.',
      'Write five words that describe fun activities in a park.',
      'Why is outdoor play important for children\'s health?',
      'Write a short poem or four lines about swinging in a garden.',
      'Name three playground equipment other than a swing.',
    ],
    flashcards: [
      Flashcard(
        term: 'swing',
        meaning: 'a seat hung by ropes or chains that moves back and forth',
      ),
      Flashcard(
        term: 'playground',
        meaning: 'an outdoor area with equipment for children to play',
      ),
      Flashcard(term: 'breeze', meaning: 'a gentle wind'),
      Flashcard(term: 'joyful', meaning: 'full of happiness'),
      Flashcard(term: 'balance', meaning: 'staying steady without falling'),
      Flashcard(
        term: 'seesaw',
        meaning: 'a long board balanced in the middle for two children to ride',
      ),
    ],
    assessment: [
      AssessmentQuestion(
        question: 'A swing moves in which way?',
        options: [
          'Back and forth',
          'Only sideways',
          'Only upward',
          'It does not move',
        ],
        correctIndex: 0,
      ),
      AssessmentQuestion(
        question: 'A gentle wind is called a',
        options: ['storm', 'breeze', 'flood', 'quake'],
        correctIndex: 1,
      ),
      AssessmentQuestion(
        question: 'Why is outdoor play good for children?',
        options: [
          'It keeps them fit and happy',
          'It is harmful',
          'It wastes time',
          'It causes illness',
        ],
        correctIndex: 0,
      ),
      AssessmentQuestion(
        question: 'Staying steady without falling is called',
        options: ['balance', 'noise', 'fear', 'hunger'],
        correctIndex: 0,
      ),
      AssessmentQuestion(
        question: 'Which of these is playground equipment?',
        options: ['Seesaw', 'Refrigerator', 'Blackboard', 'Bookshelf'],
        correctIndex: 0,
      ),
    ],
  ),
  'Class 5|English|Bravery Award': ChapterContent(
    worksheet: [
      'What does the word \'bravery\' mean to you? Give an example.',
      'Name a real Indian award given for bravery and courage.',
      'Write about a time when you or someone you know showed courage.',
      'Why do countries give bravery awards to soldiers and citizens?',
      'Write five qualities a brave person usually has.',
    ],
    flashcards: [
      Flashcard(
        term: 'bravery',
        meaning: 'courage shown in facing danger or difficulty',
      ),
      Flashcard(
        term: 'award',
        meaning: 'a prize given for achievement or good work',
      ),
      Flashcard(term: 'courage', meaning: 'the ability to face fear or danger'),
      Flashcard(term: 'hero', meaning: 'a person admired for brave deeds'),
      Flashcard(
        term: 'sacrifice',
        meaning: 'giving up something valuable for a greater cause',
      ),
      Flashcard(
        term: 'gallantry',
        meaning: 'great bravery, especially in battle',
      ),
    ],
    assessment: [
      AssessmentQuestion(
        question: '\'Bravery\' means',
        options: ['fear', 'courage in facing danger', 'laziness', 'anger'],
        correctIndex: 1,
      ),
      AssessmentQuestion(
        question: 'A person admired for brave deeds is called a',
        options: ['hero', 'villain', 'stranger', 'coward'],
        correctIndex: 0,
      ),
      AssessmentQuestion(
        question: '\'Gallantry\' is closest in meaning to',
        options: ['cowardice', 'great bravery', 'sadness', 'silence'],
        correctIndex: 1,
      ),
      AssessmentQuestion(
        question: 'Bravery awards are usually given to',
        options: [
          'those who show courage in danger',
          'those who are lazy',
          'those who hide from problems',
          'no one',
        ],
        correctIndex: 0,
      ),
      AssessmentQuestion(
        question: 'Giving up something valuable for a greater cause is called',
        options: ['sacrifice', 'theft', 'trade', 'gift'],
        correctIndex: 0,
      ),
    ],
  ),
  'Class 5|English|Science': ChapterContent(
    worksheet: [
      'What is science, and why is it important in our daily lives?',
      'Name any three branches of science and one thing each studies.',
      'Write about one scientific invention that has made life easier.',
      'What is the difference between a hypothesis and an experiment?',
      'Name three famous scientists and one of their contributions.',
    ],
    flashcards: [
      Flashcard(
        term: 'science',
        meaning:
            'the study of the natural world through observation and experiment',
      ),
      Flashcard(
        term: 'experiment',
        meaning: 'a test done to find out something new',
      ),
      Flashcard(
        term: 'observation',
        meaning: 'carefully watching and noting details',
      ),
      Flashcard(
        term: 'invention',
        meaning: 'something new created by a person',
      ),
      Flashcard(term: 'hypothesis', meaning: 'an idea or guess to be tested'),
      Flashcard(
        term: 'scientist',
        meaning: 'a person who studies and researches science',
      ),
    ],
    assessment: [
      AssessmentQuestion(
        question: 'Science is mainly the study of',
        options: [
          'stories',
          'the natural world through observation and experiment',
          'paintings',
          'music',
        ],
        correctIndex: 1,
      ),
      AssessmentQuestion(
        question: 'A test done to find out something new is called an',
        options: ['experiment', 'essay', 'exam only', 'invention'],
        correctIndex: 0,
      ),
      AssessmentQuestion(
        question: 'A person who studies and researches science is a',
        options: ['scientist', 'farmer', 'tailor', 'singer'],
        correctIndex: 0,
      ),
      AssessmentQuestion(
        question: 'An idea or guess to be tested is called a',
        options: ['hypothesis', 'conclusion', 'poem', 'story'],
        correctIndex: 0,
      ),
      AssessmentQuestion(
        question: 'Which of these is a famous scientist?',
        options: [
          'Albert Einstein',
          'William Shakespeare',
          'Leonardo da Vinci the painter',
          'Mozart',
        ],
        correctIndex: 0,
      ),
    ],
  ),
  'Class 5|English|Our Friend: Computer': ChapterContent(
    worksheet: [
      'Name the four main parts of a computer (input, output, CPU, memory) and give one example of each.',
      'Write five uses of a computer in daily life.',
      'What is the difference between hardware and software?',
      'Why should children use the internet carefully and safely?',
      'Name three devices that work like small computers.',
    ],
    flashcards: [
      Flashcard(
        term: 'computer',
        meaning:
            'an electronic device that processes data and follows instructions',
      ),
      Flashcard(
        term: 'hardware',
        meaning: 'the physical parts of a computer, like keyboard and monitor',
      ),
      Flashcard(
        term: 'software',
        meaning: 'the programs that run on a computer',
      ),
      Flashcard(
        term: 'keyboard',
        meaning: 'an input device used to type letters and numbers',
      ),
      Flashcard(
        term: 'monitor',
        meaning: 'the screen that displays computer output',
      ),
      Flashcard(
        term: 'internet',
        meaning: 'a global network connecting computers together',
      ),
    ],
    assessment: [
      AssessmentQuestion(
        question: 'The physical parts of a computer are called',
        options: ['hardware', 'software', 'internet', 'monitor only'],
        correctIndex: 0,
      ),
      AssessmentQuestion(
        question: 'Which of these is an input device?',
        options: ['Keyboard', 'Monitor', 'Printer', 'Speaker'],
        correctIndex: 0,
      ),
      AssessmentQuestion(
        question: 'The programs that run on a computer are called',
        options: ['hardware', 'software', 'mouse', 'keyboard'],
        correctIndex: 1,
      ),
      AssessmentQuestion(
        question: 'The screen that shows computer output is called the',
        options: ['monitor', 'CPU', 'keyboard', 'mouse'],
        correctIndex: 0,
      ),
      AssessmentQuestion(
        question: 'The internet connects computers',
        options: [
          'around the world',
          'in one room only',
          'never',
          'only in one country',
        ],
        correctIndex: 0,
      ),
    ],
  ),
  'Class 5|English|Mother Teresa': ChapterContent(
    worksheet: [
      'Who was Mother Teresa, and where did she do most of her work?',
      'What organisation did Mother Teresa found to help the poor and sick?',
      'Why did Mother Teresa receive the Nobel Peace Prize?',
      'Write five qualities you admire about Mother Teresa.',
      'How can you, as a child, help poor or needy people around you?',
    ],
    flashcards: [
      Flashcard(
        term: 'Mother Teresa',
        meaning:
            'a humanitarian who devoted her life to serving the poor and sick in Kolkata',
      ),
      Flashcard(
        term: 'Missionaries of Charity',
        meaning: 'the organisation founded by Mother Teresa to help the poor',
      ),
      Flashcard(
        term: 'Nobel Peace Prize',
        meaning: 'a famous international award given for work promoting peace',
      ),
      Flashcard(
        term: 'humanitarian',
        meaning: 'a person devoted to helping and promoting human welfare',
      ),
      Flashcard(
        term: 'compassion',
        meaning: 'deep sympathy and desire to help those who are suffering',
      ),
      Flashcard(
        term: 'charity',
        meaning: 'giving help, especially money or care, to those in need',
      ),
    ],
    assessment: [
      AssessmentQuestion(
        question:
            'Mother Teresa devoted her life to serving the poor mainly in which city?',
        options: ['Delhi', 'Kolkata', 'Mumbai', 'Chennai'],
        correctIndex: 1,
      ),
      AssessmentQuestion(
        question: 'What organisation did Mother Teresa found?',
        options: [
          'Missionaries of Charity',
          'Red Cross',
          'United Nations',
          'Indian Army',
        ],
        correctIndex: 0,
      ),
      AssessmentQuestion(
        question: 'Mother Teresa received which international award?',
        options: [
          'Nobel Peace Prize',
          'Olympic Gold Medal',
          'Grammy Award',
          'Oscar Award',
        ],
        correctIndex: 0,
      ),
      AssessmentQuestion(
        question: '\'Compassion\' means',
        options: [
          'deep sympathy and desire to help',
          'anger',
          'jealousy',
          'pride',
        ],
        correctIndex: 0,
      ),
      AssessmentQuestion(
        question: 'Mother Teresa is remembered mainly for her work with',
        options: [
          'the poor and sick',
          'sports teams',
          'film stars',
          'businessmen',
        ],
        correctIndex: 0,
      ),
    ],
  ),
  'Class 5|English|Sohrai Painting': ChapterContent(
    worksheet: [
      'What is Sohrai painting, and where does it come from?',
      'What natural materials are used to make Sohrai paintings?',
      'During which festival is Sohrai art traditionally created?',
      'Why is it important to preserve traditional art forms like Sohrai?',
      'Draw or describe one design or pattern you might see in a Sohrai painting.',
    ],
    flashcards: [
      Flashcard(
        term: 'Sohrai',
        meaning:
            'a traditional tribal wall-art form from Jharkhand, made during harvest festival',
      ),
      Flashcard(term: 'mural', meaning: 'a painting done directly on a wall'),
      Flashcard(
        term: 'natural pigment',
        meaning:
            'colour made from natural materials like soil, charcoal or plants',
      ),
      Flashcard(
        term: 'tribal art',
        meaning: 'traditional art created by indigenous or tribal communities',
      ),
      Flashcard(
        term: 'harvest festival',
        meaning: 'a celebration held after crops are gathered',
      ),
      Flashcard(
        term: 'heritage',
        meaning: 'traditions and culture passed down from ancestors',
      ),
    ],
    assessment: [
      AssessmentQuestion(
        question: 'Sohrai painting is a traditional art form from which state?',
        options: ['Jharkhand', 'Punjab', 'Kerala', 'Gujarat'],
        correctIndex: 0,
      ),
      AssessmentQuestion(
        question: 'Sohrai paintings are usually made on',
        options: ['walls of houses', 'paper only', 'glass', 'metal sheets'],
        correctIndex: 0,
      ),
      AssessmentQuestion(
        question: 'Sohrai art is associated with which type of festival?',
        options: [
          'Harvest festival',
          'New Year only',
          'Sports day',
          'Independence Day',
        ],
        correctIndex: 0,
      ),
      AssessmentQuestion(
        question: 'Sohrai paintings traditionally use',
        options: [
          'natural pigments from soil and plants',
          'plastic paint only',
          'digital printing',
          'metal dyes only',
        ],
        correctIndex: 0,
      ),
      AssessmentQuestion(
        question: '\'Heritage\' means',
        options: [
          'traditions passed down from ancestors',
          'a type of food',
          'a modern invention',
          'a sport',
        ],
        correctIndex: 0,
      ),
    ],
  ),
  'Class 5|English|Newspaper': ChapterContent(
    worksheet: [
      'Name five sections you might find in a newspaper (like sports, weather).',
      'Why is reading the newspaper a good daily habit?',
      'What is the difference between a headline and a news report?',
      'Name three ways news reaches people besides newspapers.',
      'Write a short headline (one line) for an imaginary school event.',
    ],
    flashcards: [
      Flashcard(
        term: 'newspaper',
        meaning:
            'a printed publication containing news, articles and advertisements',
      ),
      Flashcard(
        term: 'headline',
        meaning: 'the title of a news story, printed in large letters',
      ),
      Flashcard(
        term: 'journalist',
        meaning: 'a person who writes news reports',
      ),
      Flashcard(
        term: 'editor',
        meaning: 'a person who reviews and finalises content before printing',
      ),
      Flashcard(
        term: 'column',
        meaning: 'a regular section of writing by a particular writer',
      ),
      Flashcard(
        term: 'current affairs',
        meaning: 'events happening in the present time',
      ),
    ],
    assessment: [
      AssessmentQuestion(
        question:
            'The title of a news story printed in large letters is called a',
        options: ['headline', 'footnote', 'index', 'signature'],
        correctIndex: 0,
      ),
      AssessmentQuestion(
        question: 'A person who writes news reports is called a',
        options: ['journalist', 'farmer', 'doctor', 'tailor'],
        correctIndex: 0,
      ),
      AssessmentQuestion(
        question: 'A person who reviews and finalises newspaper content is the',
        options: ['editor', 'printer', 'reader', 'vendor'],
        correctIndex: 0,
      ),
      AssessmentQuestion(
        question: 'Reading the newspaper daily helps us know about',
        options: [
          'current affairs',
          'only cartoons',
          'nothing useful',
          'only advertisements',
        ],
        correctIndex: 0,
      ),
      AssessmentQuestion(
        question: 'Which of these is NOT usually found in a newspaper?',
        options: [
          'Sports news',
          'Weather report',
          'A birthday cake',
          'Editorial column',
        ],
        correctIndex: 2,
      ),
    ],
  ),
  'Class 5|Mathematics|कोण': ChapterContent(
    worksheet: [
      'समकोण (90 डिग्री), न्यून कोण और अधिक कोण की परिभाषा लिखो।',
      'अपने कमरे में तीन ऐसी वस्तुएँ खोजो जिनमें समकोण बनता है, उनके नाम लिखो।',
      'एक सीधी रेखा (180 डिग्री) पर बना कोण किस प्रकार का कोण कहलाता है?',
      'यदि एक कोण 45 डिग्री का है, तो वह न्यून कोण है या अधिक कोण? कारण सहित लिखो।',
      'दो कोण मिलकर 90 डिग्री बनाते हैं। यदि एक कोण 35 डिग्री है, तो दूसरा कोण कितने डिग्री का होगा?',
    ],
    flashcards: [
      Flashcard(
        term: 'कोण',
        meaning:
            'दो रेखाओं के मिलने से बनने वाला आकार, जिसे डिग्री में मापा जाता है',
      ),
      Flashcard(term: 'समकोण', meaning: 'ठीक 90 डिग्री का कोण'),
      Flashcard(term: 'न्यून कोण', meaning: '90 डिग्री से कम का कोण'),
      Flashcard(
        term: 'अधिक कोण',
        meaning: '90 डिग्री से अधिक और 180 डिग्री से कम का कोण',
      ),
      Flashcard(
        term: 'सरल कोण',
        meaning: 'ठीक 180 डिग्री का कोण, जो एक सीधी रेखा बनाता है',
      ),
      Flashcard(
        term: 'शीर्ष',
        meaning: 'वह बिंदु जहाँ कोण की दोनों भुजाएँ मिलती हैं',
      ),
    ],
    assessment: [
      AssessmentQuestion(
        question: 'समकोण कितने डिग्री का होता है?',
        options: ['45 डिग्री', '90 डिग्री', '180 डिग्री', '360 डिग्री'],
        correctIndex: 1,
      ),
      AssessmentQuestion(
        question: '60 डिग्री का कोण किस प्रकार का कोण है?',
        options: ['न्यून कोण', 'समकोण', 'अधिक कोण', 'सरल कोण'],
        correctIndex: 0,
      ),
      AssessmentQuestion(
        question: '120 डिग्री का कोण किस प्रकार का कोण है?',
        options: ['न्यून कोण', 'समकोण', 'अधिक कोण', 'शून्य कोण'],
        correctIndex: 2,
      ),
      AssessmentQuestion(
        question: 'एक सीधी रेखा पर बना कोण कितने डिग्री का होता है?',
        options: ['90 डिग्री', '180 डिग्री', '270 डिग्री', '360 डिग्री'],
        correctIndex: 1,
      ),
      AssessmentQuestion(
        question:
            'यदि एक कोण 35 डिग्री है और दूसरे के साथ मिलकर 90 डिग्री बनाता है, तो दूसरा कोण कितने डिग्री का है?',
        options: ['45 डिग्री', '55 डिग्री', '65 डिग्री', '75 डिग्री'],
        correctIndex: 1,
      ),
    ],
  ),
  'Class 5|Mathematics|संख्याएँ': ChapterContent(
    worksheet: [
      '78,345 में अंक \'3\' का स्थानीय मान लिखो।',
      'निम्न संख्याओं को आरोही क्रम (छोटे से बड़े) में लिखो: 4521, 4215, 4512, 4152',
      'सबसे बड़ी पाँच अंकों की संख्या और सबसे छोटी पाँच अंकों की संख्या लिखो।',
      '12,345 को शब्दों में लिखो (हिंदी में)।',
      '45,678 में सबसे बड़े और सबसे छोटे अंक का स्थानीय मान ज्ञात करो।',
    ],
    flashcards: [
      Flashcard(
        term: 'स्थानीय मान',
        meaning:
            'किसी अंक का उसके स्थान के अनुसार मूल्य, जैसे इकाई, दहाई, सैकड़ा',
      ),
      Flashcard(
        term: 'आरोही क्रम',
        meaning: 'छोटी संख्या से बड़ी संख्या की ओर व्यवस्थित करना',
      ),
      Flashcard(
        term: 'अवरोही क्रम',
        meaning: 'बड़ी संख्या से छोटी संख्या की ओर व्यवस्थित करना',
      ),
      Flashcard(
        term: 'अंक',
        meaning: '0 से 9 तक की संख्याएँ जिनसे बड़ी संख्याएँ बनती हैं',
      ),
      Flashcard(
        term: 'सम संख्या',
        meaning: 'वह संख्या जो 2 से पूरी-पूरी विभाजित हो जाए',
      ),
      Flashcard(
        term: 'विषम संख्या',
        meaning: 'वह संख्या जो 2 से पूरी-पूरी विभाजित न हो',
      ),
    ],
    assessment: [
      AssessmentQuestion(
        question: 'सबसे बड़ी पाँच अंकों की संख्या कौन-सी है?',
        options: ['99999', '10000', '99000', '90000'],
        correctIndex: 0,
      ),
      AssessmentQuestion(
        question: 'सबसे छोटी पाँच अंकों की संख्या कौन-सी है?',
        options: ['99999', '10000', '00001', '11111'],
        correctIndex: 1,
      ),
      AssessmentQuestion(
        question: '78,345 में अंक \'3\' का स्थानीय मान क्या है?',
        options: ['3', '30', '300', '3000'],
        correctIndex: 2,
      ),
      AssessmentQuestion(
        question: 'इनमें से कौन-सी सम संख्या है?',
        options: ['21', '35', '48', '53'],
        correctIndex: 2,
      ),
      AssessmentQuestion(
        question: 'इनमें से कौन-सी विषम संख्या है?',
        options: ['24', '36', '47', '50'],
        correctIndex: 2,
      ),
    ],
  ),
  'Class 5|Mathematics|संक्रियाएँ': ChapterContent(
    worksheet: [
      'जोड़ करो: 4,536 + 2,879 = ?',
      'घटाओ: 9,000 - 3,456 = ?',
      'गुणा करो: 245 x 12 = ?',
      'भाग करो: 968 ÷ 8 = ?',
      'एक दुकानदार के पास 3,250 रुपये थे। उसने 1,875 रुपये का सामान बेचा। अब उसके पास कुल कितने रुपये होंगे? (जोड़कर हल करो)',
    ],
    flashcards: [
      Flashcard(
        term: 'जोड़',
        meaning: 'दो या अधिक संख्याओं को मिलाने की क्रिया',
      ),
      Flashcard(
        term: 'घटाव',
        meaning: 'एक संख्या में से दूसरी संख्या निकालने की क्रिया',
      ),
      Flashcard(
        term: 'गुणा',
        meaning: 'किसी संख्या को बार-बार जोड़ने की संक्षिप्त विधि',
      ),
      Flashcard(
        term: 'भाग',
        meaning: 'किसी संख्या को बराबर भागों में बाँटने की क्रिया',
      ),
      Flashcard(term: 'योग', meaning: 'जोड़ का परिणाम'),
      Flashcard(term: 'शेषफल', meaning: 'भाग करने के बाद बचा हुआ अंश'),
    ],
    assessment: [
      AssessmentQuestion(
        question: '4,536 + 2,879 = ?',
        options: ['7,415', '7,315', '7,405', '6,415'],
        correctIndex: 0,
      ),
      AssessmentQuestion(
        question: '9,000 - 3,456 = ?',
        options: ['5,544', '5,644', '5,454', '6,544'],
        correctIndex: 0,
      ),
      AssessmentQuestion(
        question: '245 x 12 = ?',
        options: ['2,940', '2,840', '2,740', '3,040'],
        correctIndex: 0,
      ),
      AssessmentQuestion(
        question: '968 ÷ 8 = ?',
        options: ['119', '121', '126', '131'],
        correctIndex: 1,
      ),
      AssessmentQuestion(
        question: 'किसी संख्या को बराबर भागों में बाँटने की क्रिया कहलाती है',
        options: ['जोड़', 'घटाव', 'गुणा', 'भाग'],
        correctIndex: 3,
      ),
    ],
  ),
  'Class 5|Mathematics|गुणज और गुणनखंड': ChapterContent(
    worksheet: [
      '6 के पहले पाँच गुणज लिखो।',
      '24 के सभी गुणनखंड लिखो।',
      '12 और 18 का महत्तम समापवर्तक (HCF) ज्ञात करो।',
      '4 और 6 का लघुत्तम समापवर्त्य (LCM) ज्ञात करो।',
      'बताओ कि 36 अभाज्य संख्या है या भाज्य संख्या, कारण सहित लिखो।',
    ],
    flashcards: [
      Flashcard(
        term: 'गुणज',
        meaning: 'किसी संख्या को 1, 2, 3... से गुणा करने पर प्राप्त संख्याएँ',
      ),
      Flashcard(
        term: 'गुणनखंड',
        meaning: 'वे संख्याएँ जो किसी संख्या को पूरी-पूरी विभाजित करती हैं',
      ),
      Flashcard(
        term: 'अभाज्य संख्या',
        meaning: 'वह संख्या जिसके केवल दो गुणनखंड हों - 1 और वह स्वयं',
      ),
      Flashcard(
        term: 'भाज्य संख्या',
        meaning: 'वह संख्या जिसके दो से अधिक गुणनखंड हों',
      ),
      Flashcard(
        term: 'महत्तम समापवर्तक (HCF)',
        meaning: 'दो या अधिक संख्याओं का सबसे बड़ा उभयनिष्ठ गुणनखंड',
      ),
      Flashcard(
        term: 'लघुत्तम समापवर्त्य (LCM)',
        meaning: 'दो या अधिक संख्याओं का सबसे छोटा उभयनिष्ठ गुणज',
      ),
    ],
    assessment: [
      AssessmentQuestion(
        question: '6 का तीसरा गुणज क्या है?',
        options: ['12', '18', '24', '6'],
        correctIndex: 1,
      ),
      AssessmentQuestion(
        question: '24 का गुणनखंड नहीं है',
        options: ['4', '6', '8', '5'],
        correctIndex: 3,
      ),
      AssessmentQuestion(
        question: '12 और 18 का HCF क्या है?',
        options: ['2', '3', '6', '9'],
        correctIndex: 2,
      ),
      AssessmentQuestion(
        question: '4 और 6 का LCM क्या है?',
        options: ['10', '12', '24', '8'],
        correctIndex: 1,
      ),
      AssessmentQuestion(
        question: 'इनमें से कौन-सी अभाज्य संख्या है?',
        options: ['9', '15', '17', '21'],
        correctIndex: 2,
      ),
    ],
  ),
  'Class 5|Mathematics|भिन्न': ChapterContent(
    worksheet: [
      '1/2 और 1/4 को जोड़ो और उत्तर को सरलतम रूप में लिखो।',
      '3/4 और 1/8 में से कौन-सी भिन्न बड़ी है? कारण सहित बताओ।',
      '2/6 को सरलतम रूप में लिखो।',
      '3/5 को दशमलव (decimal) में बदलो।',
      'एक केक का 1/2 भाग राम ने और 1/4 भाग श्याम ने खाया। दोनों ने मिलकर कुल कितना भाग खाया?',
    ],
    flashcards: [
      Flashcard(
        term: 'भिन्न',
        meaning: 'किसी पूर्ण वस्तु का भाग, जैसे 1/2, 3/4',
      ),
      Flashcard(term: 'अंश', meaning: 'भिन्न में ऊपर लिखी गई संख्या'),
      Flashcard(term: 'हर', meaning: 'भिन्न में नीचे लिखी गई संख्या'),
      Flashcard(
        term: 'सरलतम रूप',
        meaning:
            'भिन्न का वह रूप जिसमें अंश और हर में 1 के अलावा कोई उभयनिष्ठ गुणनखंड न हो',
      ),
      Flashcard(
        term: 'सम भिन्न',
        meaning: 'वह भिन्न जिसमें अंश, हर से छोटा हो',
      ),
      Flashcard(
        term: 'विषम भिन्न',
        meaning: 'वह भिन्न जिसमें अंश, हर से बड़ा या बराबर हो',
      ),
    ],
    assessment: [
      AssessmentQuestion(
        question: '1/2 + 1/4 = ?',
        options: ['1/4', '2/4', '3/4', '1'],
        correctIndex: 2,
      ),
      AssessmentQuestion(
        question: '3/4 और 1/8 में से बड़ी भिन्न कौन-सी है?',
        options: ['3/4', '1/8', 'दोनों बराबर हैं', 'कोई नहीं'],
        correctIndex: 0,
      ),
      AssessmentQuestion(
        question: '2/6 का सरलतम रूप क्या है?',
        options: ['1/3', '1/2', '2/3', '1/6'],
        correctIndex: 0,
      ),
      AssessmentQuestion(
        question: '3/5 को दशमलव में लिखो',
        options: ['0.3', '0.5', '0.6', '0.35'],
        correctIndex: 2,
      ),
      AssessmentQuestion(
        question: 'भिन्न में ऊपर की संख्या को क्या कहते हैं?',
        options: ['हर', 'अंश', 'योग', 'गुणज'],
        correctIndex: 1,
      ),
    ],
  ),
  'Class 5|Mathematics|मापन': ChapterContent(
    worksheet: [
      '1 मीटर में कितने सेंटीमीटर होते हैं?',
      '1 किलोग्राम में कितने ग्राम होते हैं?',
      '1 लीटर में कितने मिलीलीटर होते हैं?',
      'एक कपड़े की लंबाई 2 मीटर 50 सेंटीमीटर है। इसे केवल सेंटीमीटर में लिखो।',
      'राम के पास 3 किलोग्राम 250 ग्राम चावल है। इसे केवल ग्राम में लिखो।',
    ],
    flashcards: [
      Flashcard(term: 'मीटर', meaning: 'लंबाई मापने की मानक इकाई'),
      Flashcard(term: 'किलोग्राम', meaning: 'भार (वजन) मापने की मानक इकाई'),
      Flashcard(
        term: 'लीटर',
        meaning: 'तरल पदार्थ की मात्रा मापने की मानक इकाई',
      ),
      Flashcard(
        term: 'सेंटीमीटर',
        meaning: 'मीटर का छोटा भाग, 1 मीटर = 100 सेंटीमीटर',
      ),
      Flashcard(
        term: 'ग्राम',
        meaning: 'किलोग्राम का छोटा भाग, 1 किलोग्राम = 1000 ग्राम',
      ),
      Flashcard(
        term: 'मिलीलीटर',
        meaning: 'लीटर का छोटा भाग, 1 लीटर = 1000 मिलीलीटर',
      ),
    ],
    assessment: [
      AssessmentQuestion(
        question: '1 मीटर में कितने सेंटीमीटर होते हैं?',
        options: ['10', '100', '1000', '1'],
        correctIndex: 1,
      ),
      AssessmentQuestion(
        question: '1 किलोग्राम में कितने ग्राम होते हैं?',
        options: ['100', '1000', '10', '10000'],
        correctIndex: 1,
      ),
      AssessmentQuestion(
        question: '1 लीटर में कितने मिलीलीटर होते हैं?',
        options: ['10', '100', '1000', '10000'],
        correctIndex: 2,
      ),
      AssessmentQuestion(
        question: '2 मीटर 50 सेंटीमीटर को केवल सेंटीमीटर में लिखो',
        options: ['250 सेमी', '205 सेमी', '25 सेमी', '2050 सेमी'],
        correctIndex: 0,
      ),
      AssessmentQuestion(
        question: '3 किलोग्राम 250 ग्राम को केवल ग्राम में लिखो',
        options: ['3250 ग्राम', '3025 ग्राम', '325 ग्राम', '32500 ग्राम'],
        correctIndex: 0,
      ),
    ],
  ),
  'Class 5|Mathematics|मुद्रा': ChapterContent(
    worksheet: [
      'रीना के पास 50 रुपये थे। उसने 27 रुपये की एक पेंसिल-बॉक्स खरीदी। उसके पास कितने रुपये बचे?',
      'एक कॉपी की कीमत 15 रुपये है। 6 कॉपियों की कुल कीमत कितनी होगी?',
      '100 रुपये में से 5 रुपये के सिक्कों की कितनी संख्या बनेगी?',
      'मोहन ने 235 रुपये और सीता ने 165 रुपये मिलाकर एक उपहार खरीदा। उपहार की कुल कीमत कितनी थी?',
      'यदि एक पेन 12 रुपये का है, तो 250 रुपये में अधिकतम कितने पेन खरीदे जा सकते हैं?',
    ],
    flashcards: [
      Flashcard(
        term: 'मुद्रा',
        meaning:
            'देश में लेन-देन के लिए प्रयोग होने वाला धन, जैसे भारत में रुपया',
      ),
      Flashcard(
        term: 'सिक्का',
        meaning: 'धातु से बना गोल धन जैसे 1, 2, 5, 10 रुपये का सिक्का',
      ),
      Flashcard(
        term: 'नोट',
        meaning: 'कागज़ की मुद्रा जैसे 10, 50, 100, 500 रुपये का नोट',
      ),
      Flashcard(
        term: 'कीमत',
        meaning: 'किसी वस्तु का मूल्य, जो रुपयों में बताया जाता है',
      ),
      Flashcard(term: 'बचत', meaning: 'खर्च के बाद बचा हुआ पैसा'),
      Flashcard(
        term: 'व्यय',
        meaning: 'किसी वस्तु या सेवा पर खर्च किया गया धन',
      ),
    ],
    assessment: [
      AssessmentQuestion(
        question: '50 रुपये में से 27 रुपये खर्च करने पर कितने रुपये बचेंगे?',
        options: ['13', '23', '33', '43'],
        correctIndex: 1,
      ),
      AssessmentQuestion(
        question: '15 रुपये की एक कॉपी की 6 कॉपियों की कुल कीमत क्या होगी?',
        options: ['80 रुपये', '85 रुपये', '90 रुपये', '95 रुपये'],
        correctIndex: 2,
      ),
      AssessmentQuestion(
        question: '100 रुपये में 5 रुपये के कितने सिक्के आएँगे?',
        options: ['10', '20', '25', '50'],
        correctIndex: 1,
      ),
      AssessmentQuestion(
        question: '235 रुपये और 165 रुपये को जोड़ने पर कुल कितना होगा?',
        options: ['380 रुपये', '390 रुपये', '400 रुपये', '410 रुपये'],
        correctIndex: 2,
      ),
      AssessmentQuestion(
        question:
            '12 रुपये के पेन की 250 रुपये में अधिकतम कितनी संख्या खरीदी जा सकती है?',
        options: ['18', '20', '22', '24'],
        correctIndex: 1,
      ),
    ],
  ),
  'Class 5|Mathematics|पैटर्न': ChapterContent(
    worksheet: [
      'इस श्रृंखला को आगे बढ़ाओ: 2, 4, 6, 8, __, __',
      'इस श्रृंखला को आगे बढ़ाओ: 5, 10, 15, 20, __, __',
      'इस पैटर्न में अगली दो संख्याएँ लिखो: 3, 6, 9, 12, __, __',
      'एक पैटर्न बनाओ जिसमें आकृतियाँ (जैसे वृत्त, त्रिभुज) दोहराई जाएँ, कम से कम 8 आकृतियों का।',
      'इस श्रृंखला में लुप्त संख्या ज्ञात करो: 10, 20, __, 40, 50',
    ],
    flashcards: [
      Flashcard(
        term: 'पैटर्न',
        meaning: 'किसी निश्चित नियम के अनुसार दोहराया जाने वाला क्रम',
      ),
      Flashcard(
        term: 'श्रृंखला',
        meaning: 'एक निश्चित नियम से बनी संख्याओं या आकृतियों की क्रमबद्ध सूची',
      ),
      Flashcard(
        term: 'नियम',
        meaning: 'वह तरीका जिसके अनुसार पैटर्न आगे बढ़ता है',
      ),
      Flashcard(
        term: 'आवृत्ति',
        meaning: 'किसी वस्तु या आकृति का बार-बार दोहराया जाना',
      ),
      Flashcard(
        term: 'आरोही पैटर्न',
        meaning: 'बढ़ते क्रम में चलने वाला पैटर्न',
      ),
      Flashcard(
        term: 'अवरोही पैटर्न',
        meaning: 'घटते क्रम में चलने वाला पैटर्न',
      ),
    ],
    assessment: [
      AssessmentQuestion(
        question: '2, 4, 6, 8, __, __ में अगली दो संख्याएँ क्या हैं?',
        options: ['9, 10', '10, 12', '10, 11', '12, 14'],
        correctIndex: 1,
      ),
      AssessmentQuestion(
        question: '5, 10, 15, 20, __ में अगली संख्या क्या है?',
        options: ['22', '24', '25', '30'],
        correctIndex: 2,
      ),
      AssessmentQuestion(
        question: '3, 6, 9, 12, __ में अगली संख्या क्या है?',
        options: ['14', '15', '16', '18'],
        correctIndex: 1,
      ),
      AssessmentQuestion(
        question: '10, 20, __, 40, 50 में लुप्त संख्या क्या है?',
        options: ['25', '30', '35', '45'],
        correctIndex: 1,
      ),
      AssessmentQuestion(
        question:
            'एक निश्चित नियम से बार-बार दोहराए जाने वाले क्रम को क्या कहते हैं?',
        options: ['पैटर्न', 'भिन्न', 'मुद्रा', 'मापन'],
        correctIndex: 0,
      ),
    ],
  ),
  'Class 5|Environmental Studies|कौन किसके जैसा': ChapterContent(
    worksheet: [
      'अपने माता-पिता और अपने बीच पाई जाने वाली किन्हीं तीन समानताओं को लिखो।',
      'जानवरों के बच्चे अपने माता-पिता जैसे कैसे दिखते हैं? एक उदाहरण दो।',
      'गुण एक पीढ़ी से दूसरी पीढ़ी में कैसे जाते हैं, अपने शब्दों में लिखो।',
      'अपने परिवार के किसी सदस्य से मिलती-जुलती अपनी कोई विशेषता लिखो।',
      'क्या सभी भाई-बहन एक जैसे दिखते हैं? कारण सहित बताओ।',
    ],
    flashcards: [
      Flashcard(
        term: 'आनुवंशिकता',
        meaning: 'माता-पिता से बच्चों में गुणों का संचरण',
      ),
      Flashcard(
        term: 'समानता',
        meaning: 'दो या अधिक वस्तुओं/व्यक्तियों में मिलती-जुलती विशेषताएँ',
      ),
      Flashcard(
        term: 'पीढ़ी',
        meaning: 'एक ही समय में जन्मे लोगों का समूह, जैसे दादा-पिता-बच्चे',
      ),
      Flashcard(term: 'लक्षण', meaning: 'किसी जीव की पहचान बताने वाली विशेषता'),
      Flashcard(term: 'वंश', meaning: 'एक ही परिवार की आगे की पीढ़ियाँ'),
      Flashcard(term: 'विविधता', meaning: 'भिन्नता या अलग-अलग रूप'),
    ],
    assessment: [
      AssessmentQuestion(
        question:
            'बच्चों में माता-पिता जैसे गुण आने की प्रक्रिया क्या कहलाती है?',
        options: ['आनुवंशिकता', 'प्रदूषण', 'पाचन', 'श्वसन'],
        correctIndex: 0,
      ),
      AssessmentQuestion(
        question: 'एक ही समय के परिवार के सदस्यों का समूह कहलाता है',
        options: ['पीढ़ी', 'जनसंख्या', 'वंश', 'समूह'],
        correctIndex: 0,
      ),
      AssessmentQuestion(
        question: 'क्या सभी भाई-बहन बिल्कुल एक जैसे दिखते हैं?',
        options: [
          'हाँ, हमेशा',
          'नहीं, हर किसी में कुछ भिन्नता होती है',
          'पता नहीं',
          'केवल जुड़वाँ एक जैसे होते हैं और बाकी नहीं दिखते',
        ],
        correctIndex: 1,
      ),
      AssessmentQuestion(
        question: '\'लक्षण\' शब्द का अर्थ है',
        options: ['पहचान बताने वाली विशेषता', 'भोजन', 'पानी', 'हवा'],
        correctIndex: 0,
      ),
      AssessmentQuestion(
        question: 'जानवरों के बच्चे सामान्यतः किसके समान दिखते हैं?',
        options: [
          'अपने माता-पिता के',
          'किसी अन्य जीव के',
          'पेड़-पौधों के',
          'पत्थरों के',
        ],
        correctIndex: 0,
      ),
    ],
  ),
  'Class 5|Environmental Studies|काम की खोज': ChapterContent(
    worksheet: [
      'अपने आस-पास के लोगों के किन्हीं पाँच अलग-अलग पेशों (काम) के नाम लिखो।',
      'किसी एक व्यक्ति का साक्षात्कार करके लिखो कि वह अपना काम कैसे सीखा।',
      'काम ढूँढ़ने के लिए कौशल (skill) सीखना क्यों जरूरी है?',
      'तुम बड़े होकर क्या काम करना चाहोगे और क्यों?',
      'गाँव और शहर में मिलने वाले कामों में क्या अंतर होता है?',
    ],
    flashcards: [
      Flashcard(
        term: 'पेशा',
        meaning: 'जीविका चलाने के लिए किया जाने वाला काम',
      ),
      Flashcard(term: 'कौशल', meaning: 'किसी काम को अच्छी तरह करने की क्षमता'),
      Flashcard(
        term: 'रोजगार',
        meaning: 'आजीविका कमाने के लिए किया जाने वाला कार्य',
      ),
      Flashcard(term: 'श्रमिक', meaning: 'मेहनत करके काम करने वाला व्यक्ति'),
      Flashcard(
        term: 'स्वरोजगार',
        meaning: 'स्वयं का व्यवसाय शुरू करके काम करना',
      ),
      Flashcard(term: 'प्रशिक्षण', meaning: 'किसी काम को सीखने की प्रक्रिया'),
    ],
    assessment: [
      AssessmentQuestion(
        question: 'जीविका चलाने के लिए किए जाने वाले काम को क्या कहते हैं?',
        options: ['पेशा', 'खेल', 'त्योहार', 'पर्व'],
        correctIndex: 0,
      ),
      AssessmentQuestion(
        question: 'किसी काम को अच्छी तरह करने की क्षमता को क्या कहते हैं?',
        options: ['कौशल', 'आलस्य', 'भय', 'क्रोध'],
        correctIndex: 0,
      ),
      AssessmentQuestion(
        question: 'स्वयं का व्यवसाय शुरू करना क्या कहलाता है?',
        options: ['स्वरोजगार', 'बेरोजगारी', 'अवकाश', 'यात्रा'],
        correctIndex: 0,
      ),
      AssessmentQuestion(
        question: 'मेहनत करके काम करने वाले व्यक्ति को क्या कहते हैं?',
        options: ['श्रमिक', 'अतिथि', 'यात्री', 'राजा'],
        correctIndex: 0,
      ),
      AssessmentQuestion(
        question: 'काम सीखने की प्रक्रिया को क्या कहते हैं?',
        options: ['प्रशिक्षण', 'अवकाश', 'मनोरंजन', 'भोजन'],
        correctIndex: 0,
      ),
    ],
  ),
  'Class 5|Environmental Studies|बदला बसेरा': ChapterContent(
    worksheet: [
      'जब कोई परिवार एक स्थान से दूसरे स्थान पर रहने जाता है, तो उसे क्या कहते हैं?',
      'नए स्थान पर बसने पर किन नई चीज़ों को अपनाना पड़ता है?',
      'प्रवास (माइग्रेशन) के कोई दो कारण लिखो।',
      'यदि तुम्हें नए शहर में जाना पड़े, तो तुम्हें किन बातों की सबसे ज्यादा याद आएगी?',
      'प्रवासी परिवारों की मदद करने के लिए हम क्या कर सकते हैं?',
    ],
    flashcards: [
      Flashcard(
        term: 'प्रवास',
        meaning:
            'एक स्थान से दूसरे स्थान पर स्थायी या अस्थायी रूप से जाकर बसना',
      ),
      Flashcard(term: 'बसेरा', meaning: 'रहने का स्थान, घर'),
      Flashcard(
        term: 'अनुकूलन',
        meaning: 'नए वातावरण के अनुसार स्वयं को ढालना',
      ),
      Flashcard(
        term: 'मूल निवास',
        meaning: 'वह स्थान जहाँ व्यक्ति मूलतः पैदा हुआ या रहता था',
      ),
      Flashcard(
        term: 'प्रवासी',
        meaning: 'एक स्थान से दूसरे स्थान पर बसने वाला व्यक्ति',
      ),
      Flashcard(
        term: 'संस्कृति',
        meaning: 'किसी समुदाय की रीति-रिवाज़, भाषा और परंपराएँ',
      ),
    ],
    assessment: [
      AssessmentQuestion(
        question:
            'एक स्थान से दूसरे स्थान पर बसने की प्रक्रिया को क्या कहते हैं?',
        options: ['प्रवास', 'प्रदूषण', 'पाचन', 'वाष्पीकरण'],
        correctIndex: 0,
      ),
      AssessmentQuestion(
        question: 'नए वातावरण के अनुसार स्वयं को ढालना क्या कहलाता है?',
        options: ['अनुकूलन', 'प्रदूषण', 'बाढ़', 'सूखा'],
        correctIndex: 0,
      ),
      AssessmentQuestion(
        question:
            'जो व्यक्ति एक स्थान से दूसरे स्थान बसने जाता है, उसे क्या कहते हैं?',
        options: ['प्रवासी', 'किसान', 'व्यापारी', 'शिक्षक'],
        correctIndex: 0,
      ),
      AssessmentQuestion(
        question: 'प्रवास का एक सामान्य कारण क्या हो सकता है?',
        options: [
          'काम या रोजगार की तलाश',
          'खेल खेलना',
          'छुट्टियाँ मनाना',
          'सोना',
        ],
        correctIndex: 0,
      ),
      AssessmentQuestion(
        question: 'किसी समुदाय की रीति-रिवाज़ और भाषा को क्या कहते हैं?',
        options: ['संस्कृति', 'जलवायु', 'भूगोल', 'गणित'],
        correctIndex: 0,
      ),
    ],
  ),
  'Class 5|Environmental Studies|ठंडा गरम': ChapterContent(
    worksheet: [
      'गर्मी और सर्दी के मौसम में हमारे कपड़ों में क्या अंतर होता है?',
      'किन्हीं तीन ऐसी चीज़ों के नाम लिखो जो गर्मी में उपयोगी होती हैं।',
      'किन्हीं तीन ऐसी चीज़ों के नाम लिखो जो सर्दी में उपयोगी होती हैं।',
      'शरीर को ठंड से बचाने के लिए हम क्या-क्या उपाय करते हैं?',
      'गर्म और ठंडी वस्तुओं के दो-दो उदाहरण लिखो।',
    ],
    flashcards: [
      Flashcard(
        term: 'तापमान',
        meaning: 'किसी वस्तु या स्थान की गर्मी या सर्दी की मात्रा',
      ),
      Flashcard(
        term: 'ऊष्मा',
        meaning: 'गर्मी की ऊर्जा जो एक वस्तु से दूसरी में जाती है',
      ),
      Flashcard(
        term: 'ऋतु',
        meaning: 'मौसम का एक विशेष समय जैसे गर्मी, सर्दी, वर्षा',
      ),
      Flashcard(
        term: 'ऊनी वस्त्र',
        meaning: 'ऊन से बने गर्म कपड़े जो सर्दी में पहने जाते हैं',
      ),
      Flashcard(
        term: 'सूती वस्त्र',
        meaning: 'कपास से बने हल्के कपड़े जो गर्मी में पहने जाते हैं',
      ),
      Flashcard(
        term: 'कुचालक',
        meaning: 'वह पदार्थ जो ऊष्मा को आसानी से नहीं जाने देता',
      ),
    ],
    assessment: [
      AssessmentQuestion(
        question: 'सर्दी में हम कैसे कपड़े पहनते हैं?',
        options: [
          'सूती और हल्के',
          'ऊनी और गर्म',
          'बिल्कुल नहीं पहनते',
          'गीले कपड़े',
        ],
        correctIndex: 1,
      ),
      AssessmentQuestion(
        question: 'गर्मी में कैसे कपड़े पहनना बेहतर होता है?',
        options: ['ऊनी और मोटे', 'सूती और हल्के', 'चमड़े के', 'प्लास्टिक के'],
        correctIndex: 1,
      ),
      AssessmentQuestion(
        question: 'किसी वस्तु की गर्मी-सर्दी मापने की मात्रा कहलाती है',
        options: ['तापमान', 'वजन', 'लंबाई', 'क्षेत्रफल'],
        correctIndex: 0,
      ),
      AssessmentQuestion(
        question: 'मौसम के किसी विशेष समय को क्या कहते हैं?',
        options: ['ऋतु', 'पर्व', 'उत्सव', 'मेला'],
        correctIndex: 0,
      ),
      AssessmentQuestion(
        question: 'इनमें से कौन-सी ठंडी वस्तु है?',
        options: ['बर्फ', 'आग', 'गर्म चाय', 'सूरज'],
        correctIndex: 0,
      ),
    ],
  ),
  'Class 5|Environmental Studies|ज्ञानिन्द्रियों का कमाल': ChapterContent(
    worksheet: [
      'हमारी पाँच ज्ञानेंद्रियों के नाम लिखो और प्रत्येक का एक-एक काम बताओ।',
      'आँख किस इंद्रिय का काम करती है और यह क्या पहचानने में मदद करती है?',
      'अगर हमारी कोई एक इंद्रिय काम न करे, तो हमें किन कठिनाइयों का सामना करना पड़ेगा?',
      'जीभ किस स्वाद (मीठा, खट्टा, नमकीन आदि) को पहचानने में मदद करती है, उदाहरण सहित लिखो।',
      'नाक और त्वचा के कार्यों में क्या अंतर है?',
    ],
    flashcards: [
      Flashcard(
        term: 'ज्ञानेंद्रियाँ',
        meaning: 'वे अंग जिनसे हम देखना, सुनना, सूँघना, चखना और छूना जानते हैं',
      ),
      Flashcard(term: 'आँख', meaning: 'देखने की इंद्रिय'),
      Flashcard(term: 'कान', meaning: 'सुनने की इंद्रिय'),
      Flashcard(term: 'नाक', meaning: 'सूँघने की इंद्रिय'),
      Flashcard(term: 'जीभ', meaning: 'स्वाद पहचानने की इंद्रिय'),
      Flashcard(term: 'त्वचा', meaning: 'छूने और महसूस करने की इंद्रिय'),
    ],
    assessment: [
      AssessmentQuestion(
        question: 'देखने का काम कौन-सी इंद्रिय करती है?',
        options: ['आँख', 'कान', 'नाक', 'जीभ'],
        correctIndex: 0,
      ),
      AssessmentQuestion(
        question: 'सुनने का काम कौन-सी इंद्रिय करती है?',
        options: ['आँख', 'कान', 'त्वचा', 'जीभ'],
        correctIndex: 1,
      ),
      AssessmentQuestion(
        question: 'स्वाद पहचानने का काम कौन-सी इंद्रिय करती है?',
        options: ['नाक', 'जीभ', 'आँख', 'कान'],
        correctIndex: 1,
      ),
      AssessmentQuestion(
        question: 'सूँघने का काम कौन-सी इंद्रिय करती है?',
        options: ['नाक', 'कान', 'जीभ', 'त्वचा'],
        correctIndex: 0,
      ),
      AssessmentQuestion(
        question: 'मनुष्य की कुल कितनी ज्ञानेंद्रियाँ मानी जाती हैं?',
        options: ['तीन', 'चार', 'पाँच', 'छह'],
        correctIndex: 2,
      ),
    ],
  ),
  'Class 5|Environmental Studies|मुझे ताज़ा खाओ': ChapterContent(
    worksheet: [
      'ताज़ा भोजन खाने के क्या फायदे हैं?',
      'बासी या खराब भोजन खाने से क्या नुकसान हो सकते हैं?',
      'भोजन को ताज़ा और सुरक्षित रखने के तीन तरीके लिखो।',
      'फल और सब्जियाँ खाने से पहले उन्हें धोना क्यों जरूरी है?',
      'फ्रिज (रेफ्रिजरेटर) भोजन को ताज़ा रखने में कैसे मदद करता है?',
    ],
    flashcards: [
      Flashcard(term: 'ताज़ा', meaning: 'जो अभी तैयार हुआ हो, बासी न हो'),
      Flashcard(
        term: 'संरक्षण',
        meaning: 'भोजन को खराब होने से बचाने की प्रक्रिया',
      ),
      Flashcard(term: 'बासी', meaning: 'देर तक रखा हुआ खराब हो चुका भोजन'),
      Flashcard(term: 'स्वच्छता', meaning: 'साफ-सफाई'),
      Flashcard(
        term: 'रेफ्रिजरेटर',
        meaning: 'भोजन को ठंडा रखकर ताज़ा बनाए रखने वाला उपकरण',
      ),
      Flashcard(
        term: 'पौष्टिक',
        meaning: 'जिसमें शरीर के लिए जरूरी पोषक तत्व हों',
      ),
    ],
    assessment: [
      AssessmentQuestion(
        question: 'ताज़ा भोजन खाने से क्या लाभ होता है?',
        options: [
          'स्वास्थ्य अच्छा रहता है',
          'बीमारी होती है',
          'कमजोरी आती है',
          'कोई लाभ नहीं',
        ],
        correctIndex: 0,
      ),
      AssessmentQuestion(
        question: 'बासी भोजन खाने से क्या हो सकता है?',
        options: [
          'पेट खराब हो सकता है',
          'शक्ति बढ़ती है',
          'कुछ नहीं होता',
          'बुद्धि बढ़ती है',
        ],
        correctIndex: 0,
      ),
      AssessmentQuestion(
        question: 'भोजन को ताज़ा रखने के लिए किस उपकरण का प्रयोग होता है?',
        options: ['रेफ्रिजरेटर', 'पंखा', 'टीवी', 'रेडियो'],
        correctIndex: 0,
      ),
      AssessmentQuestion(
        question: 'फल-सब्जियाँ खाने से पहले क्या करना चाहिए?',
        options: ['धोना', 'फेंकना', 'जलाना', 'छिपाना'],
        correctIndex: 0,
      ),
      AssessmentQuestion(
        question: '\'स्वच्छता\' शब्द का अर्थ है',
        options: ['साफ-सफाई', 'गंदगी', 'बीमारी', 'आलस्य'],
        correctIndex: 0,
      ),
    ],
  ),
  'Class 5|Environmental Studies|किसानों की कहानी': ChapterContent(
    worksheet: [
      'एक किसान की दिनभर की गतिविधियों के बारे में पाँच वाक्य लिखो।',
      'खेती करने के लिए किसान को किन-किन औजारों और संसाधनों की जरूरत होती है?',
      'किसानों को फसल उगाने में किन कठिनाइयों का सामना करना पड़ सकता है?',
      'किसान हमारे जीवन में कितना महत्वपूर्ण है? अपने विचार लिखो।',
      'खरीफ और रबी फसल में क्या अंतर है?',
    ],
    flashcards: [
      Flashcard(term: 'किसान', meaning: 'खेती करने वाला व्यक्ति'),
      Flashcard(term: 'हल', meaning: 'खेत जोतने का पारंपरिक औजार'),
      Flashcard(term: 'सिंचाई', meaning: 'खेतों को पानी देने की प्रक्रिया'),
      Flashcard(
        term: 'खरीफ फसल',
        meaning: 'वर्षा ऋतु में बोई जाने वाली फसल जैसे धान',
      ),
      Flashcard(
        term: 'रबी फसल',
        meaning: 'सर्दी में बोई जाने वाली फसल जैसे गेहूँ',
      ),
      Flashcard(
        term: 'उर्वरक',
        meaning: 'मिट्टी की उर्वरता बढ़ाने वाला पदार्थ, खाद',
      ),
    ],
    assessment: [
      AssessmentQuestion(
        question: 'खेत जोतने का पारंपरिक औजार कौन-सा है?',
        options: ['हल', 'कलम', 'चम्मच', 'सुई'],
        correctIndex: 0,
      ),
      AssessmentQuestion(
        question: 'खेतों को पानी देने की प्रक्रिया क्या कहलाती है?',
        options: ['सिंचाई', 'बुवाई', 'कटाई', 'जुताई'],
        correctIndex: 0,
      ),
      AssessmentQuestion(
        question: 'वर्षा ऋतु में बोई जाने वाली फसल को क्या कहते हैं?',
        options: ['खरीफ फसल', 'रबी फसल', 'जायद फसल', 'फल'],
        correctIndex: 0,
      ),
      AssessmentQuestion(
        question: 'इनमें से कौन-सी रबी फसल है?',
        options: ['गेहूँ', 'धान', 'मक्का', 'गन्ना'],
        correctIndex: 0,
      ),
      AssessmentQuestion(
        question: 'मिट्टी की उर्वरता बढ़ाने के लिए किसान क्या डालते हैं?',
        options: ['उर्वरक/खाद', 'पत्थर', 'प्लास्टिक', 'कागज़'],
        correctIndex: 0,
      ),
    ],
  ),
  'Class 5|Environmental Studies|स्वाद से शक्ति तक': ChapterContent(
    worksheet: [
      'भोजन हमें शरीर के लिए ऊर्जा (शक्ति) कैसे देता है?',
      'किन्हीं पाँच पौष्टिक खाद्य पदार्थों के नाम लिखो।',
      'संतुलित आहार में किन चीज़ों को शामिल करना चाहिए?',
      'अधिक तला-भुना या जंक फूड खाने से क्या नुकसान होते हैं?',
      '\'स्वाद\' और \'पोषण\' में क्या अंतर है, समझाओ।',
    ],
    flashcards: [
      Flashcard(
        term: 'ऊर्जा',
        meaning: 'शरीर को काम करने के लिए मिलने वाली शक्ति',
      ),
      Flashcard(
        term: 'पोषक तत्व',
        meaning:
            'भोजन में पाए जाने वाले शरीर के लिए जरूरी तत्व जैसे प्रोटीन, विटामिन',
      ),
      Flashcard(
        term: 'संतुलित आहार',
        meaning: 'वह भोजन जिसमें सभी पोषक तत्व सही मात्रा में हों',
      ),
      Flashcard(
        term: 'प्रोटीन',
        meaning: 'शरीर की वृद्धि और मरम्मत के लिए जरूरी पोषक तत्व',
      ),
      Flashcard(
        term: 'विटामिन',
        meaning: 'शरीर को स्वस्थ रखने वाले सूक्ष्म पोषक तत्व',
      ),
      Flashcard(
        term: 'जंक फूड',
        meaning: 'कम पोषण वाला और अधिक तेल-मसाले वाला भोजन',
      ),
    ],
    assessment: [
      AssessmentQuestion(
        question: 'भोजन से हमें क्या मिलता है?',
        options: ['ऊर्जा', 'थकान', 'नींद', 'बीमारी'],
        correctIndex: 0,
      ),
      AssessmentQuestion(
        question: 'शरीर की वृद्धि और मरम्मत के लिए कौन-सा पोषक तत्व जरूरी है?',
        options: ['प्रोटीन', 'धूल', 'पानी केवल', 'नमक केवल'],
        correctIndex: 0,
      ),
      AssessmentQuestion(
        question: 'वह भोजन जिसमें सभी पोषक तत्व सही मात्रा में हों, कहलाता है',
        options: ['संतुलित आहार', 'जंक फूड', 'बासी भोजन', 'मीठा भोजन'],
        correctIndex: 0,
      ),
      AssessmentQuestion(
        question: 'अधिक जंक फूड खाने से क्या हो सकता है?',
        options: [
          'स्वास्थ्य खराब हो सकता है',
          'बुद्धि तेज होती है',
          'शक्ति बढ़ती है',
          'कोई असर नहीं',
        ],
        correctIndex: 0,
      ),
      AssessmentQuestion(
        question: 'शरीर को स्वस्थ रखने वाले सूक्ष्म पोषक तत्व क्या कहलाते हैं?',
        options: ['विटामिन', 'पत्थर', 'धातु', 'प्लास्टिक'],
        correctIndex: 0,
      ),
    ],
  ),
  'Class 5|Environmental Studies|बीज ही बीज': ChapterContent(
    worksheet: [
      'बीज से पौधा बनने की प्रक्रिया के चार चरण लिखो।',
      'बीज को अंकुरित होने के लिए किन-किन चीज़ों की जरूरत होती है?',
      'किन्हीं पाँच पौधों के बीजों के नाम लिखो जिन्हें तुमने देखा हो।',
      'बीजों को सुरक्षित रखने के दो तरीके लिखो।',
      'एक छोटा प्रयोग बताओ जिससे तुम घर पर बीज को अंकुरित होते देख सको।',
    ],
    flashcards: [
      Flashcard(term: 'बीज', meaning: 'पौधे का वह भाग जिससे नया पौधा उगता है'),
      Flashcard(
        term: 'अंकुरण',
        meaning: 'बीज से नए पौधे का फूटना और बढ़ना शुरू होना',
      ),
      Flashcard(
        term: 'जड़',
        meaning: 'पौधे का वह भाग जो मिट्टी में रहकर पानी सोखता है',
      ),
      Flashcard(
        term: 'बीजपत्र',
        meaning: 'बीज के अंदर का वह भाग जो भोजन संग्रहित करता है',
      ),
      Flashcard(
        term: 'मिट्टी',
        meaning: 'जमीन की ऊपरी परत जिसमें पौधे उगते हैं',
      ),
      Flashcard(
        term: 'प्रकाश संश्लेषण',
        meaning: 'पौधों द्वारा सूर्य के प्रकाश से भोजन बनाने की प्रक्रिया',
      ),
    ],
    assessment: [
      AssessmentQuestion(
        question: 'बीज से नए पौधे के फूटने की प्रक्रिया क्या कहलाती है?',
        options: ['अंकुरण', 'पाचन', 'श्वसन', 'प्रदूषण'],
        correctIndex: 0,
      ),
      AssessmentQuestion(
        question: 'अंकुरण के लिए बीज को किसकी जरूरत होती है?',
        options: [
          'पानी, हवा और उचित तापमान',
          'केवल पत्थर',
          'केवल अंधेरा',
          'केवल बर्फ',
        ],
        correctIndex: 0,
      ),
      AssessmentQuestion(
        question: 'पौधे का वह भाग जो मिट्टी से पानी सोखता है',
        options: ['जड़', 'पत्ती', 'फूल', 'फल'],
        correctIndex: 0,
      ),
      AssessmentQuestion(
        question:
            'पौधों द्वारा सूर्य के प्रकाश से भोजन बनाने की प्रक्रिया कहलाती है',
        options: ['प्रकाश संश्लेषण', 'अंकुरण', 'वाष्पीकरण', 'पाचन'],
        correctIndex: 0,
      ),
      AssessmentQuestion(
        question: 'बीज के अंदर भोजन संग्रहित करने वाला भाग क्या कहलाता है?',
        options: ['बीजपत्र', 'जड़', 'तना', 'फूल'],
        correctIndex: 0,
      ),
    ],
  ),
  'Class 5|Environmental Studies|कैसे कैसे घर': ChapterContent(
    worksheet: [
      'अलग-अलग जलवायु क्षेत्रों में घर अलग-अलग तरह से क्यों बनाए जाते हैं?',
      'झारखंड के गाँवों में पाए जाने वाले घरों की बनावट के बारे में लिखो।',
      'शहर और गाँव के घरों में क्या अंतर होता है?',
      'घर बनाने में प्रयोग होने वाली किन्हीं चार सामग्रियों के नाम लिखो।',
      'एक अच्छे घर में कौन-सी सुविधाएँ होनी चाहिए?',
    ],
    flashcards: [
      Flashcard(term: 'मकान', meaning: 'रहने के लिए बनाया गया स्थान, घर'),
      Flashcard(
        term: 'झोपड़ी',
        meaning: 'मिट्टी, बाँस और घास से बना साधारण घर',
      ),
      Flashcard(
        term: 'ईंट',
        meaning: 'मिट्टी से बनी और पकाई गई निर्माण सामग्री',
      ),
      Flashcard(term: 'छत', meaning: 'घर का ऊपरी ढका हुआ भाग'),
      Flashcard(
        term: 'जलवायु',
        meaning: 'किसी स्थान की लंबे समय की मौसम स्थिति',
      ),
      Flashcard(
        term: 'निर्माण सामग्री',
        meaning: 'घर बनाने में प्रयोग होने वाली चीज़ें जैसे ईंट, सीमेंट, लकड़ी',
      ),
    ],
    assessment: [
      AssessmentQuestion(
        question: 'मिट्टी, बाँस और घास से बना साधारण घर क्या कहलाता है?',
        options: ['झोपड़ी', 'महल', 'किला', 'मीनार'],
        correctIndex: 0,
      ),
      AssessmentQuestion(
        question:
            'घर बनाने में प्रयोग होने वाली पकी हुई मिट्टी की सामग्री क्या कहलाती है?',
        options: ['ईंट', 'पानी', 'रेत केवल', 'हवा'],
        correctIndex: 0,
      ),
      AssessmentQuestion(
        question: 'घर के ऊपरी ढके हुए भाग को क्या कहते हैं?',
        options: ['छत', 'दरवाज़ा', 'खिड़की', 'आँगन'],
        correctIndex: 0,
      ),
      AssessmentQuestion(
        question: 'अलग-अलग स्थानों पर घर अलग-अलग क्यों बनते हैं?',
        options: [
          'जलवायु और उपलब्ध सामग्री के अनुसार',
          'बिना किसी कारण',
          'केवल रंग के लिए',
          'संयोग से',
        ],
        correctIndex: 0,
      ),
      AssessmentQuestion(
        question: 'किसी स्थान की लंबे समय की मौसम स्थिति को क्या कहते हैं?',
        options: ['जलवायु', 'पैटर्न', 'मुद्रा', 'पोषण'],
        correctIndex: 0,
      ),
    ],
  ),
  'Class 5|Environmental Studies|प्रकृति का कहर': ChapterContent(
    worksheet: [
      'बाढ़, सूखा और भूकंप में से किन्हीं दो प्राकृतिक आपदाओं के बारे में लिखो।',
      'प्राकृतिक आपदा आने पर हमें कौन-सी सावधानियाँ बरतनी चाहिए?',
      'पेड़ों की कटाई प्राकृतिक आपदाओं को कैसे बढ़ावा दे सकती है?',
      'आपदा प्रबंधन (Disaster Management) क्या होता है, सरल शब्दों में लिखो।',
      'बाढ़ या सूखे से प्रभावित लोगों की मदद के लिए हम क्या कर सकते हैं?',
    ],
    flashcards: [
      Flashcard(
        term: 'प्राकृतिक आपदा',
        meaning: 'प्रकृति द्वारा होने वाली विनाशकारी घटना जैसे बाढ़, भूकंप',
      ),
      Flashcard(
        term: 'बाढ़',
        meaning: 'अत्यधिक पानी भर जाने से होने वाली आपदा',
      ),
      Flashcard(term: 'सूखा', meaning: 'लंबे समय तक वर्षा न होने की स्थिति'),
      Flashcard(term: 'भूकंप', meaning: 'धरती का अचानक हिलना'),
      Flashcard(term: 'चक्रवात', meaning: 'तेज़ हवाओं के साथ आने वाला तूफान'),
      Flashcard(
        term: 'आपदा प्रबंधन',
        meaning: 'आपदा से बचाव और राहत की योजना और तैयारी',
      ),
    ],
    assessment: [
      AssessmentQuestion(
        question: 'अत्यधिक पानी भर जाने से होने वाली आपदा क्या कहलाती है?',
        options: ['बाढ़', 'सूखा', 'भूकंप', 'चक्रवात'],
        correctIndex: 0,
      ),
      AssessmentQuestion(
        question: 'धरती के अचानक हिलने को क्या कहते हैं?',
        options: ['भूकंप', 'बाढ़', 'सूखा', 'पाला'],
        correctIndex: 0,
      ),
      AssessmentQuestion(
        question: 'लंबे समय तक वर्षा न होने की स्थिति क्या कहलाती है?',
        options: ['सूखा', 'बाढ़', 'भूकंप', 'आँधी'],
        correctIndex: 0,
      ),
      AssessmentQuestion(
        question: 'पेड़ों की अत्यधिक कटाई किसे बढ़ावा दे सकती है?',
        options: [
          'बाढ़ और भूस्खलन',
          'वर्षा में कमी की समस्या का समाधान',
          'स्वच्छ हवा में वृद्धि',
          'इनमें से कोई नहीं',
        ],
        correctIndex: 0,
      ),
      AssessmentQuestion(
        question: 'आपदा से बचाव की योजना और तैयारी को क्या कहते हैं?',
        options: ['आपदा प्रबंधन', 'मनोरंजन', 'व्यापार', 'खेल'],
        correctIndex: 0,
      ),
    ],
  ),
  'Class 5|Environmental Studies|पानी ही जीवन': ChapterContent(
    worksheet: [
      'जल हमारे जीवन के लिए क्यों जरूरी है? पाँच कारण लिखो।',
      'पानी बचाने के किन्हीं चार उपाय लिखो।',
      'जल प्रदूषण के कारण और उससे होने वाले नुकसान लिखो।',
      'वर्षा जल संचयन (rainwater harvesting) क्या है, सरल शब्दों में समझाओ।',
      'यदि पानी न हो तो पृथ्वी पर जीवन कैसा होगा, अपने विचार लिखो।',
    ],
    flashcards: [
      Flashcard(term: 'जल', meaning: 'पानी, जीवन के लिए आवश्यक तरल पदार्थ'),
      Flashcard(
        term: 'जल संचयन',
        meaning: 'वर्षा के पानी को इकट्ठा करके सुरक्षित रखना',
      ),
      Flashcard(
        term: 'जल प्रदूषण',
        meaning: 'पानी में हानिकारक पदार्थों का मिल जाना',
      ),
      Flashcard(term: 'भूजल', meaning: 'धरती के नीचे पाया जाने वाला पानी'),
      Flashcard(term: 'वाष्पीकरण', meaning: 'पानी का भाप बनकर हवा में उड़ना'),
      Flashcard(
        term: 'जल चक्र',
        meaning:
            'पानी का वाष्पीकरण, संघनन और वर्षा के रूप में लगातार चलने वाला चक्र',
      ),
    ],
    assessment: [
      AssessmentQuestion(
        question:
            'वर्षा जल को इकट्ठा करके सुरक्षित रखने की प्रक्रिया क्या कहलाती है?',
        options: ['जल संचयन', 'जल प्रदूषण', 'वाष्पीकरण', 'संघनन'],
        correctIndex: 0,
      ),
      AssessmentQuestion(
        question: 'पानी में हानिकारक पदार्थों का मिलना क्या कहलाता है?',
        options: ['जल प्रदूषण', 'जल संचयन', 'जल शुद्धि', 'जल चक्र'],
        correctIndex: 0,
      ),
      AssessmentQuestion(
        question: 'धरती के नीचे पाए जाने वाले पानी को क्या कहते हैं?',
        options: ['भूजल', 'समुद्री जल', 'वर्षा जल केवल', 'बर्फ'],
        correctIndex: 0,
      ),
      AssessmentQuestion(
        question: 'पानी के भाप बनकर उड़ने की प्रक्रिया क्या कहलाती है?',
        options: ['वाष्पीकरण', 'संघनन', 'वर्षा', 'हिमपात'],
        correctIndex: 0,
      ),
      AssessmentQuestion(
        question: 'हमें पानी क्यों बचाना चाहिए?',
        options: [
          'क्योंकि यह सीमित संसाधन है और जीवन के लिए जरूरी है',
          'क्योंकि यह बेकार है',
          'इसकी कोई जरूरत नहीं',
          'क्योंकि यह असीमित है',
        ],
        correctIndex: 0,
      ),
    ],
  ),
  'Class 5|Environmental Studies|क्या डूबा क्या तैरा': ChapterContent(
    worksheet: [
      'किन्हीं पाँच वस्तुओं की सूची बनाओ और बताओ कि वे पानी में डूबेंगी या तैरेंगी।',
      'कोई वस्तु पानी में क्यों तैरती है और कोई क्यों डूब जाती है, अपने शब्दों में लिखो।',
      'लोहे का जहाज़ भारी होते हुए भी पानी में क्यों नहीं डूबता?',
      'घर पर एक छोटा प्रयोग करो: कागज़, लकड़ी और पत्थर को पानी में डालकर देखो कि क्या होता है, परिणाम लिखो।',
      '\'घनत्व\' शब्द का सरल अर्थ अपने शब्दों में लिखो।',
    ],
    flashcards: [
      Flashcard(
        term: 'उत्प्लावन',
        meaning: 'वह बल जो किसी वस्तु को पानी में ऊपर धकेलता है',
      ),
      Flashcard(
        term: 'घनत्व',
        meaning: 'किसी वस्तु के आयतन में समाए द्रव्यमान की मात्रा',
      ),
      Flashcard(term: 'तैरना', meaning: 'पानी की सतह पर बने रहना, न डूबना'),
      Flashcard(term: 'डूबना', meaning: 'पानी के नीचे चले जाना'),
      Flashcard(term: 'आयतन', meaning: 'किसी वस्तु द्वारा घेरा गया स्थान'),
      Flashcard(term: 'पदार्थ', meaning: 'वह चीज़ जिससे कोई वस्तु बनी होती है'),
    ],
    assessment: [
      AssessmentQuestion(
        question: 'इनमें से कौन-सी वस्तु सामान्यतः पानी में तैरती है?',
        options: ['लकड़ी का टुकड़ा', 'लोहे का सिक्का', 'पत्थर', 'काँच की गोली'],
        correctIndex: 0,
      ),
      AssessmentQuestion(
        question: 'इनमें से कौन-सी वस्तु सामान्यतः पानी में डूब जाती है?',
        options: [
          'पत्थर',
          'सूखा पत्ता',
          'प्लास्टिक की गेंद',
          'गत्ते का टुकड़ा',
        ],
        correctIndex: 0,
      ),
      AssessmentQuestion(
        question: 'वह बल जो वस्तु को पानी में ऊपर धकेलता है, कहलाता है',
        options: ['उत्प्लावन बल', 'गुरुत्वाकर्षण बल', 'घर्षण बल', 'चुंबकीय बल'],
        correctIndex: 0,
      ),
      AssessmentQuestion(
        question: 'लोहे का बड़ा जहाज़ पानी में क्यों नहीं डूबता?',
        options: [
          'उसकी बनावट पानी को हटाकर उत्प्लावन बल पैदा करती है',
          'वह हल्का होता है',
          'वह पानी में घुल जाता है',
          'वह चुंबकीय है',
        ],
        correctIndex: 0,
      ),
      AssessmentQuestion(
        question: 'किसी वस्तु के आयतन में समाए द्रव्यमान को क्या कहते हैं?',
        options: ['घनत्व', 'तापमान', 'गति', 'बल'],
        correctIndex: 0,
      ),
    ],
  ),
  'Class 5|Environmental Studies|गाँव गाँव क़स्बा क़स्बा': ChapterContent(
    worksheet: [
      'गाँव और कस्बे (कस्बा) में क्या अंतर होता है?',
      'गाँव में मिलने वाली किन्हीं तीन सुविधाओं के नाम लिखो।',
      'शहर की तुलना में गाँव के जीवन की कोई दो विशेषताएँ लिखो।',
      'लोग गाँव से शहर की ओर पलायन क्यों करते हैं?',
      'अपने गाँव या कस्बे के बारे में पाँच वाक्य लिखो।',
    ],
    flashcards: [
      Flashcard(term: 'गाँव', meaning: 'छोटी बस्ती जहाँ मुख्यतः खेती होती है'),
      Flashcard(
        term: 'कस्बा',
        meaning: 'गाँव से बड़ा और शहर से छोटा बसा हुआ स्थान',
      ),
      Flashcard(term: 'शहर', meaning: 'बड़ी आबादी और अधिक सुविधाओं वाला स्थान'),
      Flashcard(
        term: 'पलायन',
        meaning: 'एक स्थान को छोड़कर दूसरे स्थान पर बसने जाना',
      ),
      Flashcard(
        term: 'पंचायत',
        meaning: 'गाँव के प्रशासन के लिए बना स्थानीय स्वशासन निकाय',
      ),
      Flashcard(term: 'बस्ती', meaning: 'लोगों के रहने का समूहबद्ध क्षेत्र'),
    ],
    assessment: [
      AssessmentQuestion(
        question: 'गाँव में मुख्यतः कौन-सा कार्य होता है?',
        options: ['खेती', 'बड़े उद्योग', 'समुद्री व्यापार', 'अंतरिक्ष यात्रा'],
        correctIndex: 0,
      ),
      AssessmentQuestion(
        question: 'गाँव के प्रशासन के लिए बने स्थानीय निकाय को क्या कहते हैं?',
        options: ['पंचायत', 'संसद', 'न्यायालय', 'सेना'],
        correctIndex: 0,
      ),
      AssessmentQuestion(
        question: 'गाँव से बड़ा और शहर से छोटा स्थान क्या कहलाता है?',
        options: ['कस्बा', 'महानगर', 'राजधानी', 'द्वीप'],
        correctIndex: 0,
      ),
      AssessmentQuestion(
        question: 'लोग गाँव छोड़कर शहर क्यों जाते हैं?',
        options: [
          'रोजगार और सुविधाओं की तलाश में',
          'मनोरंजन के लिए केवल',
          'बिना किसी कारण',
          'छुट्टियाँ मनाने',
        ],
        correctIndex: 0,
      ),
      AssessmentQuestion(
        question: 'एक स्थान से दूसरे स्थान बसने जाने को क्या कहते हैं?',
        options: ['पलायन', 'सिंचाई', 'अंकुरण', 'वाष्पीकरण'],
        correctIndex: 0,
      ),
    ],
  ),
  'Class 5|Environmental Studies|चढ़ाई पहाड़ की': ChapterContent(
    worksheet: [
      'पहाड़ों पर चढ़ना एक चुनौतीपूर्ण काम क्यों होता है?',
      'पर्वतारोहण (पहाड़ चढ़ना) करते समय किन सावधानियों का ध्यान रखना चाहिए?',
      'पहाड़ी क्षेत्रों में रहने वाले लोगों का जीवन मैदानी क्षेत्रों से कैसे अलग होता है?',
      'पहाड़ चढ़ते समय हमें कौन-से गुण अपनाने चाहिए (जैसे धैर्य, साहस)?',
      'भारत के किन्हीं दो प्रसिद्ध पर्वतों या पर्वत श्रृंखलाओं के नाम लिखो।',
    ],
    flashcards: [
      Flashcard(term: 'पर्वत', meaning: 'भूमि का बहुत ऊँचा उठा हुआ भाग'),
      Flashcard(term: 'पर्वतारोहण', meaning: 'पहाड़ पर चढ़ने की गतिविधि'),
      Flashcard(term: 'ढलान', meaning: 'पहाड़ की तिरछी सतह'),
      Flashcard(term: 'चोटी', meaning: 'पहाड़ का सबसे ऊँचा हिस्सा'),
      Flashcard(
        term: 'धैर्य',
        meaning: 'कठिनाई में भी शांत और स्थिर बने रहने का गुण',
      ),
      Flashcard(term: 'साहस', meaning: 'डर का सामना करने की हिम्मत'),
    ],
    assessment: [
      AssessmentQuestion(
        question: 'पहाड़ का सबसे ऊँचा हिस्सा क्या कहलाता है?',
        options: ['चोटी', 'तलहटी', 'ढलान', 'घाटी'],
        correctIndex: 0,
      ),
      AssessmentQuestion(
        question: 'पहाड़ पर चढ़ने की गतिविधि क्या कहलाती है?',
        options: ['पर्वतारोहण', 'तैराकी', 'साइकिल चलाना', 'नौकायन'],
        correctIndex: 0,
      ),
      AssessmentQuestion(
        question: 'पहाड़ चढ़ते समय कौन-सा गुण सबसे ज्यादा जरूरी है?',
        options: ['धैर्य और साहस', 'जल्दबाज़ी', 'आलस्य', 'डर'],
        correctIndex: 0,
      ),
      AssessmentQuestion(
        question: 'इनमें से कौन-सी भारत की प्रसिद्ध पर्वत श्रृंखला है?',
        options: ['हिमालय', 'सहारा', 'अमेज़न', 'गंगा'],
        correctIndex: 0,
      ),
      AssessmentQuestion(
        question: 'पहाड़ की तिरछी सतह को क्या कहते हैं?',
        options: ['ढलान', 'मैदान', 'समुद्र', 'रेगिस्तान'],
        correctIndex: 0,
      ),
    ],
  ),
  'Class 5|Environmental Studies|जंगल की बेटी': ChapterContent(
    worksheet: [
      'जंगलों में रहने वाले आदिवासी समुदायों का जीवन प्रकृति से कैसे जुड़ा होता है?',
      'जंगल हमें कौन-कौन-सी चीज़ें देते हैं? पाँच उदाहरण लिखो।',
      'जंगलों को बचाना क्यों जरूरी है?',
      'आदिवासी संस्कृति में महिलाओं और बेटियों की क्या भूमिका होती है, अपने विचार लिखो।',
      'वनों की कटाई से जीव-जंतुओं और मनुष्यों पर क्या असर पड़ता है?',
    ],
    flashcards: [
      Flashcard(
        term: 'जंगल',
        meaning: 'पेड़-पौधों और जीव-जंतुओं से भरा प्राकृतिक क्षेत्र',
      ),
      Flashcard(
        term: 'आदिवासी',
        meaning: 'जंगलों और पहाड़ी क्षेत्रों के मूल निवासी समुदाय',
      ),
      Flashcard(term: 'वन्य जीव', meaning: 'जंगल में रहने वाले जानवर'),
      Flashcard(
        term: 'वनोपज',
        meaning: 'जंगल से प्राप्त होने वाली उपज जैसे फल, लकड़ी, शहद',
      ),
      Flashcard(
        term: 'वनों की कटाई',
        meaning: 'जंगलों के पेड़ों को काटना, जिससे पर्यावरण को नुकसान होता है',
      ),
      Flashcard(
        term: 'प्रकृति प्रेम',
        meaning: 'प्रकृति और पर्यावरण से गहरा लगाव',
      ),
    ],
    assessment: [
      AssessmentQuestion(
        question: 'जंगल से प्राप्त होने वाली उपज को क्या कहते हैं?',
        options: ['वनोपज', 'खनिज', 'मुद्रा', 'पैटर्न'],
        correctIndex: 0,
      ),
      AssessmentQuestion(
        question: 'जंगल में रहने वाले जानवरों को क्या कहते हैं?',
        options: ['वन्य जीव', 'पालतू जानवर', 'समुद्री जीव', 'कीड़े केवल'],
        correctIndex: 0,
      ),
      AssessmentQuestion(
        question: 'जंगलों के मूल निवासी समुदाय को क्या कहा जाता है?',
        options: ['आदिवासी', 'व्यापारी', 'पर्यटक', 'अधिकारी'],
        correctIndex: 0,
      ),
      AssessmentQuestion(
        question: 'वनों की कटाई का पर्यावरण पर क्या असर होता है?',
        options: [
          'हानिकारक असर, जैसे मिट्टी का कटाव और जलवायु परिवर्तन',
          'कोई असर नहीं',
          'लाभदायक असर',
          'हवा शुद्ध होती है',
        ],
        correctIndex: 0,
      ),
      AssessmentQuestion(
        question: 'जंगल हमें क्या-क्या देते हैं?',
        options: [
          'लकड़ी, फल, शुद्ध हवा और औषधियाँ',
          'केवल पत्थर',
          'केवल रेत',
          'कुछ नहीं',
        ],
        correctIndex: 0,
      ),
    ],
  ),
};
