class CreateCursos < ActiveRecord::Migration
  def self.up
    create_table :cursos, :force => true do |t|
      t.string :nome

      t.timestamps
    end
    Curso.create! :nome => "Inglês"
  end

  def self.down
    drop_table :cursos
  end
end
