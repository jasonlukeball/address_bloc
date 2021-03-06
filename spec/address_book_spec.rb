require_relative '../models/address_book'

RSpec.describe AddressBook do

  let (:book) { AddressBook.new }

  def check_entry(entry, expected_name, expected_number, expected_email)
    expect(entry.name).to eq expected_name
    expect(entry.phone_number).to eq expected_number
    expect(entry.email).to eq expected_email
  end

  describe "attributes" do

    it "responds to entries" do
      expect(book).to respond_to(:entries)
    end

    it "initializes entries an an array" do
      expect(book.entries).to be_an(Array)
    end

    it "initializes entries an an empty array" do
      expect(book.entries.length).to eq(0)
    end

  end

  describe "#add_entry" do

    name  = 'Ada Lovelace'
    phone = '010.012.1815'
    email = 'augusta.king@lovelace.com'

    it "adds only one entry to the address book" do
      book.add_entry(name, phone, email)
      expect(book.entries.size).to eq(1)
    end

    it "adds the correct information to entries" do
      book.add_entry(name, phone, email)
      new_entry = book.entries[0]
      expect(new_entry.name).to eq(name)
      expect(new_entry.phone_number).to eq(phone)
      expect(new_entry.email).to eq(email)
    end

  end

  describe "#remove_entry" do

    name  = 'Ada Lovelace'
    phone = '010.012.1815'
    email = 'augusta.king@lovelace.com'

    it "removes a single entry" do
      book.add_entry(name, phone, email)
      book.add_entry('Jason Ball', '555.555.5555', 'jason.ballg@example.com')
      expect(book.entries.size).to eq 2
      expect{ book.remove_entry(name, phone, email) }.to change{ book.entries.size }.from(2).to(1)
      expect(book.entries.first.name).to eq 'Jason Ball'
    end

  end

  describe "#import_from_csv" do

    it "imports the correct number of entries" do
      book.import_from_csv("entries.csv")
      book_size = book.entries.size
      expect(book_size).to eq 5
    end

    it "imports the first entry" do
      book.import_from_csv("entries.csv")
      # Check the first entry
      entry_one = book.entries[0]
      check_entry(entry_one, "Bill", "555-555-4854", "bill@blocmail.com")
    end

    it "imports the 2nd entry" do
      book.import_from_csv("entries.csv")
      entry_two = book.entries[1]
      # Check the second entry
      check_entry(entry_two, "Bob", "555-555-5415", "bob@blocmail.com")
    end

    it "imports the 3rd entry" do
      book.import_from_csv("entries.csv")
      # Check the third entry
      entry_three = book.entries[2]
      check_entry(entry_three, "Joe", "555-555-3660", "joe@blocmail.com")
    end

    it "imports the 4th entry" do
      book.import_from_csv("entries.csv")
      # Check the fourth entry
      entry_four = book.entries[3]
      check_entry(entry_four, "Sally", "555-555-4646", "sally@blocmail.com")
    end

    it "imports the 5th entry" do
      book.import_from_csv("entries.csv")
      # Check the fifth entry
      entry_five = book.entries[4]
      check_entry(entry_five, "Sussie", "555-555-2036", "sussie@blocmail.com")
    end

    it "imports the jason entry" do
      book.import_from_csv("entries_2.csv")
      # Check the jason entry
      jason = book.entries[0]
      check_entry(jason, "Jason", "555-555-1234", "jason@blocmail.com")
    end

    it "imports the msh entry" do
      book.import_from_csv("entries_2.csv")
      # Check the jason entry
      msh = book.entries[1]
      check_entry(msh, "Msh", "555-555-4567", "msh@blocmail.com")
    end

    it "imports the tristan entry" do
      book.import_from_csv("entries_2.csv")
      # Check the jason entry
      tristan = book.entries[2]
      check_entry(tristan, "Tristan", "555-555-0000", "tristan@blocmail.com")
    end

  end

  describe "#binary_search" do

    it "searches AddressBook for a non-existant entry" do
      book.import_from_csv("entries.csv")
      entry = book.binary_search("Dan", "dan@blocmail.com")
      expect(entry).to be_nil
    end

    it "searches AddressBook for Bill" do
      book.import_from_csv("entries.csv")
      entry = book.binary_search("Bill", "bill@blocmail.com")
      check_entry(entry, "Bill", "555-555-4854", "bill@blocmail.com")
    end

    it "searches AddressBook for Billy" do
      book.import_from_csv("entries.csv")
      entry = book.binary_search("Billy", "billy@blocmail.com")
      expect(entry).to be_nil
    end

    it "searches AddressBook for Bob" do
      book.import_from_csv("entries.csv")
      entry = book.binary_search("Bob", "bob@blocmail.com")
      expect(entry).to be_a Entry
      check_entry(entry, "Bob", "555-555-5415", "bob@blocmail.com")
    end

    it "searches AddressBook for Joe" do
      book.import_from_csv("entries.csv")
      entry = book.binary_search("Joe", "joe@blocmail.com")
      expect(entry).to be_a Entry
      check_entry(entry, "Joe", "555-555-3660", "joe@blocmail.com")
    end

    it "searches AddressBook for Sally" do
      book.import_from_csv("entries.csv")
      entry = book.binary_search("Sally", "sally@blocmail.com")
      expect(entry).to be_a Entry
      check_entry(entry, "Sally", "555-555-4646", "sally@blocmail.com")
    end

    it "searches AddressBook for Sussie" do
      book.import_from_csv("entries.csv")
      entry = book.binary_search("Sussie", "sussie@blocmail.com")
      expect(entry).to be_a Entry
      check_entry(entry, "Sussie", "555-555-2036", "sussie@blocmail.com")
    end

  end

  describe "#iterative_search" do

    it "searches AddressBook for a non-existant entry" do
      book.import_from_csv("entries.csv")
      entry = book.iterative_search("Dan","dan@blocmail.com")
      expect(entry).to be_nil
    end

    it "searches AddressBook for Bill" do
      book.import_from_csv("entries.csv")
      entry = book.iterative_search("Bill", "bill@blocmail.com")
      check_entry(entry, "Bill", "555-555-4854", "bill@blocmail.com")
    end

    it "searches AddressBook for Billy" do
      book.import_from_csv("entries.csv")
      entry = book.iterative_search("Billy", "bill@blocmail.com")
      expect(entry).to be_nil
    end

    it "searches AddressBook for Bob" do
      book.import_from_csv("entries.csv")
      entry = book.iterative_search("Bob", "bob@blocmail.com")
      expect(entry).to be_a Entry
      check_entry(entry, "Bob", "555-555-5415", "bob@blocmail.com")
    end

    it "searches AddressBook for Joe" do
      book.import_from_csv("entries.csv")
      entry = book.iterative_search("Joe", "joe@blocmail.com")
      expect(entry).to be_a Entry
      check_entry(entry, "Joe", "555-555-3660", "joe@blocmail.com")
    end

    it "searches AddressBook for Sally" do
      book.import_from_csv("entries.csv")
      entry = book.iterative_search("Sally", "sally@blocmail.com")
      expect(entry).to be_a Entry
      check_entry(entry, "Sally", "555-555-4646", "sally@blocmail.com")
    end

    it "searches AddressBook for Sussie" do
      book.import_from_csv("entries.csv")
      entry = book.iterative_search("Sussie", "sussie@blocmail.com")
      expect(entry).to be_a Entry
      check_entry(entry, "Sussie", "555-555-2036", "sussie@blocmail.com")
    end

  end


end