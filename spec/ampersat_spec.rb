# encoding: utf-8
path = File.expand_path(File.dirname(__FILE__) + '/../lib/')
$LOAD_PATH.unshift(path) unless $LOAD_PATH.include?(path)
require 'ampersat'

describe Ampersat do

  let(:csv_path) { File.expand_path(File.dirname(__FILE__) + '/support/test.csv') }
  let(:email) { 'test@example.com' }
  let(:multiple_emails) { 'jim@example.com, tom@example.com, bob@example.org, james@example.net' }

  it 'should return the sum of each email provider' do
    expected_result = [['example.com', 3], ['example.org', 2], ['example.net', 1]]
    expect(Ampersat.domains(csv_path)).to eq(expected_result)
  end

  it 'should return the email providers with the most common first' do
    incorrect_result = [['example.org', 2],['example.com', 3], ['example.net', 1]]
    expect(Ampersat.domains(csv_path)).not_to eq(incorrect_result)

    expected_result = [['example.com', 3], ['example.org', 2], ['example.net', 1]]
    expect(Ampersat.domains(csv_path)).to eq(expected_result)
  end

  it 'should find the domain of an email address' do
    expect(Ampersat.find_domain(email)).to eq('example.com')
  end

  describe 'column' do
    let(:csv_path) { File.expand_path(File.dirname(__FILE__) + '/support/multiple-columns.csv') }
    let(:email) { 'test@example.com' }
    let(:multiple_emails) { 'jim@example.com, tom@example.com, bob@example.org, james@example.net' }
    let(:column) { 1 }

    it 'should return the sum of each email provider' do
      expected_result = [['example.com', 3], ['example.org', 2], ['example.net', 1]]
      expect(Ampersat.domains(csv_path, column)).to eq(expected_result)
    end

    it 'should return the email providers with the most common first' do
      incorrect_result = [['example.org', 2],['example.com', 3], ['example.net', 1]]
      expect(Ampersat.domains(csv_path, column)).not_to eq(incorrect_result)

      expected_result = [['example.com', 3], ['example.org', 2], ['example.net', 1]]
      expect(Ampersat.domains(csv_path, column)).to eq(expected_result)
    end
  end

end
