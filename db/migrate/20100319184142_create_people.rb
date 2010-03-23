class CreatePeople < ActiveRecord::Migration
  def self.up
    create_table :people do |t|
      t.string :first_name
      t.string :last_name
      t.string :profile_url
      t.integer :entrepreneur
      t.integer :consulting_firm
      t.string :school
      t.string :current_job
      t.text :past_jobs

      t.timestamps
    end
  end

  def self.down
    drop_table :people
  end
end
