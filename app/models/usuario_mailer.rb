class UsuarioMailer < ActionMailer::Base
  def signup_notification(usuario)
    setup_email(usuario)
    @subject    += 'Please activate your new account'
  
    @body[:url]  = "http://YOURSITE/activate/#{usuario.activation_code}"
  
  end
  
  def activation(usuario)
    setup_email(usuario)
    @subject    += 'Your account has been activated!'
    @body[:url]  = "http://YOURSITE/"
  end
  
  protected
    def setup_email(usuario)
      @recipients  = "#{usuario.email}"
      @from        = "ADMINEMAIL"
      @subject     = "[YOURSITE] "
      @sent_on     = Time.now
      @body[:usuario] = usuario
    end
end
