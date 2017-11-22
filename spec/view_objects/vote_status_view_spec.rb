require 'rails_helper'

RSpec.describe VoteStatusView do
  describe 'initialisation' do
    it 'sets current' do
      agenda = create(:agenda_item, status: :current)
      create(:agenda_item, status: :closed)
      vote = create(:vote, status: :open, agenda_item: agenda)
      create(:vote, status: :closed)
      create(:user, presence: true)
      create(:user, presence: true)
      create(:user, presence: true)
      create(:user, presence: false)

      vote_status = VoteStatusView.new
      vote_status.agenda.should eq(agenda)
      vote_status.vote.should eq(vote)
    end
  end
end
