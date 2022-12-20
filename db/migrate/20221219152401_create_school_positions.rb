class CreateSchoolPositions < ActiveRecord::Migration[7.0]
  def change
    create_table :school_positions do |t|
      t.integer :position

      t.timestamps
    end

    add_column :schools, :school_position_id, :bigint, index: true
  end
end
