require_relative '../models/address_book'

RSpec.describe AddressBook do

  describe "attributes" do

    it "responds to entries" do
      book = AddressBook.new
      expect(book).to respond_to(:entries)
    end

    it "initializes entries an an array" do
      book = AddressBook.new
      expect(book.entries).to be_an(Array)
    end

    it "initializes entries an an empty array" do
      book = AddressBook.new
      expect(book.entries.length).to eq(0)
    end

  end


  describe "#add_entry" do

    let(:book) { AddressBook.new }

    it "adds only one entry to the address book" do
      book.add_entry('Ada Lovelace', '010.012.1815', 'augusta.king@lovelace.com')
      expect(book.entries.size).to eq(1)
    end

    it "adds the correct information to entries" do
      book.add_entry('Ada Lovelace', '010.012.1815', 'augusta.king@lovelace.com')
      new_entry = book.entries[0]
      expect(new_entry.name).to eq('Ada Lovelace')
      expect(new_entry.phone_number).to eq('010.012.1815')
      expect(new_entry.email).to eq('augusta.king@lovelace.com')
    end

  end


  describe "#remove_entry" do

    let(:book) { AddressBook.new }

    it "removes a single entry" do
      book.add_entry('Ada Lovelace', '010.012.1815', 'augusta.king@lovelace.com')
      book.add_entry('Jason Ball', '555.555.5555', 'jason.ballg@example.com')
      expect(book.entries.size).to eq 2
      expect{ book.remove_entry('Ada Lovelace', '010.012.1815', 'augusta.king@lovelace.com') }.to change{ book.entries.size }.from(2).to(1)
      expect(book.entries.first.name).to eq 'Jason Ball'
    end

  end


end