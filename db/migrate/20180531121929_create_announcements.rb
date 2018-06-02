class CreateAnnouncements < ActiveRecord::Migration[5.2]
  def change
    create_table :announcements do |t|
      t.string :title
      t.text :body
      t.belongs_to :member
      t.timestamps
    end
  end
end
