require 'spec_helper'

describe ProductsController do
  def mock_product(stubs={})
    @mock_product ||= mock_model(Product, stubs).as_null_object
  end

  describe "GET index" do
    it "assigns all products as @products" do
      Product.stub(:all) { [mock_product] }
      get :index
      assigns(:products).should eq([mock_product])
    end
  end

  describe "GET show" do
    it "assigns the requested product as @product" do
      Product.stub(:find).with("37") { mock_product }
      get :show, :id => "37"
      assigns(:product).should be(mock_product)
    end
  end
end
