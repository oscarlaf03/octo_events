class Event < ApplicationRecord
  belongs_to :sender
  belongs_to :repostiory
end
