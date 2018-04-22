class Message < ApplicationRecord
  validates_presence_of :channel, :content, :created_at, :autor

  after_initialize :set_defaults, unless: :persisted?
  # The set_defaults will only work if the object is new

  def set_defaults
    self.created_at  ||= DateTime.now
  end

end
