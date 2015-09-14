class BaseForm
  include ActiveModel::Model

  def process
  	raise "You must implement me."
  end

  def validate_related(thing)
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
