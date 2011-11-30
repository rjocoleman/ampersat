require "ampersat/version"
require "csv"

module Ampersat

  def self.domains(email_list)
    domains = Hash.new(0)
    
    CSV.foreach(email_list) do |row|
      domain = Ampersat.find_domain(row.first)
      domains[domain] = domains[domain] +1
    end

    domains.sort_by {|key, value| -value}    
  end

  def self.find_domain(email)
    email.split('@').last
  end

end