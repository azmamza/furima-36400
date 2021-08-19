class ItemsController < ApplicationController
  before_action :authenticate_user!, only: [:new]
  before_action :move_to_index, except: [:index]

  def index
    @items = Item.includes(:user)
  end

  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      redirect_to root_path
    else
      render :new
    end
  end

  private

  def item_params
    params.require(:item).permit(:image, :name, :info, :category_id, :status_id, :shipping_fee_id, :prefecture_id, :scheduled_delivery_id, :price)
  end

  def move_to_index
    unless user_signed_in?
      redirect_to action: :index
    end
  end
  
end

# .merge(user_id: current_user.id)