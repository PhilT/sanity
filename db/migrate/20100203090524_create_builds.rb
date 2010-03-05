class CreateBuilds < ActiveRecord::Migration
  def self.up
    create_table :builds do |t|
      t.string :commit_hash
      t.datetime :committed_at
      t.text :commit_message
      t.text :changed_files
      t.string :author
      t.text :output
      t.integer :project_id
      t.datetime :completed_at
      t.boolean :success
      t.string :branch

      t.timestamps
    end
  end

  def self.down
    drop_table :builds
  end
end

