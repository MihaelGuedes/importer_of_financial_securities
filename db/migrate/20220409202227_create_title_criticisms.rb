class CreateTitleCriticisms < ActiveRecord::Migration[7.0]
  def change
    create_table :title_criticisms do |t|
      t.text :assignors_protests
      t.text :drawees_protests
      t.string :status

      t.timestamps
    end
  end
end
