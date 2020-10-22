require 'rails_helper'

RSpec.describe "Products", type: :request do
  describe "#show page" do
    let(:product) { FactoryBot.create(:product) }
    let(:into_show) {
      get potepan_product_path(product.id)
    }

    it "responds successfully" do
      into_show
      expect(response).to be_successful #successだと非推奨警告出るのでとりあえず
      expect(response).to have_http_status "200"
    end
  end
end
