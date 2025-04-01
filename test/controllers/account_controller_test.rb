require "test_helper"

describe AccountController do
  it "gets switch" do
    get account_switch_url
    must_respond_with :success
  end
end
