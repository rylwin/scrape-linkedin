class AddNotesToPeople < ActiveRecord::Migration
  def self.up
    add_column :people, :notes, :text
  end

  def self.down
    remove_column :people, :notes
  end
end
