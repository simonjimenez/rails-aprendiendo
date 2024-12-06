class StoresController < ApplicationController
  def index
    @stores = Store.all
  end

  def show
    @store = Store.find(params[:id])
  end

  def new
    @store = Store.new
  end


  def create
    @store = Store.new(store_params)
    @store.user = current_user
    if @store.save
      redirect_to stores_path
    else
      render :new, status: :unprocessable_entity
    end

  end


  def update
    @store = Store.find(params[:id])
    @store.update(store_params)
    redirect_to @store

  end

  def edit
    @store = Store.find(params[:id])

  end


  def destroy
    @store = Store.find(params[:id])
    @store.destroy
    redirect_to stores_path, status: :see_other

  end

  private

  def store_params
    params.require(:store).permit(:name, :payment_type, :delivery_time, :delivery_price, :category_id)

  end
end
