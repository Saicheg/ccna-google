require 'nokogiri'
require 'open-uri'

Question.delete_all
Answer.delete_all
Admin.delete_all
Admin.create(email: 'admin@bsuir.by', password: '12345678', password_confirmation: '12345678')

require_relative 'seeds/2.rb'

