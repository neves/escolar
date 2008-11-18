Factory.sequence :plano_conta_nome do |m|
  "Plano conta #{m}"
end
Factory.define :plano_conta, :class => PlanoConta do |p|
  p.nome {Factory.next(:plano_conta_nome)}
end
