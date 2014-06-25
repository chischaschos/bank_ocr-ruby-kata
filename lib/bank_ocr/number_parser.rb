module BankOcr
  class NumberParser
    NUMBERS = {
      " _ " <<
      "| |" <<
      "|_|" => '0',
      "   " <<
      "  |" <<
      "  |" => '1',
    }

    def initialize
      @original = ""
    end

    def <<(number_section)
      @original << number_section
    end

    def original
      @original
    end

    def to_s
      NUMBERS[@original]
    end

  end
end
