Factory.sequence :subscricao_id do |m|
  m.to_i
end

Factory.sequence :aluno_email do |m|
  "aluno_#{m}@example.com.br"
end

Factory.define :aluno do |a|
  a.escola {|a| a.association(:escola)}
  a.profissao {|a| a.association(:profissao)}
  a.subscricao {|a| Factory.next(:subscricao_id)}
  a.email {|a| Factory.next(:aluno_email)}
  a.nome "Beltrano"
  a.cpf "111.444.777-35"
  a.rg "12.122.122-2"
  a.data_nasc Date.parse("01/01/1998")
  a.sexo "M"
  a.responsavel_nome "Fulano"
  a.responsavel_data_nasc Date.parse("10/10/1980")
  a.responsavel_cpf "111.444.777-35"
  a.responsavel_rg "10.100.100-0"
  a.telefone_residencial "12 12345678"
  a.telefone_celular "12 12345678"
  a.telefone_comercial "12 12345678"
end
