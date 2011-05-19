class Gladiator < ActiveRecord::Base
  validates_presence_of :name, :strength, :intelligence, :agility, :damage
  validates_numericality_of :strength, :intelligence, :agility, :damage
end
