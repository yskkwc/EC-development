require 'rails_helper'

RSpec.feature "Products_feature", type: :feature do
  let(:taxon) { create(:taxon) }
  let(:product) { create(:product, name: "SampleTote", taxons: [taxon]) }
  let(:path) { potepan_product_path(product.id) }

  before do
    visit path
  end

  describe 'check header and footer' do
    scenario 'check header' do
      header_check(path)
    end

    scenario 'check footer' do
      footer_check(path)
    end
  end

  describe "visit home_link from products#show" do
    scenario 'header navbarのロゴリンク' do
      click_on 'home_link'
      home_link_check
    end

    scenario 'header navbarのHOMEリンク' do
      find('.navbar-home').click
      home_link_check
    end

    scenario '"一覧ページへ戻る" リンク' do
      click_link '一覧ページへ戻る'
      expect(page).to have_content 'SampleTote'
      expect(page).to have_content '$19.99'
    end

    scenario '_light_sec navbarのhomeリンク' do
      find('.light_home').click
      home_link_check
    end
  end

  private

  def home_link_check
    aggregate_failures do
      expect(page).to have_content '人気カテゴリー'
      expect(page).to have_content '新着商品'
      expect(page).to have_link 'home'
    end
  end
end
