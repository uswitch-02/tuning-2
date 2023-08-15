class AddLockableToDevise < ActiveRecord::Migration[6.1]
    add_column :customers, :failed_attempts, :integer, default: 0, null: false # Only if lock strategy is :failed_attempts
    add_column :customers, :unlock_token, :string # Only if unlock strategy is :email or :both
    add_column :customers, :locked_at, :datetime
    add_index :customers, :unlock_token, unique: true

  def change
  end
end
