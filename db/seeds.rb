require 'securerandom'

Category.destroy_all
Subcategory.destroy_all
Question.destroy_all
Answer.destroy_all

citizenship_category = Category.create!(name: "Citizenship Test")
citizenship_all_subcategory = Subcategory.create!(name: "All", category: citizenship_category)

questions = [
  { title: "Aufgabe 1", question: "In Deutschland dürfen Menschen offen etwas gegen die Regierung sagen, weil …", answers: [
      { answer: "hier Religionsfreiheit gilt.", is_correct: false },
      { answer: "die Menschen Steuern zahlen.", is_correct: false },
      { answer: "die Menschen das Wahlrecht haben.", is_correct: false },
      { answer: "hier Meinungsfreiheit gilt.", is_correct: true }
    ]
  },
  { title: "Aufgabe 2", question: "In Deutschland können Eltern bis zum 14. Lebensjahr ihres Kindes entscheiden, ob es in der Schule am …", answers: [
      { answer: "Geschichtsunterricht teilnimmt.", is_correct: false },
      { answer: "Religionsunterricht teilnimmt.", is_correct: true },
      { answer: "Politikunterricht teilnimmt.", is_correct: false },
      { answer: "Sprachunterricht teilnimmt.", is_correct: false }
    ]
  },
  { title: "Aufgabe 3", question: "Deutschland ist ein Rechtsstaat. Was ist damit gemeint?", answers: [
      { answer: "Alle Einwohnerinnen/Einwohner und der Staat müssen sich an die Gesetze halten.", is_correct: true },
      { answer: "Der Staat muss sich nicht an die Gesetze halten.", is_correct: false },
      { answer: "Nur Deutsche müssen die Gesetze befolgen.", is_correct: false },
      { answer: "Die Gerichte machen die Gesetze.", is_correct: false }
    ]
  },
  { title: "Aufgabe 4", question: "Welches Recht gehört zu den Grundrechten in Deutschland?", answers: [
      { answer: "Waffenbesitz", is_correct: false },
      { answer: "Faustrecht", is_correct: false },
      { answer: "Meinungsfreiheit", is_correct: true },
      { answer: "Selbstjustiz", is_correct: false }
    ]
  },
  { title: "Aufgabe 5", question: "Wahlen in Deutschland sind frei. Was bedeutet das?", answers: [
      { answer: "Man darf Geld annehmen, wenn man dafür eine bestimmte Kandidatin/einen bestimmten Kandidaten wählt.", is_correct: false },
      { answer: "Nur Personen, die noch nie im Gefängnis waren, dürfen wählen.", is_correct: false },
      { answer: "Die Wählerin/der Wähler darf bei der Wahl weder beeinflusst noch zu einer bestimmten Stimmabgabe gezwungen werden und keine Nachteile durch die Wahl haben.", is_correct: true },
      { answer: "Alle wahlberechtigten Personen müssen wählen.", is_correct: false }
    ]
  },
  { title: "Aufgabe 6", question: "Wie heißt die deutsche Verfassung?", answers: [
      { answer: "Volksgesetz", is_correct: false },
      { answer: "Bundesgesetz", is_correct: false },
      { answer: "Deutsches Gesetz", is_correct: false },
      { answer: "Grundgesetz", is_correct: true }
    ]
  },
  { title: "Aufgabe 7", question: "Welches Recht gehört zu den Grundrechten, die nach der deutschen Verfassung garantiert werden? Das Recht auf …", answers: [
      { answer: "Glaubens- und Gewissensfreiheit", is_correct: true },
      { answer: "Unterhaltung", is_correct: false },
      { answer: "Arbeit", is_correct: false },
      { answer: "Wohnung", is_correct: false }
    ]
  },
  { title: "Aufgabe 8", question: "Was steht nicht im Grundgesetz von Deutschland?", answers: [
      { answer: "Die Würde des Menschen ist unantastbar.", is_correct: false },
      { answer: "Alle sollen gleich viel Geld haben.", is_correct: true },
      { answer: "Jeder Mensch darf seine Meinung sagen.", is_correct: false },
      { answer: "Alle sind vor dem Gesetz gleich.", is_correct: false }
    ]
  },
  { title: "Aufgabe 9", question: "Welches Grundrecht gilt in Deutschland nur für Ausländerinnen/Ausländer? Das Grundrecht auf …", answers: [
      { answer: "Schutz der Familie", is_correct: false },
      { answer: "Menschenwürde", is_correct: false },
      { answer: "Asyl", is_correct: true },
      { answer: "Meinungsfreiheit", is_correct: false }
    ]
  }
]

questions.each do |q|
  question = Question.create!(
    title: q[:title],
    question: q[:question],
    uuid: SecureRandom.uuid,
    category: citizenship_category,
    subcategory: citizenship_all_subcategory
  )
  q[:answers].each do |a|
    Answer.create!(answer: a[:answer], question: question, is_correct: a[:is_correct])
  end
end

puts "Data seeded! #{questions.size} questions created."
