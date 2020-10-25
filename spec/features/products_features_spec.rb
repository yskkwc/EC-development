require 'rails_helper'

RSpec.feature "Products_feature", type: :feature do
  let!(:product) { FactoryBot.create(:product) }
  let(:visit_show) { visit potepan_product_path(product.id) }

  describe "visit home_link from #show" do
    scenario 'header navbarのLOGO_imageリンク' do
      visit_show
      click_on 'home_link'
      aggregate_failures do
        expect(page).to have_content '人気カテゴリー'
        expect(page).to have_content '新着商品'
        expect(page).to have_link 'home'
      end
    end

    scenario '"一覧ページへ戻る" リンク' do
      visit_show
      click_link '一覧ページへ戻る'
      aggregate_failures do
        expect(page).to have_content '人気カテゴリー'
        expect(page).to have_content '新着商品'
        expect(page).to have_link 'home'
      end
    end

    scenario 'light-sec navbarのhomeリンク' do
      visit_show
      find('.light_home').click
      aggregate_failures do
        expect(page).to have_content '人気カテゴリー'
        expect(page).to have_content '新着商品'
        expect(page).to have_link 'home'
      end
    end
  end
end
