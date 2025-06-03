class Hulk
  cattr_accessor :hulk_prompt_template, :first_reference, :other_references

  def self.secrets=(config)
    @secrets = config
    @@hulk_prompt_template = config[:hulk_prompt_template]
    @@first_reference = config[:first_reference] 
    @@other_references = config[:other_references]
  end
end
