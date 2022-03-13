class Message < ApplicationRecord
  belongs_to :room, counter_cache: true
  # ActionCable
  broadcasts_to :room
  after_create_commit do
    broadcast_update_to "room-list", target: room, partial: "rooms/room", locals: {room: room}
    broadcast_update_to room, target: room, partial: "rooms/room_detail", locals: {room: room}
  end

  validates :content, presence: true
end
