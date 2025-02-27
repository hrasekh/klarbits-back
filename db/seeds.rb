# db/seeds.rb
Category.destroy_all
Subcategory.destroy_all
Question.destroy_all
Answer.destroy_all

driving_category = Category.create!(name: "Driving") 
citizenship_category = Category.create!(name: "Citizenship Test") 

citizenship_all_subcategory = Subcategory.create!(name: "All", category: citizenship_category) 
citizenship_berlin_subcategory = Subcategory.create!(name: "Berlin", category: citizenship_category) 
citizenship_bayern_subcategory = Subcategory.create!(name: "Bayern", category: citizenship_category) 


question1 = Question.create!(
  content: "What does a yellow traffic light mean?",
  category: citizenship_category,
  subcategory: citizenship_all_subcategory
)

Answer.create!(content: "Speed up", question: question1, is_correct: false)
Answer.create!(content: "Slow down and prepare to stop", question: question1, is_correct: true)
Answer.create!(content: "Stop immediately", question: question1, is_correct: false)
Answer.create!(content: "Honk your horn", question: question1, is_correct: false)

# Sample Citizenship Question (Berlin)
question2 = Question.create!(
  content: "What is the capital of Germany?",
  category: citizenship_category,
  subcategory: citizenship_all_subcategory
)

Answer.create!(content: "Munich", question: question2, is_correct: false)
Answer.create!(content: "Berlin", question: question2, is_correct: true)
Answer.create!(content: "Hamburg", question: question2, is_correct: false)
Answer.create!(content: "Cologne", question: question2, is_correct: false)

puts "Data seeded!"