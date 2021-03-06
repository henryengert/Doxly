class CreateOrganizationUsers < ActiveRecord::Migration[5.0]
  def change
    create_table :organization_users do |t|
      t.integer  :organization_id
      t.integer  :user_id
      t.string   :user_type,      limit: 30
      t.boolean  :invitation_accepted
      t.string   :invitation_token

      t.timestamps null: false
    end
    add_index :organization_users, :organization_id
    add_index :organization_users, :user_id
    add_index :organization_users, :user_type
    add_index :organization_users, :invitation_accepted
  end
end
