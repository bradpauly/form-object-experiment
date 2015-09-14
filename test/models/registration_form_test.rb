require 'test_helper'

class RegistrationFormTest < ActiveSupport::TestCase
  def test_new_form
    form = RegistrationForm.new(user_name: 'brad')
    puts form.process.inspect

  end
end
