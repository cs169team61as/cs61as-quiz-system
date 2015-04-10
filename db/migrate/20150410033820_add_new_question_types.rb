# == Schema Information
#
# Table name: questions_v2
#
#  id         :integer          not null, primary key
#  content    :text
#  created_at :datetime
#  updated_at :datetime
#  lesson     :string(255)      default("")
#  difficulty :string(255)
#  options    :text
#

class AddNewQuestionTypes < ActiveRecord::Migration
  def up
    create_table :questions_v2 do |t|
    	t.text     :content
    	t.timestamps null: false
    	t.string   :lesson,     default: ""
    	t.string   :difficulty
    	t.text     :options
    end
  end

  def down
  	drop_table :questions_v2
  end

end
