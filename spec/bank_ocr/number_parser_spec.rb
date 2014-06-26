require 'spec_helper'

describe BankOcr::NumberParser do
  let(:numbers) do
      {
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
  end

  it 'should parse each number' do
    numbers.each do |number_string, parsed_number|
      number_parser = BankOcr::NumberParser.new
      number_parser << number_string
      expect(number_parser.original).to eq number_string
      expect(number_parser.parse).to eq parsed_number
    end
  end

  it 'should return a blank when parsing an invalid string' do
      number_parser = BankOcr::NumberParser.new
      expect(number_parser.original).to eq ''
      expect(number_parser.parse).to eq '?'
  end

end
