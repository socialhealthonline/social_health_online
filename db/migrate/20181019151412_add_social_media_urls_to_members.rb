class AddSocialMediaUrlsToMembers < ActiveRecord::Migration[5.2]
  def change
    add_column :members, :social_media_url_one, :string
    add_column :members, :social_media_url_two, :string
    add_column :members, :social_media_url_three, :string
  end
end
