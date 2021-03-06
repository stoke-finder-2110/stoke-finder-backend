require 'rails_helper'

RSpec.describe "Delete an adventure request" do
  describe 'deletes an adventure' do
    it 'happy path' do
    adventure = Adventure.create!(
          rec_area_id: 1,
          guest_email_addresses: "bob@google.com, john@reddit.com",
          activities: "Hiking, Fishing, Boating",
          comment: "cool rocks",
          favorite: true,
          date: DateTime.current
        )
      expect(Adventure.count).to eq(1)

      delete "/api/v1/adventures/#{adventure.id}"

      expect(response).to be_successful
      expect(Adventure.count).to eq(0)
      expect{Adventure.find(adventure.id)}.to raise_error(ActiveRecord::RecordNotFound)
    end
  end
end
