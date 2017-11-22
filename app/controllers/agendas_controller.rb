# frozen_string_literal: true

# Handles viewing of single and multiple agendas
class AgendasController < ApplicationController
  load_and_authorize_resource

  def index
    @agendas = Agenda.includes(:agenda_items)
  end

  def show
    @agenda = Agenda.includes(:agenda_items, :documents).find(params[:id])
    @current_agenda = Agenda.now
  end
end
