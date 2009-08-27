all: rurima.db

rurima.db: schema.sql refm
	sqlite3 rurima.db < schema.sql
	ruby import_method.rb db-1_9_0/method/-array/?.*
	ruby import_method.rb db-1_9_0/method/-hash/?.*
	ruby import_class.rb db-1_9_0/class/-*

refm: db-1_9_0

db-1_9_0: ruby-refm-1.9.0-dynamic.tar.bz2
	tar jxf $^
	ln -f -s ruby-refm-1.9.0-dynamic/$@ $@

ruby-refm-1.9.0-dynamic.tar.bz2:
	curl -O http://www.ruby-lang.org/ja/man/archive/ruby-refm-1.9.0-dynamic.tar.bz2 
