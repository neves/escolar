Factory.define :previsao do |p|
  p.escola {|p| p.association(:escola)}
  p.cliente {|p| p.association(:aluno)}
  p.cliente_type "Aluno"
  p.plano_conta {|p| p.association(:plano_conta)}
  p.pagar_receber "R"
  p.valor 100.00
  p.valor_pago 0
  p.parcela 1
  p.qtde_parcelas 12
  p.historico "Blablabla"
  p.vencimento(Date.today + 20.days)
end
