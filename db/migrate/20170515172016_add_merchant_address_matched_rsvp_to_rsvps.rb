class AddMerchantAddressMatchedRsvpToRsvps < ActiveRecord::Migration[5.0]
  def change
    add_column :rsvps, :merchant, :string
    add_column :rsvps, :address, :string
    add_column :rsvps, :matched_rsvp, :integer
  end
end
