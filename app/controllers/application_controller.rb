require 'socket'

class ApplicationController < ActionController::API
  include Response
  include ExceptionHandler

  def createLog content, item, category='report'
    apikey = ENV['HOSTEDGRAPHITE_APIKEY']
    conn = TCPSocket.new '4d70dd2a.carbon.hostedgraphite.com', 2003
    conn.puts apikey + ".#{category}.#{item} #{content}\n"
    conn.close
    puts apikey + ".#{category}.#{item} #{content}"
  end

end
