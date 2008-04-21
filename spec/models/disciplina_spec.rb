require File.dirname(__FILE__) + '/../spec_helper'

=begin
Este teste está muito grande, como faço para dividí-lo em arquivos separados?
Como estes arquivos devem ser organizados?

Existe um cenário abaixo que possui a seguinte característica:
	Vamos pegar o exemplo da pilha:
		describe Pilha
			it "quando esta vazia"
				deve ter zero elementos
				... outras duzias de testes
			it "quando recebe 1 elemento"
				aqui quero chamar o cenário anterior para reaproveitar código, mas negando, ou seja"
				"quando recebe 1 elemento, não pode se comportar como uma pilha vazia"
			it "quando remover todos elementos"
				aqui quero chamar o scenario vazia, pois não quero repetir os testes
				Esta situação acontece no código abaixo.

Eu percebi que existem factorys de scenarios que gostaria de reaproveitar em outros testes,
por exemplo: factory.criar_1_professor_e_2_alunos
então sempre que quiser fazer um teste em um ambiente que eu tenha 1 professor e 2 alunos,
eu chamo este factory, mas em cada cenario, eu quero poder chamar este factory e alterar algo
para customizar.

Veja que utilizei bastante describe dentro de describe. Seria melhor ter utilizado stories?

Também testei na Disciplina, coisas relacionadas ao Professor e a Disponibilidade,
como organizar isso em arquivos diferentes?

Eu reparei que quando alterava alguns models, tinha que fazer touch neste arquivo para o autotest
rodar novamente. O que fiz de errado para ele não reconhecer automaticamente a alteração?

Que outro plugin vc utiliza:
http://blog.jayfields.com/2008/03/ruby-expectations-gem-version-023.html
http://chneukirchen.org/repos/bacon/
http://thoughtbot.com/projects/shoulda
outros...

Em algum lugar abaixo, conseguiria utilizar mock, para não precisar ir ao banco?
Pode me dar um exemplo, utilizando o sistema abaixo se possível, de como utilizar mock e stub?
Estas duas técnicas ainda estão confusas pra mim. A teoria eu compreendi.

Como você faz testes para na verdade tirar uma dúvida quanto ao funcionamento do Rails?
Por exemplo, se eu tenho um Post e um Comentario instanciado
e estou na dúvida se o Rails implementa Unit of Work, para garantir que o mesmo comentario que tenho
em um objeto, é o mesmo que está relacionado ao Post, como organizo testes desta categoria?

Todos meus testes estão passando. como rodar um relatório das espectativas,
como se fosse uma documentação do comportamento do código.
Acredito que esta prática deve ser muito utilizada,
até mesmo para mostrar ao cliente, pois estará na língua dele (regras de negócio)

Os dois únicos controllers desta aplicação, estão sem testes.
Vc pode me dar um exemplo de o que devo testar num controller? Uma dificuldade que acho que todos
tem quando estão começando com testes, é saber o que testar.

em app/helpers/grid_table.rb tem um helper que fiz para me auxiliar à gerar um tipo de tabela muito
utilizada neste meu projeto. Como faço teste de coisas que geram html
e que precisam ter acesso a engine de template, etc? Não acho certo comparar string retornada,
pois se eu modificar um simples \n ou \t, já tenho que modificar o teste.

Falando nisso, como é o workflow diário de modificar código que exijam mudanças nos testes,
desde uma simples alteração de o nome de um metodo, até a alteração de uma expectativa do cliente?
=end

def zerado
  it "deve ter professores habilitados" do
    @disciplina.professores(true).should_not be_empty
  end

  it "não deve ter nenhuma reserva" do
    @disciplina.disponibilidades.count.should == 0
  end

  it "não deve ter reservas agrupada por horario" do
    @disciplina.reservas_agrupadas_por_horario.should be_empty
  end

  it "deve existir professores disponiveis" do
    @professor.disponibilidades(true).count.should == 2
  end

  it "deve existir professor sem horarios reservados" do
    @professor.disponibilidades.reservadas.count.should == 0
  end

  it "deve exisitr professor com todos horarios livres" do
    @professor.disponibilidades.livres.count.should == 2
  end
