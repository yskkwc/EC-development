RSpec.feature "Products_feature", type: :feature do
  let(:taxonomy) { create(:taxonomy) }
  let(:taxon) { create(:taxon, taxonomy: taxonomy, parent: taxonomy.root) }
  let(:another_taxon) do
    create(:taxon, name: "NOT related taxon", taxonomy: taxonomy, parent: taxonomy.root)
  end
  let(:product) { create(:product, name: "SampleTote", taxons: [taxon]) }
  let!(:related_product) { create(:product, name: "RelatedBag", price: "88.88", taxons: [taxon]) }
  let!(:other_related_products) { create_list(:product, 3, taxons: [taxon]) }
  let!(:not_related_product) do
    create(:product, name: "NOT related product", price: "99.99",
                     taxons: [another_taxon])
  end

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

  describe 'visit home_link from products#show' do
    scenario 'to click header navbar logo link' do
      click_on 'home_link'
      home_link_check
    end

    scenario 'to click header navbar HOME link' do
      find('.navbar-home').click
      home_link_check
    end

    scenario 'to click "一覧ページへ戻る" link' do
      click_link '一覧ページへ戻る'
      expect(page).to have_content product.name
      expect(page).to have_content product.display_price
    end

    scenario 'to click navbar of upper_light_sec home link' do
      find('.light-home').click
      home_link_check
    end
  end

  describe 'visit other product_page from related_products' do
    scenario 'to check taxon in taxonomy', js: true do
      click_link '一覧ページへ戻る'
      within(:css, '.category-bar') do
        click_link taxonomy.name
        expect(page).to have_content taxon.name
        expect(page).to have_content another_taxon.name
      end
    end

    scenario 'to click related_product.name', js: true do
      product_link_check
      click_link related_product.name
      related_product_link_check
    end

    scenario 'to click related_product.display_price', js: true do
      product_link_check
      click_link related_product.display_price
      related_product_link_check
    end

    scenario 'to click related_product.display_image', js: true do
      product_link_check
      click_on "image of #{related_product.name}"
      related_product_link_check
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
      within(:css, '.product-detail') do
        expect(page).to have_content product.name.upcase
        expect(page).to have_content product.display_price
      end
      within(:css, '.related-products') do
        expect(page).to have_content '関連商品'
        expect(page).to have_content related_product.name.upcase
        expect(page).to have_content related_product.display_price
        other_related_products.each do |other_related_product|
          expect(page).to have_content other_related_product.name.upcase
          expect(page).to have_content other_related_product.display_price
        end
        expect(page).not_to have_content not_related_product.name.upcase
        expect(page).not_to have_content not_related_product.display_price
      end
    end
  end

  def related_product_link_check
    aggregate_failures do
      within(:css, '.product-detail') do
        expect(page).to have_content related_product.name.upcase
        expect(page).to have_content related_product.display_price
      end
      within(:css, '.related-products') do
        expect(page).to have_content '関連商品'
        expect(page).to have_content product.name.upcase
        expect(page).to have_content product.display_price
        other_related_products.each do |other_related_product|
          expect(page).to have_content other_related_product.name.upcase
          expect(page).to have_content other_related_product.display_price
        end
        expect(page).not_to have_content related_product.name.upcase
        expect(page).not_to have_content related_product.display_price
        expect(page).not_to have_content not_related_product.name.upcase
        expect(page).not_to have_content not_related_product.display_price
      end
    end
  end
end
