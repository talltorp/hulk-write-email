class PunyHumenController < ApplicationController
  before_action :verify_turnstile, only: [:create]

  def create
    @puny_human = PunyHuman.new(puny_human_params)

    if @puny_human.save
      puny_human_approval_url = puny_human_approval_url(@puny_human.to_signed_global_id.to_s)

      GettingStartedMailer.ask_approval(@puny_human.email, puny_human_approval_url).deliver_later

      respond_to do |format|
        format.turbo_stream
        format.html
      end
    else
      respond_to do |format|
        format.turbo_stream
        format.html { redirect_to root_path, notice: "You make Hulk angry!" }
      end
    end
  end

  private

  def puny_human_params
    params.require(:puny_human).permit(:email)
  end

  def verify_turnstile
    turnstile_token = params["cf-turnstile-response"]
    is_valid = TurnstileVerifier.new(turnstile_token, request.remote_ip).verify
  
    return if is_valid
    flash[:alert] = "Please complete the turnstile challenge."
    render :new, status: :unprocessable_entity
  end
end
