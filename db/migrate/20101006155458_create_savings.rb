class CreateSavings < ActiveRecord::Migration
  def self.up
    create_table :savings do |t|
      t.column :value, :decimal

      t.timestamps
    end
    
    Savings.create(:value => 0.0)
    
  end

  def self.down
    drop_table :savings
  end
end
