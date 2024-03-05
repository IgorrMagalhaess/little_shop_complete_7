require 'rails_helper'

RSpec.describe WelcomeHelper do
  it 'display links to each merchant dasbboard' do
    @merchant1 = Merchant.create!(name: "Hair Care")
    @merchant2 = Merchant.create!(name: "Skin Care")

    visit '/'

    expect(page).to have_content(@merchant1.name)
    expect(page).to have_link("Dashboard")
  end
end
