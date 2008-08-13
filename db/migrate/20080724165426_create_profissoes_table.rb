class CreateProfissoesTable < ActiveRecord::Migration
  def self.up
    create_table :profissoes, :force => true do |t|
      t.string :profissao
    end

    profissoes = []
    open("profissoes.txt").each_line { |line| profissoes << [line.strip]  }
    Profissao.import [:profissao], profissoes

    add_index :profissoes, :profissao, :unique => true
  end

  def self.down
    drop_table :profissoes
  end
end
