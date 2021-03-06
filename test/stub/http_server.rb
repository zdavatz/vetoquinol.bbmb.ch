#!/usr/bin/env ruby
# Stub.http_server -- bbmb.ch -- 21.09.2006 -- hwyss@ywesee.com

require 'sbsm/request'
require 'sbsm/trans_handler'
require 'stub/persistence'
require 'webrick'

## compatibility-brainfuck for integrating Apache-SBSM-Requests with WEBrick

module BBMB
  module Stub
    class Notes < Hash
      alias :add :store 
    end
    class Output < String
      alias :write :<<
      alias :print :<<
    end
    class HTTPServer < WEBrick::HTTPServer
      attr_accessor :document_root
      def method_missing(method, *args, &block)
        @logger.warn "ignoring method: #{method}"
      end
    end
    def Stub.http_server(drburi, log_level=0)
      doc = File.expand_path('../../doc', File.dirname(__FILE__))
      logger = WEBrick::Log.new
      logger.level = log_level
      config = { :Host => 'localhost', :Port => 10080, 
        :DocumentRoot => doc, :Logger => logger }
      if(log_level == 0)
        config.store(:AccessLog, [])
      end
      server = HTTPServer.new(config)
      server.document_root = doc
      bbmb = Proc.new { |req, resp| 
        if(req.uri == '/favicon.ico')
          resp.body = File.open(File.join(doc, req.uri))
        else
          ARGV.push('')
          req.server = server
          req.uri = CGI.unescape(req.uri)
          SBSM::TransHandler.instance.translate_uri(req)
          ## not Threadsafe!
          SBSM::Apache.request = req
          output = Output.new
          sbsm = SBSM::Request.new(drburi)
          sbsm.meta_eval { define_method(:handle_exception) { |e| raise e } }
          sbsm.cgi.params.update(req.query)
          sbsm.cgi.env_table['SERVER_NAME'] = 
            BBMB.config.http_server.gsub('http://', '') + ':10080'
          sbsm.cgi.env_table['REQUEST_METHOD'] = req.request_method
          sbsm.cgi.cookies['_session_id'] = 'test:preset-session-id'
          sbsm.cgi.output = output
          sbsm.process
          if(/^location:/i.match(output))
            resp.status = 303
          end
          resp.rawdata = true
          resp.body = output
        end
      }
      server.mount_proc('/', &bbmb)
      server.mount_proc('/de', &bbmb)
      server.mount_proc('/de/.*', &bbmb)
      res = File.join(doc, 'resources')
      server.mount('/resources', WEBrick::HTTPServlet::FileHandler, res, {})
      server
    end
  end
end
module WEBrick
  class HTTPRequest
    attr_accessor :server, :uri, :notes
    alias :__old_initialize__ :initialize
    def initialize(*args)
      __old_initialize__(*args)
      @notes = BBMB::Stub::Notes.new
    end
    def headers_in
      headers = {}
      if(@header)
        @header.each { |key, vals| headers.store(key, vals.join(';')) }
      end
      headers
    end
    def uri
      @uri || unparsed_uri
    end
  end
  class HTTPResponse
    attr_accessor :rawdata
    alias :__old_send_header__ :send_header
    def send_header(socket)
      if(@rawdata)
        _write_data(socket, status_line)
      else
        __old_send_header__(socket)
      end
    end
    alias :__old_setup_header__ :setup_header
    def setup_header()
      unless(@rawdata)
        __old_setup_header__
      end
    end
  end
end
module SBSM
  class Request
    def handle_exception(e)
      raise e
    end
  end
  module Apache
    DECLINED = nil
    def Apache.request=(request)
      @request = request
    end
    def Apache.request
      @request
    end
  end
end
class CGI
  attr_accessor :output
  def stdoutput
    output
  end
  public :env_table
end
