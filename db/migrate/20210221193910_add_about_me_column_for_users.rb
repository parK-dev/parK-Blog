# frozen_string_literal: true

class AddAboutMeColumnForUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :about, :text
  end
end
