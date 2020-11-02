require 'rails_helper'

RSpec.describe "Potepan::Categories", type: :request do
  let(:taxon) { create(:taxon, parent: taxonomy.root, taxonomy: taxonomy) }
  let(:taxonomy) { create(:taxonomy) }
  let!(:product) { create(:product, taxons: [taxon]) }

  describe "GET /show" do
    it "returns http success" do
      get potepan_category_path(taxon.id)
      expect(response).to have_http_status(:success)
    end
  end

end
