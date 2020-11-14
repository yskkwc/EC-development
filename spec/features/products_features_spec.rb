RSpec.feature "Products_feature", type: :feature do
  let(:taxonomy) { create(:taxonomy) }
  let(:taxon) { create(:taxon, taxonomy: taxonomy, parent: taxonomy.root) }
  let(:product) { create(:product, name: "SampleTote", taxons: [taxon]) }
  let!(:related_products) do
    4.times.collect do |i|
      create(
        :product,
        name: "related product#{i + 1}",
        price: "#{i + 1}",
        taxons: [taxon]
      )
    end
  end

  let!(:not_related_product) do
    create(:product, name: "NOT related product", price: "99.99",
                     taxons: [create(:taxon, name: "NOT related taxon",
                                             taxonomy: taxonomy, parent: taxonomy.root)])
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
      expect(page).to have_content 'SampleTote'
      expect(page).to have_content '$19.99'
    end

    scenario 'to click navbar of upper_light_sec home link' do
      find('.light_home').click
      home_link_check
    end
  end

  describe 'visit other product_page from related_products' do
    scenario 'to check taxon in taxonomy', js: true do
      click_link '一覧ページへ戻る'
      within(:css, '.category_bar') do
        click_link 'Brand'
        expect(page).to have_content 'Ruby on Rails'
        expect(page).to have_content 'NOT related taxon'
      end
    end

    scenario 'to click related_product', js: true do
      product_link_check
      related_products.each do |related_product|
        click_on related_product.name
        aggregate_failures do
          within(:css, '.product_detail') do
            expect(page).to have_content related_product.name.upcase
            expect(page).to have_content related_product.display_price
          end
          within(:css, '.related_products') do
            expect(page).to have_content '関連商品'
            expect(page).to have_content product.name.upcase
            expect(page).to have_content product.display_price
            expect(page).not_to have_content related_product.name
            expect(page).not_to have_content "NOT related product"
            expect(page).not_to have_content "99.99"
          end
        end
      end
      click_link '一覧ページへ戻る'
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
      within(:css, '.media-body') do
        expect(page).to have_content product.name.upcase
        expect(page).to have_content product.display_price
      end
      within(:css, '.related_products') do
        expect(page).to have_content '関連商品'
        expect(page).to have_content 'RELATED PRODUCT1'
        expect(page).to have_content 'RELATED PRODUCT2'
        expect(page).to have_content 'RELATED PRODUCT3'
        expect(page).to have_content 'RELATED PRODUCT4'
      end
    end
  end
end
