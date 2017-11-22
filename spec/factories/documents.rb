# frozen_string_literal: true

FactoryBot.define do
  factory :document do
    agenda_item
    title
    pdf Rack::Test::UploadedFile.new(File.open('spec/assets/pdf.pdf'))
    category { ['Styrdokument', 'Protokoll', 'Von Tänen'].sample }
  end
end
