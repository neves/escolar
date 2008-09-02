# =============================================================================
# Receita de Capistrano 2.x para hospedagem compartilhada Linux
# utilizando estratégia de cópia sem servidor de versionamento
# =============================================================================
# 
# Para que esta receita funcione realize os seguintes passos:
# 
# 1. copie o arquivo backup_locaweb.rb no diretorio 'config' de sua aplicacao
# 2. crie um arquivo 'config/database.locaweb.yml' configurando de acordo com
#    os dados de sua hospedagem (que você recebeu por e-mail com o título de
#    "Instrucoes - MySQL - Incluso"). Um exemplo seria assim: 
#    
#    production:
#      adapter: mysql
#      encoding: utf8
#      database: railsdemo
#      username: railsdemo
#      password: xxxxxxxxx
#      host: mysql1179.locaweb.com.br
#    
# 3. se você estiver utilizando subversion, git ou outro versionador, garanta
#    que os arquivos 'config/database.yml' e o 'config/database.locaweb.yml'
#    estão na lista de arquivos ignorados. Eh boa pratica nao mante-los num
#    repositorio
# 4. garanta que voce tem capistrano instalado executando 'sudo gem install
#    capistrano'
# 5. garanta que, a partir do diretorio do seu projeto, voce executou o comando
#    'capify .' para que o capistrano se configure corretamente no seu projeto
# 6. substitua o arquivo 'config/deploy.rb' gerado, por este arquivo que voce
#    baixou da Locaweb
# 7. altere o arquivo 'config/deploy.rb' conforme o exemplo abaixo:
# 
#    set :user, "railsdemo"                         
#    set :domain, "railsdemo.tecnologia.ws"         
#    set :application, "demo"                       
#    set :repository, "~/Sites/rails/demo"  
#    
#    Note que 'application' eh o nome do diretorio que voce configurou no
#    Painel de Controle da Locaweb, onde ele mostra /public_html/demo, por
#    exemplo.
# 
# 8. Feito isso digite 'cap deploy:setup'. Isso deve ser executado apenas uma vez
#    para que toda a configuracao necessaria seja feita na sua hospedagem
#    
# 9. Finalmente, para colocar sua aplicação em produção, apenas execute 
#    'cap deploy'. Se nada der errado, já deve estar tudo no ar.
#    
# 10. Se em algum momento, voce notar que a instalacao atual subiu com problemas
#    sempre podera voltar atras usando o comando 'cap deploy:rollback', garantindo
#    que problemas inesperados nao o deixem fora do ar.
#
# Autor: Fabio Akita
# E-mail: fabio.akita@locaweb.com.br
# Locaweb Serviços de Internet S/A 
# Todos os direitos reservados

# =============================================================================
# CONFIGURE OS VALORES DE ACORDO COM SUA HOSPEDAGEM
# =============================================================================
set :user, "rails"
set :domain, "rails.profissional.ws"
set :application, "escolar"

set :repository, "/mnt/win/escolar"



# =============================================================================
# NAO MEXER DAQUI PARA BAIXO
# =============================================================================
role :web, domain
role :app, domain
role :db,  domain

set :deploy_to, "/home/#{user}/rails_app/#{application}" 
set :public_html, "/home/#{user}/public_html"
set :site_path, "#{public_html}/#{application}"
set :runner, nil
set :use_sudo, false
set :no_release, true


set :scm, :none 
set :deploy_via, :copy 

