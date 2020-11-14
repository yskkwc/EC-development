RSpec.describe "Products_requests", type: :request do
  let(:taxon) { create(:taxon) }
  let(:product) { create(:product, taxons: [taxon]) }
  let!(:related_products) { create_list(:product, 4, taxons: [taxon]) }
  let!(:not_related_product) { create(:product, price: "99.99", taxons: [create(:taxon)]) }

  describe "#index" do
    before do
      get potepan_path
    end

    it "responds successfully" do
      expect(response).to be_successful
      expect(response).to have_http_status(200)
    end
  end

  describe "#show" do
    before do
      get potepan_product_path(product.id)
    end

    it "responds successfully" do
      expect(response).to be_successful
      expect(response).to have_http_status(200)
    end

    it "display contents" do
      expect(response.body).to include product.name
      expect(response.body).to include product.display_price.to_s
      expect(response.body).to include product.description
    end

    it "display images" do
      product.images.each do |image|
        expect(response.body).to include image.attachment(:large)
        expect(response.body).to include image.attachment(:small)
      end
    end

    it "display related_products" do
      expect(response.body).to include "関連商品"
      related_products.each do |related_product|
        expect(response.body).to include related_product.name
        expect(response.body).to include related_product.display_price.to_s
      end
      expect(assigns(:related_products).size).to eq 4
    end

    it "not display not_related_product" do
      expect(response.body).to include "関連商品"
      expect(response.body).not_to include not_related_product.name
      expect(response.body).not_to include not_related_product.display_price.to_s
    end
  end
end
