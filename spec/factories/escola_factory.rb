Factory.sequence :escola_nome do |m|
  "Escola #{m}"
end
Factory.define :escola do |e|
  e.nome {|e| Factory.next(:escola_nome)}
  e.preco_kit 100.00
end
