RSpec.feature "Categories_feature", type: :feature do
  let(:taxonomy) { create(:taxonomy) }
  let(:taxon) { create(:taxon, parent_id: taxonomy.root.id, taxonomy: taxonomy) }
  let!(:another_taxon) do
    create(:taxon, name: "Another taxon", parent_id: taxonomy.root.id, taxonomy: taxonomy)
  end
  let!(:product) { create(:product, name: "SampleTote", taxons: [taxon]) }
  let!(:similar_product) { create(:product, name: "SampleBag", taxons: [taxon]) }
  let!(:another_product) { create(:product, name: "SampleJersey", taxons: [another_taxon]) }
  let(:path) { potepan_category_path(taxon.id) }

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

  describe 'visit home_link from categories#show' do
    scenario 'to click navbar logo link' do
      click_on 'home_link'
      home_link_check
    end

    scenario 'to click navbar HOME link' do
      find('.navbar-home').click
      home_link_check
    end

    scenario 'to click navbar of upper_light_sec home link' do
      find('.light_home').click
      home_link_check
    end
  end

  describe 'visit product_page from categories#show' do
    scenario 'to click display_image', js: true do
      click_on "image of #{product.name}"
      product_link_check
    end

    scenario 'to click product.name', js: true do
      click_link product.name
      product_link_check
    end

    scenario 'to click product.display_price', js: true do
      click_link product.display_price, match: :first
      product_link_check
    end
  end

  describe 'visit taxon from left_bar' do
    scenario 'to click taxon "Ruby on Rails"', js: true do
      click_link taxonomy.name
      click_link taxon.name
      expect(page).to have_content product.name.upcase
      expect(page).to have_content similar_product.name.upcase
      expect(page).not_to have_content another_product.name.upcase
    end

    scenario 'to click taxon "Another taxon"', js: true do
      click_link taxonomy.name
      click_link another_taxon.name
      expect(page).not_to have_content product.name.upcase
      expect(page).not_to have_content similar_product.name.upcase
      expect(page).to have_content another_product.name.upcase
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

  def product_link_check
    aggregate_failures do
      within(:css, '.product_detail') do
        expect(page).to have_content product.name.upcase
        expect(page).not_to have_content similar_product.name.upcase
        expect(page).to have_content product.display_price
      end
      expect(page).to have_content '関連商品'
      expect(page).to have_content similar_product.name.upcase
      expect(page).not_to have_content another_product.name.upcase
      click_link '一覧ページへ戻る'
      expect(page).to have_content product.name.upcase
      expect(page).to have_content similar_product.name.upcase
      expect(page).not_to have_content another_product.name.upcase
    end
  end
end
