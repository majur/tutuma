module Components
  class HelloComponent < Components::Base
    def view_template
      h1 { "Ahoj, Phlex666!" }
    end
  end
end
