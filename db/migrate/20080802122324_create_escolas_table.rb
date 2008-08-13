class CreateEscolasTable < ActiveRecord::Migration
  def self.up
    create_table :escolas, :force => true do |t|
      t.string :nome, :null => false
      t.integer :fuso, :null => false, :default => -3
      t.decimal :preco_kit, :null => false, :precision => 14, :scale => 2
      t.timestamps
    end

    registros = []
    open("escolas.txt").each_line { |line| registros << line.split('|').map(&:strip) }
    Escola.import [:nome, :fuso, :preco_kit], registros
  end

  def self.down
    drop_table :escolas
  end
end
