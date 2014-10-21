# http://stackoverflow.com/questions/14972253/simpleform-default-input-class
# https://github.com/plataformatec/simple_form/issues/316

# Add form-control class

inputs = [
  :CollectionSelectInput,
  :DateTimeInput,
  :FileInput,
  :GroupedCollectionSelectInput,
  :NumericInput,
  :PasswordInput,
  :RangeInput,
  :StringInput,
  :TextInput,
]

inputs.each do |input_type|
  superclass = "SimpleForm::Inputs::#{input_type}".constantize

  new_class = Class.new(superclass) do
    def input_html_classes
      super.push("form-control")
    end
  end

  Object.const_set(input_type, new_class)
end

# Add control-label to labels

module SimpleForm
  module Components
    module Labels
      def label_html_options
        label_html_classes = [SimpleForm.label_class]
        label_html_classes << SimpleForm.additional_classes_for(:label) {
          [input_type, required_class]
        }

        label_options = html_options_for(:label, label_html_classes.compact)
        if options.key?(:input_html) && options[:input_html].key?(:id)
          label_options[:for] = options[:input_html][:id]
        end
        label_options
      end
    end
  end
end

# Use this setup block to configure all options available in SimpleForm.
SimpleForm.setup do |config|
  config.boolean_style = :nested

  config.wrappers :bootstrap3, tag: "div", class: "form-group", error_class: "has-error",
      defaults: { input_html: { class: "default_class" } } do |b|

    b.use :html5

    b.use :min_max
    b.use :maxlength
    b.optional :placeholder
    b.optional :pattern
    b.optional :readonly

    b.use :label_input, label: { class: "control-label" }
    b.use :hint,  wrap_with: { tag: "p", class: "control-hint help-block" }
    b.use :error, wrap_with: { tag: "p", class: "help-block" }
  end

  config.wrappers :prepend, tag: "div", class: "form-group", error_class: "error" do |b|
    b.use :html5
    b.use :placeholder
    b.use :label
    b.wrapper tag: "div", class: "controls" do |input|
      input.wrapper tag: "div", class: "input-prepend" do |prepend|
        prepend.use :input
      end
      input.use :hint,  wrap_with: { tag: "span", class: "help-block" }
      input.use :error, wrap_with: { tag: "span", class: "help-inline" }
    end
  end

  config.wrappers :append, tag: "div", class: "control-group", error_class: "error" do |b|
    b.use :html5
    b.use :placeholder
    b.use :label
    b.wrapper tag: "div", class: "controls" do |input|
      input.wrapper tag: "div", class: "input-append" do |append|
        append.use :input
      end
      input.use :hint,  wrap_with: { tag: "span", class: "help-block" }
      input.use :error, wrap_with: { tag: "span", class: "help-inline" }
    end
  end

  # Wrapper used for profile_types
  config.wrappers :checkbox, tag: 'div', class: 'control-group' do |b|
    b.use :html5
    b.wrapper tag: 'div', class: 'controls' do |ba|
      ba.use :label_input, wrap_with: { class: 'checkbox inline' }
    end
  end

  # Wrappers for forms and inputs using the Twitter Bootstrap toolkit.
  # Check the Bootstrap docs (http://getbootstrap.com/)
  # to learn about the different styles for forms and inputs,
  # buttons and other elements.
  config.default_wrapper = :bootstrap3
end
