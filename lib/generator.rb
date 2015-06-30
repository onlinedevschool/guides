# encoding: utf-8
require 'byebug'
require 'set'
require 'fileutils'

require 'active_support/core_ext/string/output_safety'
require 'active_support/core_ext/object/blank'
require 'action_controller'
require 'action_view'

require 'markdown'
require 'helpers'

module Guides
  class Generator
    GUIDES_RE = /\.(?:erb|md)\z/
    ROOT_DIR = File.join(File.dirname(__FILE__), '..')
    SOURCE_DIR = "#{ROOT_DIR}/source"
    OUTPUT_DIR = "#{ROOT_DIR}/public"

    def initialize
      persist_output_dir
    end

    def generate
      generate_guides
      copy_assets
    end

  private

    def persist_output_dir
      FileUtils.mkdir_p(OUTPUT_DIR)
    end

    def generate_guides
      all_guides.each do |guide|
        output_file = output_file_for(guide)
        generate_guide(guide, output_file)
      end
    end

    def all_guides
      Dir.entries(SOURCE_DIR).grep(GUIDES_RE)
    end

    def copy_assets
      FileUtils.cp_r(Dir.glob("#{ROOT_DIR}/assets/*"), OUTPUT_DIR)
    end

    def output_file_for(guide)
      guide.sub(/md\z/, 'html').sub(/\.erb\z/, '')
    end

    def output_path_for(output_file)
      File.join(OUTPUT_DIR, File.basename(output_file))
    end

    def exists?(source_file, output_file)
      fin  = File.join(SOURCE_DIR, source_file)
      fout = output_path_for(output_file)
      !(all || !File.exist?(fout) || File.mtime(fout) < File.mtime(fin))
    end

    def generate_guide(guide, output_file)
      output_path = output_path_for(output_file)
      puts "Generating #{guide} as #{output_file}"

      File.open(output_path, 'w') do |f|
        view = ActionView::Base.new(SOURCE_DIR, :edge => @edge, :version => @version)
        view.extend(Helpers)
        result = if guide =~ /\.(\w+)\.erb$/
                   view.render(:layout => 'layout', :formats => [$1], :file => $`)
                 else
                   render_html(view,guide)
                 end
        f.write(result)
      end
    end

    def render_html(view, guide)
      body = File.read(File.join(SOURCE_DIR, guide))
      Guides::Markdown.new(view, 'layout').render(body)
    end
  end
end
