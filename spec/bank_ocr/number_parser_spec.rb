require 'spec_helper'

describe BankOcr::NumberParser do
  subject(:number_parser) { BankOcr::NumberParser.new }

  it 'should create a number 0' do
    number_parser << BankOcr::NumberParser::NUMBERS.keys[0]
    expect(number_parser.original).to eq " _ " <<
                                         "| |" <<
                                         "|_|"
    expect(number_parser.to_s).to eq '0'
  end

  it 'should create a number 1' do
    number_parser << BankOcr::NumberParser::NUMBERS.keys[1]
    expect(number_parser.original).to eq "   " <<
                                         "  |" <<
                                         "  |"
    expect(number_parser.to_s).to eq '1'
  end

  it 'should create a number 2' do
    number_parser << BankOcr::NumberParser::NUMBERS.keys[2]
    expect(number_parser.original).to eq " _ " <<
                                         " _|" <<
                                         "|_ "
    expect(number_parser.to_s).to eq '2'
  end

  it 'should create a number 3' do
    number_parser << BankOcr::NumberParser::NUMBERS.keys[3]
    expect(number_parser.original).to eq " _ " <<
                                         " _|" <<
                                         " _|"
    expect(number_parser.to_s).to eq '3'
  end

  it 'should create a number 4' do
    number_parser << BankOcr::NumberParser::NUMBERS.keys[4]
    expect(number_parser.original).to eq "   " <<
                                         "|_|" <<
                                         "  |"
    expect(number_parser.to_s).to eq '4'
  end

  it 'should create a number 5' do
    number_parser << BankOcr::NumberParser::NUMBERS.keys[5]
    expect(number_parser.original).to eq " _ " <<
                                         "|_ " <<
                                         " _|"
    expect(number_parser.to_s).to eq '5'
  end

  it 'should create a number 6' do
    number_parser << BankOcr::NumberParser::NUMBERS.keys[6]
    expect(number_parser.original).to eq " _ " <<
                                         "|_ " <<
                                         "|_|"
    expect(number_parser.to_s).to eq '6'
  end

  it 'should create a number 7' do
    number_parser << BankOcr::NumberParser::NUMBERS.keys[7]
    expect(number_parser.original).to eq " _ " <<
                                         "  |" <<
                                         "  |"
    expect(number_parser.to_s).to eq '7'
  end

  it 'should create a number 8' do
    number_parser << BankOcr::NumberParser::NUMBERS.keys[8]
    expect(number_parser.original).to eq " _ " <<
                                         "|_|" <<
                                         "|_|"
    expect(number_parser.to_s).to eq '8'
  end

  it 'should create a number 9' do
    number_parser << BankOcr::NumberParser::NUMBERS.keys[9]
    expect(number_parser.original).to eq " _ " <<
                                         "|_|" <<
                                         " _|"
    expect(number_parser.to_s).to eq '9'
  end
end

