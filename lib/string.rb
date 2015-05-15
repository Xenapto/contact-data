class String
  def encode_component
    Addressable::URI.encode_component(self, Addressable::URI::CharacterClasses::PATH)
  end

  def to_options(base)
    { url: self }.to_options(base)
  end
end
