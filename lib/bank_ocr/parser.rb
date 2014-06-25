module BankOcr
  class Parser
    def self.parse_entry(string_entry)
      split_numbers(string_entry).reduce(String.new) do |number, number_parser|
        number << number_parser.to_s
        number
      end
    end

    def self.split_numbers(string_entry)
      numbers = []
      lines = string_entry.chop.split("\n")

      3.times do |line_index|
        each_number_section(lines[line_index]) do |number_section, column|
          numbers[column] ||= NumberParser.new
          numbers[column] << number_section
        end
      end

      numbers
    end

    private

    def self.each_number_section(line)
      section_pattern = /.{3}/

      line.scan(section_pattern).each_with_index do |number_section, index|
        yield number_section, index
      end
    end
  end
end
