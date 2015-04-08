class ScStateMachine
  attr_reader :states, :privs

  def initialize(sc)
    @sc = sc
    @states = {}
    @privs = {}
  end

  def set_states(states)
    @states = states
  end

  def set_privileges(privs)
    @privs = privs
  end

  def get_actions
    actions = Hash.new
    @sc.parties.each { |p|
      acts = Array.new
      if @states.include?(@sc.status)
        @states[@sc.status].each{ |a|
          acts << a[:action] if has_privs?(p[1], a[:action])
        }
      end
      actions[p[1]] = acts
    }
    actions
  end

  def can_perform_action_now?(user, action)
    get_actions[user].include?(action)
  end

  def has_privs?(party, action)
    return true if @privs.nil?
    if @privs.include?(party)
      return @privs[party].include?(action)
    end
    return false
  end
end
