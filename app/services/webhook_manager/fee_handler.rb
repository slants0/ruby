# frozen_string_literal: true

# Creates donation and item with the corresponding payload
module WebhookManager
    class FeeHandler < BaseService
        attr_reader :payment_intent, :amount

    def initialize(params)
      @payment_intent = params[:payment_intent]
      @amount = params[:amount]
    end

    def call
        return_amount = @amount
        campaign = Campaign.find_by_id(payment_intent.campaign_id)
        if(campaign.present?)
            campaign.fees.each do |fee|
                return_amount -= (amount * fee.multiplier)
                return_amount -= (fee.flat_cost)
            end
        else
            # Apply the default square processing fee
            return_amount *= 0.9725
            return_amount -= 0.30
        end
        return_amount.floor
    end

end