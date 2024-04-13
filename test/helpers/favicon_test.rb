require "test_helper"

class FaviconTest < ActiveSupport::TestCase
  include FaviconHelper

  test "generates correct favicon URL" do

    expected_url = 'https://www.google.com/s2/favicons?domain=example.com'
    domain = 'example.com'

    assert_equal expected_url, google_favicon_url(domain)
  end

end

