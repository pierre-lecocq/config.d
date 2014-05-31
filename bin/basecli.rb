#!/usr/bin/env ruby

require 'optparse'
require 'colorize'

class BaseCli
  attr_accessor :options, :commands
  attr_accessor :success_color, :normal_color, :warn_color, :error_color

  # Initialize
  def initialize(arguments)
    @commands = []
    @success_color = :green
    @normal_color = :blue
    @warn_color = :yellow
    @error_color = :red

    parse_options arguments

    log "#{@@caller.name} initialized"
  end

  # Parse options
  def parse_options(arguments)
    @options = {
      fake: false
    }

    opts = OptionParser.new
    opts.on('-f', '--fake') { @options[:fake] = true }

    opts.parse!(arguments)
  end

  # Output a message
  def log(str, color = nil, newline = true)
    color = @normal_color if color.nil?
    print str.colorize(color) + ' '
    puts if newline
  end

  # Execute commands stack
  def execute
    @commands.each do |command|
      log "Running #{command}".ljust(72), @normal_color, false

      if @options[:fake] == true
        log "[FAKE MODE]", @warn_color
      else
        `#{command}`
        if $?.success?
          log "[OK]", @success_color
        else
          log "[ERROR]", @error_color
        end
      end
    end
  end

  # Get caller class
  def self.inherited(subclass)
    @@caller = subclass
  end
end
