namespace :guides do

  desc 'Generate guides (for authors), use ONLY=foo to process just "foo.md"'
  task :generate => 'generate:html'

  namespace :generate do
    desc "Generate HTML guides"
    task :html do
      ENV["WARN_BROKEN_LINKS"] = "1" # authors can't disable this
      `./bin/build`
    end
  end

  # Validate guides -------------------------------------------------------------------------
  desc 'Validate guides, use ONLY=foo to process just "foo.html"'
  task :validate do
    `./bin/w3c_validator`
  end

  desc "Show help"
  task :help do
    puts <<-help

Guides are taken from the source directory, and the result goes into the
output directory. Assets are stored under files, and copied to output/files as
part of the generation process.

You can generate HTML using the `guides:generate` task.

All of these processes are handled via rake tasks, here's a full list of them:

#{%x[rake -T]}
Some arguments may be passed via environment variables:

  WARNINGS=1
    Internal links (anchors) are checked, also detects duplicated IDs.

  ALL=1
    Force generation of all guides.

  ONLY=name
    Useful if you want to generate only one or a set of guides.

    Generate only association_basics.html:
      ONLY=assoc

    Separate many using commas:
      ONLY=assoc,migrations

  GUIDES_LANGUAGE
    Use it when you want to generate translated guides in
    source/<GUIDES_LANGUAGE> folder (such as source/es)

Examples:
  $ rake guides:generate ALL=1
  $ rake guides:generate GUIDES_LANGUAGE=es
    help
  end
end

task :default => 'guides:help'
