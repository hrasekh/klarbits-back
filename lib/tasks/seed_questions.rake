require 'json'
require_relative '../tasks/seed_helpers'

namespace :db do
  desc 'Seeds questions from base_questions.json'
  task seed_base: :environment do
    puts 'Seeding base questions...'
    SeedHelpers.seed_questions(Rails.root.join('db', 'seeds', 'base_questions.json'), 'Base')
    puts 'Base questions seeded.'
  end

  desc 'Seeds questions from states_questions.json'
  task seed_states: :environment do
    puts 'Seeding state-specific questions...'
    SeedHelpers.seed_questions(Rails.root.join('db', 'seeds', 'states_questions.json'), 'States')
    puts 'State-specific questions seeded.'
  end

end