require 'spec_helper'

describe BankOcr::Parser do
  subject(:bank_ocr_parser) { BankOcr::Parser }

  describe '#parse_entry' do
    let(:series) do
      {
        " _  _  _  _  _  _  _  _  _ \n" <<
        "| || || || || || || || || |\n" <<
        "|_||_||_||_||_||_||_||_||_|\n\n" => '000000000',
        "                           \n" <<
        "  |  |  |  |  |  |  |  |  |\n" <<
        "  |  |  |  |  |  |  |  |  |\n\n" => '111111111',
        " _  _  _  _  _  _  _  _  _ \n" <<
        " _| _| _| _| _| _| _| _| _|\n" <<
        "|_ |_ |_ |_ |_ |_ |_ |_ |_ \n\n" => '222222222',
        " _  _  _  _  _  _  _  _  _ \n" <<
        " _| _| _| _| _| _| _| _| _|\n" <<
        " _| _| _| _| _| _| _| _| _|\n\n" => '333333333',
        "                           \n" <<
        "|_||_||_||_||_||_||_||_||_|\n" <<
        "  |  |  |  |  |  |  |  |  |\n\n" => '444444444',
        " _  _  _  _  _  _  _  _  _ \n" <<
        "|_ |_ |_ |_ |_ |_ |_ |_ |_ \n" <<
        " _| _| _| _| _| _| _| _| _|\n\n" => '555555555',
        " _  _  _  _  _  _  _  _  _ \n" <<
        "|_ |_ |_ |_ |_ |_ |_ |_ |_ \n" <<
        "|_||_||_||_||_||_||_||_||_|\n\n" => '666666666',
        " _  _  _  _  _  _  _  _  _ \n" <<
        "  |  |  |  |  |  |  |  |  |\n" <<
        "  |  |  |  |  |  |  |  |  |\n\n" => '777777777',
        " _  _  _  _  _  _  _  _  _ \n" <<
        "|_||_||_||_||_||_||_||_||_|\n" <<
        "|_||_||_||_||_||_||_||_||_|\n\n" => '888888888',
        " _  _  _  _  _  _  _  _  _ \n" <<
        "|_||_||_||_||_||_||_||_||_|\n" <<
        " _| _| _| _| _| _| _| _| _|\n\n" => '999999999',
        "    _  _     _  _  _  _  _ \n" <<
        "  | _| _||_||_ |_   ||_||_|\n" <<
        "  ||_  _|  | _||_|  ||_| _|\n\n" => '123456789',
      }
    end

    it 'should parse each series of numbers' do
      series.each do |numbers_string, number_parsed|
        parsed_number = bank_ocr_parser.parse_entry(numbers_string)
        expect(parsed_number).to eq number_parsed
      end
    end

  end

  describe '#split_numbers' do
    it 'should split a string of numbers into single numbers' do
      number = " _  _  _  _  _  _  _  _  _ \n" +
               "| || || || || || || || || |\n" +
               "|_||_||_||_||_||_||_||_||_|\n\n"
      numbers  = bank_ocr_parser.split_numbers(number)
      numbers.each do |number_parser|
        expect(number_parser).to be_a BankOcr::NumberParser
        expect(number_parser.to_s).to eq '0'
      end
      expect(numbers).to have(9).items
    end
  end
end
