class Private::LocationsController < LocationsController
  before_action :authenticate_request
end
