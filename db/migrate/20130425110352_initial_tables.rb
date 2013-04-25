class InitialTables < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.string :title, :null => false 
      t.text :body, :null => false
      t.timestamps
    end

    create_table :tags do |t|
      t.string :name, :null => false
    end

    create_table :post_tags do |t|
      t.integer :post_id
      t.integer :tag_id
    end
  end
end
