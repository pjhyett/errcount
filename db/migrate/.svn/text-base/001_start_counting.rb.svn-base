class StartCounting < ActiveRecord::Migration
  def self.up
    create_table :sites do |t|
      t.column :url,  :string
      t.column :hits, :integer, :default => 0
    end
  end

  def self.down
    drop_table :sites
  end
end
