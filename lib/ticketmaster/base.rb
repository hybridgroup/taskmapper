module TicketMasterMod
  class String
    def constantize(camel_cased_word)
      unless /\A(?:::)?([A-Z]\w*(?:::[A-Z]\w*)*)\z/ =~ camel_cased_word
        raise NameError, "#{camel_cased_word.inspect} is not a valid constant name!"
      end

      Object.module_eval("::#{$1}", __FILE__, __LINE__)
    end
  end

  class Ticket
    [:create, :update, :find, :delete].each do |method|
      define_method method do
        raise NotYetImplemented
      end
    end
  end

  class Project
    [:create, :update, :find, :delete].each do |method|
      define_method method do
        raise NotYetImplemented
      end
    end
  end
end
