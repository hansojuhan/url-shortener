class AddLinkReferencesToViews < ActiveRecord::Migration[7.1]
  def change
    add_reference :views, :link, null: false, foreign_key: true
  end
end
