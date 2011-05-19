class CreateGladiators < ActiveRecord::Migration
  def self.up
    create_table :gladiators do |t|
      t.string :name
      t.integer :strength
      t.integer :intelligence
      t.integer :agility
      t.integer :damage
      t.integer :win
      t.integer :loss

      t.timestamps
    end
  end

  def self.down
    drop_table :gladiators
  end
end
