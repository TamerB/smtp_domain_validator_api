class CreateValidationRequests < ActiveRecord::Migration[5.2]
  def change
    create_table :validation_requests do |t|

      t.timestamps
    end
  end
end
