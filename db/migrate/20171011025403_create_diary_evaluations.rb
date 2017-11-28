class CreateDiaryEvaluations < ActiveRecord::Migration[5.1]
  def change
    create_table :diary_evaluations do |t|
      t.references :user, foreign_key: true
      t.references :diary, foreign_key: true

      t.timestamps
    end
  end
end
