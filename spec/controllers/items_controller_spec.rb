require 'rails_helper'

RSpec.describe ItemsController, type: :controller do
	describe "GET index" do
	    it "assigns all items as @items" do
	      item = create(:item)
	      get :index, params: { owner_id: item.owner.id }
	      expect(assigns(:items).to_a).to eq([item])
	      expect(response.status).to eq(200)	
	    end
	end
	describe "GET #show" do
	  it "assigns the requested item to @item" do
	    item = create(:item)
	    get :show, params: { owner_id: item.owner.id, id: item.id }
	    expect(assigns(:item)).to eq(item)
	    expect(response.status).to eq(200)
	  end
	end
	describe "GET #inventory" do
		it "assigns the requested owner's inventory to owner.items" do
		     owner = create(:owner)
		     # inventory = create(:owner_with_inventory, items_count: 5)
		     get :index, params: { owner_id: owner.id }
		     expect(assigns(:items).to_a).to eq(owner.items)
		     expect(response.status).to eq(200)	
		end
	end

	describe "GET #inventory" do
		it "assigns the requested item in owner's inventory to @item" do
		     owner = create(:owner)
		     item = create(:item)
		     # inventory = create(:owner_with_inventory, items_count: 5)
		     get :show, params: { owner_id: owner.id, id: item.id }
		     expect(assigns(:item)).to eq(item)
		     expect(response.status).to eq(200)	
		end

		it "search the requested item to @item" do
		     search = "note"
		     item = create(:item)
		     item.name = "notebook"
		     # inventory = create(:owner_with_inventory, items_count: 5)
		     get :show, params: { owner_id: item.owner.id, id: item.id, search: search }
		     expect(assigns(:item)).to eq(item)
		     expect(response.status).to eq(200)	
		end
	end

	describe "DELETE #destroy" do
	  it "removes the requested owner's item" do
	    item = create(:item)
	    
	    delete :destroy, params: { owner_id: item.owner.id, id: item.id }
	    
	    expect(response.status).to eq(200)
	  end
	end

end
