module HashMade
  def update_attributes(attributes)
    attribute_writers.map { |writer| [writer, remove_eq(writer)] }
      .each { |writer, key| __send__ writer, attributes[key] }
  end

  def attribute_writers
    methods.select { |m| m[/\w+\=/] }
  end
  
  def to_hash
    keyvalue_pairs = attribute_writers.map { |writer| remove_eq writer }
      .map { |attribute| [attribute, __send__(attribute)] }
      
    Hash[keyvalue_pairs]
  end
  
  protected
    def remove_eq(method)
      method.to_s.chop.to_sym
    end
end
