require 'spec_helper'

describe BankOcr::Parser do
  subject(:bank_ocr_parser) { BankOcr::Parser }

  describe '#parse_entry' do
    it 'should parse a single 000000000 entry' do
      number = " _  _  _  _  _  _  _  _  _\n" +
               "| || || || || || || || || |\n" +
               "|_||_||_||_||_||_||_||_||_|\n\n"
      parsed_number = bank_ocr_parser.parse_entry(number)
      expect(parsed_number).to eq '000000000'
    end

    it 'should parse a single 111111111 entry' do
      number = "                           " +
               "  |  |  |  |  |  |  |  |  |\n" +
               "  |  |  |  |  |  |  |  |  |\n\n"
      parsed_number = bank_ocr_parser.parse_entry(number)
      expect(parsed_number).to eq '111111111'
    end
  end

  describe '#split_numbers' do
    it 'should split a string of numbers into single numbers' do
      number = " _  _  _  _  _  _  _  _  _\n" +
               "| || || || || || || || || |\n" +
               "|_||_||_||_||_||_||_||_||_|\n\n"
      numbers = bank_ocr_parser.split_numbers(number)
      expect(numbers.first).to eq " _ " +
                                  "| |" +
                                  "|_|"
    end
  end
end