set :copy_exclude, %w(.git/* .svn/* log/* tmp/* .gitignore)
set :keep_releases, 5

ssh_options[:username] = user
ssh_options[:paranoid] = false

env = "development"
# =============================================================================
# TAREFAS - NAO MEXER A MENOS QUE SAIBA O QUE ESTA FAZENDO
# =============================================================================
desc "Garante que o database.yml foi corretamente configurado"
task :before_symlink do
  on_rollback {}
  run "test -d #{release_path}/tmp || mkdir -m 755 #{release_path}/tmp"
  run "test -d #{release_path}/db || mkdir -m 755 #{release_path}/db"
  run "cp #{deploy_to}/etc/database.yml #{release_path}/config/database.yml"
  run "cd #{release_path} && rake db:migrate RAILS_ENV=#{env}"
end

desc "Garante que as configuracoes estao adequadas"
task :before_setup do
  ts = Time.now.strftime("%y%m%d%H%M%S")
  
  
  run "if [ -d #{deploy_to} ]; then mv #{deploy_to} #{deploy_to}-#{ts}.old ; fi"
  run "test -d #{deploy_to} || mkdir -m 755 #{deploy_to}"
  run "test -d #{deploy_to}/etc || mkdir -m 755 #{deploy_to}/etc"
  run "if [ -d #{site_path} ]; then mv #{site_path} #{site_path}-#{ts}.old ; fi"
  run "if [ -h #{site_path} ]; then mv #{site_path} #{site_path}-#{ts}.old ; fi"
  run "ln -s #{deploy_to}/current/public #{public_html}/#{application}"
  upload File.join(File.dirname(__FILE__), "database.locaweb.yml"), "#{deploy_to}/etc/database.yml"
  upload File.join(File.dirname(__FILE__), "locaweb_backup.rb"), "#{deploy_to}/etc/locaweb_backup.rb"
  upload File.join(File.dirname(__FILE__), "ssh_helper.rb"), "#{deploy_to}/etc/ssh_helper.rb"
  
  
end

desc "Prepare the production database before migration"
task :before_cold do
end

namespace :deploy do
  desc "Pede restart ao servidor Passenger"
  task :restart, :roles => :app do
    run "touch #{deploy_to}/current/tmp/restart.txt"
  end
end

[:start, :stop].each do |t|
    desc "A tarefa #{t} nao eh necessaria num ambiente com Passenger"
    task t, :roles => :app do ; end
end

namespace :log do
  desc "tail production log files" 
  task :tail, :roles => :app do
    run "tail -f #{shared_path}/log/production.log" do |channel, stream, data|
      puts  # para uma linha extra 
      puts "#{channel[:host]}: #{data}" 
      break if stream == :err    
    end
  end
end

namespace :db do
  desc "Faz o backup remoto e download do banco de dados MySQL"
  task :backup, :roles => :db do
    backup_rb ||= "#{deploy_to}/etc/locaweb_backup.rb"
    run "if [ -f #{backup_rb} ]; then ruby #{backup_rb} backup #{deploy_to} ; fi"
    get "#{deploy_to}/etc/dump.tar.gz", "dump.tar.gz"
    run "rm #{deploy_to}/etc/dump.tar.gz"
  end
  
  desc "Faz o upload e o restore remoto do banco de dados MySQL"
  task :restore, :roles => :db do
    unless File.exists?("dump.tar.gz")
      puts "Backup dump.tar.gz nao encontrado"
      exit 0
    end
    backup_rb ||= "#{deploy_to}/etc/locaweb_backup.rb"
    upload "dump.tar.gz", "#{deploy_to}/etc/dump.tar.gz"
    run "if [ -f #{backup_rb} ]; then ruby #{backup_rb} restore #{deploy_to} ; fi"
  end
  
  desc "Apaga todas as tabelas do banco de dados [CUIDADO! OPERACAO SEM VOLTA!]"
  task :drop_all, :roles => :db do
    backup_rb ||= "#{deploy_to}/etc/locaweb_backup.rb"
    run "if [ -f #{backup_rb} ]; then ruby #{backup_rb} drop_all #{deploy_to} ; fi"
  end
end

namespace :ssh do
  desc "Faz upload da sua chave publica"
  task :upload_key, :roles => :app do
    public_key_path = File.expand_path("~/.ssh/id_rsa.pub")
    unless File.exists?(public_key_path)
      puts %{
        Chave publica nao encontrada em #{public_key_path}
        Crie sua chave - sem passphrase - com o comando:
          ssh_keygen -t rsa
      }
      exit 0
    end
    ssh_path = "/home/#{user}/.ssh"
    run "test -d #{ssh_path} || mkdir -m 755 #{ssh_path}"
    upload public_key_path, "#{ssh_path}/../id_rsa.pub"
    run "test -f #{ssh_path}/authorized_keys || touch #{ssh_path}/authorized_keys"
    run "cat #{ssh_path}/../id_rsa.pub >> #{ssh_path}/authorized_keys"
    run "chmod 755 #{ssh_path}/authorized_keys"
  end
end
