class CreateMatriculas < ActiveRecord::Migration
  def self.up
    create_table :matriculas, :force => true do |t|
      t.references :user, :null => false
      t.references :escola, :null => false
      t.references :aluno, :null => false
      t.references :plano, :null => false
      t.references :curso, :null => false
      t.integer :numero_contrato, :null => false
      t.integer :dia_vcto_parcelas, :null => false
      t.date :data_inicio_parcelas, :null => false
      t.decimal :valor_parcelas, :null => false, :precision => 14, :scale => 2
      t.date :data_inicio_curso, :null => false
      t.decimal :valor_pri_parcela_matricula, :null => false, :precision => 14, :scale => 2
      t.date :data_pri_parcela_matricula, :null => false
      t.decimal :valor_seg_parcela_matricula, :precision => 14, :scale => 2
      t.date :data_seg_parcela_matricula

      t.timestamps
    end
  end

  def self.down
    drop_table :matriculas
  end
end
