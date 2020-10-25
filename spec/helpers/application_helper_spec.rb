require 'rails_helper'

RSpec.describe ApplicationHelper, type: :helper do
  describe "page_title" do
    let(:page_title) { "Test_page" }

    context "have indivisual title" do
      it "display title 'Test_page - BIGBAG Store'" do
        expect(full_title(page_title: page_title)).to eq "#{page_title} - #{BASE_TITLE}"
      end
    end

    context "not_have indivisual title" do
      it "display title 'BIGBAG Store' when page_title: ''" do
        expect(full_title(page_title: "")).to eq "#{BASE_TITLE}"
      end
      it "display title 'BIGBAG Store' when page_title: nil" do
        expect(full_title(page_title: nil)).to eq "#{BASE_TITLE}"
      end
    end
  end
end
