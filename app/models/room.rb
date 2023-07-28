class Room < ApplicationRecord
  has_many :customr_rooms
  has_many :chats
end
