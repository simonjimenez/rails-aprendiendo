class ProductsController < ApplicationController
  def index
    @products = Product.all
  end

  def show
    @product = Product.find(params[:id])
  end

  def new
    @product = Product.new
    @store = Store.find(params[:store_id])
  end

  def create
    @product = Product.new(product_params)
    @store = Store.find(params[:store_id])
    @product.store = @store
    if
      @product.save
      redirect_to store_path(@store)
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @product = Product.find(params[:id])
  end

  def update
    @product = Product.find(params[:id])
    @product.update(product_params)
    redirect_to @product
  end

  def destroy
    @product = Product.find(params[:id])
     @store = Store.find(params[:store_id])
    @product.destroy
    redirect_to store_path(@store)
  end
  private

  def product_params
    params.require(:product).permit(:name, :price, :description, :photo)
  end

end
