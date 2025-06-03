require 'hulk'

Hulk.secrets = {
  hulk_prompt_template: File.read(File.join(Rails.root, '..', 'hulk_prompt_template.txt')),
  first_reference: File.read(File.join(Rails.root, ENV['SECRET_FOLDER_PATH'], 'first_reference.txt')).strip,
  other_references: File.readlines(File.join(Rails.root, ENV['SECRET_FOLDER_PATH'], 'other_references.txt')).map(&:strip)
}
