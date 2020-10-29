require 'rails_helper'

RSpec.feature "Products_feature", type: :feature do
  let(:product) { FactoryBot.create(:product) }

  before do
    visit potepan_product_path(product.id)
  end

  describe "visit home_link from #show" do
    let(:contents_check) do
      aggregate_failures do
        expect(page).to have_content '人気カテゴリー'
        expect(page).to have_content '新着商品'
        expect(page).to have_link 'home'
      end
    end

    scenario 'header navbarのロゴリンク' do
      click_on 'home_link'
      contents_check
    end

    scenario '"一覧ページへ戻る" リンク' do
      click_link '一覧ページへ戻る'
      contents_check
    end

    scenario '_light_sec navbarのhomeリンク' do
      find('.light_home').click
      contents_check
    end
  end
end
