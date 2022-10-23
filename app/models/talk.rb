class Talk < ApplicationRecord
    validates_format_of :name,
               with: /\A[a-z][a-z0-9_\-]*\z/i
end
