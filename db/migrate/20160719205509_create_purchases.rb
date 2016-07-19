class CreatePurchases < ActiveRecord::Migration
  def change
    create_table(:purchases) do |t|
      t.column(:date_of_purchase, :date)
      t.column(:total_price, :float)

      t.timestamps()
    end

    add_column(:products, :purchase_id, :integer)
  end
end
