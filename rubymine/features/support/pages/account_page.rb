class AccountPage
  include PageObject

  page_url 'http://demo.redmine.org/my/account'
  element :user, xpath: ".//*[@id='loggedas']/a"


end