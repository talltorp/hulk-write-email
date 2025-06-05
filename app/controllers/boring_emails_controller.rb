class BoringEmailsController < ApplicationController
  def show
    @boring_email = GlobalID::Locator.locate_signed(params[:id])

    if @boring_email.nil?
      return redirect_to root_path, alert: "Invalid link"
    end
  end
end
