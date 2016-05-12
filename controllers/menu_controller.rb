require_relative '../models/address_book'

class MenuController

  attr_reader :address_book

  def initialize
    @address_book = AddressBook.new
  end

  def main_menu

    puts
    puts "Main Menu - #{address_book.entries.count}"
    puts "1 - View all entries"
    puts "2 - Create an entry"
    puts "3 - Search for an entry"
    puts "4 - Import entries from a CSV"
    puts "5 - Exit"
    puts "Enter your selection: "

    selection = gets.to_i
    puts "You selected #{selection}"


    case selection
      when 1
        system "clear"
        view_all_entries
        main_menu
      when 2
        system "clear"
        create_entry
        main_menu
      when 3
        system "clear"
        search_entries
        main_menu
      when 4
        system "clear"
        read_csv
        main_menu
      when 5
        puts "Good bye!"
        exit(0)
      else
        system "clear"
        puts "Sorry that's invalid, try again or exit"
        main_menu
    end

  end


  def view_all_entries
    address_book.entries.each do |entry|
      system "clear"
      puts entry.to_s + "\n\n"
      entry_submenu(entry)
    end
    system "clear"
    puts "End of entries"
  end

  def entry_submenu(entry)
    puts "n - next entry"
    puts "d - delete entry"
    puts "e - edit entry"
    puts "m - return to main menu"

    selection = gets.chomp
    case selection
      when "n"
      when "d"
      when "e"
      when "m"
        system "clear"
        main_menu
      else
        system "clear"
        puts "#{selection} is not a valid input"
        entry_submenu(entry)
    end
  end


  def create_entry
    system "clear"
    puts "New AddressBloc Entry"
    print "Name: "
    name = gets.chomp
    print "Phone: "
    phone = gets.chomp
    print "Email: "
    email = gets.chomp
    address_book.add_entry(name, phone, email)
    system "clear"
    puts "New Entry created!"
  end


  def search_entries

  end


  def read_csv

  end


end