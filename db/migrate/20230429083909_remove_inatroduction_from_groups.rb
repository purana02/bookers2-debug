class RemoveInatroductionFromGroups < ActiveRecord::Migration[6.1]
  def change
    remove_column :groups, :inatroduction, :text
  end
end
