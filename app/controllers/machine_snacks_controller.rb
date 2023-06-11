class MachineSnacksController < ApplicationController
  def create
    machine_snack = MachineSnack.create!(snack_id: params[:snack_id], machine_id: params[:id])
    redirect_to machine_path(params[:id])
  end
end