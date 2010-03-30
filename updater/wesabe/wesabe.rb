require 'net/https'
require 'hpricot'
require 'yaml'

CERT_FILENAME = File.join File.dirname(__FILE__), 'cacert.pem'
CONFIG_FILENAME = File.join File.dirname(__FILE__), 'wesabe.yml'


class Wesabe
  attr_accessor :email, :password, :http
  
  def initialize
    creds_from_file CONFIG_FILENAME
    initialize_http    
  end
  
  def accounts
    doc = Hpricot.XML get_accounts_xml
    doc.search('//account').map do |account|
      {
        :id => account.at(:id).inner_text.to_i,
        :name => account.at(:name).inner_text,
        :balance => account.at('current-balance').inner_text.to_f
      }
    end
  end
  
  def creds_from_file(file)
    config = YAML.load_file file
    self.email = config[:credentials][:email]
    self.password = config[:credentials][:password]
  end
  
  def initialize_http
    unless File.exist?(CERT_FILENAME)
      puts "Downloading certificate..."
      cert = Net::HTTP.get('curl.haxx.se', '/ca/cacert.pem')
      File.open(CERT_FILENAME, "w") { |f| f << cert }
      puts "Certificate downloaded."
    end
    self.http = Net::HTTP.new("www.wesabe.com", 443)
    http.use_ssl = true
    http.verify_mode = OpenSSL::SSL::VERIFY_PEER
    http.ca_file = CERT_FILENAME
  end
  
  def trigger_updates
    http.start do |wesabe|
      request = Net::HTTP::Post.new('/user/login')
      request.set_form_data({'email' => email, 'password' => password})
      response = http.request(request)
  
      case response
      when Net::HTTPOK
        STDERR.puts "Bad email and password"
      when Net::HTTPRedirection
        puts "Logged in successfully"
        response.body
      else
        STDERR.puts "Unexpected response: #{response.inspect}"
        exit(-1)
      end
    end
  end
  
  def get_accounts_xml
    http.start do |wesabe|
      request = Net::HTTP::Get.new('/accounts.xml')
      request.basic_auth(email, password)
      response = http.request(request)
  
      case response
      when Net::HTTPFound
        STDERR.puts "Incorrect email or password."
        response.each_header do |key, value|
          STDERR.puts "#{key}: #{value}"
        end
        exit(-1)
      when Net::HTTPOK
        response.body
      else
        STDERR.puts "Unexpected response: #{response.inspect}"
        exit(-1)
      end
    end
  end
end
