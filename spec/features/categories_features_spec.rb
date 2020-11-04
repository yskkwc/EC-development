require 'rails_helper'

RSpec.feature "Categories_feature", type: :feature do
  let(:taxonomy) { create(:taxonomy) }
  let(:taxon) { create(:taxon, parent_id: taxonomy.root.id, taxonomy: taxonomy) }
  let!(:product) { create(:product, taxons: [taxon]) }
  let!(:sample_product) { create(:product, name: "SampleTote", taxons: [taxon]) }
  let!(:into_show) do
    visit potepan_category_path(taxon.id)
  end

  describe 'check header and footer' do
    scenario 'check header' do
      header_check(into_show)
    end

    scenario 'check footer' do
      footer_check(into_show)
    end
  end

  describe 'visit home_link from categories#show' do
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

    scenario 'header navbarのHOMEリンク' do
      find('.navbar-home').click
      contents_check
    end

    scenario '_light_sec navbarのhomeリンク' do
      find('.light_home').click
      contents_check
    end
  end

  describe 'use js contents' do
    scenario 'visit product_page from categories#show', js: true do
      click_on 'image of SampleTote'
      check_contents
    end
  end

  private

  def check_contents
    aggregate_failures do
      expect(page).to have_content 'SAMPLETOTE'
      expect(page).to have_content '$19.99'
    end
    click_link '一覧ページへ戻る'
  end
end
