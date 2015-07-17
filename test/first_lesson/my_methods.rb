require 'selenium-webdriver'
require 'test/unit'

module MY_METHODS
  @driver = Selenium::WebDriver.for :firefox
  SUBJECT = rand(999).to_s

  def register(user_login, user_pass, user_firstname, user_lastname, user_mail, lang)
    @driver.find_element(:class, 'register').click
    @driver.find_element(:id, 'user_login').send_keys(user_login)
    @driver.find_element(:id, 'user_password').send_keys(user_pass)
    @driver.find_element(:id, 'user_password_confirmation').send_keys(user_pass)
    @driver.find_element(:id, 'user_firstname').send_keys(user_firstname)
    @driver.find_element(:id, 'user_lastname').send_keys(user_lastname)
    @driver.find_element(:id, 'user_mail').send_keys(user_mail)
    @driver.find_element(:id, 'user_language').find_element(:css,"option[value='"+lang+"']").click
    @driver.find_element(:xpath, ".//*[@id='new_user']/input[@type='submit']").click
  end

  def log_in(_pass, _login)
    @driver.find_element(:class, 'login').click
    @driver.find_element(:id, 'username').send_keys _login
    @driver.find_element(:id, 'password').send_keys _pass
    @driver.find_element(:xpath, ".//*[@id='login-form']//input[@type = 'submit']").click
  end
  def change_pass (pass, newpass)
    @driver.find_element(:class, 'my-account').click
    @driver.find_element(:xpath, ".//*[@id='content']//a[@href = '/my/password']").click
    @driver.find_element(:xpath, ".//div[@class = 'box']//input[@id='password']").send_keys pass
    @driver.find_element(:id, 'new_password').send_keys newpass
    @driver.find_element(:id, 'new_password_confirmation').send_keys newpass
    @driver.find_element(:xpath, ".//*[@id='content']//input[@type='submit']").click
  end


  def create_new_project(project_name, project_id)
    @driver.find_element(:class, 'projects').click
    @driver.find_element(:xpath, ".//*[@id='content']//a[@class='icon icon-add']").click
    @driver.find_element(:id, 'project_name').send_keys project_name
    @driver.find_element(:id, 'project_identifier').clear
    @driver.find_element(:id, 'project_identifier').send_keys project_id
    @driver.find_element(:xpath, ".//*[@id='new_project']//input[@name='commit']").click
  end

  def add_new_member

    @driver.find_element(:id, 'tab-members').click

    @driver.find_element(:xpath, ".//*[@id='tab-content-members']//a[@class = 'icon icon-add']").click

    @wait.until{
    !@driver.find_elements(:xpath, ".//*[@id='new_membership']//input[@value='5']").empty? }
    role = @driver.find_element(:xpath, ".//*[@id='new_membership']//input[@value='5']")
      if role.attribute('checked'=='true')
      @driver.find_element(:xpath, ".//*[@id='new_membership']//input[@value='5']").click
      end

    @wait.until{
      !user = @driver.find_elements(:xpath, ".//*[@id='principals']/label[1]/input[@type='checkbox']").empty? }
    user = @driver.find_element(:xpath, ".//*[@id='principals']/label[1]/input[@type='checkbox']")
    if user.attribute('checked'=='true')
      @driver.find_element(:xpath, ".//*[@id='principals']/label[1]/input[@type='checkbox']").click
    end

   @driver.find_element(:id, 'member-add-submit').click
  end


  def change_version (main_page, project_id)
  @driver.navigate.to main_page + '/projects/' + project_id + '/settings/versions'
  @driver.find_element(:xpath, ".//*[@id='tab-content-versions']//a[@class='icon icon-add']").click
  version = rand(999).to_s
  @driver.find_element(:id, 'version_name').send_key version
  @driver.find_element(:xpath, ".//*[@id='new_version']/input[@type = 'submit']").click
  end
  def create_bug
    @driver.find_element(:id, 'issue_tracker_id').find_element(:css, "option[value='1']").click
    @driver.find_element(:id, 'issue_subject').send_key 'bug_'+SUBJECT
    @driver.find_element(:xpath, ".//*[@id='issue-form']/input[@name = 'continue']").click

  end
  def create_feature
    @driver.find_element(:id, 'issue_tracker_id').find_element(:css, "option[value='2']").click
    @driver.find_element(:id, 'issue_subject').send_key 'feature_'+SUBJECT
    @driver.find_element(:xpath, ".//*[@id='issue-form']/input[@name = 'continue']").click

  end
  def create_support
    @driver.find_element(:id, 'issue_tracker_id').find_element(:css, "option[value='3']").click
    @driver.find_element(:id, 'issue_subject').send_key 'support_'+SUBJECT
    @driver.find_element(:xpath, ".//*[@id='issue-form']/input[@name = 'continue']").click

  end

end