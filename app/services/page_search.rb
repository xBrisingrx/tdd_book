module PageSearch
  def self.search(params)
    return [] unless params.present? && params[:term].present?
    Page.by_term(params[:term])
  end
end
# Se crea un modulo en lugar de una clase xq no vamos a crear ninguna instancia
# de el servicio de busqueda
# simplemente vamos a llamar a un metodo y nada mas
