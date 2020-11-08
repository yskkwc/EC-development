RSpec.describe "Products_requests", type: :request do
  let(:product) { create(:product, taxons: [create(:taxon)]) }

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
  end
end
