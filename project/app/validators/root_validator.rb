class RootValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    return unless value.nil? || !value.root?

    record.errors[attribute] << 'Must be a root element!'
  end
end
