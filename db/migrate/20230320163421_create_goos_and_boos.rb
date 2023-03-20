class CreateGoosAndBoos < ActiveRecord::Migration[7.0]
  def change
    create_table :goos, temporal: true do |t|
      t.string :name, null: false
      t.timestamps
    end

    create_table :boos, temporal: true do |t|
      t.string :name, null: false
      t.references :goo
      t.timestamps
    end
  end
end
