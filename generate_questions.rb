#!/usr/bin/env ruby

require 'optparse'
require 'json'

options = {}
optparser = OptionParser.new do |opts|
    opts.banner = "Usage: ./generate_questions.rb file1.json [file2.json ...]"

    # This displays the help screen, all programs are
    # assumed to have this option.
    opts.on( '-h', '--help', 'Display this screen' ) do
        options[:h] = 1
        puts opts
        exit
    end
end

optparser.parse! ARGV

ARGV.each do |filename|
    text = File.read filename
    data = JSON.parse text
    data.each do |d|
        QuestionGenerator::generate_questions(
            d.question_template,
            d.answers,
            d.explanation,
            d.template_substitutions
        )
    end
end
