#!/usr/bin/env ruby

require 'optparse'
require 'colorize'

## Demo program:
#
# require_relative 'basecli'
#
# class DemoCli < BaseCli
#
#   def initialize
#     super
#
#     # OPTIONAL: define options
#     @options = { fake: false, bonjour: false }
#     @option_parser.on('-f', '--fake') { @options[:fake] = true }
#     @option_parser.on('-b', '--bonjour') { @options[:bonjour] = true }
#
#     # Set commands to run
#     @commands << 'touch ~/testfile'
#     @commands << 'cp ~/testfile ~/testfile2'
#   end
#
# end
#
# DemoCli.new.execute

class BaseCli
  attr_accessor :option_parser, :options, :commands, :colors

  # Initialize
  def initialize
    @commands = []
    @options = {}
    @option_parser = OptionParser.new
    @colors = {
      success: :green,
      normal: :white,
      warning: :yellow,
      error: :red,
    }

    log "[*] #{@@caller.name} initialized."
  end

  # Parse options
  def parse_options
    if @options.empty?
      @options = { fake: false }
      @option_parser.on('-f', '--fake') { @options[:fake] = true }
    end

    @option_parser.parse!(ARGV)

    unless @options.has_key?(:fake)
      log 'WARNING: There is no "fake" option. It is dangerous.', :warning
      print 'Continue ? [N/y] '
      answer = gets.chomp.downcase
      answer = 'n' if answer.empty?

      case answer
      when 'y'
        puts 'Continuing ...'
      else
        abort 'Aborting program.'
      end
    end
  end

  # Output a message
  def log(str, type = nil, newline = true)
    type = :normal if type.nil?
    print str.colorize(@colors[type]) + (newline ? "\n" : '')
  end

  # Execute commands stack
  def execute
    parse_options

    @commands.each do |command|
      log "    Running #{command}".ljust(72), nil, false
      if @options[:fake] == true
        log "[FAKE MODE]", :warning
      else
        `#{command}`
        if $?.success?
          log "[OK]", :success
        else
          log "[ERROR]", :error
        end
      end
    end
  end

  # Get caller class
  def self.inherited(subclass)
    @@caller = subclass
  end
end
