class Api::Titles::Show
  prepend SimpleCommand
  attr_writer :errors

  def initialize(cnpj_assignor, cnpj_drawee, initial_date_range, final_date_range, have_criticism, title_number)
    @cnpj_drawee = cnpj_drawee
    @cnpj_assignor = cnpj_assignor
    @initial_date_range = initial_date_range
    @final_date_range = final_date_range
    @have_criticism = have_criticism
    @title_number = title_number
  end

  def call
    if @cnpj_assignor
      query
    else
      errors.add(:message, 'field cnpj_assignor required.')
    end
  end

  def query
    titles = Title.where(cnpj_assignor: @cnpj_assignor)
    titles = titles.where(cnpj_drawee: @cnpj_drawee) if @cnpj_drawee
    titles = titles.where("titles.due_date >= ?", @initial_date_range) if @initial_date_range
    titles = titles.where("titles.due_date <= ?", @final_date_range) if @final_date_range
    titles = titles.where("titles.title_number LIKE ?", "%#{@title_number}%") if @title_number
    
    if @have_criticism == 'true'
      titles = titles.joins("INNER JOIN title_criticisms tcs ON titles.id = tcs.title_id") 
    elsif @have_criticism == 'false'
      titles = titles.joins("LEFT JOIN title_criticisms tcs ON titles.id = tcs.title_id")
                     .where("tcs.title_id IS NULL")
    end

    titles = titles.as_json(
      only: [:title_number, :value, :due_date, :cnpj_assignor,:cnpj_drawee],
      include: { 
        title_criticism: { 
          only: [:status, :assignors_protests, :drawees_protests]
        }
      }
    )

    return titles
  end
end