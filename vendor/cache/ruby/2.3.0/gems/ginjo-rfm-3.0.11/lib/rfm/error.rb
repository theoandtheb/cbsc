module Rfm

  # Error is the base for the error hierarchy representing errors returned by Filemaker.
  #
  # One could raise a FileMakerError by doing:
  #   raise Rfm::Error.getError(102)
  #
  # It also takes an optional argument to give a more discriptive error message:
  #   err = Rfm::Error.getError(102, 'add description with more detail here')
  #
  # The above code would return a FieldMissing instance. Your could use this instance to raise that appropriate
  # exception:
  #
  #   raise err
  #
  # You could access the specific error code by accessing:
  #
  #   err.code
  module Error

    class RfmError < StandardError #:nodoc:
      attr_reader :code

      def initialize(code, message=nil)
        @code = code
        super(message)
      end
    end

    class UnknownError < RfmError
    end

    class SystemError  < RfmError
    end

    class MissingError < RfmError
    end

    class RecordMissingError < MissingError #:nodoc:
    end

    class FieldMissingError  < MissingError #:nodoc:
    end

    class ScriptMissingError < MissingError #:nodoc:
    end

    class LayoutMissingError < MissingError #:nodoc:
    end

    class TableMissingError  < MissingError #:nodoc:
    end

    class SecurityError < RfmError #:nodoc:
    end

    class RecordAccessDeniedError < SecurityError #:nodoc:
    end

    class FieldCannotBeModifiedError < SecurityError #:nodoc:
    end

    class FieldAccessIsDeniedError < SecurityError #:nodoc:
    end

    class ConcurrencyError < RfmError #:nodoc:
    end

    class RecordInUseError < ConcurrencyError #:nodoc:
    end

    class TableInUseError < ConcurrencyError #:nodoc:
    end

    class RecordModIdDoesNotMatchError < ConcurrencyError #:nodoc:
    end

    class GeneralError < RfmError #:nodoc:
    end

    class NoRecordsFoundError < GeneralError #:nodoc:
    end

    class ValidationError < RfmError #:nodoc:
    end

    class DateValidationError < ValidationError #:nodoc:
    end

    class TimeValidationError < ValidationError #:nodoc:
    end

    class NumberValidationError < ValidationError #:nodoc:
    end

    class RangeValidationError < ValidationError #:nodoc:
    end

    class UniqueValidationError < ValidationError #:nodoc:
    end

    class ExistingValidationError < ValidationError #:nodoc:
    end

    class ValueListValidationError < ValidationError #:nodoc:
    end

    class ValidationCalculationError < ValidationError #:nodoc:
    end

    class InvalidFindModeValueError < ValidationError #:nodoc:
    end

    class MaximumCharactersValidationError < ValidationError #:nodoc:
    end

    class FileError < RfmError #:nodoc:
    end

    class UnableToOpenFileError < FileError #:nodoc:
    end

    extend self
    # This method returns the appropriate FileMaker object depending on the error code passed to it. It
    # also accepts an optional message.
    def getError(code, message=nil)
      klass   = find_by_code(code)
      message = build_message(klass, code, message)
      error   = klass.new(code, message)
      error
    end

    def build_message(klass, code, message=nil) #:nodoc:
      msg =  ": #{message}"
      msg << " " unless message.nil?
      msg << "(FileMaker Error ##{code})"

      "#{klass.to_s.gsub(/Rfm::Error::/, '')} occurred#{msg}"
    end

    def find_by_code(code) #:nodoc:
      case code
      when 0..99 then SystemError
      when 100..199
        if code == 101; RecordMissingError
        elsif code == 102; FieldMissingError
        elsif code == 104; ScriptMissingError
        elsif code == 105; LayoutMissingError
        elsif code == 106; TableMissingError
        else; MissingError; end
      when 203..299
        if code == 200; RecordAccessDeniedError
        elsif code == 201; FieldCannotBeModifiedError
        elsif code == 202; FieldAccessIsDeniedError
        else; SecurityError; end
      when 300..399
        if code == 301; RecordInUseError
        elsif code == 302; TableInUseError
        elsif code == 306; RecordModIdDoesNotMatchError
        else; ConcurrencyError; end
      when 400..499
        if code == 401; NoRecordsFoundError
        else; GeneralError; end
      when 500..599
        if code == 500; DateValidationError
        elsif code == 501; TimeValidationError
        elsif code == 502; NumberValidationError
        elsif code == 503; RangeValidationError
        elsif code == 504; UniqueValidationError
        elsif code == 505; ExistingValidationError
        elsif code == 506; ValueListValidationError
        elsif code == 507; ValidationCalculationError
        elsif code == 508; InvalidFindModeValueError
        elsif code == 511; MaximumCharactersValidationError
        else; ValidationError
        end
      when 800..899
        if code == 802; UnableToOpenFileError
        else; FileError; end
      else
        UnknownError
      end
    end
  end

end
