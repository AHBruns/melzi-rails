class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  def short_description
    if self.id.present?
      self.id
    else
      self.to_s
    end
  end

  # with files
  def self.create_with_files(attributes, new_files = nil, existing_files = nil)
    record = self.new
    ApplicationRecord.transaction do
      record = self.create(attributes)
      record.handle_files(new_files, existing_files) if record.persisted?
    end
    record
  end

  def update_with_files(attributes, new_files = nil, existing_files = nil)
    status = false
    ApplicationRecord.transaction do
      status = self.update(attributes)
      self.handle_files(new_files, existing_files) if status
    end
    status
  end

  def handle_files(new_files = nil, existing_files = nil)
    existing_files.each { |id, should_purge| self.files.find(id.to_i).purge if should_purge == "1" } unless existing_files.nil?
    self.files.attach(new_files) unless new_files.nil?
  end

  def self.file_fields
    [files: [], new_files: [], existing_files: {}]
  end
end