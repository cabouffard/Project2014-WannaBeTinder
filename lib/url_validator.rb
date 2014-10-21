class UrlValidator < ActiveModel::EachValidator
  def validate_each(record, attr_name, value)
    unless valid?(value)
      record.errors.add(attr_name, :url, options)
    end
  end

  private

  def valid?(value)
    URI.parse(value).kind_of?(URI::HTTP)
  rescue URI::InvalidURIError
    false
  end
end

