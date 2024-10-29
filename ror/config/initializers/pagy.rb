require 'pagy/extras/overflow'

Pagy::DEFAULT[:limit] = 10 # items per page
Pagy::DEFAULT[:size] = 5  # nav bar links
Pagy::DEFAULT[:overflow] = :last_page