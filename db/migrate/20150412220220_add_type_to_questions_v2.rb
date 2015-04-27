class AddTypeToQuestionsV2 < ActiveRecord::Migration
  def up
    add_column :questions_v2, :type, :string
  end
end
