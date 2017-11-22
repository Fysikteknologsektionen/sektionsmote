require 'rails_helper'

RSpec.describe Agenda, type: :model do
  describe 'validations' do
    it 'can only have one open agenda' do
      create(:agenda_item, status: :current)
      agenda = build(:agenda_item, status: :current)
      agenda.valid?

      agenda.errors[:status].should include I18n.t('agenda.too_many_open')
    end

    it 'can not close if a associated vote is open' do
      current = create(:agenda_item, status: :current)
      create(:vote, status: :open, agenda_item: current)
      current.update(status: :closed)
      current.valid?

      current.errors[:status].should include I18n.t('agenda.vote_open')
    end

    it 'current_status from child' do
      current = create(:agenda_item, status: :current)

      current.agenda.current_status.to_s.should eq('current')
    end
  end
end
