# frozen_string_literal: true

# Sends messages via the contact form
class MessageMailer < ApplicationMailer
  def email(message)
    @message = message
    set_message_id
    return unless message.present?
    sender = "#{message.name} <#{message.email}>"

    mail(to: 'Informationsansvarig <styret.info@ftek.se>',
         subject: t('message_mailer.email.sent_via'),
         cc: sender,
         reply_to: sender)
  end
end
