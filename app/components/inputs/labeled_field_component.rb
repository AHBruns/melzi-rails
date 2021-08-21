# frozen_string_literal: true

class Inputs::LabeledFieldComponent < ViewComponent::Base
  def initialize(form:, key:, label:, errors: {}, errors_key_prefix: '')
    @form = form
    @key = key
    @label = label
    @errors = (errors["#{errors_key_prefix}#{'.' if errors_key_prefix.present?}#{
      if key.end_with?("_id")
        key.slice(0...-3)
      else
        key
      end }"] || []).filter do |error|
      not (Set["is invalid"] === error)
    end
    unless @errors.find_index("can't be blank").nil?
      @errors.delete("must exist")
    end
  end
end
