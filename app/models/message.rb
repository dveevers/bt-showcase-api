class Message < ApplicationRecord
  validates_presence_of :channel, :content, :created_at, :autor
end
