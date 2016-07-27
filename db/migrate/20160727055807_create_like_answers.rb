class CreateLikeAnswers < ActiveRecord::Migration[5.0]
  def change
    create_table :like_answers do |t|
      t.integer :friendship_id, index: true
      t.integer :answer_id, index: true

      t.timestamps
    end
  end
end
