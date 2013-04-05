# Unfortunately Ragel messes up the shebang, so you'll have to invoke this via
#   `ruby debugger`
require 'pry'
require 'colorize'

%%{

  machine debugger;

  # Include the machine definition
  include clf "clf.rl";

  # Point Ragel at instance variables so that we can inspect them later
  variable data @data;
  variable p    @p;

  # Instantiate the machine with error handling on every state transition
  main := line $!{ error };

}%%

class Tokenizer
  def initialize path
    @path = path
    %% write data;
    #% # Fix syntax highlighting
  end

  def mark
    @ts = @p
  end

  def emit type
    puts "#{type}: #{token}"
  end

  def token
    @data[@ts...@p].pack 'c*'
  end

  def line
    pre, curr, post = @line[0 ... @p], @line[@p], @line[@p+1 .. -1]
    highlight = curr =~ /\s/ ? curr.on_light_red : curr.light_red
    pre + highlight + post
  end

  def error
    puts "ERROR: ".red + line
    binding.pry && raise  # so exit 1 will halt execution immediately
  end

  def run
    File.foreach @path do |line|
      @line  = line
      @data  = line.unpack 'c*'
      @p, pe = 0, line.length
      eof    = pe

      %% write init;
      %% write exec;

      puts
    end
  end
end

Tokenizer.new(ARGV.first).run