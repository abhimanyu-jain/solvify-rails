class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.bigint :customer_id
      t.string :service
      t.timestamp :initiated_on
      t.date :booking_date
      t.time :booking_slot
      t.integer :rating
      t.text :feedback
      t.integer :amount
      t.bigint :vendor_id
      t.string :status
      t.text :customer_comments
      t.string :origin_of_request
      t.string :name
      t.text :address
      t.bigint :phone
      t.string :email
      t.string :coupon_code
    end
  end
end
