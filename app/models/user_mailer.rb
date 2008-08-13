class UserMailer < ActionMailer::Base
  def signup_notification(user)
    setup_email(user)
    @subject    += 'Ative sua conta'
  
    @body[:url]  = "http://www.systeminds.com.br/activate/#{user.activation_code}"
  
  end
  
  def activation(user)
    setup_email(user)
    @subject    += 'Sua conta foi ativada!'
    @body[:url]  = "http://www.systeminds.com.br/"
  end
  
  protected
    def setup_email(user)
      @recipients  = "#{user.email}"
      @from        = "contato@qi64.com"
      @subject     = "[systeminds] "
      @sent_on     = Time.now
      @body[:user] = user
    end
end
