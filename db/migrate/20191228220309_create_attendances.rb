class CreateAttendances < ActiveRecord::Migration[6.0]
  def change
    create_table :attendances do |t|
      t.integer :user_id
      t.integer :registrar_id
      t.timestamp :time
      t.string :type
    end
  end
end
