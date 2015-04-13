class AddTypeToQuestionsV2 < ActiveRecord::Migration
  def change
    add_column :questions_v2, :type, :string
  end
end
