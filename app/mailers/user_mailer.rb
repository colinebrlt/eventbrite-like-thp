class UserMailer < ApplicationMailer
  default from: 'coline.brault@yopmail.com'
 
  def welcome_email(user)
    #on récupère l'instance user pour ensuite pouvoir la passer à la view en @user
    @user = user 

    #on définit une variable @url qu'on utilisera dans la view d’e-mail
    @url  = 'http://monsite.fr/login' 

    # c'est cet appel à mail() qui permet d'envoyer l’e-mail en définissant destinataire et sujet.
    mail(to: @user.email, subject: 'Bienvenue chez nous !') 
  end

  def attendance_email(event_admin, event)
    @event_admin = event_admin 
    @event = event

    @url  = 'http://monsite.fr/login' 

    mail(to: event_admin.email, subject: 'Inscription à un évènement') 
  end
end
