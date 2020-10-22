require 'rails_helper'

RSpec.feature "Products", type: :feature do
  let(:product) { FactoryBot.create(:product) }
  let(:into_show) {
    visit potepan_product_path(product.id)
  }

  scenario "user access #show page" do
    into_show
    expect(page).to have_content "Potepan::Products#show" #WIP
  end
end
