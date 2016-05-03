class AddUrlToAudios < ActiveRecord::Migration
  def up
    change_table :audios do |t|
      t.string :url
    end
  end
end
