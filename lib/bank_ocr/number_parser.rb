module BankOcr
  class NumberParser
    NUMBERS = {
      " _ " <<
      "| |" <<
      "|_|" => '0',
      "   " <<
      "  |" <<
      "  |" => '1',
      " _ " <<
      " _|" <<
      "|_ " => '2',
      " _ " <<
      " _|" <<
      " _|" => '3',
      "   " <<
      "|_|" <<
      "  |" => '4',
      " _ " <<
      "|_ " <<
      " _|" => '5',
      " _ " <<
      "|_ " <<
      "|_|" => '6',
      " _ " <<
      "  |" <<
      "  |" => '7',
      " _ " <<
      "|_|" <<
      "|_|" => '8',
      " _ " <<
      "|_|" <<
      " _|" => '9',
    }

    attr_accessor :original

    def initialize
      @original = String.new
    end

    def <<(number_section)
      @original << number_section
    end

    def to_s
      NUMBERS.fetch(@original, ' ')
    end

  end
end
