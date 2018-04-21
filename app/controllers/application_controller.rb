require 'socket'

class ApplicationController < ActionController::API
  include Response
  include ExceptionHandler

  def createLog content, item, category='report'
    #apikey = ENV['HOSTEDGRAPHITE_APIKEY']
    #conn = TCPSocket.new 'carbon.hostedgraphite.com', 2003
    #conn.puts apikey + ".#{category}.#{item} #{content}\n"
    #conn.close
    puts "804e6ce0-6659-431e-acf0-b75f6e650fa8.test.testing 1.2\n"
    conn = TCPSocket.new '0168403f.carbon.hostedgraphite.com', 2003
    conn.puts "804e6ce0-6659-431e-acf0-b75f6e650fa8.test.testing 1.2\n"
    conn.close
    #puts apikey + ".#{category}.#{item} #{content}"
  end

end
