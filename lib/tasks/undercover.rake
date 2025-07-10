desc "Run the undercover code coverage augmentation tool"
task undercover: [ :spec ] do
  system "undercover"
end
