require 'pp'
require 'rubygems'
require 'sqlite3'
require 'kconv'

def parse_class_file(file)
   fh = open(file)

   ret = {}
   ret['name'] = file.sub(/.*\/-/, '')
   5.times do |i|
      t, v = fh.readline.chomp.split(/=/)
      v = v.join if v.class == Array
      ret[t] = v
   end

   fh.gets
   ret['body'] = fh.read.toutf8
   return ret
end

db = SQLite3::Database.new( "rurima.db" )

ARGV.each do |argv|
   attrs = parse_class_file(argv)
   p argv

   begin
      db.execute('insert into class values ( ?, ?, ?, ?, ?, ?, ? )',
         attrs['name'],
         attrs['type'],
         attrs['superclass'],
         attrs['included'],
         attrs['extended'],
         attrs['library'],
         attrs['body'])
   rescue
      retry
   end
end
