class Test < ActiveRecord::Migration
  def self.up
    create_table :tests do |t|
    end
  end

  def self.down
    drop_table :tests
  end
end