end

describe Disciplina do
  before(:each) do
    # cria um professor e habilita para a disciplina criada.
    @disciplina = Disciplina.create :fixa => true, :nome => 'Laboratório', :apelido => 'lab'
    @professor = Professor.create :apelido => 'Neves'
    h = Horario.new
    h.id = 108
    h.save
    h = Horario.new
    h.id = 614
    h.save
    @professor.horario_ids = [108, 614]
    @professor.disciplinas << @disciplina
  end

  zerado

  #-----------------------------------------------------------------------------

  describe "[ao agendar]" do
    before(:each) do
      @professor_nao_habilitado = Professor.create :apelido => 'Estagiário'
      @professor_habilitado_mas_ocupado = Professor.create :apelido => 'Habilitado mas Ocupado'
      @professor_habilitado_mas_ocupado.disciplinas << @disciplina
      @professor_habilitado_mas_ocupado.horario_ids = [108, 614]
      @outra_disciplina = Disciplina.create :fixa => true, :nome => 'Outra', :apelido => 'other'
      @professor_habilitado_mas_ocupado.disponibilidades.first.disciplina = @outra_disciplina
      @professor_habilitado_mas_ocupado.disponibilidades.first.save
      @disciplina.disponibilidades << @professor.disponibilidades.first
    end

    #-------------------------------------------------------------------------------  

    describe "o outro professor habilitado mas ocupado" do
      before(:each) do
        @free = @professor_habilitado_mas_ocupado.disponibilidades(true).livres
        @lock = @professor_habilitado_mas_ocupado.disponibilidades(true).reservadas
      end

      it "deve ainda ter disponibilidade 2" do
        @professor_habilitado_mas_ocupado.disponibilidades(true).should have(2).items
      end

      it "deve ter 1 horario livre" do
        @free.should have(1).item
      end

      it "deve estar livre apenas sábado às 14:00" do
        @free.first.horario_id.should == 614
      end

      it "deve ter 1 horario reservado" do
        @lock.should have(1).items
      end

      it "deve estar ocupado apenas na segunda às 08:00" do
        @lock.first.horario_id.should == 108
      end
    end

    #---------------------------------------------------------------------------

    it "deve ter reservas" do
      @disciplina.disponibilidades(true).count.should == @professor.disponibilidades.count - 1
      @professor.disponibilidades(true).count.should == 2
      @disciplina.disponibilidades.first.should == @professor.disponibilidades.first
    end

    it "achar todos professores disponiveis por horario" do
      hash = Disponibilidade.agrupadas_por_horario_para_a_disciplina(@disciplina)
      hash.should have(2).items
			hash[614].class.should == Array
			hash[614].should have(2).items
			hash[108].should have(1).item
    end

    it "a disponibilidade do professor deve ter disciplina_id" do
      @professor.disponibilidades(true).first.disciplina = @disciplina
    end

    it "a disponibilidade do professor deve continuar 2" do
      @professor.disponibilidades(true).count.should == 2
    end

    it "a disponibilidade fixa do professor, deve ser 1" do
      @professor.disponibilidades(true).reservadas.count.should == 1
    end

    it "a disponibilidade normal do professor, deve ser 1" do
      @professor.disponibilidades(true).livres.count.should == 1
    end

    it "deve ter as reservas agrupada por horario" do
      hash = @disciplina.reservas_agrupadas_por_horario
      hash.should have(1).item
      hash.should have_key(108)
      hash.should_not have_key(614)
      hash[108].should be_an_instance_of(Disponibilidade)
    end

    #-------------------------------------------------------------------------------
  
    describe "[ao des-agendar]" do
      before(:each) do
        @disciplina.disponibilidades = []
      end

      zerado

    end
  end
end

