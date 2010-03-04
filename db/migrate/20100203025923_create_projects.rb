class CreateProjects < ActiveRecord::Migration
  def self.up
    create_table :projects do |t|
      t.string :name
      t.string :working_dir
      t.string :git
      t.string :excluded_branches

      t.timestamps
    end
  end

  def self.down
    drop_table :projects
  end
end

