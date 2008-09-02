document.observe("dom:loaded", function(){
	$('matricula_plano_id').observe("change", function(e){
		var id = this.getValue()
		if (id == "") return
		var tpl = new Template('/planos/#{id}/#{action}')
		var url = tpl.evaluate({id:id, action:"valor_matricula"})
		new Ajax.Updater("valor_matricula", url, {method: 'get'})

		url = tpl.evaluate({id:id, action:"valor_mensalidade"})
		new Ajax.Updater("valor_mensalidade", url, {method: 'get'})
	})

	if ( $('matricula_valor_seg_parcela_matricula').getValue() == "" )
		$('parcelamento').hide()

	$('parcelar').observe("click", function(e){
		$('parcelamento').toggle()
	})
})