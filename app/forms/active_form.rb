module ActiveForm
  module Form
    def self.included(base)
      base.class_eval do
        include ActiveModel::Model
      end
      base.extend(ActiveForm::Form::ClassMethods)
    end

    def models
      @models ||= []
    end

    def save
      if process
        ActiveRecord::Base.transaction do
          models.map(&:save!)
          send(self.class.within_save_method) if self.class.within_save_method
        end
        send(self.class.after_save_method) if self.class.after_save_method
        return true
      else
        return false
      end
    end

    def process
      self.class.model_names.map do |model_name|
        model = "#{model_name}".camelize.constantize.new(attributes_for_model(model_name))
        models << model
        send("#{model_name}=", model)
      end
      validate_models
      errors.messages.empty?
    end

    def attributes_for_model(model_name)
      attributes = {}
      self.class.attribute_map[model_name].each do |attribute_name|
        attributes[attribute_name] = send("#{model_name}_#{attribute_name}".to_sym)
      end
      attributes
    end

    def validate_models
      models.each do |thing|
        name = thing.class.name.downcase
        unless thing.valid?
          thing.errors.messages.each do |k, v|
            v.each do |m|
              errors.add("#{name}_#{k}".to_sym, m)
            end
          end
        end
      end
    end

    module ClassMethods
      def model_names
        @model_names ||= []
      end

      def attribute_map
        @attribute_map ||= {}
      end

      def map_model_attribute(model_name, attribute_name)
        attribute_map[model_name] ||= []
        attribute_map[model_name] << attribute_name
      end

      def within_save_method
        @within_save_method
      end

      def within_save(method_name)
        @within_save_method = method_name
      end

      def after_save_method
        @after_save_method
      end

      def after_save(method_name)
        @after_save_method = method_name
      end

      def accepts_attributes_for(model_name, *attributes)
        model_names << model_name
        attr_accessor model_name
        attributes.each do |attribute_name|
          map_model_attribute(model_name, attribute_name)
          attr_accessor "#{model_name}_#{attribute_name}".to_sym
        end
      end
    end

  end
end
