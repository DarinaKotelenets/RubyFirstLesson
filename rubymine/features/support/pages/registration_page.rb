class RegistrationPage
  include PageObject
  include DataMagic
  page_url = 'http://demo.redmine.org/account/register'

  r = rand(999).to_s
  NAME = 'tester' + r

  DEFAULT_DATA = {
      'login' => NAME,
      'password' => NAME,
      'password_conf' => NAME,
      'firstname' => NAME,
      'lastname' => NAME,
      'mail' => NAME+'@i.ua',
      'language' => 'en'
  }

  button(:registration, :class => 'register')
  text_field(:login, :id => 'user_login')
  text_field(:password, :id => 'user_password')
  text_field(:password_conf, :id => 'user_password_confirmation')
  text_field(:firstname, :id => 'user_firstname')
  text_field(:lastname, :id => 'user_lastname')
  text_field(:mail, :id => 'user_mail')
  select_list(:language, :id => 'user_language')
  button(:submit, :name => 'commit')

end

public def complete_order(data = {})
  data = DEFAULT_DATA.merge(data)
  self.login = data['login']
  self.password = data['password']
  self.password_conf = data['password_conf']
  self.firstname = data['firstname']
  self.lastname = data['lastname']
  self.mail = data['mail']
  self.language = data['language']
  submit
end