class ChangeBookCommntsToBookComments < ActiveRecord::Migration[6.1]
  def change
    rename_table :book_commnts, :book_comments
  end
end
