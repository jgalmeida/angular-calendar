class Event < ActiveRecord::Base
  attr_accessible :date, :description, :location, :name, :hour
  scope :between, ->(from=Date.today, to=Date.today){ gte(from).lte(to)}
  scope :gte, ->(from = Date.today){ where("date >=?", from)}
  scope :lte, ->(to = Date.today){ where("date<=?", to)}

end
