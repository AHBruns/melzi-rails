# frozen_string_literal: true

class Forms::NestedRecordArrayComponent < ViewComponent::Base
  renders_one :template
  renders_many :existing_records

  def initialize(
    form:,
    key:,
    label:,
    template_index:,
    excluded_fields: Set[],
    errors: {},
    errors_key_prefix: ''
  )
    @form = form
    @key = key
    @label = label
    @template_index = template_index
    @excluded_fields = excluded_fields
    @errors = errors
    @errors_key_prefix = errors_key_prefix
  end
end
