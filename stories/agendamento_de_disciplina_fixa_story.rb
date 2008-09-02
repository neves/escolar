require File.join(File.dirname(__FILE__), *%w[helper])

Story "Agendamento de Disciplina Fixa", "Não sei o que escrever aqui", :type => RailsStory do
	Scenario "Primeiro Agendamento" do

			 Given "um professor" do
				@professor = Professor.create(:nome => 'Neves')   
			 end
			 And "uma disciplina fixa" do
				 @disciplina = DisciplinaFixa.create(:nome => 'Laboratorio', :apelido => 'lab')
			 end

			 When "I choose to save" do
				 #@user.save
			 end

			 Then "the record should not be new" do
				 #@user.new_record?.should == false
			 end
	end
end
