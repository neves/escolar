# This controller handles the login/logout function of the site.  
class SessionsController < ApplicationController
  layout nil
  skip_before_filter :login_required

  # render new.rhtml
  def new
    @escolas = Escola.all(:order => 'nome')
  end

  def create
    self.current_user = User.authenticate(params[:login], params[:password])
    if logged_in?
      if params[:remember_me] == "1"
        current_user.remember_me unless current_user.remember_token?
        cookies[:auth_token] = { :value => self.current_user.remember_token , :expires => self.current_user.remember_token_expires_at }
      end
      session[:empresa] = params[:empresa_id]
      redirect_to '/'
      flash[:notice] = "Usuário Logado!"
    else
      flash[:notice] = "Usuário ou Senha inválidos!"
      redirect_to '/login'
    end
  end

  def destroy
    self.current_user.forget_me if logged_in?
    cookies.delete :auth_token
    reset_session
    flash[:notice] = "Você foi deslogado!"
    redirect_back_or_default('/')
  end
end
