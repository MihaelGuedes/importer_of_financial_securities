class CreateTitles < ActiveRecord::Migration[7.0]
  def change
    create_table :titles do |t|
      t.string :title_number
      t.decimal :value
      t.string :due_date
      t.string :cnpj_assignor
      t.string :cnpj_drawee

      t.timestamps
    end
  end
end
