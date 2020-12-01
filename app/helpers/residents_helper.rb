module ResidentsHelper
  def component(component_name, locals = {}, &block)
    render("residents/#{component_name}", locals, &block)
  end

  alias c component
end
