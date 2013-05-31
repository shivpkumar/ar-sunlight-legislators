require_relative '../config'

class CreateTables < ActiveRecord::Migration
  def change
    create_table :legislators do |t|
      t.integer :id
      t.string  :title
      t.string  :firstname
      t.string  :lastname
      t.string  :party
      t.string  :state
      t.string  :district
      t.integer :in_office
      t.string  :gender
      t.string  :phone
      t.string  :fax
      t.string  :website
      t.string  :twitter_id
      t.date    :birthdate
    end
  end
end
