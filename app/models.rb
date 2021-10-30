# frozen_string_literal: true

# Bring all the models into a single file for a cleaner import.
module Models
end

Dir.glob("#{File.dirname(__FILE__)}/models/*.rb").sort.each(&method(:require))
