module BankOcr
  class NumberParser
    # The **NumberParser** abstraction uses a map of *string characters*
    # to *string integers* to find out if a given *9 characters* string has
    # a valid equivalent.
    NUMBERS = {
      ' _ ' \
      '| |' \
      '|_|' => '0',
      '   ' \
      '  |' \
      '  |' => '1',
      ' _ ' \
      ' _|' \
      '|_ ' => '2',
      ' _ ' \
      ' _|' \
      ' _|' => '3',
      '   ' \
      '|_|' \
      '  |' => '4',
      ' _ ' \
      '|_ ' \
      ' _|' => '5',
      ' _ ' \
      '|_ ' \
      '|_|' => '6',
      ' _ ' \
      '  |' \
      '  |' => '7',
      ' _ ' \
      '|_|' \
      '|_|' => '8',
      ' _ ' \
      '|_|' \
      ' _|' => '9'
    }

    attr_accessor :original

    def initialize
      @original = ''
    end

    # The idea is to simply add strings in a variable
    def <<(number_section)
      @original << number_section
    end

    # and then just look for it on the numbers hash.
    def parse
      NUMBERS.fetch(@original, '?')
    end
  end
end
