class ItemsController < ApplicationController
	before_action :set_item, only: [:show, :destroy]

	def index
		if !params[:search].blank?
			@items = Item.full_text_search(params[:search])
		else
			@items = Item.all
		end
		

		render json: @items
	end

	def create
		@item = Item.new(item_params)
		if @item.save
		  render :show
		else
		  render json: { errors: @item.errors }, status: :unprocessable_entity
		end
	end

	def update
   	    if @item.update_attributes(item_params)
	      render :show
	    else
	      render json: { errors: { project: ['not owned by user'] } }, status: :forbidden
	    end
  	end

	def show
		render json: @item
	end

	def destroy
   	    if @item.destroy(item_params)
	      render json: {}
	    else
	      render json: { errors: { project: ['not owned by user'] } }, status: :forbidden
	    end
  	end
private	

	def set_item
      @item = Item.find(params[:id])
    end

	def item_params
    	params.permit(:item).permit(:name, :img_url, :owner_id)
  	end
end