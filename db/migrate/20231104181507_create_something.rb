class CreateSomething < ActiveRecord::Migration[7.1]
  def change
    create_table :somethings do |t|

      t.timestamps
    end
  end
end
