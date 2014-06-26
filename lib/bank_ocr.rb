require "bank_ocr/version"

module BankOcr
  autoload :Parser, 'bank_ocr/parser'
  autoload :NumberParser, 'bank_ocr/number_parser'
  autoload :AccountNumber, 'bank_ocr/account_number'
end
