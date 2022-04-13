class AddTitleIdToTitleCriticisms < ActiveRecord::Migration[7.0]
  def change
    add_reference :title_criticisms, :title, null: false, foreign_key: true, on_delete: :cascade
  end
end
