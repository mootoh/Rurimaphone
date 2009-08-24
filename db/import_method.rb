require 'pp'
require 'rubygems'
require 'sqlite3'
require 'kconv'

def parse_method_file(file)
   fh = open(file)
   dir = File.dirname(fh).split(/\//).last

   ret = {}
   ret['class'] = dir[1..dir.length]
   3.times do |i|
      line = fh.readline.chomp
      line =~ /^([^=]+)=(.+)/
      ret[$1] = $2
   end

   fh.gets
   ret['body'] = fh.read.toutf8
   return ret
end

db = SQLite3::Database.new( "rurima.db" )

ARGV.each do |argv|
   attrs = parse_method_file(argv)
   p attrs

   begin
      db.execute('insert into method values ( ?, ?, ?, ?, ? )',
         attrs['names'],
         attrs['class'],
         attrs['kind'],
         attrs['visibility'],
         attrs['body'])
   rescue
      retry
   end
end
