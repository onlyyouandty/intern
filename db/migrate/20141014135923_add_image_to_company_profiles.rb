class AddImageToCompanyProfiles < ActiveRecord::Migration
  def change
    add_column :company_profiles, :image, :string
  end
end
