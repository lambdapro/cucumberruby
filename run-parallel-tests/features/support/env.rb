require 'yaml'
require 'rspec'
require 'selenium-cucumber'
require 'appium_lib'

TASK_ID = (ENV['TASK_ID'] || 0).to_i
CONFIG_NAME = ENV['CONFIG_NAME'] || 'parallel'

CONFIG = YAML.load(File.read(File.join(File.dirname(__FILE__), "../../config/#{CONFIG_NAME}.config.yml")))

caps = CONFIG['common_caps'].merge(CONFIG['browser_caps'][TASK_ID])

desired_caps = {
  caps: caps,
  appium_lib: {
    server_url: "https://#{CONFIG['server']}/wd/hub"
  }
}

begin
  $appium_driver = Appium::Driver.new(desired_caps, true)
  $driver = $appium_driver.start_driver
rescue Exception => e
  puts e.message
  Process.exit(0)
end

$wait = Selenium::WebDriver::Wait.new(:timeout => 30)
