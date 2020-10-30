require 'rails_helper'

RSpec.describe "Products_requests", type: :request do
  let(:product) { create(:product) }

  describe "#index" do
    let!(:into_index) do
      get potepan_path
    end

    it "responds successfully" do
      expect(response).to be_successful
      expect(response).to have_http_status(200)
    end
  end

  describe "#show" do
    let!(:into_show) do
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
