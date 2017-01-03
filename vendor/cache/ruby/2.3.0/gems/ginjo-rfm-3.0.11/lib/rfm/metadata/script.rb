module Rfm
  module Metadata
    # The Script object represents a FileMaker script. At this point, the Script object exists only so
    # you can enumrate all scripts in a Database (which is a rare need):
    # 
    #   myDatabase.script.each {|script|
    #     puts script.name
    #   }
    #
    # If you want to _run_ a script, see the Layout object instead.
    class Script
      def initialize(name, db_obj)
        @name = name
        self.db = db_obj
      end

      meta_attr_accessor :db
      attr_reader :name
    end # Script

  end # Metadata
end # Rfm
