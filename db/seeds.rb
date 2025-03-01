require 'securerandom'

Category.destroy_all
Subcategory.destroy_all
Question.destroy_all
Answer.destroy_all
QuestionTranslation.destroy_all
AnswerTranslation.destroy_all

citizenship_category = Category.create!(name: "Citizenship Test")
citizenship_all_subcategory = Subcategory.create!(name: "All", category: citizenship_category)

questions = [
  { title: "Aufgabe 1", question: "In Deutschland dürfen Menschen offen etwas gegen die Regierung sagen, weil …", translations: {
      en: "In Germany, people are allowed to openly speak against the government because …",
      fa: "در آلمان، مردم اجازه دارند آزادانه علیه دولت صحبت کنند زیرا …",
      tr: "Almanya'da insanlar hükümete karşı açıkça konuşabilir çünkü …",
      ar: "في ألمانيا، يُسمح للناس بالتحدث علانية ضد الحكومة لأن …"
    },
    answers: [
      { answer: "hier Religionsfreiheit gilt.", is_correct: false, translations: {
          en: "there is freedom of religion here.",
          fa: "در اینجا آزادی دین وجود دارد.",
          tr: "burada din özgürlüğü var.",
          ar: "هنا توجد حرية دينية."
        } },
      { answer: "die Menschen Steuern zahlen.", is_correct: false, translations: {
          en: "people pay taxes.",
          fa: "مردم مالیات پرداخت می‌کنند.",
          tr: "insanlar vergi ödüyor.",
          ar: "يدفع الناس الضرائب."
        } },
      { answer: "die Menschen das Wahlrecht haben.", is_correct: false, translations: {
          en: "people have the right to vote.",
          fa: "مردم حق رأی دارند.",
          tr: "insanların oy kullanma hakkı var.",
          ar: "لدى الناس حق التصويت."
        } },
      { answer: "hier Meinungsfreiheit gilt.", is_correct: true, translations: {
          en: "there is freedom of speech here.",
          fa: "در اینجا آزادی بیان وجود دارد.",
          tr: "burada ifade özgürlüğü var.",
          ar: "هنا توجد حرية التعبير."
        } }
    ]
  },
  { title: "Aufgabe 2", question: "In Deutschland können Eltern bis zum 14. Lebensjahr ihres Kindes entscheiden, ob es in der Schule am …", translations: {
      en: "In Germany, parents can decide until their child is 14 years old whether they participate in …",
      fa: "در آلمان، والدین تا سن ۱۴ سالگی فرزندشان می‌توانند تصمیم بگیرند که آیا او در … شرکت کند.",
      tr: "Almanya'da ebeveynler, çocukları 14 yaşına gelene kadar onun … katılıp katılmayacağına karar verebilir.",
      ar: "في ألمانيا، يمكن للوالدين أن يقرروا حتى يبلغ طفلهم 14 عامًا ما إذا كان سيشارك في …"
    },
    answers: [
      { answer: "Geschichtsunterricht teilnimmt.", is_correct: false, translations: {
          en: "history class.",
          fa: "کلاس تاریخ.",
          tr: "tarih dersi.",
          ar: "حصة التاريخ."
        } },
      { answer: "Religionsunterricht teilnimmt.", is_correct: true, translations: {
          en: "religious education.",
          fa: "آموزش دینی.",
          tr: "din eğitimi.",
          ar: "التعليم الديني."
        } },
      { answer: "Politikunterricht teilnimmt.", is_correct: false, translations: {
          en: "politics class.",
          fa: "کلاس سیاست.",
          tr: "siyaset dersi.",
          ar: "حصة السياسة."
        } },
      { answer: "Sprachunterricht teilnimmt.", is_correct: false, translations: {
          en: "language class.",
          fa: "کلاس زبان.",
          tr: "dil dersi.",
          ar: "حصة اللغة."
        } }
    ]
  },
  {
  title: "Aufgabe 3",
  question: "Deutschland ist ein Rechtsstaat. Was ist damit gemeint?",
  translations: {
    en: "Germany is a constitutional state. What does that mean?",
    fa: "آلمان یک کشور قانونی است. این به چه معناست؟",
    tr: "Almanya bir hukuk devletidir. Bu ne anlama geliyor?",
    ar: "ألمانيا دولة قانون. ماذا يعني ذلك؟"
  },
  answers: [
    { answer: "Alle Einwohnerinnen/Einwohner und der Staat müssen sich an die Gesetze halten.", is_correct: true, translations: {
        en: "All residents and the state must abide by the laws.",
        fa: "همه ساکنان و دولت باید از قوانین پیروی کنند.",
        tr: "Tüm sakinler ve devlet yasalara uymalıdır.",
        ar: "يجب على جميع السكان والدولة الالتزام بالقوانين."
      } },
    { answer: "Der Staat muss sich nicht an die Gesetze halten.", is_correct: false, translations: {
        en: "The state does not have to follow the laws.",
        fa: "دولت مجبور نیست از قوانین پیروی کند.",
        tr: "Devlet yasalara uymak zorunda değildir.",
        ar: "الدولة ليست ملزمة باتباع القوانين."
      } },
    { answer: "Nur Deutsche müssen die Gesetze befolgen.", is_correct: false, translations: {
        en: "Only Germans must follow the laws.",
        fa: "فقط آلمانی‌ها باید از قوانین پیروی کنند.",
        tr: "Sadece Almanlar yasalara uymak zorundadır.",
        ar: "فقط الألمان ملزمون باتباع القوانين."
      } },
    { answer: "Die Gerichte machen die Gesetze.", is_correct: false, translations: {
        en: "The courts make the laws.",
        fa: "دادگاه‌ها قوانین را وضع می‌کنند.",
        tr: "Mahkemeler yasaları yapar.",
        ar: "المحاكم هي التي تصنع القوانين."
      } }
  ]
},
  {
    title: "Aufgabe 4",
    question: "Welches Recht gehört zu den Grundrechten in Deutschland?",
    translations: {
      en: "Which right is one of the fundamental rights in Germany?",
      fa: "کدام حق یکی از حقوق اساسی در آلمان است؟",
      tr: "Almanya'daki temel haklardan biri hangisidir?",
      ar: "أي حق من الحقوق الأساسية في ألمانيا؟"
    },
    answers: [
      { answer: "Waffenbesitz", is_correct: false, translations: {
          en: "Gun ownership",
          fa: "مالکیت اسلحه",
          tr: "Silah sahipliği",
          ar: "امتلاك الأسلحة"
        } },
      { answer: "Faustrecht", is_correct: false, translations: {
          en: "Right of the fist (vigilante justice)",
          fa: "حق مشت (عدالت خودسرانه)",
          tr: "Güç hakkı (bireysel adalet)",
          ar: "حق القبضة (العدالة الذاتية)"
        } },
      { answer: "Meinungsfreiheit", is_correct: true, translations: {
          en: "Freedom of speech",
          fa: "آزادی بیان",
          tr: "İfade özgürlüğü",
          ar: "حرية التعبير"
        } },
      { answer: "Selbstjustiz", is_correct: false, translations: {
          en: "Vigilante justice",
          fa: "عدالت خودسرانه",
          tr: "Bireysel adalet",
          ar: "العدالة الذاتية"
        } }
    ]
  },
  {
    title: "Aufgabe 5",
    question: "Wahlen in Deutschland sind frei. Was bedeutet das?",
    translations: {
      en: "Elections in Germany are free. What does that mean?",
      fa: "انتخابات در آلمان آزاد هستند. این به چه معناست؟",
      tr: "Almanya'daki seçimler özgürdür. Bu ne anlama geliyor?",
      ar: "الانتخابات في ألمانيا حرة. ماذا يعني ذلك؟"
    },
    answers: [
      { answer: "Man darf Geld annehmen, wenn man dafür eine bestimmte Kandidatin/einen bestimmten Kandidaten wählt.", is_correct: false, translations: {
          en: "You may accept money if you vote for a certain candidate.",
          fa: "می‌توانید پول بگیرید اگر به یک نامزد خاص رأی دهید.",
          tr: "Belirli bir adaya oy vermek için para kabul edebilirsiniz.",
          ar: "يمكنك قبول المال إذا صوتت لمرشح معين."
        } },
      { answer: "Nur Personen, die noch nie im Gefängnis waren, dürfen wählen.", is_correct: false, translations: {
          en: "Only people who have never been in prison are allowed to vote.",
          fa: "فقط افرادی که هرگز در زندان نبوده‌اند، حق رأی دارند.",
          tr: "Sadece hiç hapse girmemiş kişiler oy kullanabilir.",
          ar: "فقط الأشخاص الذين لم يدخلوا السجن مطلقًا يُسمح لهم بالتصويت."
        } },
      { answer: "Die Wählerin/der Wähler darf bei der Wahl weder beeinflusst noch zu einer bestimmten Stimmabgabe gezwungen werden und keine Nachteile durch die Wahl haben.", is_correct: true, translations: {
          en: "The voter must not be influenced or forced to vote a certain way and should not face any disadvantages from voting.",
          fa: "رای‌دهنده نباید تحت تأثیر قرار گیرد یا مجبور شود به شکلی خاص رأی دهد و نباید از رأی دادن متضرر شود.",
          tr: "Seçmen, oy verirken etkilenmemeli veya belirli bir şekilde oy vermeye zorlanmamalıdır ve oy vermekten dolayı dezavantaj yaşamamalıdır.",
          ar: "لا يجوز التأثير على الناخب أو إجباره على التصويت بطريقة معينة، ولا ينبغي أن يتعرض لأي عواقب سلبية بسبب تصويته."
        } },
      { answer: "Alle wahlberechtigten Personen müssen wählen.", is_correct: false, translations: {
          en: "All eligible voters must vote.",
          fa: "همه افراد واجد شرایط باید رأی دهند.",
          tr: "Tüm seçme hakkı olan kişiler oy kullanmak zorundadır.",
          ar: "يجب على جميع الناخبين المؤهلين التصويت."
        } }
    ]
  },
  {
  title: "Aufgabe 6",
  question: "Wie heißt die deutsche Verfassung?",
  translations: {
    en: "What is the name of the German constitution?",
    fa: "قانون اساسی آلمان چه نام دارد؟",
    tr: "Almanya anayasasının adı nedir?",
    ar: "ما هو اسم الدستور الألماني؟"
  },
  answers: [
    { answer: "Volksgesetz", is_correct: false, translations: {
        en: "People's Law",
        fa: "قانون مردم",
        tr: "Halk Yasası",
        ar: "قانون الشعب"
      } },
    { answer: "Bundesgesetz", is_correct: false, translations: {
        en: "Federal Law",
        fa: "قانون فدرال",
        tr: "Federal Yasa",
        ar: "القانون الاتحادي"
      } },
    { answer: "Deutsches Gesetz", is_correct: false, translations: {
        en: "German Law",
        fa: "قانون آلمان",
        tr: "Alman Yasası",
        ar: "القانون الألماني"
      } },
    { answer: "Grundgesetz", is_correct: true, translations: {
        en: "Basic Law",
        fa: "قانون اساسی",
        tr: "Temel Yasa",
        ar: "القانون الأساسي"
      } }
  ]
},
]

questions.each do |q|
  question = Question.create!(
    title: q[:title],
    question: q[:question],
    uuid: SecureRandom.uuid,
    category: citizenship_category,
    subcategory: citizenship_all_subcategory
  )
  q[:translations].each do |locale, content|
    QuestionTranslation.create!(question: question, locale: locale, content: content)
  end
  q[:answers].each do |a|
    answer = Answer.create!(answer: a[:answer], question: question, is_correct: a[:is_correct])
    a[:translations].each do |locale, content|
      AnswerTranslation.create!(answer: answer, locale: locale, content: content)
    end
  end
end

puts "Data seeded, #{questions.count} has been created!"
