# frozen_string_literal: true

# Describes an election item on the agenda.
class Election
  include ActiveModel::Model
  attr_accessor :agenda_item

  def self.create!(options)
    AgendaItem.create!(type: :election, agenda: options[:agenda_id],
                       position: options[:position],
                       data: serialize(options[:candidates]),
                       title: options[:title])
  end

  def title
    @title ||= @agenda_item.title
  end

  def candidates
    @candidates ||= Election.deserialize(@agenda_item.data)
  end

  def to_partial
    'agenda_items/election'
  end

  def self.serialize(arr)
    return arr unless arr.is_a?(Array)
    str = arr.first.dup
    arr.drop(1).each { |s| str = "#{str}, #{s}" }
    puts str
    str
  end

  def self.deserialize(str)
    return str unless str.is_a?(String)
    str.split(',').collect(&:strip)
  end
end
