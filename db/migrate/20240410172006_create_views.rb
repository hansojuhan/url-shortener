class CreateViews < ActiveRecord::Migration[7.1]
  def change
    create_table :views do |t|
      t.string :user_agent
      t.string :ip

      t.timestamps
    end
  end
end
