require File.dirname(__FILE__) + '/../spec_helper'

describe Endereco do

  fixtures :alunos, :enderecos

  it "nao deve salvar um endereco se ele nao estiver associado a nenhum elemento enderecavel" do
    address = Endereco.new(:cep => '12122-122', :uf => 'SP', :cidade => 'foo', :bairro => 'bar', :numero => '12')
    address.save.should be_false
  end
  
  it "deve manter o mesmo id apos atualizado" do
    address = enderecos(:one)
    old_id = address.id
    address.update_attributes(:logradouro => 'bleble', :cidade => "Tangamandapio")
    address.id.should == old_id
  end
  
  it "nao deve ser salvo caso nao possua dados" do
    address = Endereco.new(:enderecavel_type => Aluno, :enderecavel_id => 1)
    address.save.should be_false
  end


#"quando excluir um aluno, levar junto os dois enderecos dele"

# Marcos:  e outro para verificar o bug que o cliente reclamou, ou seja, garantir que o endereço residencial seja separado do comercial.

#tipo, se eu cadastrar um aluno sem informar os dados de endereço, ele não deve criar um registro vazio de endereço.
#e se o aluno tiver um endereço e eu apagar os dados, ele deve excluir o endereço respectivo.
# eu:  esse eu entendi
#mas entao ele grava o aluno, mesmo sem endereco?
#endereco nao é obrigatorio
#?

#Marcos:  exato



end
