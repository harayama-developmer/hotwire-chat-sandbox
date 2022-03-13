class Room < ApplicationRecord
  has_many :messages, dependent: :destroy

  # ActionCable
  after_create_commit do
    broadcast_prepend_to "room-list", target: "rooms", partial: "rooms/room"
  end
  after_update_commit do
    broadcast_replace_to "room-list", target: self, partial: "rooms/room"
    broadcast_update_to self, target: self, partial: "rooms/room_detail", locals: {room: self}
  end
  after_destroy_commit do
    broadcast_remove_to "room-list", target: self
    broadcast_replace_to self, target: "room-detail", partial: "shared/not_found"
  end

  validates :name, presence: true
end
