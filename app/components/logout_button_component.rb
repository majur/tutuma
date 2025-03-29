class LogoutButtonComponent < ViewComponent::Base
  def initialize(
    scheme: :danger,
    size: :medium,
    full_width: false,
    tag: :button,
    css_class: nil,
    button_text: "Odhlásiť sa"
  )
    @scheme = scheme
    @size = size
    @full_width = full_width
    @tag = tag
    @css_class = css_class
    @button_text = button_text
  end

  def button_classes
    classes = ["btn"]
    
    # Scheme class
    classes << case @scheme
    when :danger
      "btn-danger"
    when :primary
      "btn-primary"
    when :outline
      "btn-outline"
    else
      "btn-default"
    end
    
    # Size class
    classes << case @size
    when :small
      "btn-sm"
    when :large
      "btn-lg"
    else
      # Medium je default, nepotrebuje extra triedu
    end
    
    # Block display
    classes << "btn-block" if @full_width
    
    # Custom classes
    classes << @css_class if @css_class
    
    classes.compact.join(" ")
  end

  def button_styles
    if @scheme == :danger
      "display: inline-block; padding: 5px 16px; font-size: 14px; font-weight: 500; line-height: 20px; white-space: nowrap; vertical-align: middle; cursor: pointer; user-select: none; border: 1px solid; border-radius: 6px; appearance: none; background-color: #d93c31; color: white; border-color: rgba(27,31,36,0.15);"
    else
      nil
    end
  end

  private

  attr_reader :tag, :button_text
end
