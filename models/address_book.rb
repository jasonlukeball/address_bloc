require_relative 'entry'
require 'csv'


class AddressBook
  attr_accessor :entries

  def initialize
    @entries = []
  end

  def add_entry(name, phone_number, email)
    index = 0
    entries.each do |entry|
      if name < entry.name
        break
      end
      index += 1
    end
    entries.insert(index, Entry.new(name, phone_number, email))
  end

  def remove_entry(name, phone_number, email)
    entries.delete_if {|e| (e.name == name) && (e.phone_number == phone_number) && (e.email == email) }
  end

  def import_from_csv(csv_filename)
    csv_text = File.read(csv_filename)
    csv = CSV.parse(csv_text, headers: true, skip_blanks: true)
    csv.each do |row|
      row_hash = row.to_hash
      add_entry(row_hash["name"], row_hash["phone_number"], row_hash["email"])
    end

  end

end