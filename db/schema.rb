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

  create_table "alunos", :force => true do |t|
    t.integer  "empresa_id",                 :null => false
    t.string   "nome",       :default => "", :null => false
    t.integer  "subscricao",                 :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "alunos", ["empresa_id", "subscricao"], :name => "index_alunos_on_empresa_id_and_subscricao", :unique => true
  add_index "alunos", ["subscricao"], :name => "index_alunos_on_subscricao"

  create_table "disciplinas", :force => true do |t|
    t.integer  "material_id"
    t.string   "nome"
    t.string   "apelido"
    t.integer  "duracao",     :default => 1,     :null => false
    t.integer  "lotacao",     :default => 1,     :null => false
    t.boolean  "fixa",        :default => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "disciplinas", ["apelido"], :name => "index_disciplinas_on_apelido", :unique => true
  add_index "disciplinas", ["nome"], :name => "index_disciplinas_on_nome", :unique => true
  add_index "disciplinas", ["duracao"], :name => "index_disciplinas_on_duracao"
  add_index "disciplinas", ["lotacao"], :name => "index_disciplinas_on_lotacao"
  add_index "disciplinas", ["fixa"], :name => "index_disciplinas_on_fixa"

  create_table "disponibilidades", :force => true do |t|
    t.integer  "professor_id"
    t.integer  "horario_id"
    t.integer  "disciplina_id"
    t.boolean  "ocupada",       :default => false, :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "disponibilidades", ["professor_id", "horario_id"], :name => "index_disponibilidades_on_professor_id_and_horario_id", :unique => true
  add_index "disponibilidades", ["disciplina_id"], :name => "index_disponibilidades_on_disciplina_id"
  add_index "disponibilidades", ["horario_id"], :name => "index_disponibilidades_on_horario_id"
  add_index "disponibilidades", ["ocupada"], :name => "index_disponibilidades_on_ocupada"

  create_table "empresas", :force => true do |t|
    t.string   "nome",       :default => "", :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "feiras", :force => true do |t|
    t.string   "feira",      :default => "", :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "habilitacoes", :id => false, :force => true do |t|
    t.integer  "disciplina_id", :null => false
    t.integer  "professor_id",  :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "habilitacoes", ["professor_id", "disciplina_id"], :name => "index_habilitacoes_on_professor_id_and_disciplina_id", :unique => true
  add_index "habilitacoes", ["disciplina_id"], :name => "index_habilitacoes_on_disciplina_id"

  create_table "horarios", :force => true do |t|
    t.integer  "hora"
    t.integer  "semana"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "horarios", ["semana", "hora"], :name => "index_horarios_on_semana_and_hora", :unique => true
  add_index "horarios", ["hora"], :name => "index_horarios_on_hora"

  create_table "horas", :primary_key => "hora", :force => true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "horas", ["hora"], :name => "index_horas_on_hora", :unique => true

  create_table "materiais", :force => true do |t|
    t.string   "nome"
    t.integer  "preco",      :limit => 2, :precision => 2, :scale => 0, :default => 0, :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "professores", :force => true do |t|
    t.integer  "empresa_id"
    t.string   "nome"
    t.string   "apelido"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "professores", ["apelido", "empresa_id"], :name => "index_professores_on_apelido_and_empresa_id", :unique => true
  add_index "professores", ["empresa_id"], :name => "index_professores_on_empresa_id"

end
