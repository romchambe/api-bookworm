class Note < ApplicationRecord

  belongs_to :user

  def render_hash_with_attribute_key
    note_attributes = self.attributes
    note_attributes[:key] = 'k' + note_attributes["id"].to_s
    return note_attributes
  end
end
