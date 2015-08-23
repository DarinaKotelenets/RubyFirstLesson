class StartPage
  include PageObject

  page_url 'http://demo.redmine.org/'

  button(:login, :class => 'login')
  link :register, class: 'register'


end