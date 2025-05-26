class PunyHumenController < ApplicationController
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
end
