module InvitesHelper
  #Checks if the selected user has already been invited by the current user, 0== false, >0 true
  def invited?(user_id)
    Invite.where(user_id: current_user.id).where(invite_id: user_id).count != 0
  end
end
