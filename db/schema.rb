# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of ActiveRecord to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 0) do

  create_table "disciplinas", :force => true do |t|
    t.string  "type",        :default => "Disciplina", :null => false
    t.string  "nome",        :default => "Disciplina", :null => false
    t.string  "apelido",     :default => "Disciplina", :null => false
    t.integer "curso_id"
    t.integer "material_id"
    t.integer "duracao",     :default => 1,            :null => false
    t.integer "lotacao",     :default => 1,            :null => false
  end

  add_index "disciplinas", ["lotacao"], :name => "index_disciplinas_on_lotacao"
  add_index "disciplinas", ["duracao"], :name => "index_disciplinas_on_duracao"
  add_index "disciplinas", ["material_id"], :name => "index_disciplinas_on_material_id"
  add_index "disciplinas", ["curso_id"], :name => "index_disciplinas_on_curso_id"
  add_index "disciplinas", ["type"], :name => "index_disciplinas_on_type"

  create_table "disponibilidades", :force => true do |t|
    t.integer "agendavel_id"
    t.string  "agendavel_type"
    t.string  "type",           :default => "@base.table_name.capitalize", :null => false
    t.integer "habilitacao_id"
    t.integer "horario_id"
  end

  add_index "disponibilidades", ["horario_id", "agendavel_id", "agendavel_type"], :name => "index_disponibilidades_on_horario_id_and_agendavel_id_and_agendavel_type", :unique => true
  add_index "disponibilidades", ["habilitacao_id", "agendavel_id"], :name => "index_disponibilidades_on_habilitacao_id_and_agendavel_id", :unique => true
  add_index "disponibilidades", ["type"], :name => "index_disponibilidades_on_type"
  add_index "disponibilidades", ["agendavel_type"], :name => "index_disponibilidades_on_agendavel_type"
  add_index "disponibilidades", ["agendavel_id"], :name => "index_disponibilidades_on_agendavel_id"

  create_table "feiras", :force => true do |t|
    t.string "feira", :null => false
  end

  create_table "habilitacoes", :force => true do |t|
    t.integer "disciplina_id"
    t.integer "professor_id"
  end

  add_index "habilitacoes", ["professor_id", "disciplina_id"], :name => "index_habilitacoes_on_professor_id_and_disciplina_id", :unique => true
  add_index "habilitacoes", ["disciplina_id"], :name => "index_habilitacoes_on_disciplina_id"

  create_table "horarios", :force => true do |t|
    t.integer "hora"
    t.integer "semana"
  end

  add_index "horarios", ["semana", "hora"], :name => "index_horarios_on_semana_and_hora", :unique => true
  add_index "horarios", ["hora"], :name => "index_horarios_on_hora"

  create_table "horas", :force => true do |t|
    t.integer "hora", :null => false
  end

  add_index "horas", ["hora"], :name => "index_horas_on_hora", :unique => true

  create_table "professores", :force => true do |t|
    t.string "nome", :default => "Nome do Professor", :null => false
  end

end
