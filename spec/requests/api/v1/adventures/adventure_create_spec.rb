require 'rails_helper'

RSpec.describe "create an adventure request" do

  it "creates an adventure, useradventure from submitted data" do
    user = FactoryBot.create(:user)
    # adventure_params = {
    # user_id: user.id,
    # #user id from session
    # rec_area_id: 1,
    # guest_email_addresses: "bob@google.com, john@reddit.com",
    # activities: "Hiking, Fishing, Boating",
    # comment: "cool rocks",
    # favorite: true,
    # date: DateTime.current
    # }
adventure_params = {
  guest_email_addresses: "bob@gmail.com",
  date:"2022-03-03T23:43:00.000+00:00",
  comment:"woop",
  activities:"BIKING",
  favorite:"false",
  rec_area_id:"284",
  user_id: user.id
}

    headers = { "CONTENT_TYPE" => "application/json" }
    post "/api/v1/adventures", headers: headers, params: adventure_params, as: :json
    expect(response).to be_successful
    parsed = JSON.parse(response.body, symbolize_names: true)
    expect(parsed).to be_a(Hash)
    expect(parsed[:data][:attributes][:comment]).to eq("woop")
  end

  it " sad path attribute not given" do
    user = FactoryBot.create(:user)
    adventure_params = {
    user_id: user.id,
    #user id from session
    rec_area_id: 1,
    activities: "Hiking, Fishing, Boating",
    comment: "cool rocks",
    favorite: true,
    date: DateTime.current
    }

    headers = { "CONTENT_TYPE" => "application/json" }
    post "/api/v1/adventures", headers: headers, params: adventure_params, as: :json
    expect(response).to_not be_successful
    parsed = JSON.parse(response.body, symbolize_names: true)
    expect(parsed).to be_a(Hash)
    expect(parsed[:status]).to eq("ERROR")
  end
end