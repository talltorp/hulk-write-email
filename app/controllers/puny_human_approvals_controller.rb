class PunyHumanApprovalsController < ApplicationController
  def show
    @puny_human = GlobalID::Locator.locate_signed(params[:id])
    if @puny_human.nil?
      return redirect_to root_path, alert: "Invalid link"
    end

    if @puny_human.approved?
      return redirect_to root_path, alert: "You already approved"
    end

    @puny_human.approve!
    GettingStartedMailer.instructions(@puny_human.email).deliver_later

    redirect_to hulk_have_new_email_friend_path
  end
end
