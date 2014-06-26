module BankOcr
  class Parser
    def self.parse_file(file_name)
      IO.readlines(file_name).each_slice(4).map { |slice| parse_entry(slice) }
    end

    def self.each_entry(lines)
      lines.each_slice(4).map { |slice| yield slice }
    end

    def self.parse_entry(lines_entry)
      numbers_per_entry(lines_entry).reduce(String.new) do |number, number_parser|
        number << number_parser.to_s
        number
      end
    end

    def self.numbers_per_entry(lines_entry)
      numbers = []

      3.times do |line_index|
        each_number_section(lines_entry.first(3)[line_index]) do |number_section, column|
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
