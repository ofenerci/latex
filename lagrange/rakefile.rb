# Have faith in the way things are.
#
# rakefile.rb
# production of LaTeX documents
# Copyright (c) 2013 rimbaudcode
# Licensed under GPLv3+. No warranty provided.

require 'rake/clean'

SRC = 'lagrange.tex'

COMPILE_SRC_TIMES = 2

PDFLATEX = `which pdflatex`.chomp
XELATEX  = `which xelatex`.chomp
BIBTEX   = `which bibtex`.chomp
VIEWER   = `which open`.chomp

# choose compiler: pdflatex or xelatex
COMPILER       = XELATEX
COMPILER_FLAGS = '-interaction=batchmode'

OUTPUT_PDF = File.basename(SRC, 'tex') << 'pdf'

# tasks
DEFAULT_TASKS = [
  :sanity_checks,
  :tex_to_pdf,
  ]

desc 'compile latex source with bibtex to pdf'
task :default => DEFAULT_TASKS

desc 'check for installed bibtex, pdflatex and xetex'
task :sanity_checks do
  begin
    raise FileDoesNotExistError unless File.file? SRC
  rescue
    puts "File: #{SRC} doesn't exist."
    exit 1
  end
  begin
    raise NoPDFLaTeXInstalledError if PDFLATEX.empty?
    raise NoXeLaTeXInstalledError if XELATEX.empty?
    raise NoBibTeXInstalledError if BIBTEX.empty?
    raise NoPDFViewerInstalledError if VIEWER.empty?
  rescue
    puts "No TeX distribution found. Install TeX."
    exit 1
  end
end

desc 'compile latex source to pdf'
task :tex_to_pdf do
  sh "#{COMPILER} #{COMPILER_FLAGS} #{SRC}"
  sh "#{BIBTEX} #{File.basename(SRC, '.tex')}"
  COMPILE_SRC_TIMES.times do sh "#{COMPILER} #{COMPILER_FLAGS} #{SRC}" end
end

desc 'open pdf for reviewing'
task :open do
  sh "#{VIEWER} #{OUTPUT_PDF}"
end

CLEAN.include('**/*.aux', '*.bak', '*.log', '*~', '*.acn', '*.glo', 
'*.ist', '*.lof', '*.lot', '*.ntn', '*.toc', '*.idx', '*.out', '*.acr', 
'*.bbl', '*.blg', '*.brf', '*.gls', '*.not', '*.nav', 
'*.snm', '*.gz', '*.synctex.gz*')

CLOBBER.include("#{OUTPUT_PDF}")

FileDoesNotExistError     = Class.new StandardError
NoBibTeXInstalledError    = Class.new StandardError
NoPDFLaTeXInstalledError  = Class.new StandardError
NoPDFViewerInstalledError = Class.new StandardError
