class Talk < ApplicationRecord
    validates_format_of :name,
               with: /\A[a-z][a-z\-]*\z/i
end
