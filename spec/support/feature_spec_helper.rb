module FeatureSpecHelper
  def header_check(path)
    visit path
    expect(page).to have_css('.topBar')
    expect(page).to have_css('.navbar')
  end

  def footer_check(path)
    visit path
    expect(page).to have_css('div#footer')
  end
end
