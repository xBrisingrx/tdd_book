module PageSearch
  def self.search(params)
    return [] unless params.present?

    pages = if params[:year].present? && params[:month].present?
              Page.by_year_month(params[:year], params[:month])
    elsif params[:term].present?
              Page.by_term(params[:term])
    end
    return [] unless pages
    pages.published.ordered
  end
end
# Se crea un modulo en lugar de una clase xq no vamos a crear ninguna instancia
# de el servicio de busqueda
# simplemente vamos a llamar a un metodo y nada mas
