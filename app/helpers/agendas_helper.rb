# frozen_string_literal: true

module AgendasHelper
  def agenda_state_link(agenda)
    if agenda.current?
      agenda_close_link(agenda)
    else
      agenda_current_link(agenda)
    end
  end

  def agenda_close_link(agenda)
    link_to(t('agenda.close'), admin_current_agenda_path(agenda),
            method: :delete, remote: true)
  end

  def agenda_current_link(agenda)
    link_to(t('agenda.set_current'), admin_current_agenda_path(agenda),
            method: :patch, remote: true)
  end

  def agenda_status(state)
    t("model.agenda_item.statuses.#{state}")
  end

  def agenda_status_collection
    AgendaItem.statuses.keys.map do |s|
      [agenda_status(s), s]
    end
  end

  def agenda_item_type(type)
    t("model.agenda_item.types.#{type}")
  end

  def agenda_item_types
    AgendaItem.types.keys.map do |s|
      [agenda_item_type(s), s]
    end
  end

  def agenda_link(agenda)
    content = [agenda.to_s]

    link_to safe_join(content), agenda_path(agenda)
  end
end
