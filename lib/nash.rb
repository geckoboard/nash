require "nash/version"
require 'hashie/hash'
require 'set'

module Hashie
  # A Nash is a Nested Defined Hash and is an extension of a Dash
  # A Nash allows you to create complex assignments composing of 
  # several nested Dashes
  # 
  #
  # Nashes are useful when you need to create a lightweigth nested 
  # data object, ideal for validating JSON
  class Nash < Hashie::Dash
    include Hashie::PrettyInspect
    alias_method :to_s, :inspect

    class << self
      attr_reader :class_properties
    end
    instance_variable_set('@class_properties', Hash.new)

    # Defines a property on the Nash. Options are
    # as follows:
    #
    # * <tt>:default</tt> - Specify a default value for this property,
    #   to be returned before a value is set on the property in a new
    #   Nash.
    #
    # * <tt>:required</tt> - Specify the value as required for this
    #   property, to raise an error if a value is unset in a new or
    #   existing Nash.
    #
    # * <tt>:class</tt> - Specify a class for this property that
    #   should be instantiated when an assignment is made to this
    #   property.
    #
    def self.property(property_name, options = {})
          property_name = property_name.to_sym

          self.properties << property_name

          if options.has_key?(:class)
            class_name = options[:class].to_s
            puts class_properties
            class_properties[property_name] = class_name if options.delete(:class)
            class_eval <<-ACCESSORS
              def #{property_name}(&block)
                self.[](#{property_name.to_s.inspect}, &block)
              end

              def #{property_name}=(value)
                self.[]=(#{property_name.to_s.inspect}, #{class_properties[property_name]}.new(value))
              end
              
            ACCESSORS
            
            
          elsif
            class_properties[property_name] = nil
          end

          if options.has_key?(:default)
            self.defaults[property_name] = options[:default]
          elsif self.defaults.has_key?(property_name)
            self.defaults.delete property_name
          end

          unless instance_methods.map { |m| m.to_s }.include?("#{property_name}=")
            class_eval <<-ACCESSORS
              def #{property_name}(&block)
                self.[](#{property_name.to_s.inspect}, &block)
              end

              def #{property_name}=(value)
                self.[]=(#{property_name.to_s.inspect}, value)
              end
            ACCESSORS
          end

          if defined? @subclasses
            @subclasses.each { |klass| klass.property(property_name, options) }
          end
          required_properties << property_name if options.delete(:required)
    end



    def self.inherited(klass)
      super
      (@subclasses ||= Set.new) << klass
      klass.instance_variable_set('@properties', self.properties.dup)
      klass.instance_variable_set('@defaults', self.defaults.dup)
      klass.instance_variable_set('@required_properties', self.required_properties.dup)
      klass.instance_variable_set('@class_properties', self.class_properties.dup)
    end


    # You may initialize a Dash with an attributes hash
    # just like you would many other kinds of data objects.
    def initialize(attributes = {}, &block)
      super(attributes, &block) 
      
      # override whatever Dash has set
      attributes.each_pair do |att, value|
        self.send((att.to_s + '=').to_sym,value) 
      end if attributes
      assert_required_properties_set!
    end
  end
end
