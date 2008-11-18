Factory.sequence :profissao_nome do |m|
  "Profissao #{m}"
end
Factory.define :profissao do |p|
  p.profissao {Factory.next(:profissao_nome)}
end
