# frozen_string_literal: true

module Admin
  class BulletsController < Admin::BaseController
    authorize_resource(class: Agenda)

    def create
      @agenda = Agenda.find(params[:agenda_id])
      @item = @agenda.bullets.build(bullet_params)

      @bullet.save!
    end

    def update
      agenda = Agenda.find(params[:agenda_id])
      bullet = agenda.bullets.find(params[:id])

      bullet.update!(bullet_params)
      redirect_to(edit_admin_agenda_path(agenda))
    end

    private

    def bullet_params
      params.require(:bullet).permit(:type, :status, :title, :position)
    end
  end
end
