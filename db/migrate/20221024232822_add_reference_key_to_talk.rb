class AddReferenceKeyToTalk < ActiveRecord::Migration[6.1]
  def change
    add_reference :talks, :track, index: false
  end
end
