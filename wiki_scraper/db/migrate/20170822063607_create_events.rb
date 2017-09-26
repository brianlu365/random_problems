class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.string :img_url
      t.string :page_url
      t.text :title
      t.text :description
      t.date :event_date
      t.string :job_id
      t.timestamp
    end
  end
end
