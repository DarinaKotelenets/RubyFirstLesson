require 'selenium-webdriver'
require 'test/unit'
require_relative 'my_methods.rb'
require_relative 'vars.rb'
class TEST_FIRST < Test::Unit::TestCase
  include MY_METHODS, VARS

  def setup
    @driver = Selenium::WebDriver.for :firefox
    @driver.get MAIN_PAGE
    @driver.manage.window.maximize
    @wait = Selenium::WebDriver::Wait.new(:timeout => 30)

  end

  def test_registration
    @wait.until {
      register(LOGIN, PASS, FIRST, LAST, MAIL, 'en')
      }
      actual_result = @driver.find_element(:xpath, ".//*[@id='loggedas']/a")
      assert_equal(LOGIN, actual_result.text)

    puts "New user was registed"
  end


  def test_log_in
    @wait.until {
      register(LOGIN, PASS, FIRST, LAST, MAIL, 'en')
      @driver.find_element(:class, 'logout').click
      log_in(PASS, LOGIN)
    }
    actual_name = @driver.find_element(:xpath, ".//*[@id='loggedas']/a")
    assert_equal(LOGIN, actual_name.text)

    puts "Registered user can login"
  end

  def test_log_out
    @wait.until {
      register(LOGIN, PASS, FIRST, LAST, MAIL, 'en')
      @driver.find_element(:class, 'logout').click
    }
      actual_button = @driver.find_element(:class, 'login')
      assert_true(actual_button.displayed?)

    puts "Registered user can logout"
  end

  def test_change_pass
    @wait.until {
      register(LOGIN, PASS, FIRST, LAST, MAIL, 'en')
      change_pass(PASS, NEWPASS)
    }
      message_actual = @driver.find_element(:id, 'flash_notice')
      message_expected = 'Password was successfully updated.'
      assert_equal(message_expected, message_actual.text)

    puts "Eegistered user can change pass"
  end


  def test_create_project
    @wait.until {
      register(LOGIN, PASS, FIRST, LAST, MAIL, 'en')
      create_new_project(PROJECT_NAME, PROJECT_ID)
    }
      actual_massage = @driver.find_element(:id, 'flash_notice').text
      expected_message = 'Successful creation.'
      assert_equal(actual_massage, expected_message)

    puts "New project was created"
  end


  def test_add_another_user_to_project

    register(LOGIN, PASS, FIRST, LAST, MAIL, 'en')
    create_new_project(PROJECT_NAME, PROJECT_ID)
    add_new_member
    number_of_users = @driver.find_elements(:xpath, ".//*[@class='name user']").size
    puts number_of_users
    assert_true(number_of_users==2)
    puts "Test Passed: The new member added"
  end


  def test_edit_user
    register(LOGIN, PASS, FIRST, LAST, MAIL, 'en')
    create_new_project(PROJECT_NAME, PROJECT_ID)
    add_new_member
    @driver.find_element(:xpath, ".//tr[@class = 'even member']//a[@class='icon icon-edit']").click
    #@driver.find_element(:xpath, ".//tr[@class ='even member' ]//input[@value='4']")
    cb = @wait.until {
      element = @driver.find_element(:xpath, ".//tr[@class ='even member' ]//input[@value='4']")
      element if element.displayed?
    }
    puts "Test Passed: Memder role added" if cb
    cb.click
    @driver.find_element(:xpath, ".//tr[@class ='even member' ]//input[@type = 'submit']").click
    roles = @driver.find_element(:xpath, ".//*[@class = 'even member']//*[@class = 'roles']/span").text
    assert_equal(roles, 'Developer, Reporter')
  end

  def test_edit_version
    register(LOGIN, PASS, FIRST, LAST, MAIL, 'en')
    create_new_project(PROJECT_NAME, PROJECT_ID)
    change_version(MAIN_PAGE, PROJECT_ID)

    message_actual = @driver.find_element(:id, 'flash_notice')
    message_expected = 'Successful creation.'
    assert_equal(message_expected, message_actual.text)
  end

  def test_created_issues
    register(LOGIN, PASS, FIRST, LAST, MAIL, 'en')
    create_new_project(PROJECT_NAME, PROJECT_ID)
    @driver.navigate.to MAIN_PAGE+'/projects/'+PROJECT_ID+'/issues/new'
    create_bug
    create_feature
    create_support
    @driver.find_element(:xpath, ".//*[@id='main-menu']//a[@class = 'issues']").click
    number_of_users = @driver.find_elements(:xpath, ".//*[@class='id']").size
    puts number_of_users
    assert_true(number_of_users==3)

  end

  #def teardown
    #@driver.quit
 # end

end