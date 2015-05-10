class Nokogiri::XML::Node
  def to_json(*a)
    {"$name"=>name}.tap do |h|
      kids = children.to_a
      h.merge!(attributes)
      h.merge!("$text"=>text) unless text.empty?
      h.merge!("$kids"=>kids) unless kids.empty?
    end.to_json(*a)
  end
end

class Nokogiri::XML::Document
  def to_json(*a); root.to_json(*a); end
end

class Nokogiri::XML::Text
  def to_json(*a); text.to_json(*a); end
end

class Nokogiri::XML::Attr
  def to_json(*a); value.to_json(*a); end
end

