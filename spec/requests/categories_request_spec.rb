RSpec.describe "Categories_requests", type: :request do
  let(:taxonomy) { create(:taxonomy) }
  let(:taxon) { create(:taxon, parent: taxonomy.root, taxonomy: taxonomy) }
  let!(:product) { create(:product, taxons: [taxon]) }

  describe "#show" do
    before do
      get potepan_category_path(taxon.id)
    end

    it "responds successfully" do
      expect(response).to be_successful
      expect(response).to have_http_status(200)
    end

    it "display taxonomies" do
      expect(response.body).to include taxonomy.name
    end

    it "display taxons" do
      expect(response.body).to include taxon.name
    end

    it "display products" do
      expect(response.body).to include product.name
    end

    it "display brand LOGO" do
      expect(response).to render_template :_bottom_partners
    end
  end
end
