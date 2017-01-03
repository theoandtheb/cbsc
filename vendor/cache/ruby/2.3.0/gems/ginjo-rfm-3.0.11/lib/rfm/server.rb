require 'net/https'
require 'cgi'

module Rfm
  # This class represents a single FileMaker server. It is initialized with basic
  # connection information, including the hostname, port number, and default database
  # account name and password.
  #
  # Note: The host and port number refer to the FileMaker Web Publishing Engine, which
  # must be installed and configured in order to use RFM. It may not actually be running
  # on the same server computer as FileMaker Server itself. See your FileMaker Server
  # or FileMaker Server Advanced documentation for information about configuring a Web
  # Publishing Engine.
  #
  # =Accessing Databases
  #
  # Typically, you access a Database object from the Server like this:
  #
  #   myDatabase = myServer["Customers"]
  # 
  # This code gets the Database object representing the Customers object.
  # 
  # Note: RFM does not talk to the server when you retrieve a database object in this way. Instead, it
  # simply assumes you know what you're talking about. If the database you specify does not exist, you 
  # will get no error at this point. Instead, you'll get an error when you use the Layout object you get
  # from this database. This makes debugging a little less convenient, but it would introduce too much
  # overhead to hit the server at this point.
  #
  # The Server object has a +db+ attribute that provides alternate access to Database objects. It acts
  # like a hash of Database objects, one for each accessible database on the server. So, for example, you
  # can do this if you want to print out a list of all databses on the server:
  # 
  #   myServer.db.each {|database|
  #     puts database.name
  #   }
  # 
  # The Server::db attribute is actually a DbFactory object, although it subclasses hash, so it should work
  # in all the ways you expect. Note, though, that it is completely empty until the first time you attempt 
  # to access its elements. At that (lazy) point, it hits FileMaker, loads in the list of databases, and
  # constructs a Database object for each one. In other words, it incurrs no overhead until you use it.
  #
  # =Attributes
  # 
  # In addition to the +db+ attribute, Server has a few other useful attributes:
  #
  # * *host_name* is the host name this server points to
  # * *port* is the port number this server communicates on
  # * *state* is a hash of all server options used to initialize this server



  # The Database object represents a single FileMaker Pro database. When you retrieve a Database
  # object from a server, its account name and password are set to the account name and password you 
  # used when initializing the Server object. You can override this of course:
  #
  #   myDatabase = myServer["Customers"]
  #   myDatabase.account_name = "foo"
  #   myDatabase.password = "bar"
  #
  # =Accessing Layouts
  #
  # All interaction with FileMaker happens through a Layout object. You can get a Layout object
  # from the Database object like this:
  #
  #   myLayout = myDatabase["Details"]
  #
  # This code gets the Layout object representing the layout called Details in the database.
  #
  # Note: RFM does not talk to the server when you retrieve a Layout object in this way. Instead, it
  # simply assumes you know what you're talking about. If the layout you specify does not exist, you 
  # will get no error at this point. Instead, you'll get an error when you use the Layout object methods
  # to talk to FileMaker. This makes debugging a little less convenient, but it would introduce too much
  # overhead to hit the server at this point.
  #
  # The Database object has a +layout+ attribute that provides alternate access to Layout objects. It acts
  # like a hash of Layout objects, one for each accessible layout in the database. So, for example, you
  # can do this if you want to print out a list of all layouts:
  # 
  #   myDatabase.layout.each {|layout|
  #     puts layout.name
  #   }
  # 
  # The Database::layout attribute is actually a LayoutFactory object, although it subclasses hash, so it
  # should work in all the ways you expect. Note, though, that it is completely empty until the first time
  # you attempt to access its elements. At that (lazy) point, it hits FileMaker, loads in the list of layouts,
  # and constructs a Layout object for each one. In other words, it incurrs no overhead until you use it.
  #
  # =Accessing Scripts
  #
  # If for some reason you need to enumerate the scripts in a database, you can do so:
  #  
  #   myDatabase.script.each {|script|
  #     puts script.name
  #   }
  # 
  # The Database::script attribute is actually a ScriptFactory object, although it subclasses hash, so it
  # should work in all the ways you expect. Note, though, that it is completely empty until the first time
  # you attempt to access its elements. At that (lazy) point, it hits FileMaker, loads in the list of scripts,
  # and constructs a Script object for each one. In other words, it incurrs no overhead until you use it. 
  #
  # Note: You don't need a Script object to _run_ a script (see the Layout object instead).
  #
  # =Attributes
  # 
  # In addition to the +layout+ attribute, Server has a few other useful attributes:
  #
  # * *server* is the Server object this database comes from
  # * *name* is the name of this database
  # * *state* is a hash of all server options used to initialize this server
  class Server
    include Config


    # To create a Server object, you typically need at least a host name:
    # 
    #   myServer = Rfm::Server.new({:host => 'my.host.com'})
    #
    # ===Several other options are supported
    # 
    # * *host* the hostname of the Web Publishing Engine (WPE) server (defaults to 'localhost')
    #
    # * *port* the port number the WPE is listening no (defaults to 80 unless *ssl* +true+ which sets it to 443)
    #
    # * *account_name* the default account name to log in to databases with (you can also supply a
    #   account name on a per-database basis if necessary)
    #
    # * *password* the default password to log in to databases with (you can also supplly a password
    #   on a per-databases basis if necessary)
    #
    # * *log_actions* when +true+, RFM logs all action URLs that are sent to FileMaker server to stderr
    #   (defaults to +false+)
    #
    # * *log_responses* when +true+, RFM logs all raw XML responses (including headers) from FileMaker to
    #   stderr (defaults to +false+)
    #
    # * *warn_on_redirect* normally, RFM prints a warning to stderr if the Web Publishing Engine redirects
    #   (this can usually be fixed by using a different host name, which speeds things up); if you *don't*
    #   want this warning printed, set +warn_on_redirect+ to +true+
    #
    # * *raise_on_401* although RFM raises error when FileMaker returns error responses, it typically
    #   ignores FileMaker's 401 error (no records found) and returns an empty record set instead; if you
    #   prefer a raised error when a find produces no errors, set this option to +true+
    #
    # ===SSL Options (SSL AND CERTIFICATE VERIFICATION ARE ON BY DEFAULT)
    # 
    # * *ssl* +false+ if you want to turn SSL (HTTPS) off when connecting to connect to FileMaker (default is +true+)
    #
    # If you are using SSL and want to verify the certificate, use the following options:
    #
    # * *root_cert* +true+ is the default. If you do not want to verify your SSL session, set this to +false+. 
    #   You will want to turn this off if you are using a self signed certificate and do not have a certificate authority cert file.
    #   If you choose this option you will need to provide a cert *root_cert_name* and *root_cert_path* (if not in root directory).
    #
    # * *root_cert_name* name of pem file for certificate verification (Root cert from certificate authority who issued certificate.
    #   If self signed certificate do not use this option!!). You can download the entire bundle of CA Root Certificates
    #   from http://curl.haxx.se/ca/cacert.pem. Place the pem file in config directory.
    #
    # * *root_cert_path* path to cert file. (defaults to '/' if no path given)
    #
    # ===Configuration Examples    
    # 
    # Example to turn off SSL:
    # 
    #   myServer = Rfm::Server.new({
    #           :host => 'localhost',
    #           :account_name => 'sample',
    #           :password => '12345',
    #           :ssl => false 
    #           })
    #           
    # Example using SSL without *root_cert*:
    #           
    #   myServer = Rfm::Server.new({
    #           :host => 'localhost',
    #           :account_name => 'sample',
    #           :password => '12345',
    #           :root_cert => false 
    #           })
    #           
    # Example using SSL with *root_cert* at file root:
    # 
    #   myServer = Rfm::Server.new({
    #            :host => 'localhost',
    #            :account_name => 'sample',
    #            :password => '12345',
    #            :root_cert_name => 'example.pem' 
    #            })
    #            
    # Example using SSL with *root_cert* specifying *root_cert_path*:
    # 
    #   myServer = Rfm::Server.new({
    #            :host => 'localhost',
    #            :account_name => 'sample',
    #            :password => '12345',
    #            :root_cert_name => 'example.pem'
    #            :root_cert_path => '/usr/cert_file/'
    #            })
    def initialize(*args)
      config(*args)
      raise Rfm::Error::RfmError.new(0, "New instance of Rfm::Server has no host name. Attempted name '#{state[:host]}'.") if state[:host].to_s == ''
      @databases = Rfm::Factory::DbFactory.new(self)
    end

    # Access the database object representing a database on the server. For example:
    #
    #   myServer['Customers']
    #
    # would return a Database object representing the _Customers_
    # database on the server.
    #
    # Note: RFM never talks to the server until you perform an action. The database object
    # returned is created on the fly and assumed to refer to a valid database, but you will
    # get no error at this point if the database you access doesn't exist. Instead, you'll
    # receive an error when you actually try to perform some action on a layout from this
    # database.
    #     def [](dbname, acnt=nil, pass=nil)
    #       self.db[dbname, acnt, pass]
    #     end
    def_delegator :databases, :[]

    attr_reader :databases #, :host_name, :port, :scheme, :state
    # Legacy Rfm method to get/create databases from server object
    alias_method :db, :databases

    def config(*args)
      super(:capture_strings_with=>[:host, :account_name, :password])
      super(*args)
    end

    def host_name
      state[:host]
    end

    def scheme
      state[:ssl] ? "https" : "http"
    end

    def port
      state[:ssl] && state[:port].nil? ? 443 : state[:port]
    end

    # Performs a raw FileMaker action. You will generally not call this method directly, but it
    # is exposed in case you need to do something "under the hood."
    # 
    # The +action+ parameter is any valid FileMaker web url action. For example, +-find+, +-finadny+ etc.
    #
    # The +args+ parameter is a hash of arguments to be included in the action url. It will be serialized
    # and url-encoded appropriately.
    #
    # The +options+ parameter is a hash of RFM-specific options, which correspond to the more esoteric
    # FileMaker URL parameters. They are exposed separately because they can also be passed into
    # various methods on the Layout object, which is a much more typical way of sending an action to
    # FileMaker.
    #
    # This method returns the Net::HTTP response object representing the response from FileMaker.
    #
    # For example, if you wanted to send a raw command to FileMaker to find the first 20 people in the
    # "Customers" database whose first name is "Bill" you might do this:
    #
    #   response = myServer.connect(
    #     '-find',
    #     {
    #       "-db" => "Customers",
    #       "-lay" => "Details",
    #       "First Name" => "Bill"
    #     },
    #     { :max_records => 20 }
    #   )

  end
end
