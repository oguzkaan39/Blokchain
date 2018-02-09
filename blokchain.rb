#/usr/bin/env ruby
#BlokChain App
require 'sqlite3'
require 'digest'
def create_table
  begin
    db=SQLite3::Database.open "blocks.sqlite3"#Open database
    db.execute "CREATE TABLE IF NOT EXISTS blocks7(id integer primary key, value, hashCode)"#Create table

  rescue SQLite3::Exception => error #View errors 
    puts error
  ensure 
    db.close if db
  end
end

def add_block
  #Son Eklenen verinin hash kodunu al
  #Yeni eklenen veriyi al
  #Yeni eklenen veri ile yeni eklenen veriden bir önceki verinin hash kodunun hash kodunu al
  db=SQLite3::Database.open "blocks.sqlite3"# Open Database Connection

  print "Enter word = " # Enter word
  word = gets.chomp

  id = db.execute "SELECT MAX(id) FROM blocks7" #Select max id from database

  value = db.execute "SELECT value FROM blocks7 WHERE id='#{id.first.first}'"#value = Last added value

  value_hash_code = db.execute "SELECT hashCode FROM blocks7 WHERE value='#{value.first.first}'"#value's hash code

  # puts id[0][0] #View id on screen
  # puts id[0][0].class #=>Integer

  # puts value_hash_code[0][0].class #=>String
  #puts value[0][0].class #=>String

  hashin_hashi = Digest::SHA256.hexdigest(value_hash_code[0][0]+word)#Create new value hash code

  db.execute "INSERT INTO blocks7(value, hashCode) VALUES ( '#{word}', '#{hashin_hashi}')"#Add value and hash code

  #puts id[0][0].class #=>Integer
  db.close if db #Close Database
  puts "Succesfully added"
end

#create_table
add_block