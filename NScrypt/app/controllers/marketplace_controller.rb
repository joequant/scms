class MarketplaceController < ApplicationController
  def index
    # Fetches only open offers
    @codes = Code.where(state: 'Open Offer')
    @codes = @codes.sort{ |a, b| b.id <=> a.id }
  end
end
