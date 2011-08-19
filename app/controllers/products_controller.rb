class ProductsController < ApplicationController
  before_filter :authenticate_user!, :except => [:index, :show]
  
  # GET /products
  # GET /products.xml
  def index
    @available = Product.available.sorted
    @sold = Product.sold.sorted

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => {:available => @available, :sold => @sold} }
    end
  end

  # GET /products/1
  # GET /products/1.xml
  def show
    @product = Product.where(:_id => params[:id].to_i).first

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @product }
    end
  end
end
