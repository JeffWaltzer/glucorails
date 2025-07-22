desc "Run the undercover code coverage augmentation tool"
task undercover: [ :spec ] do
  system "undercover --exclude-files lib/tasks/undercover.rake --simplecov coverage/my_project_coverage.json"
end
