class UsuarioObserver < ActiveRecord::Observer
  def after_create(usuario)
    UsuarioMailer.deliver_signup_notification(usuario)
  end

  def after_save(usuario)
  
    UsuarioMailer.deliver_activation(usuario) if usuario.recently_activated?
  
  end
end
