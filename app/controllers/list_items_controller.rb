class ListItemsController < ApplicationController

  def create
    @party = Party.find(params[:party_id])
    @item = Item.find(params[:item_id])
    @party_item = PartyItem.find_by(party_id: @party.id, item_id: @item.id)
    @guest = Guest.find_by(user: current_user, party: @party)
    list_item = ListItem.find_or_create_by(guest: @guest, party_item: @party_item)
    if request.xhr?
      # binding.pry
      render partial: "list_item_added", locals:{item: @item, party: @party}
    else
      redirect_to @party
    end
  end


  def destroy
    @party = Party.find(params[:party_id])
    @item = Item.find(params[:item_id])
    @party_item = PartyItem.find_by(party_id: @party.id, item_id: @item.id)
    @guest = Guest.find_by(user: current_user, party: @party)
    list_item = ListItem.find_by(guest: @guest, party_item: @party_item)
    list_item.destroy
    if request.xhr?
      if @guest.list_items.empty?
        render :partial => "./guests/empty_list"
      end
    else
      redirect_to current_user
    end
  end

end
