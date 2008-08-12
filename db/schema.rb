# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of Active Record to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20080508042039) do

  create_table "alunos", :force => true do |t|
    t.integer  "empresa_id", :limit => 11, :null => false
    t.string   "nome",                     :null => false
    t.integer  "subscricao", :limit => 11, :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "alunos", ["empresa_id", "subscricao"], :name => "index_alunos_on_empresa_id_and_subscricao", :unique => true
  add_index "alunos", ["subscricao"], :name => "index_alunos_on_subscricao"

  create_table "aulas", :force => true do |t|
    t.integer  "turma_id",   :limit => 11, :null => false
    t.integer  "aluno_id",   :limit => 11, :null => false
    t.string   "status"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "aulas", ["turma_id", "aluno_id"], :name => "index_aulas_on_turma_id_and_aluno_id", :unique => true
  add_index "aulas", ["status"], :name => "index_aulas_on_status"

  create_table "disciplinas", :force => true do |t|
    t.integer  "material_id", :limit => 11
    t.string   "nome"
    t.string   "apelido"
    t.integer  "duracao",     :limit => 11, :default => 1,     :null => false
    t.integer  "lotacao",     :limit => 11, :default => 1,     :null => false
    t.boolean  "fixa",                      :default => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "disciplinas", ["apelido"], :name => "index_disciplinas_on_apelido", :unique => true
  add_index "disciplinas", ["nome"], :name => "index_disciplinas_on_nome", :unique => true
  add_index "disciplinas", ["duracao"], :name => "index_disciplinas_on_duracao"
  add_index "disciplinas", ["lotacao"], :name => "index_disciplinas_on_lotacao"
  add_index "disciplinas", ["fixa"], :name => "index_disciplinas_on_fixa"

  create_table "disponibilidades", :force => true do |t|
    t.integer  "professor_id",  :limit => 11
    t.integer  "horario_id",    :limit => 11
    t.integer  "disciplina_id", :limit => 11
    t.boolean  "ocupada",                     :default => false, :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "disponibilidades", ["professor_id", "horario_id"], :name => "index_disponibilidades_on_professor_id_and_horario_id", :unique => true
  add_index "disponibilidades", ["disciplina_id"], :name => "index_disponibilidades_on_disciplina_id"
  add_index "disponibilidades", ["horario_id"], :name => "index_disponibilidades_on_horario_id"
  add_index "disponibilidades", ["ocupada"], :name => "index_disponibilidades_on_ocupada"

  create_table "empresas", :force => true do |t|
    t.string   "nome",                                      :null => false
    t.string   "fuso"
    t.decimal  "preco_kit",  :precision => 14, :scale => 2, :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "feiras", :force => true do |t|
    t.string   "feira",      :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "habilitacoes", :id => false, :force => true do |t|
    t.integer  "disciplina_id", :limit => 11, :null => false
    t.integer  "professor_id",  :limit => 11, :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "habilitacoes", ["professor_id", "disciplina_id"], :name => "index_habilitacoes_on_professor_id_and_disciplina_id", :unique => true
  add_index "habilitacoes", ["disciplina_id"], :name => "index_habilitacoes_on_disciplina_id"

  create_table "horarios", :force => true do |t|
    t.integer  "hora",       :limit => 11
    t.integer  "semana",     :limit => 11
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
    t.decimal  "preco",      :precision => 7, :scale => 2, :default => 0.0, :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "professores", :force => true do |t|
    t.integer  "empresa_id", :limit => 11
    t.string   "nome"
    t.string   "apelido"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "professores", ["apelido", "empresa_id"], :name => "index_professores_on_apelido_and_empresa_id", :unique => true
  add_index "professores", ["empresa_id"], :name => "index_professores_on_empresa_id"

  create_table "turmas", :force => true do |t|
    t.integer  "professor_id",  :limit => 11, :null => false
    t.integer  "disciplina_id", :limit => 11, :null => false
    t.datetime "quando",                      :null => false
    t.date     "data",                        :null => false
    t.time     "time",                        :null => false
    t.integer  "hora",          :limit => 11, :null => false
    t.integer  "semana",        :limit => 11, :null => false
    t.integer  "horario_id",    :limit => 11, :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "turmas", ["professor_id", "quando"], :name => "index_turmas_on_professor_id_and_quando", :unique => true
  add_index "turmas", ["disciplina_id"], :name => "index_turmas_on_disciplina_id"

  create_table "users", :force => true do |t|
    t.string   "email"
    t.string   "crypted_password",          :limit => 40
    t.string   "salt",                      :limit => 40
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "remember_token"
    t.datetime "remember_token_expires_at"
    t.string   "activation_code",           :limit => 40
    t.datetime "activated_at"
    t.string   "state",                                   :default => "passive"
    t.datetime "deleted_at"
  end

end
