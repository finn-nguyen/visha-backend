class CreateVideos < ActiveRecord::Migration[6.0]
  def change
    create_table :videos, id: :uuid do |t|
      t.string :title
      t.string :link
      t.text :description
      t.uuid :user_id
      t.integer :views, :default => 0

      t.timestamps
    end
  end
end
