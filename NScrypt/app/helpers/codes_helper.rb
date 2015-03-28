module CodesHelper

class CodeState
  attr_reader :fm

  def initialize()
    fm = FiniteMachine.define do
      initial :unassigned

      events {
        event :assign_a, :unassigned => :self_assigned
        event :assign_a, :counter_assigned => :assigned
        event :assign_cp, :unassigned => :counter_assigned
        event :assign_cp, :self_assigned => :assigned
        event :assign_cp, :open_offer => :pre_signed
        event :propose, :assigned => :proposal
        event :propose, :pre_signed => :offer
        event :a_sign, :proposal => :pre_signed
        event :a_sign, :self_assigned => :open_offer
        event :a_sign, :assigned => :pre_signed
        event :a_sign, :counter_signed => :signed
        event :cp_sign, :proposal => :counter_signed
        event :cp_sign, :pre_signed => :signed
        event :post, :open_offer => :public_offer
        event :accept, :public_offer => :accepted

        event :retract, :offer => :void
        event :reject, :offer => :void
        event :retract, :proposal => :void
        event :unpost, :public_offer => :void
        event :unassign_a, :self_assigned => :unassigned
        event :unassign_a, :assigned => :counter_assigned
        event :unassign_cp, :assigned => :self_assigned
        event :unassign_cp, :counter_assigned => :unassigned
      }
    end 
  end

end



end
