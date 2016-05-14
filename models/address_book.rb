require_relative 'entry'
require 'csv'


class AddressBook
  attr_accessor :entries

  def initialize
    @entries = []
  end

  def add_entry(name, phone_number, email)
    # inserts entries in alphabetical order by name
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

  def binary_search(name,email)
    lower = 0
    upper = entries.length - 1

    while lower <= upper
      mid = ( lower + upper ) / 2
      mid_name = entries[mid].name
      mid_email = entries[mid].email

      if name == mid_name && email == mid_email
        return entries[mid]
      elsif name < mid_name
        upper = mid - 1
      elsif name > mid_name
        lower = mid + 1
      end

    end

    nil

  end

  def iterative_search(name, email)

    entries.each do |entry|
      return entry if name == entry.name && email == entry.email
    end

    nil

  end

end