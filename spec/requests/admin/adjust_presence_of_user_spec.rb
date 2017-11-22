# frozen_string_literal: true

require 'rails_helper'

RSpec.describe("Adjust presence of user", type: :request) do
  let(:adjuster) { create(:user, role: :adjuster) }

  describe 'set presence' do
    it 'makes not present user present' do
      sign_in(adjuster)
      user = create(:user, presence: false)
      create(:vote, status: :future)
      create(:agenda_item, status: :current)

      patch(admin_attendance_path(user), xhr: true)
      expect(response).to have_http_status(200)

      user.reload
      expect(user.presence?).to be_truthy
    end

    it 'makes already present user stay present' do
      sign_in(adjuster)
      user = create(:user, presence: true)
      create(:vote, status: :future)
      create(:agenda_item, status: :current)

      patch(admin_attendance_path(user), xhr: true)
      expect(response).to have_http_status(200)

      user.reload
      expect(user.presence?).to be_truthy
    end

    it 'works even if a vote is open' do
      sign_in(adjuster)
      user = create(:user, presence: false)
      agenda_item = create(:agenda_item, status: :current)
      create(:vote, status: :open, agenda_item: agenda_item)

      patch(admin_attendance_path(user), xhr: true)
      expect(response).to have_http_status(200)

      user.reload
      expect(user.presence?).to be_truthy
    end

    it 'doesnt work without a current agenda_item' do
      sign_in(adjuster)
      user = create(:user, presence: false)
      create(:vote, status: :future)
      create(:agenda_item)

      patch(admin_attendance_path(user), xhr: true)
      expect(response).to have_http_status(200)

      user.reload
      expect(user.presence?).to be_falsey
    end
  end

  describe 'set not present' do
    it 'makes present user not present' do
      sign_in(adjuster)
      user = create(:user, presence: true)
      create(:vote, status: :future)
      create(:agenda_item, status: :current)

      delete(admin_attendance_path(user), xhr: true)
      expect(response).to have_http_status(200)

      user.reload
      expect(user.presence?).to be_falsey
    end

    it 'makes already not present user stay not present' do
      sign_in(adjuster)
      user = create(:user, presence: false)
      create(:vote, status: :future)
      create(:agenda_item, status: :current)

      delete(admin_attendance_path(user), xhr: true)
      expect(response).to have_http_status(200)

      user.reload
      expect(user.presence?).to be_falsey
    end

    it 'doesnt work if a vote is open' do
      sign_in(adjuster)
      user = create(:user, presence: true)
      agenda_item = create(:agenda_item, status: :current)
      create(:vote, status: :open, agenda_item: agenda_item)

      delete(admin_attendance_path(user), xhr: true)
      expect(response).to have_http_status(200)

      user.reload
      expect(user.presence?).to be_truthy
    end

    it 'doesnt work without a current agenda_item' do
      sign_in(adjuster)
      user = create(:user, presence: true)
      create(:vote, status: :future)
      create(:agenda_item)

      delete(admin_attendance_path(user), xhr: true)
      expect(response).to have_http_status(200)

      user.reload
      expect(user.presence?).to be_truthy
    end
  end
end
