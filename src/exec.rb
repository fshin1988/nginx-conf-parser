require './parse.rb'
require 'pp'

class ConfAnalyzer
  def initialize
    @hash = {}
  end

  def get_keys(conf_list)
    key_list = []
    conf_list.each do |element|
      key_list << element[0]
      # ブロックがある場合
      if element[2]
        key_list << get_keys(element[2])
      end
    end
    key_list.flatten.uniq
  end

  def get_values_by_key(conf_list)
    conf_list.each do |element|
      if @hash.key?(element[0])
        @hash[element[0]] << element[1]
        @hash[element[0]].uniq!
      else
        @hash[element[0]] = [ element[1] ]
      end
      # ブロックがある場合
      if element[2]
        get_values_by_key(element[2])
      end
    end
    @hash
  end
end

parser = CFParser.new
analyzer = ConfAnalyzer.new
begin
  File.open(ARGV[0]) do |f|
    conf_list = parser.parse(f, ARGV[0], nil)
    puts "\nResult of parse"
    pp conf_list

    keys = analyzer.get_keys(conf_list)
    puts "\nList of used directive"
    pp keys

    hash = analyzer.get_values_by_key(conf_list)
    puts "\nList of values by directive"
    pp hash
  end
rescue Racc::ParseError => e
  $stderr.puts e
end
