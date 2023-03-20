class CreateGoosAndBoos < ActiveRecord::Migration[7.0]
  def change
    create_table :goos, temporal: true do |t|
      t.timestamps
    end

    create_table :boos, temporal: true do |t|
      t.references :goo
      t.timestamps
    end
  end
end
