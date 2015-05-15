class Hash
  def to_options(base, text = nil)
    o = { base: base }

    [:verbose, :url_base, :api_base, :format, :noformat].each { |k| o[k] = delete(k) if key?(k) }

    o[:payload] = { text: text } if text
    o[:params]  = self unless empty?
    o
  end
end
