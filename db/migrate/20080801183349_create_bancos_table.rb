class CreateBancosTable < ActiveRecord::Migration
  def self.up
    create_table :bancos, :force => true do |t|
      t.string :banco, :null => false
    end

    registros = []
    open("bancos.txt").each_line { |line| registros << line.split('|').map(&:strip).reverse }
    Banco.import [:id, :banco], registros

    add_index :bancos, :banco, :unique => true
  end

  def self.down
    drop table :bancos
  end
end
