class Fight < ActiveRecord::Base
  belongs_to :winner, :class_name => "Gladiator"
  belongs_to :losser, :class_name => "Gladiator"
end
