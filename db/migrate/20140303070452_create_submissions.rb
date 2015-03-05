class CreateSubmissions < ActiveRecord::Migration
  def change
    create_table :submissions do |t|
      t.text    :text
      t.integer :question_id
      t.integer :student_id

      t.timestamps
    end
  end
end
