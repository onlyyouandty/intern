class CreateCompanyProfiles < ActiveRecord::Migration
  def change
    create_table :company_profiles do |t|
      t.string :user_id
      t.string :company_name
      t.string :email
      t.text :description
      t.string :qsort
      t.string :company_type
      t.integer :number_of_employees
      t.string :website
      t.string :location
      t.string :tax_code
      t.boolean :verified

      t.timestamps
    end
  end
end
