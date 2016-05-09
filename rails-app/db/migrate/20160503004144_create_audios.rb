class CreateAudios < ActiveRecord::Migration
  def change
    create_table :audios do |t|
      t.string :text
      t.string :file

      t.timestamps null: false
    end
  end
end
