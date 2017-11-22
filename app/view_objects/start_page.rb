class StartPage
  attr_accessor :agendas, :news

  def initialize
    @agendas = Agenda.position.includes(:agenda_items) || []
    @news = News.order(created_at: :desc).limit(5).includes(:user) || []
  end
end
