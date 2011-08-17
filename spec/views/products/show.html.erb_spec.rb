require 'spec_helper'

describe "products/show.html.erb" do
  before(:each) do
    @product = assign(:product, stub_model(Product,
      :name => "Name",
      :price => "9.99",
      :description => "MyText"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    response.body.should match(/Name/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    response.body.should match(/9.99/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    response.body.should match(/MyText/)
  end
end
